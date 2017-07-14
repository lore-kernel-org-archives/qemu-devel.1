Received: from eggs.gnu.org ([2001:4830:134:3::10]:33845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8k-0003Nw-3h
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8j-00019I-5r
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8i-00018w-Sx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E28573D972
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:31 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:14:56 +0800
Message-Id: <20170714021509.23681-8-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/20] virtio-scsi: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/s390x/virtio-ccw.c  |  2 --
 hw/scsi/virtio-scsi.c  | 13 ++-----------
 hw/virtio/virtio-pci.c |  2 --
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a0437d1..c5e0606 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -950,8 +950,6 @@ static void virtio_ccw_scsi_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_SCSI);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev), "iothread",
-                              &error_abort);
 }
 
 #ifdef CONFIG_VHOST_SCSI
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d076fe7..eb63944 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -898,16 +898,6 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     virtio_scsi_dataplane_setup(s, errp);
 }
 
-static void virtio_scsi_instance_init(Object *obj)
-{
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(obj);
-
-    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
-                             (Object **)&vs->conf.iothread,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_abort);
-}
-
 void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -935,6 +925,8 @@ static Property virtio_scsi_properties[] = {
                                            VIRTIO_SCSI_F_HOTPLUG, true),
     DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true),
+    DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
+                     TYPE_IOTHREAD, IOThread *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -989,7 +981,6 @@ static const TypeInfo virtio_scsi_info = {
     .name = TYPE_VIRTIO_SCSI,
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
-    .instance_init = virtio_scsi_instance_init,
     .class_init = virtio_scsi_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 94f72f3..cc69fe3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2069,8 +2069,6 @@ static void virtio_scsi_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_SCSI);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev), "iothread",
-                              &error_abort);
 }
 
 static const TypeInfo virtio_scsi_pci_info = {
-- 
2.9.4
