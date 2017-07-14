Received: from eggs.gnu.org ([2001:4830:134:3::10]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYb-0000Im-O0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYa-00051z-Cy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:45 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYa-00051a-6g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:44 -0400
Received: by mail-wr0-x241.google.com with SMTP id y28so6807409wrd.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:20 +0200
Message-Id: <1500027028-4127-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/55] virtio-blk: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-7-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/virtio-blk.c  | 6 ++----
 hw/s390x/virtio-ccw.c  | 2 --
 hw/virtio/virtio-pci.c | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index c0bd247..b750bd8 100644
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
@@ -1014,6 +1010,8 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
+                     IOThread *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e18fd26..a0437d1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -867,8 +867,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
-                              &error_abort);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
                               "bootindex", &error_abort);
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 93480a7..94f72f3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2000,8 +2000,6 @@ static void virtio_blk_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
-                              &error_abort);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
                               "bootindex", &error_abort);
 }
-- 
1.8.3.1
