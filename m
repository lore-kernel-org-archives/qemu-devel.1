Received: from eggs.gnu.org ([2001:4830:134:3::10]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZC-00041B-Jl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZ7-00030N-Pw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZ7-0002zu-HH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7610731A34A
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:04 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:33 +0800
Message-Id: <20170704064347.7022-7-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/20] virtio-blk: Convert to
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
 hw/block/dataplane/virtio-blk.c | 2 +-
 hw/block/virtio-blk.c           | 5 +----
 hw/s390x/virtio-ccw.c           | 2 --
 hw/virtio/virtio-pci.c          | 2 --
 include/hw/virtio/virtio-blk.h  | 3 ++-
 5 files changed, 4 insertions(+), 10 deletions(-)

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
index c0bd247..8146306 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -983,10 +983,6 @@ static void virtio_blk_instance_init(Object *obj)
 {
     VirtIOBlock *s = VIRTIO_BLK(obj);
 
-    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
-                             (Object **)&s->conf.iothread,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
     device_add_bootindex_property(obj, &s->conf.conf.bootindex,
                                   "bootindex", "/disk@0,0",
                                   DEVICE(obj), NULL);
@@ -1014,6 +1010,7 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 90d37cb..a17ce84 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -789,8 +789,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
-                              &error_abort);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
                               "bootindex", &error_abort);
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 301920e..984baf8 100644
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
index d3c8a6f..2452074 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -33,7 +33,8 @@ struct virtio_blk_inhdr
 struct VirtIOBlkConf
 {
     BlockConf conf;
-    IOThread *iothread;
+    /* IOThread pointer to be filled by link property */
+    Object *iothread;
     char *serial;
     uint32_t scsi;
     uint32_t config_wce;
-- 
2.9.4
