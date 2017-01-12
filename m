Received: from eggs.gnu.org ([2001:4830:134:3::10]:46508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-00032d-4N
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006c2-K9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:46 +1100
Message-Id: <20170112020327.24882-27-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 26/67] target-ppc: Add xxperm and xxpermr
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xxperm:  VSX Vector Permute
xxpermr: VSX Vector Permute Right-indexed

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 23 +++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 3b867cf..1ccd5e6 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2869,3 +2869,26 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
     float_check_status(env);
     return xt;
 }
+
+#define VSX_XXPERM(op, indexed)                                       \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
+{                                                                     \
+    ppc_vsr_t xt, xa, pcv, xto;                                       \
+    int i, idx;                                                       \
+                                                                      \
+    getVSR(xA(opcode), &xa, env);                                     \
+    getVSR(xT(opcode), &xt, env);                                     \
+    getVSR(xB(opcode), &pcv, env);                                    \
+                                                                      \
+    for (i = 0; i < 16; i++) {                                        \
+        idx = pcv.VsrB(i) & 0x1F;                                     \
+        if (indexed) {                                                \
+            idx = 31 - idx;                                           \
+        }                                                             \
+        xto.VsrB(i) = (idx <= 15) ? xa.VsrB(idx) : xt.VsrB(idx - 16); \
+    }                                                                 \
+    putVSR(xT(opcode), &xto, env);                                    \
+}
+
+VSX_XXPERM(xxperm, 0)
+VSX_XXPERM(xxpermr, 1)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index bc39efb..c3df982 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -532,6 +532,8 @@ DEF_HELPER_2(xvrspic, void, env, i32)
 DEF_HELPER_2(xvrspim, void, env, i32)
 DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
+DEF_HELPER_2(xxperm, void, env, i32)
+DEF_HELPER_2(xxpermr, void, env, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 90d26a2..7000035 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -883,6 +883,8 @@ GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
 static void gen_xxbrd(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 68fa171..f684066 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -267,6 +267,8 @@ VSX_LOGICAL(xxlnand, 0x8, 0x16, PPC2_VSX207),
 VSX_LOGICAL(xxlorc, 0x8, 0x15, PPC2_VSX207),
 GEN_XX3FORM(xxmrghw, 0x08, 0x02, PPC2_VSX),
 GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
+GEN_XX3FORM(xxperm, 0x08, 0x03, PPC2_ISA300),
+GEN_XX3FORM(xxpermr, 0x08, 0x07, PPC2_ISA300),
 GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
-- 
2.9.3
