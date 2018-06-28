Received: from eggs.gnu.org ([2001:4830:134:3::10]:38096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAi-0007Hn-95
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAh-0000cJ-6P
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:40 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAg-0000b0-VV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:39 -0400
Received: by mail-wm0-x235.google.com with SMTP id u18-v6so10302528wmc.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:34 +0200
Message-Id: <1530216310-52873-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/60] pc-dimm: merge
 get_(vmstate_)memory_region()
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

Importantly, get_vmstate_memory_region() should also fail with a proper
error if called before the device is realized. For a PCDIMM, both functions
are to return the same thing, so share the implementation.

All current users are called after the device has been realized, so we
can expect the calls to succeed.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-9-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/pc-dimm.c         | 13 +++++--------
 include/hw/mem/pc-dimm.h |  3 ++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 73f0eee..4ff39b5 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -35,7 +35,8 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
     int slot;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
+    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
+                                                              &error_abort);
     Error *local_err = NULL;
     MemoryRegion *mr;
     uint64_t addr;
@@ -90,7 +91,8 @@ void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
+    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
+                                                              &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
     memory_device_unplug_region(machine, mr);
@@ -229,11 +231,6 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
     return host_memory_backend_get_memory(dimm->hostmem);
 }
 
-static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
-{
-    return host_memory_backend_get_memory(dimm->hostmem);
-}
-
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
     const PCDIMMDevice *dimm = PC_DIMM(md);
@@ -298,7 +295,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     dc->desc = "DIMM memory module";
 
     ddc->get_memory_region = pc_dimm_get_memory_region;
-    ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
+    ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
     /* for a dimm plugged_size == region_size */
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index cf71247..5679a80 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -73,7 +73,8 @@ typedef struct PCDIMMDeviceClass {
     /* public */
     void (*realize)(PCDIMMDevice *dimm, Error **errp);
     MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
-    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
+    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
+                                               Error **errp);
 } PCDIMMDeviceClass;
 
 void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
-- 
1.8.3.1
