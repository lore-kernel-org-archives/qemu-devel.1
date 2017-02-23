Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTR-0000So-Go
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTO-0001m4-5Q
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmTN-0001lo-Rx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5rdqV113185
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:48 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sm3ec330-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:48 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:45 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 17:00:03 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <ac9e5c1e3b571f0286a2ebcd955abfd7be5d7ac7.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 10/12] spapr: move
 spapr_populate_pa_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

In the next patch, spapr_fixup_cpu_dt() will need to call
spapr_populate_pa_features() so move it's definition up without making
any other changes.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c | 86 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dfee0f685f..0c0782b558 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -194,6 +194,49 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
     return ret;
 }
 
+/* Populate the "ibm,pa-features" property */
+static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
+{
+    uint8_t pa_features_206[] = { 6, 0,
+        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
+    uint8_t pa_features_207[] = { 24, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
+    uint8_t *pa_features;
+    size_t pa_size;
+
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    case POWERPC_MMU_VER_2_06:
+        pa_features = pa_features_206;
+        pa_size = sizeof(pa_features_206);
+        break;
+    case POWERPC_MMU_VER_2_07:
+        pa_features = pa_features_207;
+        pa_size = sizeof(pa_features_207);
+        break;
+    default:
+        return;
+    }
+
+    if (env->ci_large_pages) {
+        /*
+         * Note: we keep CI large pages off by default because a 64K capable
+         * guest provisioned with large pages might otherwise try to map a qemu
+         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
+         * even if that qemu runs on a 4k host.
+         * We dd this bit back here if we are confident this is not an issue
+         */
+        pa_features[3] |= 0x20;
+    }
+    if (kvmppc_has_cap_htm() && pa_size > 24) {
+        pa_features[24] |= 0x80;    /* Transactional memory support */
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
+}
+
 static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 {
     int ret = 0, offset, cpus_offset;
@@ -346,49 +389,6 @@ static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
     return 0;
 }
 
-/* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
-{
-    uint8_t pa_features_206[] = { 6, 0,
-        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
-    uint8_t pa_features_207[] = { 24, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
-    uint8_t *pa_features;
-    size_t pa_size;
-
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
-    case POWERPC_MMU_VER_2_06:
-        pa_features = pa_features_206;
-        pa_size = sizeof(pa_features_206);
-        break;
-    case POWERPC_MMU_VER_2_07:
-        pa_features = pa_features_207;
-        pa_size = sizeof(pa_features_207);
-        break;
-    default:
-        return;
-    }
-
-    if (env->ci_large_pages) {
-        /*
-         * Note: we keep CI large pages off by default because a 64K capable
-         * guest provisioned with large pages might otherwise try to map a qemu
-         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
-         * even if that qemu runs on a 4k host.
-         * We dd this bit back here if we are confident this is not an issue
-         */
-        pa_features[3] |= 0x20;
-    }
-    if (kvmppc_has_cap_htm() && pa_size > 24) {
-        pa_features[24] |= 0x80;    /* Transactional memory support */
-    }
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
-}
-
 static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                                   sPAPRMachineState *spapr)
 {
-- 
2.11.0
