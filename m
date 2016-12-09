Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK88-0007OD-3h
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK82-000397-9h
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFK82-00038b-13
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CEE7c086025
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:18:17 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtmbcb4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:18:16 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 17:48:13 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 17:47:25 +0530
In-Reply-To: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481285845-16415-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 6/6] target-ppc: implement xxinsertw
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
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 21 +++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c |  5 +++--
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 8b30420..6c5b194 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -541,6 +541,7 @@ DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_2(xxperm, void, env, i32)
 DEF_HELPER_2(xxpermr, void, env, i32)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index e3f66ac..4d7eab6 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -2054,6 +2054,27 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
     putVSR(xtn, &xt, env);
 }
 
+void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
+                      target_ulong xbn, uint32_t index)
+{
+    ppc_vsr_t xt, xb;
+    size_t es = sizeof(uint32_t);
+    uint32_t ins_index;
+
+    getVSR(xbn, &xb, env);
+    getVSR(xtn, &xt, env);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    ins_index = index;
+    memcpy(&xt.u8[ins_index], &xb.u8[8 - es], es);
+#else
+    ins_index = (16 - index) - es;
+    memcpy(&xt.u8[ins_index], &xb.u8[8], es);
+#endif
+
+    putVSR(xtn, &xt, env);
+}
+
 #define VEXT_SIGNED(name, element, mask, cast, recast)              \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 1c40a35..9124e99 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1180,7 +1180,7 @@ static void gen_xxsldwi(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
-#define VSX_EXTRACT(name)                                       \
+#define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
     TCGv xt, xb;                                                \
@@ -1205,7 +1205,8 @@ static void gen_##name(DisasContext *ctx)                       \
     tcg_temp_free_i32(t0);                                      \
 }
 
-VSX_EXTRACT(xxextractuw)
+VSX_EXTRACT_INSERT(xxextractuw)
+VSX_EXTRACT_INSERT(xxinsertw)
 
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 473d925..096d358 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -285,6 +285,7 @@ GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
 GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
+GEN_XX2FORM_EXT(xxinsertw, 0x0A, 0x0B, PPC2_ISA300),
 
 #define GEN_XXSEL_ROW(opc3) \
 GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX), \
-- 
2.7.4
