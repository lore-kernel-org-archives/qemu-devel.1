Received: from eggs.gnu.org ([2001:4830:134:3::10]:59570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPa-0003uM-CT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPY-0003Fl-NA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:38 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPY-0003Db-F0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:36 -0400
Received: by mail-pg0-x241.google.com with SMTP id u185so853471pgb.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:36 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:11 -0700
Message-Id: <20170804054426.10590-9-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 08/23] tcg/s390: Use constant pool for
 andi
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
2.13.3
