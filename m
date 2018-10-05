Received: from eggs.gnu.org ([2001:4830:134:3::10]:47318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRh-0001nG-67
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MIz-0006Vq-Cd
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:16 +0200
Message-Id: <20181005092024.14344-9-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/16] memory-device: document
 MemoryDeviceClass
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

Document the functions. Don't document get_region_size(), as we will be
dropping/replacing that one soon.

Use same documentation style as in include/exec/memory.h, but don't
document the parameters, as they are self-explanatory.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index f02b229837..0474a3dd11 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -29,12 +29,48 @@ typedef struct MemoryDeviceState {
     Object parent_obj;
 } MemoryDeviceState;
 
+/**
+ * MemoryDeviceClass:
+ *
+ * All memory devices need to implement TYPE_MEMORY_DEVICE as an interface.
+ *
+ * A memory device is a device that owns a memory region which is
+ * mapped into guest physical address space at a certain address. The
+ * address in guest physical memory can either be specified explicitly
+ * or get assigned automatically.
+ */
 typedef struct MemoryDeviceClass {
+    /* private */
     InterfaceClass parent_class;
 
+    /*
+     * Return the address of the memory device in guest physical memory.
+     *
+     * Called when (un)plugging a memory device or when iterating over
+     * all memory devices mapped into guest physical address space.
+     *
+     * If "0" is returned, no address has been specified by the user and
+     * no address has been assigned to this memory device yet.
+     */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
+
+    /*
+     * Return the amount of memory provided by the memory device currently
+     * usable ("plugged") by the VM.
+     *
+     * Called when calculating the total amount of ram available to the
+     * VM (e.g. to report memory stats to the user).
+     *
+     * This is helpful for devices that dynamically manage the amount of
+     * memory accessible by the guest via the reserved memory region. For
+     * most devices, this corresponds to the size of the memory region.
+     */
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
     uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
+
+    /*
+     * Translate the memory device into #MemoryDeviceInfo.
+     */
     void (*fill_device_info)(const MemoryDeviceState *md,
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
-- 
2.17.1
