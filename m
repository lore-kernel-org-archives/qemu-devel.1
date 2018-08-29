Received: from eggs.gnu.org ([2001:4830:134:3::10]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wg-0004YK-8J
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wc-00021H-Ta
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wc-000219-NB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:54 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:11 +0200
Message-Id: <20180829153624.12299-8-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/20] memory-device: add device class
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

To be able to factor out address asignment of memory devices, we will
have to read (get_addr()) and write (set_addr()) the address.

We can't use properties for this purpose, as properties are device
specific. E.g. while the address property for a DIMM is called "addr", it
might be called differently (e.g. "memaddr") for other devices.

Especially virtio based memory devices cannot use "addr" as that is already
reserved and used for the address on the bus (for the proxy device).

Also, it might be possible to have memory devices without address
properties (e.g. internal DIMM-like thingies).

In contrast to get_addr(), we expect that set_addr() can fail.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index d353564faf..148f32743f 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -34,6 +34,7 @@ typedef struct MemoryDeviceState {
  * @get_addr: The address of the @md in guest physical memory. "0" means that
  * no address has been specified by the user and that no address has been
  * assigned yet.
+ * @set_addr: Set the address of the @md in guest physical memory.
  * @get_plugged_size: The amount of memory provided by this @md currently
  * usable ("plugged") by the guest. Will not fail after the device was realized.
  * @get_memory_region: The memory region of the @md to mapped in guest
@@ -46,6 +47,7 @@ typedef struct MemoryDeviceClass {
 
     /* public */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
+    void (*set_addr)(MemoryDeviceState *md, uint64_t addr, Error **errp);
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
     void (*fill_device_info)(const MemoryDeviceState *md,
-- 
2.17.1
