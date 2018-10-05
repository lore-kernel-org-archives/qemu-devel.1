Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRf-0001nn-7X
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MJW-0006pa-1O
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:22:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:20 +0200
Message-Id: <20181005092024.14344-13-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 12/16] memory-device: add device class
 function set_addr()
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

To be able to factor out address assignment of memory devices, we will
have to read (get_addr()) and write (set_addr()) the address.

We can't use properties for this purpose, as properties are device
specific. E.g. while the address property for a DIMM is called "addr", it
might be called differently (e.g. "memaddr") for other devices.

Especially virtio based memory devices cannot use "addr" as that is already
reserved and used for the address on the bus (for the proxy device).

Also, it might be possible to have memory devices without address
properties (e.g. internal DIMM-like thingies).

In contrast to get_addr(), we expect that set_addr() can fail.

Keep it simple for now for pc-dimm and simply set the static property, that
will fail once realized.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c               | 7 +++++++
 include/hw/mem/memory-device.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 47b2e83389..4a15091734 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,6 +236,12 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
+static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, PC_DIMM_ADDR_PROP, errp);
+}
+
 static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
                                                   Error **errp)
 {
@@ -286,6 +292,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
+    mdc->set_addr = pc_dimm_md_set_addr;
     /* for a dimm plugged_size == region_size */
     mdc->get_plugged_size = memory_device_get_region_size;
     mdc->get_memory_region = pc_dimm_md_get_memory_region;
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 9c3398bc4a..ed7cf5bf4b 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -59,6 +59,14 @@ typedef struct MemoryDeviceClass {
      */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
 
+    /*
+     * Set the address of the memory device in guest physical memory.
+     *
+     * Called when plugging the memory device to configure the determined
+     * address in guest physical memory.
+     */
+    void (*set_addr)(MemoryDeviceState *md, uint64_t addr, Error **errp);
+
     /*
      * Return the amount of memory provided by the memory device currently
      * usable ("plugged") by the VM.
-- 
2.17.1
