Received: from eggs.gnu.org ([2001:4830:134:3::10]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPe-0003yO-Al
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPc-0003Pl-RX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:42 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPc-0003O9-Lv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:40 -0400
Received: by mail-pg0-x244.google.com with SMTP id y192so836729pgd.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:40 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:15 -0700
Message-Id: <20170804054426.10590-13-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 12/23] tcg/aarch64: Use constant pool
 for movi
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
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/aarch64/tcg-target.inc.c | 62 +++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 484cf6236c..e86c2684fb 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -123,5 +123,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index c7c751bafc..c2f3812214 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -10,6 +10,7 @@
  * See the COPYING file in the top-level directory for details.
  */
 
+#include "tcg-pool.inc.c"
 #include "qemu/bitops.h"
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
@@ -587,9 +588,11 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
-    int i, wantinv, shift;
     tcg_target_long svalue = value;
     tcg_target_long ivalue = ~value;
+    tcg_target_long t0, t1, t2;
+    int s0, s1;
+    AArch64Insn opc;
 
     /* For 32-bit values, discard potential garbage in value.  For 64-bit
        values within [2**31, 2**32-1], we can create smaller sequences by
@@ -638,38 +641,29 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         }
     }
 
-    /* Would it take fewer insns to begin with MOVN?  For the value and its
-       inverse, count the number of 16-bit lanes that are 0.  */
-    for (i = wantinv = 0; i < 64; i += 16) {
-        tcg_target_long mask = 0xffffull << i;
-        wantinv -= ((value & mask) == 0);
-        wantinv += ((ivalue & mask) == 0);
-    }
-
-    if (wantinv <= 0) {
-        /* Find the lowest lane that is not 0x0000.  */
-        shift = ctz64(value) & (63 & -16);
-        tcg_out_insn(s, 3405, MOVZ, type, rd, value >> shift, shift);
-        /* Clear out the lane that we just set.  */
-        value &= ~(0xffffUL << shift);
-        /* Iterate until all non-zero lanes have been processed.  */
-        while (value) {
-            shift = ctz64(value) & (63 & -16);
-            tcg_out_insn(s, 3405, MOVK, type, rd, value >> shift, shift);
-            value &= ~(0xffffUL << shift);
-        }
+    /* Would it take fewer insns to begin with MOVN?  */
+    if (ctpop64(value) >= 32) {
+        t0 = ivalue;
+        opc = I3405_MOVN;
     } else {
-        /* Like above, but with the inverted value and MOVN to start.  */
-        shift = ctz64(ivalue) & (63 & -16);
-        tcg_out_insn(s, 3405, MOVN, type, rd, ivalue >> shift, shift);
-        ivalue &= ~(0xffffUL << shift);
-        while (ivalue) {
-            shift = ctz64(ivalue) & (63 & -16);
-            /* Provide MOVK with the non-inverted value.  */
-            tcg_out_insn(s, 3405, MOVK, type, rd, ~(ivalue >> shift), shift);
-            ivalue &= ~(0xffffUL << shift);
+        t0 = value;
+        opc = I3405_MOVZ;
+    }
+    s0 = ctz64(t0) & (63 & -16);
+    t1 = t0 & ~(0xffffUL << s0);
+    s1 = ctz64(t1) & (63 & -16);
+    t2 = t1 & ~(0xffffUL << s1);
+    if (t2 == 0) {
+        tcg_out_insn_3405(s, opc, type, rd, t0 >> s0, s0);
+        if (t1 != 0) {
+            tcg_out_insn(s, 3405, MOVK, type, rd, value >> s1, s1);
         }
+        return;
     }
+
+    /* For more than 2 insns, dump it into the constant pool.  */
+    new_pool_label(s, value, R_AARCH64_CONDBR19, s->code_ptr, 0);
+    tcg_out_insn(s, 3305, LDR, 0, rd);
 }
 
 /* Define something more legible for general use.  */
@@ -2030,6 +2024,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_insn(s, 3207, RET, TCG_REG_LR);
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int i;
+    for (i = 0; i < count; ++i) {
+        p[i] = NOP;
+    }
+}
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
-- 
2.13.3
