Received: from eggs.gnu.org ([2001:4830:134:3::10]:53334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ936-0001x9-Nb
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0002y5-Gf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:12 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92v-0002OY-2i
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:01 -0500
Received: by mail-pf1-x441.google.com with SMTP id y126so7654008pfb.4
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:56 -0800
Message-Id: <20181218063911.2112-20-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/34] target/ppc: convert vspltis[bhw] to use
 vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  3 ---
 target/ppc/int_helper.c             | 15 ------------
 target/ppc/translate/vmx-impl.inc.c | 36 +++++++----------------------
 3 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 553ff500c8..2aa60e5d36 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -246,9 +246,6 @@ DEF_HELPER_3(vrld, void, avr, avr, avr)
 DEF_HELPER_3(vsl, void, avr, avr, avr)
 DEF_HELPER_3(vsr, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
-DEF_HELPER_2(vspltisb, void, avr, i32)
-DEF_HELPER_2(vspltish, void, avr, i32)
-DEF_HELPER_2(vspltisw, void, avr, i32)
 DEF_HELPER_3(vspltb, void, avr, avr, i32)
 DEF_HELPER_3(vsplth, void, avr, avr, i32)
 DEF_HELPER_3(vspltw, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 4547453ef1..e44c0d90ee 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2066,21 +2066,6 @@ VNEG(vnegw, s32)
 VNEG(vnegd, s64)
 #undef VNEG
 
-#define VSPLTI(suffix, element, splat_type)                     \
-    void helper_vspltis##suffix(ppc_avr_t *r, uint32_t splat)   \
-    {                                                           \
-        splat_type x = (int8_t)(splat << 3) >> 3;               \
-        int i;                                                  \
-                                                                \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {          \
-            r->element[i] = x;                                  \
-        }                                                       \
-    }
-VSPLTI(b, s8, int8_t)
-VSPLTI(h, s16, int16_t)
-VSPLTI(w, s32, int32_t)
-#undef VSPLTI
-
 #define VSR(suffix, element, mask)                                      \
     void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
     {                                                                   \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index e353d3f174..be638cdb1a 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -720,25 +720,21 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
 GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
                  vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
 
-#define GEN_VXFORM_SIMM(name, opc2, opc3)                               \
+#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
 static void glue(gen_, name)(DisasContext *ctx)                         \
     {                                                                   \
-        TCGv_ptr rd;                                                    \
-        TCGv_i32 simm;                                                  \
+        int simm;                                                       \
         if (unlikely(!ctx->altivec_enabled)) {                          \
             gen_exception(ctx, POWERPC_EXCP_VPU);                       \
             return;                                                     \
         }                                                               \
-        simm = tcg_const_i32(SIMM5(ctx->opcode));                       \
-        rd = gen_avr_ptr(rD(ctx->opcode));                              \
-        gen_helper_##name (rd, simm);                                   \
-        tcg_temp_free_i32(simm);                                        \
-        tcg_temp_free_ptr(rd);                                          \
+        simm = SIMM5(ctx->opcode);                                      \
+        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
     }
 
-GEN_VXFORM_SIMM(vspltisb, 6, 12);
-GEN_VXFORM_SIMM(vspltish, 6, 13);
-GEN_VXFORM_SIMM(vspltisw, 6, 14);
+GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
+GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
+GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
 
 #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
 static void glue(gen_, name)(DisasContext *ctx)                                 \
@@ -818,22 +814,6 @@ GEN_VXFORM_NOA(vprtybw, 1, 24);
 GEN_VXFORM_NOA(vprtybd, 1, 24);
 GEN_VXFORM_NOA(vprtybq, 1, 24);
 
-#define GEN_VXFORM_SIMM(name, opc2, opc3)                               \
-static void glue(gen_, name)(DisasContext *ctx)                                 \
-    {                                                                   \
-        TCGv_ptr rd;                                                    \
-        TCGv_i32 simm;                                                  \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        simm = tcg_const_i32(SIMM5(ctx->opcode));                       \
-        rd = gen_avr_ptr(rD(ctx->opcode));                              \
-        gen_helper_##name (rd, simm);                                   \
-        tcg_temp_free_i32(simm);                                        \
-        tcg_temp_free_ptr(rd);                                          \
-    }
-
 #define GEN_VXFORM_UIMM(name, opc2, opc3)                               \
 static void glue(gen_, name)(DisasContext *ctx)                                 \
     {                                                                   \
@@ -1255,7 +1235,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
 #undef GEN_VXRFORM_DUAL
 #undef GEN_VXRFORM1
 #undef GEN_VXRFORM
-#undef GEN_VXFORM_SIMM
+#undef GEN_VXFORM_DUPI
 #undef GEN_VXFORM_NOA
 #undef GEN_VXFORM_UIMM
 #undef GEN_VAFORM_PAIRED
-- 
2.17.2
