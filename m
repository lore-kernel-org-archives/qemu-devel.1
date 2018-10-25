Received: from eggs.gnu.org ([2001:4830:134:3::10]:59037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfq5-000659-2B
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfpx-0001ZR-5Y
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:45 -0300
Message-Id: <20181025133301.16578-28-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/43] memory-device: drop get_region_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

There are no remaining users of get_region_size() except
memory_device_get_region_size() itself. We can make
memory_device_get_region_size() work directly on get_memory_region()
instead and drop get_region_size().

In addition, we can now use memory_device_get_region_size() in pc-dimm
code to implement get_plugged_size()"

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-12-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h |  1 -
 hw/mem/memory-device.c         | 11 +++++++++--
 hw/mem/pc-dimm.c               | 18 +-----------------
 3 files changed, 10 insertions(+), 20 deletions(-)

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
-- 
2.18.0.rc1.1.g3f1ff2140
