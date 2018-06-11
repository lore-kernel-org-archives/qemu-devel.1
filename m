Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl1-00021u-BD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLkz-0008Sc-O5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:11 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:49 +0200
Message-Id: <20180611121655.19616-6-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/11] spapr: move memory hotplug size check
 into plug code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

This might look like a step backwards, but it is not. get_memory_region()
should not be called on uninititalized devices. In general, only
properties should be access, but no "derived" satte like the memory
region.

1. We need duplicate error checks if memdev is actually already set.
   realize() performs these checks, no need to duplicate.
2. This is bad practise as one can see when looking at the NVDIMM
   implemetation. The call does not return sane data before the device
   is realized. Although spapr does not use NVDIMM, conceptually it is
   wrong.

So let's just move this call to the right place. We can then cleanup
get_memory_region().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f59999daac..a5f1bbd58a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3153,6 +3153,12 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
+    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
+                   "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+        goto out;
+    }
+
     pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
     if (local_err) {
         goto out;
@@ -3186,9 +3192,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
-    uint64_t size;
     char *mem_dev;
 
     if (!smc->dr_lmb_enabled) {
@@ -3196,18 +3199,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    mr = ddc->get_memory_region(dimm, errp);
-    if (!mr) {
-        return;
-    }
-    size = memory_region_size(mr);
-
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
-        error_setg(errp, "Hotplugged memory size must be a multiple of "
-                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
-        return;
-    }
-
     mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
     if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
         error_setg(errp, "Memory backend has bad page size. "
-- 
2.17.1
