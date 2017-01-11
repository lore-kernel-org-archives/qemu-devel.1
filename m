Received: from eggs.gnu.org ([2001:4830:134:3::10]:35676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VH-0006f9-3b
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VG-0003Wc-2U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:07 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VF-0003WD-Tu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:06 -0500
Received: by mail-pf0-x241.google.com with SMTP id 127so31459445pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:05 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:06 -0800
Message-Id: <20170111021820.24416-52-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/65] target-arm: Use clrsb helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/helper-a64.c    | 10 ----------
 target/arm/helper-a64.h    |  2 --
 target/arm/translate-a64.c |  8 ++++----
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 77999ff..d9df82c 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -54,16 +54,6 @@ int64_t HELPER(sdiv64)(int64_t num, int64_t den)
     return num / den;
 }
 
-uint64_t HELPER(cls64)(uint64_t x)
-{
-    return clrsb64(x);
-}
-
-uint32_t HELPER(cls32)(uint32_t x)
-{
-    return clrsb32(x);
-}
-
 uint64_t HELPER(rbit64)(uint64_t x)
 {
     return revbit64(x);
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index d320f96..6f9eaba 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -18,8 +18,6 @@
  */
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_1(cls64, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(cls32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
 DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1bf94bc..4f09dfb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3972,11 +3972,11 @@ static void handle_cls(DisasContext *s, unsigned int sf,
     tcg_rn = cpu_reg(s, rn);
 
     if (sf) {
-        gen_helper_cls64(tcg_rd, tcg_rn);
+        tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
     } else {
         TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        gen_helper_cls32(tcg_tmp32, tcg_tmp32);
+        tcg_gen_clrsb_i32(tcg_tmp32, tcg_tmp32);
         tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
         tcg_temp_free_i32(tcg_tmp32);
     }
@@ -7593,7 +7593,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         if (u) {
             tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
         } else {
-            gen_helper_cls64(tcg_rd, tcg_rn);
+            tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
         }
         break;
     case 0x5: /* NOT */
@@ -10263,7 +10263,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     if (u) {
                         tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
                     } else {
-                        gen_helper_cls32(tcg_res, tcg_op);
+                        tcg_gen_clrsb_i32(tcg_res, tcg_op);
                     }
                     break;
                 case 0x7: /* SQABS, SQNEG */
-- 
2.9.3
