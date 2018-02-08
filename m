Received: from eggs.gnu.org ([2001:4830:134:3::10]:57277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBS-0002w3-Vh
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBR-0000R3-IY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:30 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejqBR-0000QZ-8q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:29 -0500
Received: by mail-wr0-x242.google.com with SMTP id v31so5567234wrc.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:40:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:46 +0000
Message-Id: <20180208173157.24705-22-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/32] arm/translate-a64: add FP16
 SCVTF/UCVFT to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

I've re-factored the handle_simd_intfp_conv helper to properly handle
half-precision as well as call plain conversion helpers when we are
not doing fixed point conversion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c        |   4 ++
 target/arm/helper.h        |  10 ++++
 target/arm/translate-a64.c | 121 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 108 insertions(+), 27 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 72522c125c..d2ef3a0f00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10883,8 +10883,10 @@ CONV_ITOF(vfp_##name##to##p, fsz, sign) \
 CONV_FTOI(vfp_to##name##p, fsz, sign, ) \
 CONV_FTOI(vfp_to##name##z##p, fsz, sign, _round_to_zero)
 
+FLOAT_CONVS(si, h, 16, )
 FLOAT_CONVS(si, s, 32, )
 FLOAT_CONVS(si, d, 64, )
+FLOAT_CONVS(ui, h, 16, u)
 FLOAT_CONVS(ui, s, 32, u)
 FLOAT_CONVS(ui, d, 64, u)
 
@@ -10967,6 +10969,8 @@ VFP_CONV_FIX_A64(sq, s, 32, 64, int64)
 VFP_CONV_FIX(uh, s, 32, 32, uint16)
 VFP_CONV_FIX(ul, s, 32, 32, uint32)
 VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
+VFP_CONV_FIX_A64(sl, h, 16, 32, int32)
+VFP_CONV_FIX_A64(ul, h, 16, 32, uint32)
 #undef VFP_CONV_FIX
 #undef VFP_CONV_FIX_FLOAT
 #undef VFP_CONV_FLOAT_FIX_ROUND
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 40dcd74cfd..fcdb2b1520 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -120,17 +120,23 @@ DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
 DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
 DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
 
+DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
 DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
 DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
+DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
 DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
 DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
 
+DEF_HELPER_2(vfp_touih, i32, f16, ptr)
 DEF_HELPER_2(vfp_touis, i32, f32, ptr)
 DEF_HELPER_2(vfp_touid, i32, f64, ptr)
+DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
 DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
 DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
+DEF_HELPER_2(vfp_tosih, i32, f16, ptr)
 DEF_HELPER_2(vfp_tosis, i32, f32, ptr)
 DEF_HELPER_2(vfp_tosid, i32, f64, ptr)
+DEF_HELPER_2(vfp_tosizh, i32, f16, ptr)
 DEF_HELPER_2(vfp_tosizs, i32, f32, ptr)
 DEF_HELPER_2(vfp_tosizd, i32, f64, ptr)
 
@@ -142,6 +148,8 @@ DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
@@ -166,6 +174,8 @@ DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
 
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0efe9ae2fc..5baf0261ff 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6862,23 +6862,28 @@ static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
                                    int fracbits, int size)
 {
-    bool is_double = size == 3 ? true : false;
-    TCGv_ptr tcg_fpst = get_fpstatus_ptr(false);
-    TCGv_i32 tcg_shift = tcg_const_i32(fracbits);
-    TCGv_i64 tcg_int = tcg_temp_new_i64();
+    TCGv_ptr tcg_fpst = get_fpstatus_ptr(size == MO_16);
+    TCGv_i32 tcg_shift = NULL;
+
     TCGMemOp mop = size | (is_signed ? MO_SIGN : 0);
     int pass;
 
-    for (pass = 0; pass < elements; pass++) {
-        read_vec_element(s, tcg_int, rn, pass, mop);
+    if (fracbits || size == MO_64) {
+        tcg_shift = tcg_const_i32(fracbits);
+    }
+
+    if (size == MO_64) {
+        TCGv_i64 tcg_int64 = tcg_temp_new_i64();
+        TCGv_i64 tcg_double = tcg_temp_new_i64();
+
+        for (pass = 0; pass < elements; pass++) {
+            read_vec_element(s, tcg_int64, rn, pass, mop);
 
-        if (is_double) {
-            TCGv_i64 tcg_double = tcg_temp_new_i64();
             if (is_signed) {
-                gen_helper_vfp_sqtod(tcg_double, tcg_int,
+                gen_helper_vfp_sqtod(tcg_double, tcg_int64,
                                      tcg_shift, tcg_fpst);
             } else {
-                gen_helper_vfp_uqtod(tcg_double, tcg_int,
+                gen_helper_vfp_uqtod(tcg_double, tcg_int64,
                                      tcg_shift, tcg_fpst);
             }
             if (elements == 1) {
@@ -6886,32 +6891,77 @@ static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
             } else {
                 write_vec_element(s, tcg_double, rd, pass, MO_64);
             }
-            tcg_temp_free_i64(tcg_double);
-        } else {
-            TCGv_i32 tcg_single = tcg_temp_new_i32();
-            if (is_signed) {
-                gen_helper_vfp_sqtos(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpst);
-            } else {
-                gen_helper_vfp_uqtos(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpst);
+        }
+
+        tcg_temp_free_i64(tcg_int64);
+        tcg_temp_free_i64(tcg_double);
+
+    } else {
+        TCGv_i32 tcg_int32 = tcg_temp_new_i32();
+        TCGv_i32 tcg_float = tcg_temp_new_i32();
+
+        for (pass = 0; pass < elements; pass++) {
+            read_vec_element_i32(s, tcg_int32, rn, pass, mop);
+
+            switch (size) {
+            case MO_32:
+                if (fracbits) {
+                    if (is_signed) {
+                        gen_helper_vfp_sltos(tcg_float, tcg_int32,
+                                             tcg_shift, tcg_fpst);
+                    } else {
+                        gen_helper_vfp_ultos(tcg_float, tcg_int32,
+                                             tcg_shift, tcg_fpst);
+                    }
+                } else {
+                    if (is_signed) {
+                        gen_helper_vfp_sitos(tcg_float, tcg_int32, tcg_fpst);
+                    } else {
+                        gen_helper_vfp_uitos(tcg_float, tcg_int32, tcg_fpst);
+                    }
+                }
+                break;
+            case MO_16:
+                if (fracbits) {
+                    if (is_signed) {
+                        gen_helper_vfp_sltoh(tcg_float, tcg_int32,
+                                             tcg_shift, tcg_fpst);
+                    } else {
+                        gen_helper_vfp_ultoh(tcg_float, tcg_int32,
+                                             tcg_shift, tcg_fpst);
+                    }
+                } else {
+                    if (is_signed) {
+                        gen_helper_vfp_sitoh(tcg_float, tcg_int32, tcg_fpst);
+                    } else {
+                        gen_helper_vfp_uitoh(tcg_float, tcg_int32, tcg_fpst);
+                    }
+                }
+                break;
+            default:
+                g_assert_not_reached();
             }
+
             if (elements == 1) {
-                write_fp_sreg(s, rd, tcg_single);
+                write_fp_sreg(s, rd, tcg_float);
             } else {
-                write_vec_element_i32(s, tcg_single, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_float, rd, pass, size);
             }
-            tcg_temp_free_i32(tcg_single);
         }
-    }
 
-    if (!is_double && elements == 2) {
-        clear_vec_high(s, rd);
+        tcg_temp_free_i32(tcg_int32);
+        tcg_temp_free_i32(tcg_float);
+
+        if ((size == MO_32 && elements == 2) ||
+            (size == MO_16 && elements == 4)) {
+            clear_vec_high(s, rd);
+        }
     }
 
-    tcg_temp_free_i64(tcg_int);
     tcg_temp_free_ptr(tcg_fpst);
-    tcg_temp_free_i32(tcg_shift);
+    if (tcg_shift) {
+        tcg_temp_free_i32(tcg_shift);
+    }
 }
 
 /* UCVTF/SCVTF - Integer to FP conversion */
@@ -10771,6 +10821,23 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     rn = extract32(insn, 5, 5);
 
     switch (fpop) {
+    case 0x1d: /* SCVTF */
+    case 0x5d: /* UCVTF */
+    {
+        int elements;
+
+        if (is_scalar) {
+            elements = 1;
+        } else {
+            elements = (is_q ? 8 : 4);
+        }
+
+        if (!fp_access_check(s)) {
+            return;
+        }
+        handle_simd_intfp_conv(s, rd, rn, elements, !u, 0, MO_16);
+        return;
+    }
     break;
     case 0x2c: /* FCMGT (zero) */
     case 0x2d: /* FCMEQ (zero) */
-- 
2.15.1
