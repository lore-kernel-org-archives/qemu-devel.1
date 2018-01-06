Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew4-0007d9-4d
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew2-0005QZ-Tt
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:16 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXew2-0005P7-NT
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:14 -0500
Received: by mail-pg0-x241.google.com with SMTP id q67so2709665pga.9
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:14 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:38 -0800
Message-Id: <20180106031346.6650-16-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 15/23] target/arm: Use vector infrastructure
 for aa64 mov/not/neg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 572af456d1..bc14c28e71 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -85,6 +85,7 @@ typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 
 /* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
@@ -4579,14 +4580,19 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i64 tcg_op;
     TCGv_i64 tcg_res;
 
+    switch (opcode) {
+    case 0x0: /* FMOV */
+        tcg_gen_gvec_mov(0, vec_full_reg_offset(s, rd),
+                         vec_full_reg_offset(s, rn),
+                         8, vec_full_reg_size(s));
+        return;
+    }
+
     fpst = get_fpstatus_ptr();
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i64(tcg_res, tcg_op);
-        break;
     case 0x1: /* FABS */
         gen_helper_vfp_absd(tcg_res, tcg_op);
         break;
@@ -9153,6 +9159,12 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         gvec_fn = tcg_gen_gvec_andc;
         goto do_fn;
     case 2: /* ORR */
+        if (rn == rm) { /* MOV */
+            tcg_gen_gvec_mov(0, vec_full_reg_offset(s, rd),
+                             vec_full_reg_offset(s, rn),
+                             is_q ? 16 : 8, vec_full_reg_size(s));
+            return;
+        }
         gvec_fn = tcg_gen_gvec_or;
         goto do_fn;
     case 3: /* ORN */
@@ -10032,6 +10044,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     int rmode = -1;
     TCGv_i32 tcg_rmode;
     TCGv_ptr tcg_fpstatus;
+    GVecGen2Fn *gvec_fn;
 
     switch (opcode) {
     case 0x0: /* REV64, REV32 */
@@ -10040,8 +10053,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         return;
     case 0x5: /* CNT, NOT, RBIT */
         if (u && size == 0) {
-            /* NOT: adjust size so we can use the 64-bits-at-a-time loop. */
-            size = 3;
+            /* NOT */
             break;
         } else if (u && size == 1) {
             /* RBIT */
@@ -10293,6 +10305,27 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         tcg_rmode = NULL;
     }
 
+    switch (opcode) {
+    case 0x5:
+        if (u && size == 0) { /* NOT */
+            gvec_fn = tcg_gen_gvec_not;
+            goto do_fn;
+        }
+        break;
+    case 0xb:
+        if (u) { /* NEG */
+            gvec_fn = tcg_gen_gvec_neg;
+            goto do_fn;
+        }
+        break;
+
+    do_fn:
+        gvec_fn(size, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+    }
+
     if (size == 3) {
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
-- 
2.14.3
