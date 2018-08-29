Received: from eggs.gnu.org ([2001:4830:134:3::10]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wy-0004sg-GQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Ww-0002A2-M7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Ww-00029g-Ge
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:18 +0200
Message-Id: <20180829153624.12299-15-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio based
 devices are special
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

When reporting the id of virtio-based memory devices, we always have to
take the one of the proxy device (parent).

Expose the function, so especially virtio-based memory devices can
reuse the function when filling out the id in MemoryDeviceInfo.

Details:

When the user creates a virtio device (e.g.  virtio-balloon-pci), two
devices are actually created.

1. Virtio proxy device (e.g. TYPE_VIRTIO_BALLOON_PCI)
2. The "real" virtio device (e.g. TYPE_VIRTIO_BALLOON).

1. aliases all properties of 2, so 2. can be properly configured using 1.
1. gets the device ID set specified by the user. 2. gets no ID set.

If we want to make 2. a MemoryDevice but report errors/information to the
user, we always have to report the id of 1. (because that's the device the
user instantiated and configured).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 21 +++++++++++++++++++--
 include/hw/mem/memory-device.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a31ba73ea7..89a0c584be 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -19,6 +19,22 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 
+const char *memory_device_id(const MemoryDeviceState *md)
+{
+    Object *obj = OBJECT(md);
+
+    /* always use the ID of the proxy device for virtio devices */
+    if (object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
+        if (obj->parent && object_dynamic_cast(obj->parent, TYPE_DEVICE)) {
+            const DeviceState *parent_dev = DEVICE(obj->parent);
+
+            return parent_dev->id;
+        }
+        return NULL;
+    }
+    return DEVICE(md)->id;
+}
+
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
     const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
@@ -168,6 +184,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     for (item = list; item; item = g_slist_next(item)) {
         MemoryDeviceState *md = item->data;
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
+        const char *id = memory_device_id(md);
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
@@ -178,8 +195,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
 
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
-                const DeviceState *d = DEVICE(md);
-                error_setg(errp, "address range conflicts with '%s'", d->id);
+                error_setg(errp, "address range conflicts with '%s'",
+                           id ? id : 0);
                 goto out;
             }
             new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 05cb9437b7..324cc45b6f 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -54,6 +54,7 @@ typedef struct MemoryDeviceClass {
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
 
+const char *memory_device_id(const MemoryDeviceState *md);
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
-- 
2.17.1
