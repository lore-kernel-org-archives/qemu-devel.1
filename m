Received: from eggs.gnu.org ([2001:4830:134:3::10]:44239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g80kj-0005vX-NC
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g80XH-0002x4-9U
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:07:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  4 Oct 2018 12:07:01 +0200
Message-Id: <1538647621-9376-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr_rng: Introduce CONFIG_SPAPR_RNG
 switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

The spapr-rng device is suboptimal when compared to virtio-rng, so
users might want to disable it in their builds. Thus let's introduce
a proper CONFIG switch to allow us to compile QEMU without this device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc64-softmmu.mak |  1 +
 hw/ppc/Makefile.objs              |  3 ++-
 hw/ppc/spapr.c                    |  3 ++-
 hw/ppc/spapr_rng.c                | 24 +-------------------
 hw/ppc/spapr_rng.h                | 48 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h            |  4 ----
 6 files changed, 54 insertions(+), 29 deletions(-)
 create mode 100644 hw/ppc/spapr_rng.h

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index b94af6c..24d4717 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -17,3 +17,4 @@ CONFIG_XICS=$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_MEM_HOTPLUG=y
+CONFIG_SPAPR_RNG=y
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 4ab5564..4e0c1c0 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -3,8 +3,9 @@ obj-y += ppc.o ppc_booke.o fdt.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
-obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng.o
+obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
+obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 98868d8..ba40c85 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -53,9 +53,10 @@
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "spapr_rng.h"
+
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msi.h"
-
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-scsi.h"
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index d2acd61..dec8434 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -27,6 +27,7 @@
 #include "sysemu/rng.h"
 #include "hw/ppc/spapr.h"
 #include "kvm_ppc.h"
+#include "spapr_rng.h"
 
 #define SPAPR_RNG(obj) \
     OBJECT_CHECK(sPAPRRngState, (obj), TYPE_SPAPR_RNG)
@@ -132,29 +133,6 @@ static void spapr_rng_realize(DeviceState *dev, Error **errp)
     }
 }
 
-int spapr_rng_populate_dt(void *fdt)
-{
-    int node;
-    int ret;
-
-    node = qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
-    if (node <= 0) {
-        return -1;
-    }
-    ret = fdt_setprop_string(fdt, node, "device_type",
-                             "ibm,platform-facilities");
-    ret |= fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
-    ret |= fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
-
-    node = fdt_add_subnode(fdt, node, "ibm,random-v1");
-    if (node <= 0) {
-        return -1;
-    }
-    ret |= fdt_setprop_string(fdt, node, "compatible", "ibm,random");
-
-    return ret ? -1 : 0;
-}
-
 static Property spapr_rng_properties[] = {
     DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
     DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
diff --git a/hw/ppc/spapr_rng.h b/hw/ppc/spapr_rng.h
new file mode 100644
index 0000000..1d5fdcb
--- /dev/null
+++ b/hw/ppc/spapr_rng.h
@@ -0,0 +1,48 @@
+/*
+ * QEMU sPAPR random number generator "device" for H_RANDOM hypercall
+ *
+ * Copyright 2015 Thomas Huth, Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SPAPR_RNG_H
+#define SPAPR_RNG_H
+
+#define TYPE_SPAPR_RNG "spapr-rng"
+
+static inline int spapr_rng_populate_dt(void *fdt)
+{
+    int node;
+    int ret;
+
+    node = qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
+    if (node <= 0) {
+        return -1;
+    }
+    ret = fdt_setprop_string(fdt, node, "device_type",
+                             "ibm,platform-facilities");
+    ret |= fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
+    ret |= fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
+
+    node = fdt_add_subnode(fdt, node, "ibm,random-v1");
+    if (node <= 0) {
+        return -1;
+    }
+    ret |= fdt_setprop_string(fdt, node, "compatible", "ibm,random");
+
+    return ret ? -1 : 0;
+}
+
+#endif
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad4d7cf..9460c46 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -743,10 +743,6 @@ void spapr_lmb_release(DeviceState *dev);
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
 
-#define TYPE_SPAPR_RNG "spapr-rng"
-
-int spapr_rng_populate_dt(void *fdt);
-
 #define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
 
 /*
-- 
1.8.3.1
