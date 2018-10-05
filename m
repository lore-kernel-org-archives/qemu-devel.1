Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRh-0001nL-D1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MIo-0006OU-JR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:15 +0200
Message-Id: <20181005092024.14344-8-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 07/16] memory-device: forward errors in
 get_region_size()/get_plugged_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

Let's properly forward the errors, so errors from get_region_size() /
get_plugged_size() can be handled.

Users right now call both functions after the device has been realized,
which is will never fail, so it is fine to continue using error_abort.

While at it, remove a leftover error check (suggested by Igor).

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 9 +++------
 hw/mem/pc-dimm.c               | 5 +++--
 include/hw/mem/memory-device.h | 4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 87369ef2e1..c1e1b81cf2 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -60,7 +60,7 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_region_size(md);
+            *size += mdc->get_region_size(md, &error_abort);
         }
     }
 
@@ -167,10 +167,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
-        md_size = mdc->get_region_size(md);
-        if (*errp) {
-            goto out;
-        }
+        md_size = mdc->get_region_size(md, &error_abort);
 
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
@@ -234,7 +231,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_plugged_size(md);
+            *size += mdc->get_plugged_size(md, &error_abort);
         }
     }
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index f46fb7ada2..130f78d0de 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -234,14 +234,15 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
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
