Received: from eggs.gnu.org ([2001:4830:134:3::10]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEgub-00052W-Nm
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguX-0001tD-7d
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:49 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:57465
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguW-0001sj-NN
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IJw9x008876
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:43 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276jhcsp78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:43 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:39 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:59 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481135102-20011-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 6/9] target-ppc: implement xxinsertw
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

xxinsertw: VSX Vector Insert Word

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 30 ++++++++++++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c |  5 +++--
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 940f81c..9f812c8 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -537,6 +537,7 @@ DEF_HELPER_2(xvrspim, void, env, i32)
 DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 093c5ec..b6e8c37 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -2064,6 +2064,36 @@ void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
 XXEXTRACT(xxextractuw, u32)
 #undef XXEXTRACT
 
+#if defined(HOST_WORDS_BIGENDIAN)
+#define XXINSERT(name, element)                                         \
+void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
+                   target_ulong xbn, uint32_t index)                    \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+                                                                        \
+    getVSR(xbn, &xb, env);                                              \
+    getVSR(xtn, &xt, env);                                              \
+    memmove(&xt.u8[index], &xb.u8[8 - sizeof(xt.element)],              \
+            sizeof(xt.element[0]));                                     \
+    putVSR(xtn, &xt, env);                                              \
+}
+#else
+#define XXINSERT(name, element)                                         \
+void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
+                   target_ulong xbn, uint32_t index)                    \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+    uint32_t d = (16 - index) - sizeof(xt.element[0]);                  \
+                                                                        \
+    getVSR(xbn, &xb, env);                                              \
+    getVSR(xtn, &xt, env);                                              \
+    memmove(&xt.u8[d], &xb.u8[8], sizeof(xt.element[0]));               \
+    putVSR(xtn, &xt, env);                                              \
+}
+#endif
+XXINSERT(xxinsertw, u32)
+#undef XXINSERT
+
 #define VEXT_SIGNED(name, element, mask, cast, recast)              \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index a9c07c9..6a81b2e 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1162,7 +1162,7 @@ static void gen_xxsldwi(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
-#define VSX_EXTRACT(name)                                       \
+#define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
     TCGv xt, xb;                                                \
@@ -1187,7 +1187,8 @@ static void gen_##name(DisasContext *ctx)                       \
     tcg_temp_free_i32(t0);                                      \
 }
 
-VSX_EXTRACT(xxextractuw)
+VSX_EXTRACT_INSERT(xxextractuw)
+VSX_EXTRACT_INSERT(xxinsertw)
 
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 3ce657d..0216efe 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -277,6 +277,7 @@ GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
 GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
+GEN_XX2FORM_EXT(xxinsertw, 0x0A, 0x0B, PPC2_ISA300),
 
 #define GEN_XXSEL_ROW(opc3) \
 GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX), \
-- 
2.7.4
