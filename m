Received: from eggs.gnu.org ([2001:4830:134:3::10]:47318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRf-0001nG-VQ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MJP-0006kE-D8
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:22:23 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:19 +0200
Message-Id: <20181005092024.14344-12-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/16] memory-device: drop get_region_size()
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

There are no remaining users of get_region_size() except
memory_device_get_region_size() itself. We can make
memory_device_get_region_size() work directly on get_memory_region()
instead and drop get_region_size().

In addition, we can now use memory_device_get_region_size() in pc-dimm
code to implement get_plugged_size()"

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 11 +++++++++--
 hw/mem/pc-dimm.c               | 18 +-----------------
 include/hw/mem/memory-device.h |  1 -
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 425830c65c..07749bab69 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -268,9 +268,16 @@ void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
                                        Error **errp)
 {
-    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr;
 
-    return mdc->get_region_size(md, errp);
+    /* dropping const here is fine as we don't touch the memory region */
+    mr = mdc->get_memory_region((MemoryDeviceState *)md, errp);
+    if (!mr) {
+        return 0;
+    }
+
+    return memory_region_size(mr);
 }
 
 static const TypeInfo memory_device_info = {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c9f6ad589e..47b2e83389 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,21 +236,6 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
-static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
-                                           Error **errp)
-{
-    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
-    MemoryRegion *mr;
-
-    /* dropping const here is fine as we don't touch the memory region */
-    mr = mdc->get_memory_region((MemoryDeviceState *)md, errp);
-    if (!mr) {
-        return 0;
-    }
-
-    return memory_region_size(mr);
-}
-
 static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
                                                   Error **errp)
 {
@@ -302,8 +287,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
 
     mdc->get_addr = pc_dimm_md_get_addr;
     /* for a dimm plugged_size == region_size */
-    mdc->get_plugged_size = pc_dimm_md_get_region_size;
-    mdc->get_region_size = pc_dimm_md_get_region_size;
+    mdc->get_plugged_size = memory_device_get_region_size;
     mdc->get_memory_region = pc_dimm_md_get_memory_region;
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
 }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 659f38385c..9c3398bc4a 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -71,7 +71,6 @@ typedef struct MemoryDeviceClass {
      * most devices, this corresponds to the size of the memory region.
      */
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
-    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
 
     /*
      * Return the memory region of the memory device.
-- 
2.17.1
