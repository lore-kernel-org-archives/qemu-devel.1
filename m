Received: from eggs.gnu.org ([2001:4830:134:3::10]:43097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1H-0000On-8w
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1F-0002R6-Th
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:35 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  1 Aug 2017 17:19:04 +0300
Message-Id: <1501597152-25342-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 07/15] qcow2: preallocation at image expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: "Denis V. Lunev" <den@openvz.org>

This patch adds image preallocation at expand to provide better locality
of QCOW2 image file and optimize this procedure for some distributed
storage where this procedure is slow.

Preallocation is not issued upon writing metadata clusters.

Possible conflicts are resolved by the common block layer code since
ALLOCATE requests are serialising.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.h   |  3 +++
 block/qcow2.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx |  4 ++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 96a8d43..ebbb9cf 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -102,6 +102,7 @@
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
+#define QCOW2_OPT_PREALLOC_SIZE "prealloc-size"
 
 typedef struct QCowHeader {
     uint32_t magic;
@@ -327,6 +328,8 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+
+    uint64_t prealloc_size;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2.c b/block/qcow2.c
index bcdd212..66aa8c2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -674,6 +674,11 @@ static QemuOptsList qcow2_runtime_opts = {
         },
         BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
             "ID of secret providing qcow2 AES key or LUKS passphrase"),
+        {
+            .name = QCOW2_OPT_PREALLOC_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Preallocation amount at image expand",
+        },
         { /* end of list */ }
     },
 };
@@ -1016,6 +1021,15 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         goto fail;
     }
 
+    s->prealloc_size =
+        ROUND_UP(qemu_opt_get_size_del(opts, QCOW2_OPT_PREALLOC_SIZE, 0),
+                 s->cluster_size);
+    if (s->prealloc_size &&
+        !(bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
+    {
+        s->prealloc_size = 0;
+    }
+
     ret = 0;
 fail:
     QDECREF(encryptopts);
@@ -1898,6 +1912,43 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+/*
+ * If the specified area is beyond EOF, allocates it + prealloc_size
+ * bytes ahead.
+ */
+static void coroutine_fn handle_prealloc(BlockDriverState *bs,
+                                         const QCowL2Meta *m)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t start = m->alloc_offset;
+    uint64_t end = start + m->nb_clusters * s->cluster_size;
+    int64_t flen = bdrv_getlength(bs->file->bs);
+
+    if (flen < 0) {
+        return;
+    }
+
+    if (end > flen) {
+        /* try to alloc host space in one chunk for better locality */
+        bdrv_co_pwrite_zeroes(bs->file, flen,
+                              QEMU_ALIGN_UP(end + s->prealloc_size - flen,
+                                            s->cluster_size),
+                              BDRV_REQ_ALLOCATE);
+    }
+}
+
+static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *m;
+
+    for (m = l2meta; m != NULL; m = m->next) {
+        if (s->prealloc_size) {
+            handle_prealloc(bs, m);
+        }
+    }
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1982,24 +2033,31 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE) {
+            handle_alloc_space(bs, l2meta);
+        }
+
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regions.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret = bdrv_co_pwritev(bs->file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
+                qemu_co_mutex_lock(&s->lock);
                 goto fail;
             }
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         while (l2meta != NULL) {
             QCowL2Meta *next;
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 2cc70b9..98e5136 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -758,6 +758,10 @@ occasions where a cluster gets freed (on/off; default: off)
 Which overlap checks to perform for writes to the image
 (none/constant/cached/all; default: cached). For details or finer
 granularity control refer to the QAPI documentation of @code{blockdev-add}.
+
+@item prealloc-size
+The number of bytes that will be preallocated ahead at qcow2 file expansion
+(allocating a new cluster beyond the end of file).
 @end table
 
 Example 1:
-- 
2.7.4
