Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUW-0000j4-By
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUV-0003jH-Ex
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:32 +0200
Message-Id: <20180503154936.18946-5-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/8] memory-device: new functions to handle
 resource assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We will need a handful of new functions:
- set_addr(): To set the calculated address
- get_memory_region(): To add it to the memory region container
- get_addr(): If the device has any specific alignment requirements

Using these and the existing functions, we can properly assign resources
to memory devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..e43ce1c8d3 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -32,11 +32,17 @@ typedef struct MemoryDeviceState {
 typedef struct MemoryDeviceClass {
     InterfaceClass parent_class;
 
+    /* required functions that have to be implemented */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
+    uint64_t (*set_addr)(MemoryDeviceState *md);
+    MemoryRegion * (*get_memory_region)(MemoryDeviceState *md);
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md);
     uint64_t (*get_region_size)(const MemoryDeviceState *md);
     void (*fill_device_info)(const MemoryDeviceState *md,
                              MemoryDeviceInfo *info);
+
+    /* optional functions that can be implemented */
+    uint64_t (*get_align)(const MemoryDeviceState *md);
 } MemoryDeviceClass;
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
-- 
2.14.3
