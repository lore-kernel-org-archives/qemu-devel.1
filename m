Received: from eggs.gnu.org ([2001:4830:134:3::10]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfoT-0003jW-QW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfoS-0000gE-Eq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:42 -0300
Message-Id: <20181025133301.16578-25-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 24/43] memory-device: document
 MemoryDeviceClass
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

Document the functions. Don't document get_region_size(), as we will be
dropping/replacing that one soon.

Use same documentation style as in include/exec/memory.h, but don't
document the parameters, as they are self-explanatory.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-9-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
