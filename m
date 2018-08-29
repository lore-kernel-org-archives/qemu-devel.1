Received: from eggs.gnu.org ([2001:4830:134:3::10]:35071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wl-0004cb-2E
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wk-00024L-5h
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wj-00024C-U9
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:02 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:14 +0200
Message-Id: <20180829153624.12299-11-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/20] memory-device: complete factoring out
 plug handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

With the new memory device functions in place, we can factor out
plugging of memory devices completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 10 +++++++---
 hw/mem/pc-dimm.c               |  7 +------
 include/hw/mem/memory-device.h |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index ec9d175a2c..c7a12ff2c4 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -278,10 +278,14 @@ out:
     error_propagate(errp, local_err);
 }
 
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr)
+void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const uint64_t addr = mdc->get_addr(md);
+    MemoryRegion *mr;
+
+    /* we expect a previous call to memory_device_pre_plug() */
+    mr = mdc->get_memory_region(md, &error_abort);
     g_assert(ms->device_memory);
 
     memory_region_add_subregion(&ms->device_memory->mr,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 0d0072a7e8..9d3dcc8da9 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -65,13 +65,8 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t addr;
-
-    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
-                                    &error_abort);
 
-    memory_device_plug_region(machine, mr, addr);
+    memory_device_plug(MEMORY_DEVICE(dev), machine);
     vmstate_register_ram(vmstate_mr, dev);
 }
 
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index dd582f9125..49cf2d498b 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -58,8 +58,7 @@ MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr);
+void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
 void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
 
 #endif
-- 
2.17.1
