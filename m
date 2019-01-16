Received: from eggs.gnu.org ([209.51.188.92]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjUv-0005RR-7y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjUt-00006i-2G
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:40 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Jan 2019 12:35:18 +0100
Message-Id: <20190116113523.9213-6-david@redhat.com>
In-Reply-To: <20190116113523.9213-1-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 05/10] virtio-pci: Allow to specify
 additional interfaces for the base type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Let's allow to specify additional interfaces for the base type (e.g.
later TYPE_MEMORY_DEVICE), something that was possible before the
rework of virtio PCI device instantiation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-pci.c | 1 +
 hw/virtio/virtio-pci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d05066deb8..62fe1278e0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1995,6 +1995,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .class_init    = virtio_pci_base_class_init,
         .class_data    = (void *)t,
         .abstract      = true,
+        .interfaces    = t->interfaces,
     };
     TypeInfo generic_type_info = {
         .name = t->generic_name,
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 29b4216107..9d8f41ea15 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -466,6 +466,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     size_t instance_size;
     void (*instance_init)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
+    InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
 /* Register virtio-pci type(s).  @t must be static. */
-- 
2.17.2
