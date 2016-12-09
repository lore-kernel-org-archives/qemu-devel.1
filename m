Received: from eggs.gnu.org ([2001:4830:134:3::10]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK82-00073D-GM
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7x-00036o-Sd
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFK7x-000362-K0
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:13 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CEFM2086125
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:18:12 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtmbc6j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:18:12 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 17:48:09 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 17:47:24 +0530
In-Reply-To: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/6] target-ppc: implement xxextractuw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

xxextractuw: VSX Vector Extract Unsigned Word

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 21 +++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  5 +++++
 4 files changed, 54 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 4707db4..8b30420 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -540,6 +540,7 @@ DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_2(xxperm, void, env, i32)
 DEF_HELPER_2(xxpermr, void, env, i32)
+DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 7989b1f..e3f66ac 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -2033,6 +2033,27 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
 
+void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
+                        target_ulong xbn, uint32_t index)
+{
+    ppc_vsr_t xt, xb;
+    size_t es = sizeof(uint32_t);
+    uint32_t ext_index;
+
+    getVSR(xbn, &xb, env);
+    memset(&xt, 0, sizeof(xt));
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    ext_index = index;
+    memcpy(&xt.u8[8 - es], &xb.u8[ext_index], es);
+#else
+    ext_index = (16 - index) - es;
+    memcpy(&xt.u8[8], &xb.u8[ext_index], es);
+#endif
+
+    putVSR(xtn, &xt, env);
+}
+
 #define VEXT_SIGNED(name, element, mask, cast, recast)              \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 2a17c35..1c40a35 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1180,6 +1180,33 @@ static void gen_xxsldwi(DisasContext *ctx)
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
+    if (uimm > 12) {                                            \
+        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
+        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
+        return;                                                 \
+    }                                                           \
+    xt = tcg_const_tl(xT(ctx->opcode));                         \
+    xb = tcg_const_tl(xB(ctx->opcode));                         \
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
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 46b95e3..473d925 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
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
2.7.4
