Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmts-0002iK-2H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtq-0007dy-Ts
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:36 -0400
Date: Fri, 1 Jun 2018 19:27:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-32-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 31/31] vhost-blk: turn on pre-defined RO feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Changpeng Liu <changpeng.liu@intel.com>

Read only feature shouldn't be negotiable, because if the
backend device reported Read only feature supported, QEMU
host driver shouldn't change backend's RO attribute. While
here, also enable the vhost-user-blk test utility to test
RO feature.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h      |  1 -
 contrib/vhost-user-blk/vhost-user-blk.c | 48 ++++++++++++++++++-------
 hw/block/vhost-user-blk.c               |  5 +--
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index f1258ae545..d52944aeeb 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -35,7 +35,6 @@ typedef struct VHostUserBlk {
     uint16_t num_queues;
     uint32_t queue_size;
     uint32_t config_wce;
-    uint32_t config_ro;
     struct vhost_dev dev;
     VhostUserState *vhost_user;
 } VHostUserBlk;
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index a6a132a492..571f114a56 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -31,6 +31,7 @@ typedef struct VubDev {
     VugDev parent;
     int blk_fd;
     struct virtio_blk_config blkcfg;
+    bool enable_ro;
     char *blk_name;
     GMainLoop *loop;
 } VubDev;
@@ -301,14 +302,27 @@ static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started)
 static uint64_t
 vub_get_features(VuDev *dev)
 {
-    return 1ull << VIRTIO_BLK_F_SIZE_MAX |
-           1ull << VIRTIO_BLK_F_SEG_MAX |
-           1ull << VIRTIO_BLK_F_TOPOLOGY |
-           1ull << VIRTIO_BLK_F_BLK_SIZE |
-           1ull << VIRTIO_BLK_F_FLUSH |
-           1ull << VIRTIO_BLK_F_CONFIG_WCE |
-           1ull << VIRTIO_F_VERSION_1 |
-           1ull << VHOST_USER_F_PROTOCOL_FEATURES;
+    uint64_t features;
+    VugDev *gdev;
+    VubDev *vdev_blk;
+
+    gdev = container_of(dev, VugDev, parent);
+    vdev_blk = container_of(gdev, VubDev, parent);
+
+    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
+               1ull << VIRTIO_BLK_F_SEG_MAX |
+               1ull << VIRTIO_BLK_F_TOPOLOGY |
+               1ull << VIRTIO_BLK_F_BLK_SIZE |
+               1ull << VIRTIO_BLK_F_FLUSH |
+               1ull << VIRTIO_BLK_F_CONFIG_WCE |
+               1ull << VIRTIO_F_VERSION_1 |
+               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
+
+    if (vdev_blk->enable_ro) {
+        features |= 1ull << VIRTIO_BLK_F_RO;
+    }
+
+    return features;
 }
 
 static uint64_t
@@ -476,6 +490,7 @@ vub_new(char *blk_file)
         vub_free(vdev_blk);
         return NULL;
     }
+    vdev_blk->enable_ro = false;
     vdev_blk->blkcfg.wce = 0;
     vdev_blk->blk_name = blk_file;
 
@@ -490,10 +505,11 @@ int main(int argc, char **argv)
     int opt;
     char *unix_socket = NULL;
     char *blk_file = NULL;
+    bool enable_ro = false;
     int lsock = -1, csock = -1;
     VubDev *vdev_blk = NULL;
 
-    while ((opt = getopt(argc, argv, "b:s:h")) != -1) {
+    while ((opt = getopt(argc, argv, "b:rs:h")) != -1) {
         switch (opt) {
         case 'b':
             blk_file = g_strdup(optarg);
@@ -501,17 +517,20 @@ int main(int argc, char **argv)
         case 's':
             unix_socket = g_strdup(optarg);
             break;
+        case 'r':
+            enable_ro = true;
+            break;
         case 'h':
         default:
-            printf("Usage: %s [-b block device or file, -s UNIX domain socket]"
-                   " | [ -h ]\n", argv[0]);
+            printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
+                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
             return 0;
         }
     }
 
     if (!unix_socket || !blk_file) {
-        printf("Usage: %s [-b block device or file, -s UNIX domain socket] |"
-               " [ -h ]\n", argv[0]);
+        printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
+               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
         return -1;
     }
 
@@ -530,6 +549,9 @@ int main(int argc, char **argv)
     if (!vdev_blk) {
         goto err;
     }
+    if (enable_ro) {
+        vdev_blk->enable_ro = true;
+    }
 
     vug_init(&vdev_blk->parent, csock, vub_panic_cb, &vub_iface);
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 7c3fa8bb1c..d755223643 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -203,13 +203,11 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
     virtio_add_feature(&features, VIRTIO_BLK_F_FLUSH);
+    virtio_add_feature(&features, VIRTIO_BLK_F_RO);
 
     if (s->config_wce) {
         virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
     }
-    if (s->config_ro) {
-        virtio_add_feature(&features, VIRTIO_BLK_F_RO);
-    }
     if (s->num_queues > 1) {
         virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
     }
@@ -339,7 +337,6 @@ static Property vhost_user_blk_properties[] = {
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
     DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
-    DEFINE_PROP_BIT("config-ro", VHostUserBlk, config_ro, 0, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST
