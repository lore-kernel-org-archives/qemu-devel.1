Received: from eggs.gnu.org ([209.51.188.92]:44719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPd-0004kO-JL
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPM-0001rz-H6
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:29 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:45111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzoPJ-0001lJ-RT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:23 -0500
Received: by mail-pg1-x52a.google.com with SMTP id y4so11905105pgc.12
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:05:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:05:00 -0800
Message-Id: <20190301200501.16533-10-richard.henderson@linaro.org>
In-Reply-To: <20190301200501.16533-1-richard.henderson@linaro.org>
References: <20190301200501.16533-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/10] target/arm: Restructure
 handle_fp_1src_{single, double}
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

This will allow sharing code that adjusts rmode beyond
the existing users.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 90 +++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c2b9e800c8..94184ea5af 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5686,55 +5686,59 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 /* Floating-point data-processing (1 source) - single precision */
 static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 {
+    void (*gen_fpst)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    TCGv_i32 tcg_op, tcg_res;
     TCGv_ptr fpst;
-    TCGv_i32 tcg_op;
-    TCGv_i32 tcg_res;
+    int rmode = -1;
 
-    fpst = get_fpstatus_ptr(false);
     tcg_op = read_fp_sreg(s, rn);
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
     case 0x0: /* FMOV */
         tcg_gen_mov_i32(tcg_res, tcg_op);
-        break;
+        goto done;
     case 0x1: /* FABS */
         gen_helper_vfp_abss(tcg_res, tcg_op);
-        break;
+        goto done;
     case 0x2: /* FNEG */
         gen_helper_vfp_negs(tcg_res, tcg_op);
-        break;
+        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrts(tcg_res, tcg_op, cpu_env);
-        break;
+        goto done;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
     case 0xb: /* FRINTZ */
     case 0xc: /* FRINTA */
-    {
-        TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
-
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-        gen_helper_rints(tcg_res, tcg_op, fpst);
-
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-        tcg_temp_free_i32(tcg_rmode);
+        rmode = arm_rmode_to_sf(opcode & 7);
+        gen_fpst = gen_helper_rints;
         break;
-    }
     case 0xe: /* FRINTX */
-        gen_helper_rints_exact(tcg_res, tcg_op, fpst);
+        gen_fpst = gen_helper_rints_exact;
         break;
     case 0xf: /* FRINTI */
-        gen_helper_rints(tcg_res, tcg_op, fpst);
+        gen_fpst = gen_helper_rints;
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
-    write_fp_sreg(s, rd, tcg_res);
-
+    fpst = get_fpstatus_ptr(false);
+    if (rmode >= 0) {
+        TCGv_i32 tcg_rmode = tcg_const_i32(rmode);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        gen_fpst(tcg_res, tcg_op, fpst);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        tcg_temp_free_i32(tcg_rmode);
+    } else {
+        gen_fpst(tcg_res, tcg_op, fpst);
+    }
     tcg_temp_free_ptr(fpst);
+
+ done:
+    write_fp_sreg(s, rd, tcg_res);
     tcg_temp_free_i32(tcg_op);
     tcg_temp_free_i32(tcg_res);
 }
@@ -5742,9 +5746,10 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 /* Floating-point data-processing (1 source) - double precision */
 static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 {
+    void (*gen_fpst)(TCGv_i64, TCGv_i64, TCGv_ptr);
+    TCGv_i64 tcg_op, tcg_res;
     TCGv_ptr fpst;
-    TCGv_i64 tcg_op;
-    TCGv_i64 tcg_res;
+    int rmode = -1;
 
     switch (opcode) {
     case 0x0: /* FMOV */
@@ -5752,48 +5757,51 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         return;
     }
 
-    fpst = get_fpstatus_ptr(false);
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
     case 0x1: /* FABS */
         gen_helper_vfp_absd(tcg_res, tcg_op);
-        break;
+        goto done;
     case 0x2: /* FNEG */
         gen_helper_vfp_negd(tcg_res, tcg_op);
-        break;
+        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_res, tcg_op, cpu_env);
-        break;
+        goto done;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
     case 0xb: /* FRINTZ */
     case 0xc: /* FRINTA */
-    {
-        TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
-
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-        gen_helper_rintd(tcg_res, tcg_op, fpst);
-
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-        tcg_temp_free_i32(tcg_rmode);
+        rmode = arm_rmode_to_sf(opcode & 7);
+        gen_fpst = gen_helper_rintd;
         break;
-    }
     case 0xe: /* FRINTX */
-        gen_helper_rintd_exact(tcg_res, tcg_op, fpst);
+        gen_fpst = gen_helper_rintd_exact;
         break;
     case 0xf: /* FRINTI */
-        gen_helper_rintd(tcg_res, tcg_op, fpst);
+        gen_fpst = gen_helper_rintd;
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
-    write_fp_dreg(s, rd, tcg_res);
-
+    fpst = get_fpstatus_ptr(false);
+    if (rmode >= 0) {
+        TCGv_i32 tcg_rmode = tcg_const_i32(rmode);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        gen_fpst(tcg_res, tcg_op, fpst);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        tcg_temp_free_i32(tcg_rmode);
+    } else {
+        gen_fpst(tcg_res, tcg_op, fpst);
+    }
     tcg_temp_free_ptr(fpst);
+
+ done:
+    write_fp_dreg(s, rd, tcg_res);
     tcg_temp_free_i64(tcg_op);
     tcg_temp_free_i64(tcg_res);
 }
-- 
2.17.2
