Received: from eggs.gnu.org ([2001:4830:134:3::10]:57097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG7F-0005pK-9H
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG7D-00051Y-0f
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:12385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG7C-0004sQ-CS
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:26 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:38 +0800
Message-Id: <1496079043-26694-9-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 1/6] vfio: Add Intel platform definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chuanxiao.dong@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, joonas.lahtinen@linux.intel.com, zhiyuan.lv@intel.com, zhenyuw@linux.intel.com, kevin.tian@intel.com, Zhi Wang <zhi.a.wang@intel.com>

This patch introduces device descriptions for Intel platforms. Most of
the Intel device definitions come from i915.

Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 hw/vfio/Makefile.objs    |   2 +-
 hw/vfio/intel-platform.c | 366 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/intel-platform.h |  38 +++++
 hw/vfio/pci-quirks.c     |  28 ++--
 4 files changed, 421 insertions(+), 13 deletions(-)
 create mode 100644 hw/vfio/intel-platform.c
 create mode 100644 hw/vfio/intel-platform.h

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 05e7fbb..b183f5c 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,6 +1,6 @@
 ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
-obj-$(CONFIG_PCI) += pci.o pci-quirks.o
+obj-$(CONFIG_PCI) += pci.o pci-quirks.o intel-platform.o
 obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
 obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
