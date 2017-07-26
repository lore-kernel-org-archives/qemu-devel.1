Received: from eggs.gnu.org ([2001:4830:134:3::10]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daL2q-0001QX-7t
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daL2o-0000ER-TD
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:04:04 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 20:02:53 +0800
Message-ID: <20170726120255.14292-5-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20170726120255.14292-1-maozy.fnst@cn.fujitsu.com>
References: <20170726120255.14292-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/6] hw/block: Fix the return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When the function no success value to transmit, it usually make the
function return void. It has turned out not to be a success, because
it means that the extra local_err variable and error_propagate() will
be needed. It leads to cumbersome code, therefore, transmit success/
failure in the return value is worth.

So fix the return type of blkconf_apply_backend_options(),
blkconf_geometry() and virtio_blk_data_plane_create() to avoid it.

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/block/block.c                | 21 ++++++++++++---------
 hw/block/dataplane/virtio-blk.c | 16 +++++++++-------
 hw/block/dataplane/virtio-blk.h |  6 +++---
 include/hw/block/block.h        | 10 +++++-----
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index 27878d0..717bd0e 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -51,8 +51,8 @@ void blkconf_blocksizes(BlockConf *conf)
     }
 }
 
-void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp)
+int blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+                                  bool resizable, Error **errp)
 {
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
@@ -76,7 +76,7 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 
     ret = blk_set_perm(blk, perm, shared_perm, errp);
     if (ret < 0) {
-        return;
+        return -1;
     }
 
     switch (conf->wce) {
@@ -99,11 +99,13 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 
     blk_set_enable_write_cache(blk, wce);
     blk_set_on_error(blk, rerror, werror);
+
+    return 0;
 }
 
-void blkconf_geometry(BlockConf *conf, int *ptrans,
-                      unsigned cyls_max, unsigned heads_max, unsigned secs_max,
-                      Error **errp)
+int blkconf_geometry(BlockConf *conf, int *ptrans,
+                     unsigned cyls_max, unsigned heads_max, unsigned secs_max,
+                     Error **errp)
 {
     DriveInfo *dinfo;
 
@@ -129,15 +131,16 @@ void blkconf_geometry(BlockConf *conf, int *ptrans,
     if (conf->cyls || conf->heads || conf->secs) {
         if (conf->cyls < 1 || conf->cyls > cyls_max) {
             error_setg(errp, "cyls must be between 1 and %u", cyls_max);
-            return;
+            return -1;
         }
         if (conf->heads < 1 || conf->heads > heads_max) {
             error_setg(errp, "heads must be between 1 and %u", heads_max);
-            return;
+            return -1;
         }
         if (conf->secs < 1 || conf->secs > secs_max) {
             error_setg(errp, "secs must be between 1 and %u", secs_max);
-            return;
+            return -1;
         }
     }
+    return 0;
 }
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e..619bc5e 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -76,9 +76,9 @@ static void notify_guest_bh(void *opaque)
 }
 
 /* Context: QEMU global mutex held */
-void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
-                                  VirtIOBlockDataPlane **dataplane,
-                                  Error **errp)
+int virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
+                                 VirtIOBlockDataPlane **dataplane,
+                                 Error **errp)
 {
     VirtIOBlockDataPlane *s;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -91,11 +91,11 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
             error_setg(errp,
                        "device is incompatible with iothread "
                        "(transport does not support notifiers)");
-            return;
+            return -1;
         }
         if (!virtio_device_ioeventfd_enabled(vdev)) {
             error_setg(errp, "ioeventfd is required for iothread");
-            return;
+            return -1;
         }
 
         /* If dataplane is (re-)enabled while the guest is running there could
@@ -103,12 +103,12 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
          */
         if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
             error_prepend(errp, "cannot start virtio-blk dataplane: ");
-            return;
+            return -1;
         }
     }
     /* Don't try if transport does not support notifiers. */
     if (!virtio_device_ioeventfd_enabled(vdev)) {
-        return;
+        return -1;
     }
 
     s = g_new0(VirtIOBlockDataPlane, 1);
@@ -126,6 +126,8 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     s->batch_notify_vqs = bitmap_new(conf->num_queues);
 
     *dataplane = s;
+
+    return 0;
 }
 
 /* Context: QEMU global mutex held */
diff --git a/hw/block/dataplane/virtio-blk.h b/hw/block/dataplane/virtio-blk.h
index db3f47b..d25773d 100644
--- a/hw/block/dataplane/virtio-blk.h
+++ b/hw/block/dataplane/virtio-blk.h
@@ -19,9 +19,9 @@
 
 typedef struct VirtIOBlockDataPlane VirtIOBlockDataPlane;
 
-void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
-                                  VirtIOBlockDataPlane **dataplane,
-                                  Error **errp);
+int virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
+                                 VirtIOBlockDataPlane **dataplane,
+                                 Error **errp);
 void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s);
 void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq);
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index f3f6e8e..66117c6 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -72,12 +72,12 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 /* Configuration helpers */
 
 void blkconf_serial(BlockConf *conf, char **serial);
-void blkconf_geometry(BlockConf *conf, int *trans,
-                      unsigned cyls_max, unsigned heads_max, unsigned secs_max,
-                      Error **errp);
+int blkconf_geometry(BlockConf *conf, int *trans,
+                     unsigned cyls_max, unsigned heads_max, unsigned secs_max,
+                     Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
-void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp);
+int blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+                                  bool resizable, Error **errp);
 
 /* Hard disk geometry */
 
-- 
2.9.4
