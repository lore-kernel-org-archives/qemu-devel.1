Received: from eggs.gnu.org ([2001:4830:134:3::10]:60050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPp-0004Av-GF
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPo-0003sq-HR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:53 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPo-0003rE-CI
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:52 -0400
Received: by mail-pg0-x242.google.com with SMTP id u185so854016pgb.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:52 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:26 -0700
Message-Id: <20170804054426.10590-24-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 23/23] tcg/ppc: Use constant pool for
 movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/ppc/tcg-target.h     |  1 +
 tcg/ppc/tcg-target.inc.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index c1226ea5b6..e10d7e4411 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -130,5 +130,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 4b32809217..7598157e5f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+#include "elf.h"
+#include "tcg-pool.inc.c"
+
 #if defined _CALL_DARWIN || defined __APPLE__
 #define TCG_TARGET_CALL_DARWIN
 #endif
@@ -58,8 +61,6 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
-#include "elf.h"
-
 bool have_isa_2_06;
 bool have_isa_3_00;
 
@@ -224,9 +225,12 @@ static inline void tcg_out_bc_noaddr(TCGContext *s, int insn)
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    tcg_insn_unit *target = (tcg_insn_unit *)value;
+    tcg_insn_unit *target;
+    tcg_insn_unit old;
+
+    value += addend;
+    target = (tcg_insn_unit *)value;
 
-    tcg_debug_assert(addend == 0);
     switch (type) {
     case R_PPC_REL14:
         reloc_pc14(code_ptr, target);
@@ -234,6 +238,12 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_PPC_REL24:
         reloc_pc24(code_ptr, target);
         break;
+    case R_PPC_ADDR16:
+        assert(value == (int16_t)value);
+        old = *code_ptr;
+        old = deposit32(old, 0, 16, value);
+        *code_ptr = old;
+        break;
     default:
         tcg_abort();
     }
@@ -647,6 +657,14 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Use the constant pool, if possible.  */
+    if (!in_prologue && USE_REG_TB) {
+        new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
+                       -(intptr_t)s->code_gen_ptr);
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
+        return;
+    }
+
     high = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, high);
     if (high) {
@@ -1829,6 +1847,14 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 #endif
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int i;
+    for (i = 0; i < count; ++i) {
+        p[i] = NOP;
+    }
+}
+
 /* Parameters for function call generation, used in tcg.c.  */
 #define TCG_TARGET_STACK_ALIGN       16
 #define TCG_TARGET_EXTEND_ARGS       1
-- 
2.13.3
