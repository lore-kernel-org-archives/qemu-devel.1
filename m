Received: from eggs.gnu.org ([2001:4830:134:3::10]:53260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ934-0001sJ-KN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0002xK-1i
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:10 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92u-0002tc-MX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:00 -0500
Received: by mail-pf1-x444.google.com with SMTP id h3so7665511pfg.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:10 -0800
Message-Id: <20181218063911.2112-34-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 33/34] target/ppc: convert vadd*s and vsub*s to
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
 target/ppc/helper.h                 | 24 ++++++------
 target/ppc/int_helper.c             | 18 ++-------
 target/ppc/translate/vmx-impl.inc.c | 57 +++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 38 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7dbb08b9dd..3daf6bf863 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -219,18 +219,18 @@ DEF_HELPER_2(vprtybq, void, avr, avr)
 DEF_HELPER_3(vsubcuw, void, avr, avr, avr)
 DEF_HELPER_2(lvsl, void, avr, tl)
 DEF_HELPER_2(lvsr, void, avr, tl)
-DEF_HELPER_4(vaddsbs, void, env, avr, avr, avr)
-DEF_HELPER_4(vaddshs, void, env, avr, avr, avr)
-DEF_HELPER_4(vaddsws, void, env, avr, avr, avr)
-DEF_HELPER_4(vsubsbs, void, env, avr, avr, avr)
-DEF_HELPER_4(vsubshs, void, env, avr, avr, avr)
-DEF_HELPER_4(vsubsws, void, env, avr, avr, avr)
-DEF_HELPER_4(vaddubs, void, env, avr, avr, avr)
-DEF_HELPER_4(vadduhs, void, env, avr, avr, avr)
-DEF_HELPER_4(vadduws, void, env, avr, avr, avr)
-DEF_HELPER_4(vsububs, void, env, avr, avr, avr)
-DEF_HELPER_4(vsubuhs, void, env, avr, avr, avr)
-DEF_HELPER_4(vsubuws, void, env, avr, avr, avr)
+DEF_HELPER_FLAGS_5(vaddsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vaddshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vaddsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsubsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsubshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsubsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vaddubs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vadduhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vadduws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsububs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsubuhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(vsubuws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
 DEF_HELPER_3(vadduqm, void, avr, avr, avr)
 DEF_HELPER_4(vaddecuq, void, avr, avr, avr, avr)
 DEF_HELPER_4(vaddeuqm, void, avr, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 9dbcbcd87a..22671c71e5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -583,27 +583,17 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
     }
 
 #define VARITHSAT_DO(name, op, optype, cvt, element)                    \
-    void helper_v##name(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,   \
-                        ppc_avr_t *b)                                   \
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
+                        ppc_avr_t *a, ppc_avr_t *b, uint32_t desc)      \
     {                                                                   \
         int sat = 0;                                                    \
         int i;                                                          \
                                                                         \
         for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            switch (sizeof(r->element[0])) {                            \
-            case 1:                                                     \
-                VARITHSAT_CASE(optype, op, cvt, element);               \
-                break;                                                  \
-            case 2:                                                     \
-                VARITHSAT_CASE(optype, op, cvt, element);               \
-                break;                                                  \
-            case 4:                                                     \
-                VARITHSAT_CASE(optype, op, cvt, element);               \
-                break;                                                  \
-            }                                                           \
+            VARITHSAT_CASE(optype, op, cvt, element);                   \
         }                                                               \
         if (sat) {                                                      \
-            set_vscr_sat(env);                                          \
+            vscr_sat->u32[0] = 1;                                       \
         }                                                               \
     }
 #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 1c0c461241..c6a53a9f63 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -548,22 +548,55 @@ GEN_VXFORM(vslo, 6, 16);
 GEN_VXFORM(vsro, 6, 17);
 GEN_VXFORM(vaddcuw, 0, 6);
 GEN_VXFORM(vsubcuw, 0, 22);
-GEN_VXFORM_ENV(vaddubs, 0, 8);
+
+#define GEN_VXFORM_SAT(NAME, VECE, NORM, SAT, OPC2, OPC3)               \
+static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
+                                         TCGv_vec sat, TCGv_vec a,      \
+                                         TCGv_vec b)                    \
+{                                                                       \
+    TCGv_vec x = tcg_temp_new_vec_matching(t);                          \
+    glue(glue(tcg_gen_, NORM), _vec)(VECE, x, a, b);                    \
+    glue(glue(tcg_gen_, SAT), _vec)(VECE, t, a, b);                     \
+    tcg_gen_cmp_vec(TCG_COND_NE, VECE, x, x, t);                        \
+    tcg_gen_or_vec(VECE, sat, sat, x);                                  \
+    tcg_temp_free_vec(x);                                               \
+}                                                                       \
+static void glue(gen_, NAME)(DisasContext *ctx)                         \
+{                                                                       \
+    static const GVecGen4 g = {                                         \
+        .fniv = glue(glue(gen_, NAME), _vec),                           \
+        .fno = glue(gen_helper_, NAME),                                 \
+        .opc = glue(glue(INDEX_op_, NORM), _vec),                       \
+        .write_aofs = true,                                             \
+        .vece = VECE,                                                   \
+    };                                                                  \
+    if (unlikely(!ctx->altivec_enabled)) {                              \
+        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
+        return;                                                         \
+    }                                                                   \
+    tcg_gen_gvec_4(avr64_offset(rD(ctx->opcode), true),                 \
+                   offsetof(CPUPPCState, vscr_sat),                     \
+                   avr64_offset(rA(ctx->opcode), true),                 \
+                   avr64_offset(rB(ctx->opcode), true),                 \
+                   16, 16, &g);                                         \
+}
+
+GEN_VXFORM_SAT(vaddubs, MO_8, add, usadd, 0, 8);
 GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10uq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM_ENV(vadduhs, 0, 9);
+GEN_VXFORM_SAT(vadduhs, MO_16, add, usadd, 0, 9);
 GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
                 vmul10euq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_ENV(vadduws, 0, 10);
-GEN_VXFORM_ENV(vaddsbs, 0, 12);
-GEN_VXFORM_ENV(vaddshs, 0, 13);
-GEN_VXFORM_ENV(vaddsws, 0, 14);
-GEN_VXFORM_ENV(vsububs, 0, 24);
-GEN_VXFORM_ENV(vsubuhs, 0, 25);
-GEN_VXFORM_ENV(vsubuws, 0, 26);
-GEN_VXFORM_ENV(vsubsbs, 0, 28);
-GEN_VXFORM_ENV(vsubshs, 0, 29);
-GEN_VXFORM_ENV(vsubsws, 0, 30);
+GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
+GEN_VXFORM_SAT(vaddsbs, MO_8, add, ssadd, 0, 12);
+GEN_VXFORM_SAT(vaddshs, MO_16, add, ssadd, 0, 13);
+GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
+GEN_VXFORM_SAT(vsububs, MO_8, sub, ussub, 0, 24);
+GEN_VXFORM_SAT(vsubuhs, MO_16, sub, ussub, 0, 25);
+GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
+GEN_VXFORM_SAT(vsubsbs, MO_8, sub, sssub, 0, 28);
+GEN_VXFORM_SAT(vsubshs, MO_16, sub, sssub, 0, 29);
+GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
 GEN_VXFORM(vadduqm, 0, 4);
 GEN_VXFORM(vaddcuq, 0, 5);
 GEN_VXFORM3(vaddeuqm, 30, 0);
-- 
2.17.2
