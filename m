Received: from eggs.gnu.org ([209.51.188.92]:48724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZe-0002iZ-51
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZd-0006DU-5I
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:62698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gvyZc-0006Co-TR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:09 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 19 Feb 2019 14:07:19 +0800
Message-Id: <20190219060719.8211-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190219060719.8211-1-richardw.yang@linux.intel.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] pc-dimm: remove realize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, Wei Yang <richardw.yang@linux.intel.com>

PCDIMM's realize callback is introduced to do proper setup for NVDIMM.

Currently the NVDIMM setup task is nvdimm_prepare_memory_region(), which
is done in pre_plug stage. This means related task has already been done
at realize point.

This patch remove PCDIMM realize callback.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/memory_hotplug.c |  1 -
 hw/mem/nvdimm.c          | 11 -----------
 hw/mem/pc-dimm.c         |  5 -----
 include/hw/mem/pc-dimm.h |  3 ---
 4 files changed, 20 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index b19673d337..cb5284d36f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -264,7 +264,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
     MemStatus *mdev;
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     mdev = acpi_memory_slot_status(mem_st, dev, errp);
     if (!mdev) {
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index bf2adf5e16..8f69576926 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -136,15 +136,6 @@ static MemoryRegion *nvdimm_md_get_memory_region(MemoryDeviceState *md,
     return nvdimm->nvdimm_mr;
 }
 
-static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(dimm);
-
-    if (!nvdimm->nvdimm_mr) {
-        nvdimm_prepare_memory_region(nvdimm, errp);
-    }
-}
-
 /*
  * the caller should check the input parameters before calling
  * label read/write functions.
@@ -192,12 +183,10 @@ static Property nvdimm_properties[] = {
 
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
-    PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    ddc->realize = nvdimm_realize;
     mdc->get_memory_region = nvdimm_md_get_memory_region;
     dc->props = nvdimm_properties;
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..5832c0ba92 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -159,7 +159,6 @@ static void pc_dimm_init(Object *obj)
 static void pc_dimm_realize(DeviceState *dev, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
 
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
@@ -178,10 +177,6 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (ddc->realize) {
-        ddc->realize(dimm, errp);
-    }
-
     host_memory_backend_set_mapped(dimm->hostmem, true);
 }
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 01436b9f50..d18f8246b7 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -59,8 +59,6 @@ typedef struct PCDIMMDevice {
 
 /**
  * PCDIMMDeviceClass:
- * @realize: called after common dimm is realized so that the dimm based
- * devices get the chance to do specified operations.
  * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
  * memory of @dimm should be kept during live migration. Will not fail
  * after the device was realized.
@@ -70,7 +68,6 @@ typedef struct PCDIMMDeviceClass {
     DeviceClass parent_class;
 
     /* public */
-    void (*realize)(PCDIMMDevice *dimm, Error **errp);
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
                                                Error **errp);
 } PCDIMMDeviceClass;
-- 
2.19.1
