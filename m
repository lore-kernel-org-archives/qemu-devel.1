Received: from eggs.gnu.org ([2001:4830:134:3::10]:50986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vc-0000tH-4E
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vb-00038d-9H
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vb-00037h-4G
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FBF94074474
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 12:00:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:42 +0200
Message-Id: <20180705115943.29402-11-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 10/11] memory-device: complete factoring out
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

With the new memory device functions in place, we can factor out
unplugging of memory devices completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 5 ++++-
 hw/mem/pc-dimm.c               | 3 +--
 include/hw/mem/memory-device.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index ec81133edf..b52a0972d0 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -288,8 +288,11 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
                                 addr - ms->device_memory->base, mr);
 }
 
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 {
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr = mdc->get_memory_region(md, &error_abort);
+
     /* we expect a previous call to memory_device_get_free_addr() */
     g_assert(ms->device_memory);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4760b17062..70c46d2a73 100644
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
index ea9331a778..d06b944ee7 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -60,6 +60,6 @@ uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 
 #endif
-- 
2.17.1
