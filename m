Received: from eggs.gnu.org ([2001:4830:134:3::10]:57247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZ2-0004EZ-Iv
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJYw-0006XP-76
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJYv-0006Wu-U6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:24 +0000
Message-Id: <20171219151144.11120-4-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 03/23] hw/block: Fix the return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: ac0edc1fc70c4457e5cec94405eb7d1f89f9c2c1.1511317952.git.maozy.fnst@cn.fujitsu.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.h |  2 +-
 include/hw/block/block.h        |  4 ++--
 hw/block/block.c                | 15 +++++++++------
 hw/block/dataplane/virtio-blk.c | 12 +++++++-----
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.h b/hw/block/dataplane/virtio-blk.h
index db3f47b173..5e18bb99ae 100644
--- a/hw/block/dataplane/virtio-blk.h
+++ b/hw/block/dataplane/virtio-blk.h
@@ -19,7 +19,7 @@
 
 typedef struct VirtIOBlockDataPlane VirtIOBlockDataPlane;
 
-void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
+bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
                                   VirtIOBlockDataPlane **dataplane,
                                   Error **errp);
 void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s);
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index f3f6e8ef02..64b9298829 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -72,11 +72,11 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 /* Configuration helpers */
 
 void blkconf_serial(BlockConf *conf, char **serial);
-void blkconf_geometry(BlockConf *conf, int *trans,
+bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
-void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
 /* Hard disk geometry */
diff --git a/hw/block/block.c b/hw/block/block.c
index 27878d0087..b0269c857f 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -51,7 +51,7 @@ void blkconf_blocksizes(BlockConf *conf)
     }
 }
 
-void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
     BlockBackend *blk = conf->blk;
@@ -76,7 +76,7 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 
     ret = blk_set_perm(blk, perm, shared_perm, errp);
     if (ret < 0) {
-        return;
+        return false;
     }
 
     switch (conf->wce) {
@@ -99,9 +99,11 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 
     blk_set_enable_write_cache(blk, wce);
     blk_set_on_error(blk, rerror, werror);
+
+    return true;
 }
 
-void blkconf_geometry(BlockConf *conf, int *ptrans,
+bool blkconf_geometry(BlockConf *conf, int *ptrans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp)
 {
@@ -129,15 +131,16 @@ void blkconf_geometry(BlockConf *conf, int *ptrans,
     if (conf->cyls || conf->heads || conf->secs) {
         if (conf->cyls < 1 || conf->cyls > cyls_max) {
             error_setg(errp, "cyls must be between 1 and %u", cyls_max);
-            return;
+            return false;
         }
         if (conf->heads < 1 || conf->heads > heads_max) {
             error_setg(errp, "heads must be between 1 and %u", heads_max);
-            return;
+            return false;
         }
         if (conf->secs < 1 || conf->secs > secs_max) {
             error_setg(errp, "secs must be between 1 and %u", secs_max);
-            return;
+            return false;
         }
     }
+    return true;
 }
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e64e..f6fc639e88 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -76,7 +76,7 @@ static void notify_guest_bh(void *opaque)
 }
 
 /* Context: QEMU global mutex held */
-void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
+bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
                                   VirtIOBlockDataPlane **dataplane,
                                   Error **errp)
 {
@@ -91,11 +91,11 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
             error_setg(errp,
                        "device is incompatible with iothread "
                        "(transport does not support notifiers)");
-            return;
+            return false;
         }
         if (!virtio_device_ioeventfd_enabled(vdev)) {
             error_setg(errp, "ioeventfd is required for iothread");
-            return;
+            return false;
         }
 
         /* If dataplane is (re-)enabled while the guest is running there could
@@ -103,12 +103,12 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
          */
         if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
             error_prepend(errp, "cannot start virtio-blk dataplane: ");
-            return;
+            return false;
         }
     }
     /* Don't try if transport does not support notifiers. */
     if (!virtio_device_ioeventfd_enabled(vdev)) {
-        return;
+        return false;
     }
 
     s = g_new0(VirtIOBlockDataPlane, 1);
@@ -126,6 +126,8 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     s->batch_notify_vqs = bitmap_new(conf->num_queues);
 
     *dataplane = s;
+
+    return true;
 }
 
 /* Context: QEMU global mutex held */
-- 
2.14.3
