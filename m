Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZC-00041D-K7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZA-00031V-7g
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZ9-00031A-Uo
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2B587DCC8
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:06 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:34 +0800
Message-Id: <20170704064347.7022-8-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/20] virtio-scsi: Convert to
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
 hw/s390x/virtio-ccw.c           |  2 --
 hw/scsi/virtio-scsi-dataplane.c |  2 +-
 hw/scsi/virtio-scsi.c           | 13 ++-----------
 hw/virtio/virtio-pci.c          |  2 --
 include/hw/virtio/virtio-scsi.h |  3 ++-
 5 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a17ce84..9386893 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -872,8 +872,6 @@ static void virtio_ccw_scsi_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_SCSI);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev), "iothread",
-                              &error_abort);
 }
 
 #ifdef CONFIG_VHOST_SCSI
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
index f46f06d..d48bcce 100644
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
@@ -934,6 +924,8 @@ static Property virtio_scsi_properties[] = {
                                            VIRTIO_SCSI_F_HOTPLUG, true),
     DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true),
+    DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
+                     TYPE_IOTHREAD),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -988,7 +980,6 @@ static const TypeInfo virtio_scsi_info = {
     .name = TYPE_VIRTIO_SCSI,
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
-    .instance_init = virtio_scsi_instance_init,
     .class_init = virtio_scsi_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 984baf8..1eb61be 100644
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
index de6ae5a..9d9bb56 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -56,7 +56,8 @@ struct VirtIOSCSIConf {
 #endif
     CharBackend chardev;
     uint32_t boot_tpgt;
-    IOThread *iothread;
+    /* IOThread pointer to be filled by link property */
+    Object *iothread;
 };
 
 struct VirtIOSCSI;
-- 
2.9.4
