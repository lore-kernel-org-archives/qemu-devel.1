Received: from eggs.gnu.org ([2001:4830:134:3::10]:51768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jw-0007VB-24
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jr-0003sU-BM
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:24 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:45 +1100
Message-Id: <20170202051445.5735-48-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 047/107] target-ppc: Add xxinsertw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xxinsertw: VSX Vector Insert Word

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 25 +++++++++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c |  5 +++--
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ead799c..a4504eb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -536,6 +536,7 @@ DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_2(xxperm, void, env, i32)
 DEF_HELPER_2(xxpermr, void, env, i32)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 07832ba..81f134b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2027,6 +2027,31 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
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
2.9.3
