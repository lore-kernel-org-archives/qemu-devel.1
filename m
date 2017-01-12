Received: from eggs.gnu.org ([2001:4830:134:3::10]:46706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk9-00038x-3o
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk6-0006g1-5R
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:06 +1100
Message-Id: <20170112020327.24882-47-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 46/67] target-ppc: Add xxextractuw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xxextractuw: VSX Vector Extract Unsigned Word

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 26 ++++++++++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  5 +++++
 4 files changed, 62 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 4707db4..8b30420 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -540,6 +540,7 @@ DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_2(xxperm, void, env, i32)
 DEF_HELPER_2(xxpermr, void, env, i32)
+DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 2bb628f..63ba0e3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2033,6 +2033,32 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
 
+void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
+                        target_ulong xbn, uint32_t index)
+{
+    ppc_vsr_t xt, xb;
+    size_t es = sizeof(uint32_t);
+    uint32_t ext_index;
+    int i;
+
+    getVSR(xbn, &xb, env);
+    memset(&xt, 0, sizeof(xt));
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    ext_index = index;
+    for (i = 0; i < es; i++, ext_index++) {
+        xt.u8[8 - es + i] = xb.u8[ext_index % 16];
+    }
+#else
+    ext_index = 15 - index;
+    for (i = es - 1; i >= 0; i--, ext_index--) {
+        xt.u8[8 + i] = xb.u8[ext_index % 16];
+    }
+#endif
+
+    putVSR(xtn, &xt, env);
+}
+
 #define VEXT_SIGNED(name, element, mask, cast, recast)              \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 2a17c35..7977f24 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1180,6 +1180,36 @@ static void gen_xxsldwi(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
+#define VSX_EXTRACT(name)                                       \
+static void gen_##name(DisasContext *ctx)                       \
+{                                                               \
+    TCGv xt, xb;                                                \
+    TCGv_i32 t0 = tcg_temp_new_i32();                           \
+    uint8_t uimm = UIMM4(ctx->opcode);                          \
+                                                                \
+    if (unlikely(!ctx->vsx_enabled)) {                          \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
+        return;                                                 \
+    }                                                           \
+    xt = tcg_const_tl(xT(ctx->opcode));                         \
+    xb = tcg_const_tl(xB(ctx->opcode));                         \
+    /* uimm > 15 out of bound and for                           \
+     * uimm > 12 handle as per hardware in helper               \
+     */                                                         \
+    if (uimm > 15) {                                            \
+        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
+        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
+        return;                                                 \
+    }                                                           \
+    tcg_gen_movi_i32(t0, uimm);                                 \
+    gen_helper_##name(cpu_env, xt, xb, t0);                     \
+    tcg_temp_free(xb);                                          \
+    tcg_temp_free(xt);                                          \
+    tcg_temp_free_i32(t0);                                      \
+}
+
+VSX_EXTRACT(xxextractuw)
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 46b95e3..473d925 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -49,6 +49,10 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2)
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2)
 
+#define GEN_XX2FORM_EXT(name, opc2, opc3, fl2)                          \
+GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0x00100000, PPC_NONE, fl2), \
+GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0x00100000, PPC_NONE, fl2)
+
 #define GEN_XX2FORM_EO(name, opc2, opc3, opc4, fl2)                          \
 GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 0, opc3, opc4, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 1, opc3, opc4, 0, PPC_NONE, fl2)
@@ -280,6 +284,7 @@ GEN_XX3FORM(xxpermr, 0x08, 0x07, PPC2_ISA300),
 GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
+GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
 
 #define GEN_XXSEL_ROW(opc3) \
 GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX), \
-- 
2.9.3
