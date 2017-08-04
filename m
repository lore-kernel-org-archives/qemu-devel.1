Received: from eggs.gnu.org ([2001:4830:134:3::10]:59430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPW-0003nl-Fr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPU-00035k-Ti
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:34 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPU-00033n-MW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:32 -0400
Received: by mail-pg0-x244.google.com with SMTP id 83so821866pgb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:32 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:07 -0700
Message-Id: <20170804054426.10590-5-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 04/23] tcg/i386: Store out-of-range
 call targets in constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Already it saves 2 bytes per call, but also the constant pool
entry may well be shared across multiple calls.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.h     |  1 +
 tcg/i386/tcg-target.inc.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 11ee7fadd1..b89dababf4 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -189,5 +189,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1a1ad96906..5231056fd3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#include "tcg-pool.inc.c"
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
@@ -1180,9 +1182,14 @@ static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
         tcg_out_opc(s, call ? OPC_CALL_Jz : OPC_JMP_long, 0, 0, 0);
         tcg_out32(s, disp);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R10, (uintptr_t)dest);
-        tcg_out_modrm(s, OPC_GRP5,
-                      call ? EXT5_CALLN_Ev : EXT5_JMPN_Ev, TCG_REG_R10);
+        /* rip-relative addressing into the constant pool.
+           This is 6 + 8 = 14 bytes, as compared to using an
+           an immediate load 10 + 6 = 16 bytes, plus we may
+           be able to re-use the pool constant for more calls.  */
+        tcg_out_opc(s, OPC_GRP5, 0, 0, 0);
+        tcg_out8(s, (call ? EXT5_CALLN_Ev : EXT5_JMPN_Ev) << 3 | 5);
+        new_pool_label(s, (uintptr_t)dest, R_386_PC32, s->code_ptr, -4);
+        tcg_out32(s, 0);
     }
 }
 
@@ -2595,6 +2602,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 #endif
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0x90, count);
+}
+
 static void tcg_target_init(TCGContext *s)
 {
 #ifdef CONFIG_CPUID_H
-- 
2.13.3
