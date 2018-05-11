Received: from eggs.gnu.org ([2001:4830:134:3::10]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yb-0001Od-Qg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7ya-0004QC-T9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:45 +0200
Message-Id: <20180511131953.12905-10-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/17] memory-device: new functions to
 handle plug/unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

We will need a handful of new functions:
- set_addr(): To set the calculated address
- get_memory_region(): To add it to the memory region container
- get_addr(): If the device has any specific alignment requirements

Using these and the existing functions, we can properly plug/unplug
memory devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..62d906be50 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -29,14 +29,24 @@ typedef struct MemoryDeviceState {
     Object parent_obj;
 } MemoryDeviceState;
 
+/*
+ * MemoryDeviceClass functions should only be called on realized
+ * MemoryDevice instances.
+ */
 typedef struct MemoryDeviceClass {
     InterfaceClass parent_class;
 
+    /* required functions that have to be implemented */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
+    void (*set_addr)(MemoryDeviceState *md, uint64_t addr);
+    MemoryRegion *(*get_memory_region)(MemoryDeviceState *md);
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
