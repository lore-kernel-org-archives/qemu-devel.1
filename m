Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vY-0000pF-15
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vU-0002n1-NJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vU-0002m1-IF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15A90818534C
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:38 +0200
Message-Id: <20180705115943.29402-7-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/11] memory-device: add device class
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

To be able to factor out address asignment of memory devices, we will
have to read (get_addr()) and write (set_addr()) the address. We cannot
use properties for this purpose, as properties are device specific. E.g.
while the address property for a DIMM is called "addr", it might be
called differently (e.g. "phys_addr") for other devices. E.g. virtio
based memory devices cannot use "addr" as that is already reserved and
used for the virtio device address on the bus.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 0c1fd66b68..cf5d182ac2 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -34,6 +34,7 @@ typedef struct MemoryDeviceState {
  * @get_addr: The address of the @md in guest physical memory. "0" means that
  * no address has been specified by the user and that no address has been
  * assigned yet.
+ * @set_addr: Set the address of the @md in guest physical memory.
  * @get_plugged_size: The the amount of memory provided by this @md
  * currently usable ("plugged") by the guest. Will not fail after the device
  * was realized.
@@ -47,6 +48,7 @@ typedef struct MemoryDeviceClass {
 
     /* public */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
+    void (*set_addr)(MemoryDeviceState *md, uint64_t addr, Error **errp);
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
     void (*fill_device_info)(const MemoryDeviceState *md,
-- 
2.17.1
