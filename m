Received: from eggs.gnu.org ([209.51.188.92]:39123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1giwVl-0008Hj-AN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1giwVj-0002T5-T2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:16363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1giwVj-0002I3-Jo
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:15 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Mon, 14 Jan 2019 15:35:17 +0800
Message-Id: <1547451317-21375-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH] vhost-user-blk: enable discard/write zeroes
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, changpeng.liu@intel.com

Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
added the support in the Guest kernel, while here enable the feature bits
support with vhost-user-blk driver.  Also enable the test example utility
with DISCARD command support.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c     | 107 +++++++++++++++++++---------
 hw/block/vhost-user-blk.c                   |   4 ++
 include/standard-headers/linux/virtio_blk.h |  54 ++++++++++++++
 3 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 858221a..fe6302c 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -20,6 +20,10 @@
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
 
+#if defined(__linux__)
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#endif
 
 struct virtio_blk_inhdr {
     unsigned char status;
@@ -157,6 +161,29 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
     return rc;
 }
 
+static int
+vub_discard(VubReq *req, struct iovec *iov, uint32_t iovcnt)
+{
+    if (iovcnt != 1) {
+        fprintf(stderr, "Invalid Discard IOV count\n");
+        return -1;
+    }
+
+    #if defined(__linux__) && defined(BLKDISCARD)
+    VubDev *vdev_blk = req->vdev_blk;
+    struct virtio_blk_discard_write_zeroes *desc =
+                       (struct virtio_blk_discard_write_zeroes *)iov->iov_base;
+    uint64_t range[2] = { le64toh(desc->sector) << 9,
+                          le32toh(desc->num_sectors) << 9 };
+    if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
+        return 0;
+    }
+    return -1;
+    #endif
+
+    return -1;
+}
+
 static void
 vub_flush(VubReq *req)
 {
@@ -212,44 +239,54 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
     in_num--;
 
     type = le32toh(req->out->type);
-    switch (type & ~(VIRTIO_BLK_T_OUT | VIRTIO_BLK_T_BARRIER)) {
-        case VIRTIO_BLK_T_IN: {
-            ssize_t ret = 0;
-            bool is_write = type & VIRTIO_BLK_T_OUT;
-            req->sector_num = le64toh(req->out->sector);
-            if (is_write) {
-                ret  = vub_writev(req, &elem->out_sg[1], out_num);
-            } else {
-                ret = vub_readv(req, &elem->in_sg[0], in_num);
-            }
-            if (ret >= 0) {
-                req->in->status = VIRTIO_BLK_S_OK;
-            } else {
-                req->in->status = VIRTIO_BLK_S_IOERR;
-            }
-            vub_req_complete(req);
-            break;
+    switch (type & ~VIRTIO_BLK_T_BARRIER) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT: {
+        ssize_t ret = 0;
+        bool is_write = type & VIRTIO_BLK_T_OUT;
+        req->sector_num = le64toh(req->out->sector);
+        if (is_write) {
+            ret  = vub_writev(req, &elem->out_sg[1], out_num);
+        } else {
+            ret = vub_readv(req, &elem->in_sg[0], in_num);
         }
-        case VIRTIO_BLK_T_FLUSH: {
-            vub_flush(req);
+        if (ret >= 0) {
             req->in->status = VIRTIO_BLK_S_OK;
-            vub_req_complete(req);
-            break;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
         }
-        case VIRTIO_BLK_T_GET_ID: {
-            size_t size = MIN(vub_iov_size(&elem->in_sg[0], in_num),
-                              VIRTIO_BLK_ID_BYTES);
-            snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
+        vub_req_complete(req);
+        break;
+    }
+    case VIRTIO_BLK_T_FLUSH:
+        vub_flush(req);
+        req->in->status = VIRTIO_BLK_S_OK;
+        vub_req_complete(req);
+        break;
+    case VIRTIO_BLK_T_GET_ID: {
+        size_t size = MIN(vub_iov_size(&elem->in_sg[0], in_num),
+                          VIRTIO_BLK_ID_BYTES);
+        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
+        req->in->status = VIRTIO_BLK_S_OK;
+        req->size = elem->in_sg[0].iov_len;
+        vub_req_complete(req);
+        break;
+    }
+    case VIRTIO_BLK_T_DISCARD: {
+        int rc;
+        rc = vub_discard(req, &elem->out_sg[1], out_num);
+        if (rc == 0) {
             req->in->status = VIRTIO_BLK_S_OK;
-            req->size = elem->in_sg[0].iov_len;
-            vub_req_complete(req);
-            break;
-        }
-        default: {
+        } else {
             req->in->status = VIRTIO_BLK_S_UNSUPP;
-            vub_req_complete(req);
-            break;
         }
+        vub_req_complete(req);
+        break;
+    }
+    default:
+        req->in->status = VIRTIO_BLK_S_UNSUPP;
+        vub_req_complete(req);
+        break;
     }
 
     return 0;
@@ -313,6 +350,7 @@ vub_get_features(VuDev *dev)
                1ull << VIRTIO_BLK_F_TOPOLOGY |
                1ull << VIRTIO_BLK_F_BLK_SIZE |
                1ull << VIRTIO_BLK_F_FLUSH |
+               1ull << VIRTIO_BLK_F_DISCARD |
                1ull << VIRTIO_BLK_F_CONFIG_WCE |
                1ull << VIRTIO_F_VERSION_1 |
                1ull << VHOST_USER_F_PROTOCOL_FEATURES;
@@ -454,7 +492,7 @@ vub_get_blocksize(int fd)
 
 #if defined(__linux__) && defined(BLKSSZGET)
     if (ioctl(fd, BLKSSZGET, &blocksize) == 0) {
-        return blocklen;
+        return blocksize;
     }
 #endif
 
@@ -474,6 +512,9 @@ vub_initialize_config(int fd, struct virtio_blk_config *config)
     config->min_io_size = 1;
     config->opt_io_size = 1;
     config->num_queues = 1;
+    config->max_discard_sectors = 32768;
+    config->max_discard_seg = 1;
+    config->discard_sector_alignment = config->blk_size >> 9;
 }
 
 static VubDev *
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 1451940..5fe1810 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -38,6 +38,8 @@ static const int user_feature_bits[] = {
     VIRTIO_BLK_F_RO,
     VIRTIO_BLK_F_FLUSH,
     VIRTIO_BLK_F_CONFIG_WCE,
+    VIRTIO_BLK_F_DISCARD,
+    VIRTIO_BLK_F_WRITE_ZEROES,
     VIRTIO_F_VERSION_1,
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
@@ -204,6 +206,8 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
     virtio_add_feature(&features, VIRTIO_BLK_F_FLUSH);
     virtio_add_feature(&features, VIRTIO_BLK_F_RO);
+    virtio_add_feature(&features, VIRTIO_BLK_F_DISCARD);
+    virtio_add_feature(&features, VIRTIO_BLK_F_WRITE_ZEROES);
 
     if (s->config_wce) {
         virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
index ab16ec5..666dc2e 100644
--- a/include/standard-headers/linux/virtio_blk.h
+++ b/include/standard-headers/linux/virtio_blk.h
@@ -38,6 +38,8 @@
 #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
+#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
+#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -84,6 +86,39 @@ struct virtio_blk_config {
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
 	uint16_t num_queues;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
+	/*
+	 * The maximum discard sectors (in 512-byte sectors) for
+	 * one segment.
+	 */
+	uint32_t max_discard_sectors;
+	/*
+	 * The maximum number of discard segments in a
+	 * discard command.
+	 */
+	uint32_t max_discard_seg;
+	/* Discard commands must be aligned to this number of sectors. */
+	uint32_t discard_sector_alignment;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
+	/*
+	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
+	 * one segment.
+	 */
+	uint32_t max_write_zeroes_sectors;
+	/*
+	 * The maximum number of segments in a write zeroes
+	 * command.
+	 */
+	uint32_t max_write_zeroes_seg;
+	/*
+	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
+	 * deallocation of one or more of the sectors.
+	 */
+	uint8_t write_zeroes_may_unmap;
+
+	uint8_t unused1[3];
 } QEMU_PACKED;
 
 /*
@@ -112,6 +147,12 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Discard command */
+#define VIRTIO_BLK_T_DISCARD   11
+
+/* Write zeroes command */
+#define VIRTIO_BLK_T_WRITE_ZEROES      13
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -131,6 +172,19 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/* Unmap this range (only valid for write zeroes command) */
+#define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP	0x00000001
+
+/* Discard/write zeroes range for each request. */
+struct virtio_blk_discard_write_zeroes {
+	/* discard/write zeroes start sector */
+	uint64_t sector;
+	/* number of discard/write zeroes sectors */
+	uint32_t num_sectors;
+	/* flags for this range */
+	uint32_t flags;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
-- 
1.9.3