diff --git a/hw/vfio/intel-platform.c b/hw/vfio/intel-platform.c
new file mode 100644
index 0000000..41f1fa0
--- /dev/null
+++ b/hw/vfio/intel-platform.c
@@ -0,0 +1,366 @@
+/*
+ * Device descriptions for Intel platforms.
+ *
+ * Copyright Intel Coporation 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "intel-platform.h"
+
+#define    SNB_GMCH_GGMS_SHIFT  8 /* GTT Graphics Memory Size */
+#define    SNB_GMCH_GGMS_MASK   0x3
+#define    SNB_GMCH_GMS_SHIFT   3 /* Graphics Mode Select */
+#define    SNB_GMCH_GMS_MASK    0x1f
+#define    BDW_GMCH_GGMS_SHIFT  6
+#define    BDW_GMCH_GGMS_MASK   0x3
+#define    BDW_GMCH_GMS_SHIFT   8
+#define    BDW_GMCH_GMS_MASK    0xff
+
+static unsigned int gen6_get_stolen_size(uint16_t gmch)
+{
+    gmch >>= SNB_GMCH_GMS_SHIFT;
+    gmch &= SNB_GMCH_GMS_MASK;
+    return gmch << 25; /* 32 MB units */
+}
+
+static unsigned int bdw_get_stolen_size(uint16_t gmch)
+{
+    gmch >>= BDW_GMCH_GMS_SHIFT;
+    gmch &= BDW_GMCH_GMS_MASK;
+    return gmch << 25; /* 32 MB units */
+}
+
+static unsigned int chv_get_stolen_size(uint16_t gmch)
+{
+    gmch >>= SNB_GMCH_GMS_SHIFT;
+    gmch &= SNB_GMCH_GMS_MASK;
+
+    /*
+     * 0x0  to 0x10: 32MB increments starting at 0MB
+     * 0x11 to 0x16: 4MB increments starting at 8MB
+     * 0x17 to 0x1d: 4MB increments start at 36MB
+     */
+    if (gmch < 0x11)
+        return gmch << 25;
+    else if (gmch < 0x17)
+        return (gmch - 0x11 + 2) << 22;
+    else
+        return (gmch - 0x17 + 9) << 22;
+}
+
+static unsigned int gen9_get_stolen_size(uint16_t gmch)
+{
+    gmch >>= BDW_GMCH_GMS_SHIFT;
+    gmch &= BDW_GMCH_GMS_MASK;
+
+    if (gmch < 0xf0)
+        return gmch << 25; /* 32 MB units */
+    else
+        /* 4MB increments starting at 0xf0 for 4MB */
+        return (gmch - 0xf0 + 1) << 22;
+}
+
+static unsigned int gen6_get_gtt_size(uint16_t gmch)
+{
+        gmch >>= SNB_GMCH_GGMS_SHIFT;
+        gmch &= SNB_GMCH_GGMS_MASK;
+        return gmch << 20;
+}
+
+static unsigned int gen8_get_gtt_size(uint16_t gmch)
+{
+        gmch >>= BDW_GMCH_GGMS_SHIFT;
+        gmch &= BDW_GMCH_GGMS_MASK;
+        if (gmch)
+                gmch = 1 << gmch;
+
+        return gmch << 20;
+}
+
+static unsigned int chv_get_gtt_size(uint16_t gmch)
+{
+        gmch >>= SNB_GMCH_GGMS_SHIFT;
+        gmch &= SNB_GMCH_GGMS_MASK;
+
+        if (gmch)
+                return 1 << (20 + gmch);
+
+        return 0;
+}
+
+static const struct intel_device_info intel_sandybridge_info = {
+    .gen = 6,
+    .platform = INTEL_SANDYBRIDGE,
+    .gtt_entry_size = 4,
+    .get_stolen_size = gen6_get_stolen_size,
+    .get_gtt_size = gen6_get_gtt_size,
+};
+
+static const struct intel_device_info intel_ivybridge_info = {
+    .gen = 7,
+    .platform = INTEL_IVYBRIDGE,
+    .gtt_entry_size = 4,
+    .get_stolen_size = gen6_get_stolen_size,
+    .get_gtt_size = gen6_get_gtt_size,
+};
+
+static const struct intel_device_info intel_valleyview_info = {
+    .gen = 7,
+    .platform = INTEL_VALLEYVIEW,
+    .gtt_entry_size = 4,
+    .get_stolen_size = gen6_get_stolen_size,
+    .get_gtt_size = gen6_get_gtt_size,
+};
+
+static const struct intel_device_info intel_haswell_info = {
+    .gen = 7,   /* Actually HASWELL is GEN 7.5 */
+    .platform = INTEL_HASWELL,
+    .gtt_entry_size = 4,
+    .get_stolen_size = gen6_get_stolen_size,
+    .get_gtt_size = gen6_get_gtt_size,
+};
+
+static const struct intel_device_info intel_broadwell_info = {
+    .gen = 8,
+    .platform = INTEL_BROADWELL,
+    .gtt_entry_size = 8,
+    .get_stolen_size = bdw_get_stolen_size,
+    .get_gtt_size = gen8_get_gtt_size,
+};
+
+static const struct intel_device_info intel_cherryview_info = {
+    .gen = 8,
+    .platform = INTEL_CHERRYVIEW,
+    .gtt_entry_size = 8,
+    .get_stolen_size = chv_get_stolen_size,
+    .get_gtt_size = chv_get_gtt_size,
+};
+
+static const struct intel_device_info intel_skylake_info = {
+    .gen = 9,
+    .platform = INTEL_SKYLAKE,
+    .gtt_entry_size = 8,
+    .get_stolen_size = gen9_get_stolen_size,
+    .get_gtt_size = gen8_get_gtt_size,
+};
+
+static const struct intel_device_info intel_broxton_info = {
+    .gen = 9,
+    .platform = INTEL_BROXTON,
+    .gtt_entry_size = 8,
+    .get_stolen_size = gen9_get_stolen_size,
+    .get_gtt_size = gen8_get_gtt_size,
+};
+
+struct intel_pci_device_id {
+    uint16_t device_id;
+    const struct intel_device_info *info;
+};
+
+#define INTEL_VGA_DEVICE(id, info) \
+    { id, info }
+
+#define INTEL_SNB_D_IDS(info) \
+    INTEL_VGA_DEVICE(0x0102, info), \
+    INTEL_VGA_DEVICE(0x0112, info), \
+    INTEL_VGA_DEVICE(0x0122, info), \
+    INTEL_VGA_DEVICE(0x010A, info)
+
+#define INTEL_SNB_M_IDS(info) \
+    INTEL_VGA_DEVICE(0x0106, info), \
+    INTEL_VGA_DEVICE(0x0116, info), \
+    INTEL_VGA_DEVICE(0x0126, info)
+
+#define INTEL_IVB_M_IDS(info) \
+    INTEL_VGA_DEVICE(0x0156, info), /* GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0166, info)  /* GT2 mobile */
+
+#define INTEL_IVB_D_IDS(info) \
+    INTEL_VGA_DEVICE(0x0152, info), /* GT1 desktop */ \
+    INTEL_VGA_DEVICE(0x0162, info), /* GT2 desktop */ \
+    INTEL_VGA_DEVICE(0x015a, info), /* GT1 server */ \
+    INTEL_VGA_DEVICE(0x016a, info)  /* GT2 server */
+
+#define INTEL_HSW_IDS(info) \
+    INTEL_VGA_DEVICE(0x0402, info), /* GT1 desktop */ \
+    INTEL_VGA_DEVICE(0x0412, info), /* GT2 desktop */ \
+    INTEL_VGA_DEVICE(0x0422, info), /* GT3 desktop */ \
+    INTEL_VGA_DEVICE(0x040a, info), /* GT1 server */ \
+    INTEL_VGA_DEVICE(0x041a, info), /* GT2 server */ \
+    INTEL_VGA_DEVICE(0x042a, info), /* GT3 server */ \
+    INTEL_VGA_DEVICE(0x040B, info), /* GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x041B, info), /* GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x042B, info), /* GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x040E, info), /* GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x041E, info), /* GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x042E, info), /* GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0C02, info), /* SDV GT1 desktop */ \
+    INTEL_VGA_DEVICE(0x0C12, info), /* SDV GT2 desktop */ \
+    INTEL_VGA_DEVICE(0x0C22, info), /* SDV GT3 desktop */ \
+    INTEL_VGA_DEVICE(0x0C0A, info), /* SDV GT1 server */ \
+    INTEL_VGA_DEVICE(0x0C1A, info), /* SDV GT2 server */ \
+    INTEL_VGA_DEVICE(0x0C2A, info), /* SDV GT3 server */ \
+    INTEL_VGA_DEVICE(0x0C0B, info), /* SDV GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x0C1B, info), /* SDV GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x0C2B, info), /* SDV GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0C0E, info), /* SDV GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x0C1E, info), /* SDV GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x0C2E, info), /* SDV GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0A02, info), /* ULT GT1 desktop */ \
+    INTEL_VGA_DEVICE(0x0A12, info), /* ULT GT2 desktop */ \
+    INTEL_VGA_DEVICE(0x0A22, info), /* ULT GT3 desktop */ \
+    INTEL_VGA_DEVICE(0x0A0A, info), /* ULT GT1 server */ \
+    INTEL_VGA_DEVICE(0x0A1A, info), /* ULT GT2 server */ \
+    INTEL_VGA_DEVICE(0x0A2A, info), /* ULT GT3 server */ \
+    INTEL_VGA_DEVICE(0x0A0B, info), /* ULT GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x0A1B, info), /* ULT GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x0A2B, info), /* ULT GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0D02, info), /* CRW GT1 desktop */ \
+    INTEL_VGA_DEVICE(0x0D12, info), /* CRW GT2 desktop */ \
+    INTEL_VGA_DEVICE(0x0D22, info), /* CRW GT3 desktop */ \
+    INTEL_VGA_DEVICE(0x0D0A, info), /* CRW GT1 server */ \
+    INTEL_VGA_DEVICE(0x0D1A, info), /* CRW GT2 server */ \
+    INTEL_VGA_DEVICE(0x0D2A, info), /* CRW GT3 server */ \
+    INTEL_VGA_DEVICE(0x0D0B, info), /* CRW GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x0D1B, info), /* CRW GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x0D2B, info), /* CRW GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0D0E, info), /* CRW GT1 reserved */ \
+    INTEL_VGA_DEVICE(0x0D1E, info), /* CRW GT2 reserved */ \
+    INTEL_VGA_DEVICE(0x0D2E, info),  /* CRW GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0406, info), /* GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0416, info), /* GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0426, info), /* GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0C06, info), /* SDV GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0C16, info), /* SDV GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0C26, info), /* SDV GT3 mobile */ \
+    INTEL_VGA_DEVICE(0x0A06, info), /* ULT GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0A16, info), /* ULT GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0A26, info), /* ULT GT3 mobile */ \
+    INTEL_VGA_DEVICE(0x0A0E, info), /* ULX GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0A1E, info), /* ULX GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0A2E, info), /* ULT GT3 reserved */ \
+    INTEL_VGA_DEVICE(0x0D06, info), /* CRW GT1 mobile */ \
+    INTEL_VGA_DEVICE(0x0D16, info), /* CRW GT2 mobile */ \
+    INTEL_VGA_DEVICE(0x0D26, info)  /* CRW GT3 mobile */
+
+#define INTEL_VLV_IDS(info) \
+    INTEL_VGA_DEVICE(0x0f30, info), \
+    INTEL_VGA_DEVICE(0x0f31, info), \
+    INTEL_VGA_DEVICE(0x0f32, info), \
+    INTEL_VGA_DEVICE(0x0f33, info), \
+    INTEL_VGA_DEVICE(0x0157, info), \
+    INTEL_VGA_DEVICE(0x0155, info)
+
+#define INTEL_BDW_GT12_IDS(info)  \
+    INTEL_VGA_DEVICE(0x1602, info), /* GT1 ULT */ \
+    INTEL_VGA_DEVICE(0x1606, info), /* GT1 ULT */ \
+    INTEL_VGA_DEVICE(0x160B, info), /* GT1 Iris */ \
+    INTEL_VGA_DEVICE(0x160E, info), /* GT1 ULX */ \
+    INTEL_VGA_DEVICE(0x1612, info), /* GT2 Halo */ \
+    INTEL_VGA_DEVICE(0x1616, info), /* GT2 ULT */ \
+    INTEL_VGA_DEVICE(0x161B, info), /* GT2 ULT */ \
+    INTEL_VGA_DEVICE(0x161E, info),  /* GT2 ULX */ \
+    INTEL_VGA_DEVICE(0x160A, info), /* GT1 Server */ \
+    INTEL_VGA_DEVICE(0x160D, info), /* GT1 Workstation */ \
+    INTEL_VGA_DEVICE(0x161A, info), /* GT2 Server */ \
+    INTEL_VGA_DEVICE(0x161D, info)  /* GT2 Workstation */
+
+#define INTEL_BDW_GT3_IDS(info) \
+    INTEL_VGA_DEVICE(0x1622, info), /* ULT */ \
+    INTEL_VGA_DEVICE(0x1626, info), /* ULT */ \
+    INTEL_VGA_DEVICE(0x162B, info), /* Iris */ \
+    INTEL_VGA_DEVICE(0x162E, info),  /* ULX */\
+    INTEL_VGA_DEVICE(0x162A, info), /* Server */ \
+    INTEL_VGA_DEVICE(0x162D, info)  /* Workstation */
+
+#define INTEL_BDW_RSVD_IDS(info) \
+    INTEL_VGA_DEVICE(0x1632, info), /* ULT */ \
+    INTEL_VGA_DEVICE(0x1636, info), /* ULT */ \
+    INTEL_VGA_DEVICE(0x163B, info), /* Iris */ \
+    INTEL_VGA_DEVICE(0x163E, info), /* ULX */ \
+    INTEL_VGA_DEVICE(0x163A, info), /* Server */ \
+    INTEL_VGA_DEVICE(0x163D, info)  /* Workstation */
+
+#define INTEL_BDW_IDS(info) \
+    INTEL_BDW_GT12_IDS(info), \
+    INTEL_BDW_GT3_IDS(info), \
+    INTEL_BDW_RSVD_IDS(info)
+
+#define INTEL_CHV_IDS(info) \
+    INTEL_VGA_DEVICE(0x22b0, info), \
+    INTEL_VGA_DEVICE(0x22b1, info), \
+    INTEL_VGA_DEVICE(0x22b2, info), \
+    INTEL_VGA_DEVICE(0x22b3, info)
+
+#define INTEL_SKL_GT1_IDS(info)	\
+    INTEL_VGA_DEVICE(0x1906, info), /* ULT GT1 */ \
+    INTEL_VGA_DEVICE(0x190E, info), /* ULX GT1 */ \
+    INTEL_VGA_DEVICE(0x1902, info), /* DT  GT1 */ \
+    INTEL_VGA_DEVICE(0x190B, info), /* Halo GT1 */ \
+    INTEL_VGA_DEVICE(0x190A, info) /* SRV GT1 */
+
+#define INTEL_SKL_GT2_IDS(info)	\
+    INTEL_VGA_DEVICE(0x1916, info), /* ULT GT2 */ \
+    INTEL_VGA_DEVICE(0x1921, info), /* ULT GT2F */ \
+    INTEL_VGA_DEVICE(0x191E, info), /* ULX GT2 */ \
+    INTEL_VGA_DEVICE(0x1912, info), /* DT  GT2 */ \
+    INTEL_VGA_DEVICE(0x191B, info), /* Halo GT2 */ \
+    INTEL_VGA_DEVICE(0x191A, info), /* SRV GT2 */ \
+    INTEL_VGA_DEVICE(0x191D, info)  /* WKS GT2 */
+
+#define INTEL_SKL_GT3_IDS(info) \
+    INTEL_VGA_DEVICE(0x1923, info), /* ULT GT3 */ \
+    INTEL_VGA_DEVICE(0x1926, info), /* ULT GT3 */ \
+    INTEL_VGA_DEVICE(0x1927, info), /* ULT GT3 */ \
+    INTEL_VGA_DEVICE(0x192B, info)  /* Halo GT3 */ \
+
+#define INTEL_SKL_GT4_IDS(info) \
+    INTEL_VGA_DEVICE(0x1932, info), /* DT GT4 */ \
+    INTEL_VGA_DEVICE(0x193B, info), /* Halo GT4 */ \
+    INTEL_VGA_DEVICE(0x193D, info), /* WKS GT4 */ \
+    INTEL_VGA_DEVICE(0x192A, info), /* SRV GT4 */ \
+    INTEL_VGA_DEVICE(0x193A, info)  /* SRV GT4e */
+
+#define INTEL_SKL_IDS(info)	 \
+    INTEL_SKL_GT1_IDS(info), \
+    INTEL_SKL_GT2_IDS(info), \
+    INTEL_SKL_GT3_IDS(info), \
+    INTEL_SKL_GT4_IDS(info)
+
+#define INTEL_BXT_IDS(info) \
+    INTEL_VGA_DEVICE(0x0A84, info), \
+    INTEL_VGA_DEVICE(0x1A84, info), \
+    INTEL_VGA_DEVICE(0x1A85, info), \
+    INTEL_VGA_DEVICE(0x5A84, info), /* APL HD Graphics 505 */ \
+    INTEL_VGA_DEVICE(0x5A85, info)  /* APL HD Graphics 500 */
+
+static const struct intel_pci_device_id pciidlist[] = {
+    INTEL_SNB_D_IDS(&intel_sandybridge_info),
+    INTEL_SNB_M_IDS(&intel_sandybridge_info),
+    INTEL_IVB_M_IDS(&intel_ivybridge_info),
+    INTEL_IVB_D_IDS(&intel_ivybridge_info),
+    INTEL_HSW_IDS(&intel_haswell_info),
+    INTEL_VLV_IDS(&intel_valleyview_info),
+    INTEL_BDW_GT12_IDS(&intel_broadwell_info),
+    INTEL_BDW_GT3_IDS(&intel_broadwell_info),
+    INTEL_BDW_RSVD_IDS(&intel_broadwell_info),
+    INTEL_CHV_IDS(&intel_cherryview_info),
+    INTEL_SKL_GT1_IDS(&intel_skylake_info),
+    INTEL_SKL_GT2_IDS(&intel_skylake_info),
+    INTEL_SKL_GT3_IDS(&intel_skylake_info),
+    INTEL_SKL_GT4_IDS(&intel_skylake_info),
+    INTEL_BXT_IDS(&intel_broxton_info),
+};
+
+const struct intel_device_info *intel_get_device_info(uint16_t device_id)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(pciidlist); i++)
+        if (pciidlist[i].device_id == device_id)
+            return pciidlist[i].info;
+
+    return NULL;
+}
diff --git a/hw/vfio/intel-platform.h b/hw/vfio/intel-platform.h
new file mode 100644
index 0000000..7a2655e
--- /dev/null
+++ b/hw/vfio/intel-platform.h
@@ -0,0 +1,38 @@
+/*
+ * Device descriptions for Intel platforms.
+ *
+ * Copyright Intel Coporation 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VFIO_INTEL_PLATFORM_H
+#define HW_VFIO_INTEL_PLATFORM_H
+
+#include "qemu/osdep.h"
+
+enum intel_platform {
+    INTEL_PLATFORM_UNINITIALIZED = 0,
+    INTEL_SANDYBRIDGE,
+    INTEL_IVYBRIDGE,
+    INTEL_VALLEYVIEW,
+    INTEL_HASWELL,
+    INTEL_BROADWELL,
+    INTEL_CHERRYVIEW,
+    INTEL_SKYLAKE,
+    INTEL_BROXTON,
+    INTEL_MAX_PLATFORMS
+};
+
+struct intel_device_info {
+    uint8_t gen;
+    enum intel_platform platform;
+    uint32_t gtt_entry_size;
+    unsigned int (*get_stolen_size)(uint16_t gmch);
+    unsigned int (*get_gtt_size)(uint16_t gmch);
+};
+
+const struct intel_device_info *intel_get_device_info(uint16_t device_id);
+
+#endif /* HW_VFIO_INTEL_PLATFORM_H */
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 349085e..71360ef 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -17,6 +17,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "trace.h"
+#include "intel-platform.h"
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
@@ -1360,6 +1361,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                             *host = NULL, *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
+    const struct intel_device_info *info;
     PCIDevice *lpc_bridge;
     int i, ret, ggms_mb, gms_mb = 0, gen;
     uint64_t *bdsm_size;
@@ -1380,6 +1382,20 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /*
+     * IGD is not a standard, they like to change their specs often.  We
+     * only attempt to support back to SandBridge and we hope that newer
+     * devices maintain compatibility with generation 8.
+     */
+    info = intel_get_device_info(vdev->device_id);
+    if (!info) {
+        error_report("IGD device %s is unsupported in legacy mode, "
+                     "try SandyBridge or newer", vdev->vbasedev.name);
+        return;
+    }
+
+    gen = info->gen;
+
+    /*
      * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
      * can stuff host values into, so if there's already one there and it's not
      * one we can hack on, legacy mode is no-go.  Sorry Q35.
@@ -1394,18 +1410,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /*
-     * IGD is not a standard, they like to change their specs often.  We
-     * only attempt to support back to SandBridge and we hope that newer
-     * devices maintain compatibility with generation 8.
-     */
-    gen = igd_gen(vdev);
-    if (gen != 6 && gen != 8) {
-        error_report("IGD device %s is unsupported in legacy mode, "
-                     "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
-    }
-
-    /*
      * Most of what we're doing here is to enable the ROM to run, so if
      * there's no ROM, there's no point in setting up this quirk.
      * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
-- 
2.7.4
