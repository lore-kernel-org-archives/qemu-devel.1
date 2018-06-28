Received: from eggs.gnu.org ([2001:4830:134:3::10]:38162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAn-0007OO-BP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAk-0000iW-Oj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:45 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAk-0000hR-Ed
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:42 -0400
Received: by mail-wm0-x22c.google.com with SMTP id l15-v6so240723wmc.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:38 +0200
Message-Id: <1530216310-52873-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/60] pc-dimm: get_memory_region() will not
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's try to reduce error handling a bit. In the plug/unplug case, the
device was realized and therefore we can assume that getting access to
the memory region will not fail.

For get_vmstate_memory_region() this is already handled that way.
Document both cases.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-13-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             |  7 +------
 hw/mem/pc-dimm.c         |  7 +------
 hw/ppc/spapr.c           | 12 ++----------
 include/hw/mem/pc-dimm.h |  6 ++++--
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2db032a..f310040 100644
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
index 4ff39b5..65843bc 100644
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
index 3a1bd73..b32b971 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3149,14 +3149,10 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
 
@@ -3344,16 +3340,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
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
index 5679a80..26ebb7d 100644
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
1.8.3.1
