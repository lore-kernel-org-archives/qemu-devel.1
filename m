Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPS-0003Fy-5F
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPR-0001IY-Aj
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCPR-0001IA-1c
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:49 +0800
Message-Id: <20170628124850.12821-7-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] virtio-scsi: Use DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c |  2 +-
 hw/scsi/virtio-scsi.c           | 15 ++++-----------
 hw/virtio/virtio-pci.c          |  2 --
 include/hw/virtio/virtio-scsi.h |  2 +-
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 944ea4e..887c100 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -40,7 +40,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             error_setg(errp, "ioeventfd is required for iothread");
             return;
         }
-        s->ctx = iothread_get_aio_context(vs->conf.iothread);
+        s->ctx = iothread_get_aio_context(IOTHREAD(vs->conf.iothread));
     } else {
         if (!virtio_device_ioeventfd_enabled(vdev)) {
             return;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f46f06d..afe4389 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -897,16 +897,6 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
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
@@ -934,6 +924,10 @@ static Property virtio_scsi_properties[] = {
                                            VIRTIO_SCSI_F_HOTPLUG, true),
     DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true),
+    DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
+                     TYPE_IOTHREAD,
+                     qdev_prop_allow_set_link_before_realize,
+                     OBJ_PROP_LINK_UNREF_ON_RELEASE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -988,7 +982,6 @@ static const TypeInfo virtio_scsi_info = {
     .name = TYPE_VIRTIO_SCSI,
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
-    .instance_init = virtio_scsi_instance_init,
     .class_init = virtio_scsi_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e6960ae..eb03ba5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2065,8 +2065,6 @@ static void virtio_scsi_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_SCSI);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev), "iothread",
-                              &error_abort);
 }
 
 static const TypeInfo virtio_scsi_pci_info = {
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index de6ae5a..1decc40 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -56,7 +56,7 @@ struct VirtIOSCSIConf {
 #endif
     CharBackend chardev;
     uint32_t boot_tpgt;
-    IOThread *iothread;
+    Object *iothread;
 };
 
 struct VirtIOSCSI;
-- 
2.9.4
