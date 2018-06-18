Received: from eggs.gnu.org ([2001:4830:134:3::10]:41675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6i-0002Ak-3b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6e-0000sK-Tk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:26:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:25:36 +0200
Message-Id: <20180618142536.23995-13-david@redhat.com>
In-Reply-To: <20180618142536.23995-1-david@redhat.com>
References: <20180618142536.23995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 12/12] pc-dimm: get_memory_region() will not
 fail after realize
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

Let's try to reduce error handling a bit. In the plug/unplug case, the
device was realized and therefore we can assume that getting access to
the memory region will not fail.

For get_vmstate_memory_region() this is already handled that way.
Document both cases.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             |  7 +------
 hw/mem/pc-dimm.c         |  7 +------
 hw/ppc/spapr.c           | 12 ++----------
 include/hw/mem/pc-dimm.h |  6 ++++--
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2db032a6df..f310040351 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1706,15 +1706,10 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
         align = memory_region_get_alignment(mr);
     }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4ff39b59ef..65843bc52a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -37,15 +37,10 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     Error *local_err = NULL;
-    MemoryRegion *mr;
     uint64_t addr;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     addr = object_property_get_uint(OBJECT(dimm),
                                     PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3e5320020f..6934abc21e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3142,14 +3142,10 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint64_t align, size, addr;
     uint32_t node;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
@@ -3340,16 +3336,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
     size = memory_region_size(mr);
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 5679a80465..26ebb7d5e9 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -62,9 +62,11 @@ typedef struct PCDIMMDevice {
  * @realize: called after common dimm is realized so that the dimm based
  * devices get the chance to do specified operations.
  * @get_memory_region: returns #MemoryRegion associated with @dimm which
- * is directly mapped into the physical address space of guest.
+ * is directly mapped into the physical address space of guest. Will not
+ * fail after the device was realized.
  * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
- * memory of @dimm should be kept during live migration.
+ * memory of @dimm should be kept during live migration. Will not fail
+ * after the device was realized.
  */
 typedef struct PCDIMMDeviceClass {
     /* private */
-- 
2.17.1
