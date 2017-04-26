Received: from eggs.gnu.org ([2001:4830:134:3::10]:56703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwk-0005ER-EF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwa-0007xr-6F
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 16:59:56 +1000
Message-Id: <20170426070034.10727-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/48] spapr: move spapr_populate_pa_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

In the next patch, spapr_fixup_cpu_dt() will need to call
spapr_populate_pa_features() so move it's definition up without making
any other changes.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 122 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54391a1..21da9a1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -227,6 +227,67 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
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
+    /* Currently we don't advertise any of the "new" ISAv3.00 functionality */
+    uint8_t pa_features_300[] = { 64, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
+        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
+
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
+    case POWERPC_MMU_VER_3_00:
+        pa_features = pa_features_300;
+        pa_size = sizeof(pa_features_300);
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
@@ -379,67 +440,6 @@ static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
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
-    /* Currently we don't advertise any of the "new" ISAv3.00 functionality */
-    uint8_t pa_features_300[] = { 64, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
-        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
-
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
-    case POWERPC_MMU_VER_3_00:
-        pa_features = pa_features_300;
-        pa_size = sizeof(pa_features_300);
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
2.9.3
