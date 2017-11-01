Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCG-0008Cu-Mk
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCC-0006hX-0M
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:52 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:02 +0300
Message-Id: <1509551048-129830-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 09/15] qcow2: preallocation at image expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

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
 block/qcow2.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx |  4 ++++
 3 files changed, 50 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index e312e48..9a2711e 100644
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
index 827058d..3899524 100644
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
@@ -1924,6 +1938,31 @@ static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
     return true;
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
 static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -1932,6 +1971,10 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     for (m = l2meta; m != NULL; m = m->next) {
         int ret;
 
+        if (s->prealloc_size) {
+            handle_prealloc(bs, m);
+        }
+
         if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
             continue;
         }
diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b..a75a9fd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -771,6 +771,10 @@ occasions where a cluster gets freed (on/off; default: off)
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
