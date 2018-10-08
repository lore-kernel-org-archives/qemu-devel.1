Received: from eggs.gnu.org ([2001:4830:134:3::10]:47166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9V1X-0006L7-Lw
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9UpF-0007O9-9M
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:39:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  8 Oct 2018 14:39:42 +0200
Message-Id: <1539002382-3764-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
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
The function spapr_rng_populate_dt is required for linking, so move it
to a different location.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Put spapr_rng_populate_dt() into spapr.c instead of a header

 default-configs/ppc64-softmmu.mak |  1 +
 hw/ppc/Makefile.objs              |  3 ++-
 hw/ppc/spapr.c                    | 23 +++++++++++++++++++++++
 hw/ppc/spapr_rng.c                | 23 -----------------------
 include/hw/ppc/spapr.h            |  2 --
 5 files changed, 26 insertions(+), 26 deletions(-)

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
index 98868d8..e666872 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -610,6 +610,29 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
     g_free(rev);
 }
 
+static int spapr_rng_populate_dt(void *fdt)
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
 static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
 {
     MemoryDeviceInfoList *info;
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index d2acd61..644bac9 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -132,29 +132,6 @@ static void spapr_rng_realize(DeviceState *dev, Error **errp)
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad4d7cf..0805ad8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -745,8 +745,6 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
 
 #define TYPE_SPAPR_RNG "spapr-rng"
 
-int spapr_rng_populate_dt(void *fdt);
-
 #define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
 
 /*
-- 
1.8.3.1
