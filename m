Received: from eggs.gnu.org ([2001:4830:134:3::10]:53325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ936-0001wc-B0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0002yS-LJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:12 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92v-0002S1-6H
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:01 -0500
Received: by mail-pf1-x443.google.com with SMTP id r136so592943pfc.6
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:57 -0800
Message-Id: <20181218063911.2112-21-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/34] target/ppc: convert vsplt[bhw] to use
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
 target/ppc/helper.h                 |  3 --
 target/ppc/int_helper.c             | 24 ---------------
 target/ppc/translate/vmx-impl.inc.c | 45 +++++++++++++++++------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2aa60e5d36..069daa9883 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -246,9 +246,6 @@ DEF_HELPER_3(vrld, void, avr, avr, avr)
 DEF_HELPER_3(vsl, void, avr, avr, avr)
 DEF_HELPER_3(vsr, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
-DEF_HELPER_3(vspltb, void, avr, avr, i32)
-DEF_HELPER_3(vsplth, void, avr, avr, i32)
-DEF_HELPER_3(vspltw, void, avr, avr, i32)
 DEF_HELPER_3(vextractub, void, avr, avr, i32)
 DEF_HELPER_3(vextractuh, void, avr, avr, i32)
 DEF_HELPER_3(vextractuw, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index e44c0d90ee..3bf0fdb6c5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1918,30 +1918,6 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #endif
 }
 
-/* Experimental testing shows that hardware masks the immediate.  */
-#define _SPLAT_MASKED(element) (splat & (ARRAY_SIZE(r->element) - 1))
-#if defined(HOST_WORDS_BIGENDIAN)
-#define SPLAT_ELEMENT(element) _SPLAT_MASKED(element)
-#else
-#define SPLAT_ELEMENT(element)                                  \
-    (ARRAY_SIZE(r->element) - 1 - _SPLAT_MASKED(element))
-#endif
-#define VSPLT(suffix, element)                                          \
-    void helper_vsplt##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t splat) \
-    {                                                                   \
-        uint32_t s = b->element[SPLAT_ELEMENT(element)];                \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            r->element[i] = s;                                          \
-        }                                                               \
-    }
-VSPLT(b, u8)
-VSPLT(h, u16)
-VSPLT(w, u32)
-#undef VSPLT
-#undef SPLAT_ELEMENT
-#undef _SPLAT_MASKED
 #if defined(HOST_WORDS_BIGENDIAN)
 #define VINSERT(suffix, element)                                            \
     void helper_vinsert##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index be638cdb1a..529ae0e5f5 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -814,24 +814,31 @@ GEN_VXFORM_NOA(vprtybw, 1, 24);
 GEN_VXFORM_NOA(vprtybd, 1, 24);
 GEN_VXFORM_NOA(vprtybq, 1, 24);
 
-#define GEN_VXFORM_UIMM(name, opc2, opc3)                               \
-static void glue(gen_, name)(DisasContext *ctx)                                 \
-    {                                                                   \
-        TCGv_ptr rb, rd;                                                \
-        TCGv_i32 uimm;                                                  \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        uimm = tcg_const_i32(UIMM5(ctx->opcode));                       \
-        rb = gen_avr_ptr(rB(ctx->opcode));                              \
-        rd = gen_avr_ptr(rD(ctx->opcode));                              \
-        gen_helper_##name (rd, rb, uimm);                               \
-        tcg_temp_free_i32(uimm);                                        \
-        tcg_temp_free_ptr(rb);                                          \
-        tcg_temp_free_ptr(rd);                                          \
+static void gen_vsplt(DisasContext *ctx, int vece)
+{
+    int uimm, dofs, bofs;
+
+    if (unlikely(!ctx->altivec_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VPU);
+        return;
     }
 
+    uimm = UIMM5(ctx->opcode);
+    bofs = avr64_offset(rB(ctx->opcode), true);
+    dofs = avr64_offset(rD(ctx->opcode), true);
+
+    /* Experimental testing shows that hardware masks the immediate.  */
+    bofs += (uimm << vece) & 15;
+#ifndef HOST_WORDS_BIGENDIAN
+    bofs ^= 15;
+#endif
+
+    tcg_gen_gvec_dup_mem(vece, dofs, bofs, 16, 16);
+}
+
+#define GEN_VXFORM_VSPLT(name, vece, opc2, opc3) \
+static void glue(gen_, name)(DisasContext *ctx) { gen_vsplt(ctx, vece); }
+
 #define GEN_VXFORM_UIMM_ENV(name, opc2, opc3)                           \
 static void glue(gen_, name)(DisasContext *ctx)                         \
     {                                                                   \
@@ -873,9 +880,9 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
         tcg_temp_free_ptr(rd);                                          \
     }
 
-GEN_VXFORM_UIMM(vspltb, 6, 8);
-GEN_VXFORM_UIMM(vsplth, 6, 9);
-GEN_VXFORM_UIMM(vspltw, 6, 10);
+GEN_VXFORM_VSPLT(vspltb, MO_8, 6, 8);
+GEN_VXFORM_VSPLT(vsplth, MO_16, 6, 9);
+GEN_VXFORM_VSPLT(vspltw, MO_32, 6, 10);
 GEN_VXFORM_UIMM_SPLAT(vextractub, 6, 8, 15);
 GEN_VXFORM_UIMM_SPLAT(vextractuh, 6, 9, 14);
 GEN_VXFORM_UIMM_SPLAT(vextractuw, 6, 10, 12);
-- 
2.17.2
