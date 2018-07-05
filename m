Received: from eggs.gnu.org ([2001:4830:134:3::10]:50997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vd-0000un-Jf
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vZ-00032m-Jj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vZ-00031f-F8
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC3E94074474
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 12:00:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:41 +0200
Message-Id: <20180705115943.29402-10-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 09/11] memory-device: complete factoring out
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

With the new memory device functions in place, we can factor out
plugging of memory devices completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 7 +++++--
 hw/mem/pc-dimm.c               | 7 +------
 include/hw/mem/memory-device.h | 3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3ed067debb..ec81133edf 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -275,9 +275,12 @@ out:
     error_propagate(errp, local_err);
 }
 
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr)
+void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 {
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const uint64_t addr = mdc->get_addr(md);
+    MemoryRegion *mr = mdc->get_memory_region(md, &error_abort);
+
     /* we expect a previous call to memory_device_get_free_addr() */
     g_assert(ms->device_memory);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 33ab0621cc..4760b17062 100644
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
index fb920b9f44..ea9331a778 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -59,8 +59,7 @@ MemoryDeviceInfoList *qmp_memory_device_list(void);
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
