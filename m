Received: from eggs.gnu.org ([209.51.188.92]:40594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzU-0004aQ-00
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzS-0002Ph-4c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1nzQ-0002OG-7V
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8226F8762B
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 08:02:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 09:02:42 +0100
Message-Id: <20190307080244.9011-2-kraxel@redhat.com>
In-Reply-To: <20190307080244.9011-1-kraxel@redhat.com>
References: <20190307080244.9011-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] virtio: add class_size to
 VirtioPCIDeviceTypeInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Needed when VirtioPCIClass subclasses have their own
class struct with some extra fields.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/virtio/virtio-pci.h | 1 +
 hw/virtio/virtio-pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index bd223a6e3b0b..18581854cae1 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -230,6 +230,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
 
     /* Same as TypeInfo fields: */
     size_t instance_size;
+    size_t class_size;
     void (*instance_init)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
 } VirtioPCIDeviceTypeInfo;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e978bfe76048..cb44e19b6789 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1935,6 +1935,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size = t->instance_size,
         .instance_init = t->instance_init,
+        .class_size    = t->class_size,
         .class_init    = virtio_pci_base_class_init,
         .class_data    = (void *)t,
         .abstract      = true,
-- 
2.18.1
