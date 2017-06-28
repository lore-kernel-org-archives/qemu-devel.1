Received: from eggs.gnu.org ([2001:4830:134:3::10]:47255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPR-0003FS-M2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPN-0001Fw-Qo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCPN-0001FY-IM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:48 +0800
Message-Id: <20170628124850.12821-6-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] virtio-blk: Use DEFINE_PROP_LINK
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
 hw/block/dataplane/virtio-blk.c | 2 +-
 hw/block/virtio-blk.c           | 7 +++----
 hw/virtio/virtio-pci.c          | 2 --
 include/hw/virtio/virtio-blk.h  | 2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e..6fdc6f6 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -116,7 +116,7 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     s->conf = conf;
 
     if (conf->iothread) {
-        s->iothread = conf->iothread;
+        s->iothread = IOTHREAD(conf->iothread);
         object_ref(OBJECT(s->iothread));
         s->ctx = iothread_get_aio_context(s->iothread);
     } else {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 604d37d..aa2c38c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -981,10 +981,6 @@ static void virtio_blk_instance_init(Object *obj)
 {
     VirtIOBlock *s = VIRTIO_BLK(obj);
 
-    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
-                             (Object **)&s->conf.iothread,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
     device_add_bootindex_property(obj, &s->conf.conf.bootindex,
                                   "bootindex", "/disk@0,0",
                                   DEVICE(obj), NULL);
@@ -1012,6 +1008,9 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
+                     qdev_prop_allow_set_link_before_realize,
+                     OBJ_PROP_LINK_UNREF_ON_RELEASE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 20d6a08..e6960ae 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1996,8 +1996,6 @@ static void virtio_blk_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
-                              &error_abort);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
                               "bootindex", &error_abort);
 }
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index d3c8a6f..94a9f0c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -33,7 +33,7 @@ struct virtio_blk_inhdr
 struct VirtIOBlkConf
 {
     BlockConf conf;
-    IOThread *iothread;
+    Object *iothread;
     char *serial;
     uint32_t scsi;
     uint32_t config_wce;
-- 
2.9.4
