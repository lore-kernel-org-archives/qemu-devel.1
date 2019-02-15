Received: from eggs.gnu.org ([209.51.188.92]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJq-0006mp-2m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000PO-CS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:44 +0000
Message-Id: <20190215100058.20015-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/17] target/ppc: convert vspltis[bhw] to use
 vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  3 ---
 target/ppc/int_helper.c             | 15 ---------------
 target/ppc/translate/vmx-impl.inc.c | 36 ++++++++----------------------------
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
index ffccda8b9b..2f793a3543 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1998,21 +1998,6 @@ VNEG(vnegw, s32)
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
index b104c6e38e..c26c342e16 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -704,25 +704,21 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
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
@@ -802,22 +798,6 @@ GEN_VXFORM_NOA(vprtybw, 1, 24);
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
@@ -1240,7 +1220,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
 #undef GEN_VXRFORM_DUAL
 #undef GEN_VXRFORM1
 #undef GEN_VXRFORM
-#undef GEN_VXFORM_SIMM
+#undef GEN_VXFORM_DUPI
 #undef GEN_VXFORM_NOA
 #undef GEN_VXFORM_UIMM
 #undef GEN_VAFORM_PAIRED
-- 
2.11.0
