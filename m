Received: from eggs.gnu.org ([2001:4830:134:3::10]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vQ-0000i9-Pz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vP-0002Y1-VF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vP-0002US-LJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13B324074474
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:35 +0200
Message-Id: <20180705115943.29402-4-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/11] memory-device:
 get_region_size()/get_plugged_size() might fail
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

Let's properly forward the error, so in case somebody calls
get_region_size() / get_plugged_size(), he can react on the error.

Users right now call both functions after the device has been realized,
which is guaranteed to no fail (we'll document this behavior in a
follow-up patch).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 6 +++---
 hw/mem/pc-dimm.c               | 5 +++--
 include/hw/mem/memory-device.h | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index efacbc2a7d..3ac0d5e505 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -60,7 +60,7 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_region_size(md);
+            *size += mdc->get_region_size(md, &error_abort);
         }
     }
 
@@ -167,7 +167,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
-        md_size = mdc->get_region_size(md);
+        md_size = mdc->get_region_size(md, &error_abort);
         if (*errp) {
             goto out;
         }
@@ -233,7 +233,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_plugged_size(md);
+            *size += mdc->get_plugged_size(md, &error_abort);
         }
     }
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index fb6bcaedc4..4bf1a0acc9 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,14 +236,15 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
-static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
+static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
+                                           Error **errp)
 {
     /* dropping const here is fine as we don't touch the memory region */
     PCDIMMDevice *dimm = PC_DIMM(md);
     const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
     MemoryRegion *mr;
 
-    mr = ddc->get_memory_region(dimm, &error_abort);
+    mr = ddc->get_memory_region(dimm, errp);
     if (!mr) {
         return 0;
     }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..f02b229837 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -33,8 +33,8 @@ typedef struct MemoryDeviceClass {
     InterfaceClass parent_class;
 
     uint64_t (*get_addr)(const MemoryDeviceState *md);
-    uint64_t (*get_plugged_size)(const MemoryDeviceState *md);
-    uint64_t (*get_region_size)(const MemoryDeviceState *md);
+    uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
+    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
     void (*fill_device_info)(const MemoryDeviceState *md,
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
-- 
2.17.1
