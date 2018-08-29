Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wq-0004hL-1P
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wm-00026T-Pa
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wm-00024r-GD
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:15 +0200
Message-Id: <20180829153624.12299-12-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/20] memory-device: complete factoring out
 unplug handling
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
unplugging of memory devices completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 8 ++++++--
 hw/mem/pc-dimm.c               | 3 +--
 include/hw/mem/memory-device.h | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index c7a12ff2c4..5f62eb6a94 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -292,9 +292,13 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
                                 addr - ms->device_memory->base, mr);
 }
 
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr;
+
+    /* we expect a previous call to memory_device_pre_plug() */
+    mr = mdc->get_memory_region(md, &error_abort);
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9d3dcc8da9..634335f984 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -76,9 +76,8 @@ void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_device_unplug_region(machine, mr);
+    memory_device_unplug(MEMORY_DEVICE(dev), machine);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 49cf2d498b..05cb9437b7 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -59,6 +59,6 @@ uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 
 #endif
-- 
2.17.1
