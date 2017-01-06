Received: from eggs.gnu.org ([2001:4830:134:3::10]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoP-0006n7-H0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoL-0002o3-Vg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42313
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoL-0002nw-JT
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066E15f009352
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:15:33 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27t0y0hpua-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:15:33 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:15:30 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:44 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 02/14] target-ppc: Add xxinsertw instruction
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
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 25 +++++++++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c |  5 +++--
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 8b30420..6c5b194 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -541,6 +541,7 @@ DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_2(xxperm, void, env, i32)
 DEF_HELPER_2(xxpermr, void, env, i32)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 63ba0e3..24e5964 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2059,6 +2059,31 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
     putVSR(xtn, &xt, env);
 }
 
+void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
+                      target_ulong xbn, uint32_t index)
+{
+    ppc_vsr_t xt, xb;
+    size_t es = sizeof(uint32_t);
+    int ins_index, i = 0;
+
+    getVSR(xbn, &xb, env);
+    getVSR(xtn, &xt, env);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    ins_index = index;
+    for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
+        xt.u8[ins_index] = xb.u8[8 - es + i];
+    }
+#else
+    ins_index = 15 - index;
+    for (i = es - 1; i >= 0 && ins_index >= 0; i--, ins_index--) {
+        xt.u8[ins_index] = xb.u8[8 + i];
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
index 7977f24..c9ba0f5 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1180,7 +1180,7 @@ static void gen_xxsldwi(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
-#define VSX_EXTRACT(name)                                       \
+#define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
     TCGv xt, xb;                                                \
@@ -1208,7 +1208,8 @@ static void gen_##name(DisasContext *ctx)                       \
     tcg_temp_free_i32(t0);                                      \
 }
 
-VSX_EXTRACT(xxextractuw)
+VSX_EXTRACT_INSERT(xxextractuw)
+VSX_EXTRACT_INSERT(xxinsertw)
 
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 473d925..096d358 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -285,6 +285,7 @@ GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
 GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
+GEN_XX2FORM_EXT(xxinsertw, 0x0A, 0x0B, PPC2_ISA300),
 
 #define GEN_XXSEL_ROW(opc3) \
 GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX), \
-- 
2.7.4
