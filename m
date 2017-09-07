Received: from eggs.gnu.org ([2001:4830:134:3::10]:52400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UJ-0003IV-N4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UE-0008Qr-Rp
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:31 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:35371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5UE-0008Q0-LJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:26 -0400
Received: by mail-pf0-x22b.google.com with SMTP id g13so1630258pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:50 -0700
Message-Id: <20170907224051.21518-23-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/23] tcg/ppc: Look for shifted constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/ppc/tcg-target.inc.c | 58 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bc14d2c9c6..df709c4a96 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -593,11 +593,26 @@ static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
     tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
 }
 
+/* Emit a move into ret of arg, if it can be done in one insn.  */
+static bool tcg_out_movi_one(TCGContext *s, TCGReg ret, tcg_target_long arg)
+{
+    if (arg == (int16_t)arg) {
+        tcg_out32(s, ADDI | TAI(ret, 0, arg));
+        return true;
+    }
+    if (arg == (int32_t)arg && (arg & 0xffff) == 0) {
+        tcg_out32(s, ADDIS | TAI(ret, 0, arg >> 16));
+        return true;
+    }
+    return false;
+}
+
 static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
                              tcg_target_long arg, bool in_prologue)
 {
     intptr_t tb_diff;
-    int32_t high;
+    tcg_target_long tmp;
+    int shift;
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
 
@@ -606,8 +621,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Load 16-bit immediates with one insn.  */
-    if (arg == (int16_t)arg) {
-        tcg_out32(s, ADDI | TAI(ret, 0, arg));
+    if (tcg_out_movi_one(s, ret, arg)) {
         return;
     }
 
@@ -618,12 +632,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
-    /* Load 32-bit immediates with two insns.  */
+    /* Load 32-bit immediates with two insns.  Note that we've already
+       eliminated bare ADDIS, so we know both insns are required.  */
     if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
         tcg_out32(s, ADDIS | TAI(ret, 0, arg >> 16));
-        if (arg & 0xffff) {
-            tcg_out32(s, ORI | SAI(ret, ret, arg));
-        }
+        tcg_out32(s, ORI | SAI(ret, ret, arg));
         return;
     }
     if (arg == (uint32_t)arg && !(arg & 0x8000)) {
@@ -632,15 +645,40 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Load masked 16-bit value.  */
+    if (arg > 0 && (arg & 0x8000)) {
+        tmp = arg | 0x7fff;
+        if ((tmp & (tmp + 1)) == 0) {
+            int mb = clz64(tmp + 1) + 1;
+            tcg_out32(s, ADDI | TAI(ret, 0, arg));
+            tcg_out_rld(s, RLDICL, ret, ret, 0, mb);
+            return;
+        }
+    }
+
+    /* Load common masks with 2 insns.  */
+    shift = ctz64(arg);
+    tmp = arg >> shift;
+    if (tmp == (int16_t)tmp) {
+        tcg_out32(s, ADDI | TAI(ret, 0, tmp));
+        tcg_out_shli64(s, ret, ret, shift);
+        return;
+    }
+    shift = clz64(arg);
+    if (tcg_out_movi_one(s, ret, arg << shift)) {
+        tcg_out_shri64(s, ret, ret, shift);
+        return;
+    }
+
     /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
     if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
         tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
         return;
     }
 
-    high = arg >> 31 >> 1;
-    tcg_out_movi(s, TCG_TYPE_I32, ret, high);
-    if (high) {
+    tmp = arg >> 31 >> 1;
+    tcg_out_movi(s, TCG_TYPE_I32, ret, tmp);
+    if (tmp) {
         tcg_out_shli64(s, ret, ret, 32);
     }
     if (arg & 0xffff0000) {
-- 
2.13.5
