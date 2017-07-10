Received: from eggs.gnu.org ([2001:4830:134:3::10]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUT05-0000Uo-5V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUT02-00010r-0z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUT01-00010f-NF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8C50C04B32C
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:52 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:27 +0800
Message-Id: <20170710072027.7948-6-famz@redhat.com>
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
References: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 5/5] virtio-blk: Add iothread-group property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Do I/O on the IOThreadGroup's aio context. This is mutually exclusive to
iothread property.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 18 +++++++++++-------
 hw/block/virtio-blk.c           |  6 ++++++
 include/hw/virtio/virtio-blk.h  |  2 ++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 6fdc6f6..4b76f8b 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -40,7 +40,6 @@ struct VirtIOBlockDataPlane {
      * (because you don't own the file descriptor or handle; you just
      * use it).
      */
-    IOThread *iothread;
     AioContext *ctx;
 };
 
@@ -86,7 +85,7 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
 
     *dataplane = NULL;
 
-    if (conf->iothread) {
+    if (conf->iothread || conf->iothread_group) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
             error_setg(errp,
                        "device is incompatible with iothread "
@@ -116,9 +115,11 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     s->conf = conf;
 
     if (conf->iothread) {
-        s->iothread = IOTHREAD(conf->iothread);
-        object_ref(OBJECT(s->iothread));
-        s->ctx = iothread_get_aio_context(s->iothread);
+        object_ref(conf->iothread);
+        s->ctx = iothread_get_aio_context(IOTHREAD(conf->iothread));
+    } else if (conf->iothread_group) {
+        object_ref(conf->iothread_group);
+        s->ctx = iothread_group_get_aio_context(IOTHREAD_GROUP(conf->iothread_group));
     } else {
         s->ctx = qemu_get_aio_context();
     }
@@ -141,8 +142,11 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
     assert(!vblk->dataplane_started);
     g_free(s->batch_notify_vqs);
     qemu_bh_delete(s->bh);
-    if (s->iothread) {
-        object_unref(OBJECT(s->iothread));
+    if (s->conf->iothread) {
+        object_unref(s->conf->iothread);
+    }
+    if (s->conf->iothread_group) {
+        object_unref(s->conf->iothread_group);
     }
     g_free(s);
 }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8146306..cfd847b 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -918,6 +918,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "drive property not set");
         return;
     }
+    if (conf->iothread && conf->iothread_group) {
+        error_setg(errp, "iothread and iothread-group cannot be used together");
+        return;
+    }
     if (!blk_is_inserted(conf->conf.blk)) {
         error_setg(errp, "Device needs media, but drive is empty");
         return;
@@ -1011,6 +1015,8 @@ static Property virtio_blk_properties[] = {
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD),
+    DEFINE_PROP_LINK("iothread-group", VirtIOBlock, conf.iothread_group,
+                     TYPE_IOTHREAD_GROUP),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 2452074..16e72e0 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -35,6 +35,8 @@ struct VirtIOBlkConf
     BlockConf conf;
     /* IOThread pointer to be filled by link property */
     Object *iothread;
+    /* IOThreadGroup pointer to be filled by link property */
+    Object *iothread_group;
     char *serial;
     uint32_t scsi;
     uint32_t config_wce;
-- 
2.9.4
