Received: from eggs.gnu.org ([2001:4830:134:3::10]:54551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z4N-0005vH-O6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z4L-0002pW-Vi
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1g9z4L-0002mt-MD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue,  9 Oct 2018 22:56:52 +0200
Message-Id: <20181009205652.10605-8-david@redhat.com>
In-Reply-To: <20181009205652.10605-1-david@redhat.com>
References: <20181009205652.10605-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/7] memory-device: rewrite address
 assignment using ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Let's rewrite it properly using ranges. This fixes certain overflows that
are right now possible. E.g.

qemu-system-x86_64 -m 4G,slots=20,maxmem=40G -M pc \
    -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=2G
    -device pc-dimm,memdev=mem1,id=dimm1,addr=-0x40000000

Now properly reports an error instead of succeeding.

"can't add memory device [0xffffffffc0000000:0x80000000], range overflow"

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 56 +++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8be63c8032..1ca9c8e410 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -100,9 +100,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
                                             uint64_t align, uint64_t size,
                                             Error **errp)
 {
-    uint64_t address_space_start, address_space_end;
     GSList *list = NULL, *item;
-    uint64_t new_addr = 0;
+    Range as, new = range_empty;
 
     if (!ms->device_memory) {
         error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
@@ -115,13 +114,11 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
                          "enabled, please specify the maxmem option");
         return 0;
     }
-    address_space_start = ms->device_memory->base;
-    address_space_end = address_space_start +
-                        memory_region_size(&ms->device_memory->mr);
-    g_assert(address_space_end >= address_space_start);
+    range_init(&as, ms->device_memory->base,
+               memory_region_size(&ms->device_memory->mr));
 
-    /* address_space_start indicates the maximum alignment we expect */
-    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
+    /* start of address space indicates the maximum alignment we expect */
+    if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
         error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
                    align);
         return 0;
@@ -145,20 +142,26 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     }
 
     if (hint) {
-        new_addr = *hint;
-        if (new_addr < address_space_start) {
+        if (!range_valid(*hint, size)) {
             error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
-                       "] before 0x%" PRIx64, new_addr, size,
-                       address_space_start);
+                       "], range overflow", *hint, size);
             return 0;
-        } else if ((new_addr + size) > address_space_end) {
+        }
+        range_init(&new, *hint, size);
+        if (range_starts_before_range(&new, &as)) {
+            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
+                       "] before 0x%" PRIx64, range_lob(&new), range_size(&new),
+                       range_lob(&as));
+            return 0;
+        } else if (range_ends_after_range(&new, &as)) {
             error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
-                       "] beyond 0x%" PRIx64, new_addr, size,
-                       address_space_end);
+                       "] beyond 0x%" PRIx64, range_lob(&new), range_size(&new),
+                       range_upb(&as));
             return 0;
         }
     } else {
-        new_addr = address_space_start;
+        /* our previous size checks make sure that this never overflows */
+        range_init(&new, range_lob(&as), size);
     }
 
     /* find address range that will fit new memory device */
@@ -166,30 +169,37 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     for (item = list; item; item = g_slist_next(item)) {
         const MemoryDeviceState *md = item->data;
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
-        uint64_t md_size, md_addr;
+        uint64_t next_addr;
+        Range tmp;
 
-        md_addr = mdc->get_addr(md);
-        md_size = memory_device_get_region_size(md, &error_abort);
+        range_init(&tmp, mdc->get_addr(md),
+                   memory_device_get_region_size(md, &error_abort));
 
-        if (ranges_overlap(md_addr, md_size, new_addr, size)) {
+        if (range_overlaps_range(&tmp, &new)) {
             if (hint) {
                 const DeviceState *d = DEVICE(md);
                 error_setg(errp, "address range conflicts with memory device"
                            " id='%s'", d->id ? d->id : "(unnamed)");
                 goto out;
             }
-            new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
+
+            next_addr = QEMU_ALIGN_UP(range_upb(&tmp) + 1, align);
+            if (!range_valid(next_addr, size)) {
+                range_make_empty(&new);
+                break;
+            }
+            range_init(&new, next_addr, size);
         }
     }
 
-    if (new_addr + size > address_space_end) {
+    if (!range_contains_range(&as, &new)) {
         error_setg(errp, "could not find position in guest address space for "
                    "memory device - memory fragmented due to alignments");
         goto out;
     }
 out:
     g_slist_free(list);
-    return new_addr;
+    return range_lob(&new);
 }
 
 MemoryDeviceInfoList *qmp_memory_device_list(void)
-- 
2.17.1
