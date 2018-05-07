Received: from eggs.gnu.org ([2001:4830:134:3::10]:38591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYD-0006aD-3L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYC-0007jw-3j
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYB-0007ja-S7
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:10 -0300
Message-Id: <20180507170315.11497-8-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] pc-dimm: move actual plug/unplug of a
 memory region to MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Registering the memory region for migration has do be done by the owner.
There could be cases, where we don't want to migrate the memory.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-8-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h |  3 +++
 hw/mem/memory-device.c         | 18 ++++++++++++++++++
 hw/mem/pc-dimm.c               |  5 ++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 3427c7d424..2853b084b5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -44,5 +44,8 @@ uint64_t get_plugged_memory_size(void);
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp);
+void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
+                               uint64_t addr);
+void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
 
 #endif
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8535ddcb14..3e04f3954e 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -243,6 +243,24 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
+                               uint64_t addr)
+{
+    /* we expect a previous call to memory_device_get_free_addr() */
+    g_assert(ms->device_memory);
+
+    memory_region_add_subregion(&ms->device_memory->mr,
+                                addr - ms->device_memory->base, mr);
+}
+
+void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+{
+    /* we expect a previous call to memory_device_get_free_addr() */
+    g_assert(ms->device_memory);
+
+    memory_region_del_subregion(&ms->device_memory->mr, mr);
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8aa2d36ce9..0119c68e01 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -36,7 +36,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp)
 {
     int slot;
-    MemoryHotplugState *hpms = machine->device_memory;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
@@ -83,7 +82,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
     }
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
+    memory_device_plug_region(machine, mr, addr);
     vmstate_register_ram(vmstate_mr, dev);
 
 out:
@@ -97,7 +96,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_region_del_subregion(&machine->device_memory->mr, mr);
+    memory_device_unplug_region(machine, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
-- 
2.14.3
