Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnF2-0007G1-GY
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnF1-0001nC-IM
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gXnF1-0001mi-AM
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:55 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri, 14 Dec 2018 14:10:43 +0100
Message-Id: <20181214131043.25071-3-david@redhat.com>
In-Reply-To: <20181214131043.25071-1-david@redhat.com>
References: <20181214131043.25071-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/2] memory-device: rewrite address
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Let's rewrite it properly using ranges. This fixes certain overflows that
are right now possible. E.g.

qemu-system-x86_64 -m 4G,slots=20,maxmem=40G -M pc \
    -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=2G
    -device pc-dimm,memdev=mem1,id=dimm1,addr=-0x40000000

Now properly errors out instead of succeeding. (Note that qapi
parsing of huge uint64_t values is broken and fixes are on the way)

"can't add memory device [0xffffffffa0000000:0x80000000], usable range for
memory devices [0x140000000:0xe00000000]"

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 51 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8be63c8032..5f2c408036 100644
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
+    range_init_nofail(&as, ms->device_memory->base,
+                      memory_region_size(&ms->device_memory->mr));
 
-    /* address_space_start indicates the maximum alignment we expect */
-    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
+    /* start of address space indicates the maximum alignment we expect */
+    if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
         error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
                    align);
         return 0;
@@ -145,20 +142,18 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     }
 
     if (hint) {
-        new_addr = *hint;
-        if (new_addr < address_space_start) {
+        if (range_init(&new, *hint, size) || !range_contains_range(&as, &new)) {
             error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
-                       "] before 0x%" PRIx64, new_addr, size,
-                       address_space_start);
-            return 0;
-        } else if ((new_addr + size) > address_space_end) {
-            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
-                       "] beyond 0x%" PRIx64, new_addr, size,
-                       address_space_end);
+                       "], usable range for memory devices [0x%" PRIx64 ":0x%"
+                       PRIx64 "]", *hint, size, range_lob(&as),
+                       range_size(&as));
             return 0;
         }
     } else {
-        new_addr = address_space_start;
+        if (range_init(&new, range_lob(&as), size)) {
+            error_setg(errp, "can't add memory device, device too big");
+            return 0;
+        }
     }
 
     /* find address range that will fit new memory device */
@@ -166,30 +161,36 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     for (item = list; item; item = g_slist_next(item)) {
         const MemoryDeviceState *md = item->data;
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
-        uint64_t md_size, md_addr;
+        uint64_t next_addr;
+        Range tmp;
 
-        md_addr = mdc->get_addr(md);
-        md_size = memory_device_get_region_size(md, &error_abort);
+        range_init_nofail(&tmp, mdc->get_addr(md),
+                          memory_device_get_region_size(md, &error_abort));
 
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
+            if (!next_addr || range_init(&new, next_addr, range_size(&new))) {
+                range_make_empty(&new);
+                break;
+            }
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
2.17.2
