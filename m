Received: from eggs.gnu.org ([209.51.188.92]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjx5O-00023P-Am
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjx5I-0006O5-0L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:07:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:49224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gjx5H-0006Fg-LU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:07:07 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Thu, 17 Jan 2019 10:24:16 +0800
Message-Id: <1547691856-26675-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v3] vhost-user-blk: add discard/write zeroes
 features support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, sgazare@redhat.com, changpeng.liu@intel.com

Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
added the support in the Guest kernel, while here also enable the features
support with vhost-user-blk driver. Also enable the test example utility
with DISCARD and WRITE ZEROES commands.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c     | 134 +++++++++++++++++++++-------
 hw/block/vhost-user-blk.c                   |   4 +
 include/standard-headers/linux/virtio_blk.h |  54 +++++++++++
 3 files changed, 159 insertions(+), 33 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 49640df..6f2662a 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -63,6 +63,20 @@ static size_t vub_iov_size(const struct iovec *iov,
     return len;
 }
 
+static size_t vub_iov_to_buf(const struct iovec *iov,
+                             const unsigned int iov_cnt, void *buf)
+{
+    size_t len;
+    unsigned int i;
+
+    len = 0;
+    for (i = 0; i < iov_cnt; i++) {
+        memcpy(buf + len,  iov[i].iov_base, iov[i].iov_len);
+        len += iov[i].iov_len;
+    }
+    return len;
+}
+
 static void vub_panic_cb(VuDev *vu_dev, const char *buf)
 {
     VugDev *gdev;
@@ -161,6 +175,38 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
     return rc;
 }
 
+static int
+vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
+                         uint32_t type)
+{
+    struct virtio_blk_discard_write_zeroes desc;
+    ssize_t size;
+
+    size = vub_iov_size(iov, iovcnt);
+    if (size != sizeof(desc)) {
+        fprintf(stderr, "Invalid size %zd, expect %zu\n", size, sizeof(desc));
+        return -1;
+    }
+    vub_iov_to_buf(iov, iovcnt, &desc);
+
+    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+    VubDev *vdev_blk = req->vdev_blk;
+    uint64_t range[2] = { le64toh(desc.sector) << 9,
+                          le32toh(desc.num_sectors) << 9 };
+    if (type == VIRTIO_BLK_T_DISCARD) {
+        if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
+            return 0;
+        }
+    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+        if (ioctl(vdev_blk->blk_fd, BLKZEROOUT, range) == 0) {
+            return 0;
+        }
+    }
+    #endif
+
+    return -1;
+}
+
 static void
 vub_flush(VubReq *req)
 {
@@ -216,44 +262,55 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
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
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES: {
+        int rc;
+        rc = vub_discard_write_zeroes(req, &elem->out_sg[1], out_num, type);
+        if (rc == 0) {
             req->in->status = VIRTIO_BLK_S_OK;
-            req->size = elem->in_sg[0].iov_len;
-            vub_req_complete(req);
-            break;
-        }
-        default: {
-            req->in->status = VIRTIO_BLK_S_UNSUPP;
-            vub_req_complete(req);
-            break;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
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
@@ -317,6 +374,10 @@ vub_get_features(VuDev *dev)
                1ull << VIRTIO_BLK_F_TOPOLOGY |
                1ull << VIRTIO_BLK_F_BLK_SIZE |
                1ull << VIRTIO_BLK_F_FLUSH |
+               #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+               1ull << VIRTIO_BLK_F_DISCARD |
+               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
+               #endif
                1ull << VIRTIO_BLK_F_CONFIG_WCE |
                1ull << VIRTIO_F_VERSION_1 |
                1ull << VHOST_USER_F_PROTOCOL_FEATURES;
@@ -478,6 +539,13 @@ vub_initialize_config(int fd, struct virtio_blk_config *config)
     config->min_io_size = 1;
     config->opt_io_size = 1;
     config->num_queues = 1;
+    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+    config->max_discard_sectors = 32768;
+    config->max_discard_seg = 1;
+    config->discard_sector_alignment = config->blk_size >> 9;
+    config->max_write_zeroes_sectors = 32768;
+    config->max_write_zeroes_seg = 1;
+    #endif
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
