Received: from eggs.gnu.org ([2001:4830:134:3::10]:52395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguW-0004yT-N4
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguS-0001ra-4s
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:44 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:41057
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguR-0001r1-Op
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IKVg0071481
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:38 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276nmyprhy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:38 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:35 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:58 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481135102-20011-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 5/9] target-ppc: implement xxextractuw
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
 target-ppc/int_helper.c             | 31 +++++++++++++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  5 +++++
 4 files changed, 64 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 91bdfc3..940f81c 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -536,6 +536,7 @@ DEF_HELPER_2(xvrspic, void, env, i32)
 DEF_HELPER_2(xvrspim, void, env, i32)
 DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
+DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 7030f61..093c5ec 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -2033,6 +2033,37 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
 
+#if defined(HOST_WORDS_BIGENDIAN)
+#define XXEXTRACT(name, element)                                        \
+void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
+                   target_ulong xbn, uint32_t index)                    \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+    uint32_t es = sizeof(xt.element[0]);                                \
+                                                                        \
+    getVSR(xbn, &xb, env);                                              \
+    memset(&xt, 0, sizeof(xt));                                         \
+    memcpy(&xt.u8[8 - es], &xb.u8[index], es);                          \
+    putVSR(xtn, &xt, env);                                              \
+}
+#else
+#define XXEXTRACT(name, element)                                        \
+void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
+                   target_ulong xbn, uint32_t index)                    \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+    uint32_t es = sizeof(xt.element[0]);                                \
+    uint32_t s = (16 - index) - es;                                     \
+                                                                        \
+    getVSR(xbn, &xb, env);                                              \
+    memset(&xt, 0, sizeof(xt));                                         \
+    memcpy(&xt.u8[8], &xb.u8[s], es);                                   \
+    putVSR(xtn, &xt, env);                                              \
+}
+#endif
+XXEXTRACT(xxextractuw, u32)
+#undef XXEXTRACT
+
 #define VEXT_SIGNED(name, element, mask, cast, recast)              \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index c691141..a9c07c9 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1162,6 +1162,33 @@ static void gen_xxsldwi(DisasContext *ctx)
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
index be446ae..3ce657d 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -45,6 +45,10 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2)
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2)
 
+#define GEN_XX2FORM_EXT(name, opc2, opc3, fl2)                          \
+GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0x00100000, PPC_NONE, fl2), \
+GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0x00100000, PPC_NONE, fl2)
+
 #define GEN_XX2FORM_EO(name, opc2, opc3, opc4, fl2)                          \
 GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 0, opc3, opc4, 0, PPC_NONE, fl2), \
 GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 1, opc3, opc4, 0, PPC_NONE, fl2)
@@ -272,6 +276,7 @@ GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
 GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
+GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
 
 #define GEN_XXSEL_ROW(opc3) \
 GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX), \
-- 
2.7.4
