Received: from eggs.gnu.org ([209.51.188.92]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaY-00066m-G7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTX-0005eo-6p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTW-0005eQ-VO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id 2so96627qtb.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:54 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-18-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 17/25] vhost-user-blk: add discard/write zeroes
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Changpeng Liu <changpeng.liu@intel.com>

Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
added the support in the Guest kernel, while here also enable the features
support with vhost-user-blk driver. Also enable the test example utility
with DISCARD and WRITE ZEROES commands.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/virtio_blk.h |  48 +++++++
 contrib/vhost-user-blk/vhost-user-blk.c     | 140 +++++++++++++++-----
 hw/block/vhost-user-blk.c                   |   4 +
 3 files changed, 159 insertions(+), 33 deletions(-)

diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
index ae6e865fee..0229b0fbe4 100644
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
@@ -137,6 +172,19 @@ struct virtio_blk_outhdr {
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
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 49640dfdf2..43583f2659 100644
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
@@ -161,6 +175,44 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
     return rc;
 }
 
+static int
+vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
+                         uint32_t type)
+{
+    struct virtio_blk_discard_write_zeroes *desc;
+    ssize_t size;
+    void *buf;
+
+    size = vub_iov_size(iov, iovcnt);
+    if (size != sizeof(*desc)) {
+        fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*desc));
+        return -1;
+    }
+    buf = g_new0(char, size);
+    vub_iov_to_buf(iov, iovcnt, buf);
+
+    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+    VubDev *vdev_blk = req->vdev_blk;
+    desc = (struct virtio_blk_discard_write_zeroes *)buf;
+    uint64_t range[2] = { le64toh(desc->sector) << 9,
+                          le32toh(desc->num_sectors) << 9 };
+    if (type == VIRTIO_BLK_T_DISCARD) {
+        if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
+            g_free(buf);
+            return 0;
+        }
+    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+        if (ioctl(vdev_blk->blk_fd, BLKZEROOUT, range) == 0) {
+            g_free(buf);
+            return 0;
+        }
+    }
+    #endif
+
+    g_free(buf);
+    return -1;
+}
+
 static void
 vub_flush(VubReq *req)
 {
@@ -216,44 +268,55 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
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
@@ -317,6 +380,10 @@ vub_get_features(VuDev *dev)
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
@@ -478,6 +545,13 @@ vub_initialize_config(int fd, struct virtio_blk_config *config)
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
index c3af28fad4..44ac814016 100644
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
-- 
MST
