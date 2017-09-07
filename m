Received: from eggs.gnu.org ([2001:4830:134:3::10]:52075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tz-00032B-NE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tu-00088V-TC
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:11 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tu-00087n-NS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:06 -0400
Received: by mail-pf0-x229.google.com with SMTP id y29so859862pff.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:36 -0700
Message-Id: <20170907224051.21518-9-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/23] tcg/s390: Use constant pool for andi
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
 tcg/s390/tcg-target.inc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 29b77ff67f..4be57c5765 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -224,6 +224,7 @@ typedef enum S390Opcode {
     RXY_LRVG    = 0xe30f,
     RXY_LRVH    = 0xe31f,
     RXY_LY      = 0xe358,
+    RXY_NG      = 0xe380,
     RXY_STCY    = 0xe372,
     RXY_STG     = 0xe324,
     RXY_STHY    = 0xe370,
@@ -985,8 +986,17 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
         return;
     }
 
-    /* Fall back to loading the constant.  */
-    tcg_out_movi(s, type, TCG_TMP0, val);
+    /* Use the constant pool if USE_REG_TB, but not for small constants.  */
+    if (USE_REG_TB) {
+        if (!maybe_out_small_movi(s, type, TCG_TMP0, val)) {
+            tcg_out_insn(s, RXY, NG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
+            new_pool_label(s, val & valid, R_390_20, s->code_ptr - 2,
+                           -(intptr_t)s->code_gen_ptr);
+            return;
+        }
+    } else {
+        tcg_out_movi(s, type, TCG_TMP0, val);
+    }
     if (type == TCG_TYPE_I32) {
         tcg_out_insn(s, RR, NR, dest, TCG_TMP0);
     } else {
@@ -2341,6 +2351,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &r_r_ri;
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
         return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_mul_i32:
@@ -2375,10 +2387,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_rM : &r_0_rM)
                 : &r_0_r);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-- 
2.13.5
