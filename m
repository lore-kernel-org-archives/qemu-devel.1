Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJb-0006m0-QZ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJX-0006nX-UA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:19 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com
	([104.47.2.122]:23424
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJX-0006nH-K8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:15 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:33 +0300
Message-ID: <1495186480-114192-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 06/13] qcow2: truncate preallocated space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, "Denis V.
	Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: "Denis V. Lunev" <den@openvz.org>

This could be done after calculation of the end of data and metadata in
the qcow2 image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2-cluster.c  | 9 +++++++++
 block/qcow2-refcount.c | 7 +++++++
 block/qcow2.c          | 8 ++++++++
 block/qcow2.h          | 3 +++
 4 files changed, 27 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a4b6d40..b2879b9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1957,3 +1957,12 @@ fail:
     g_free(l1_table);
     return ret;
 }
+
+void qcow2_update_data_end(BlockDriverState *bs, uint64_t off)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->data_end < off) {
+        s->data_end = off;
+    }
+}
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 873a1d2..8156466 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -744,6 +744,9 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
             ret = alloc_refcount_block(bs, cluster_index, &refcount_block);
             if (ret < 0) {
                 goto fail;
+            } else {
+                qcow2_update_data_end(bs, s->refcount_table_offset +
+                        s->refcount_table_size * sizeof(uint64_t));
             }
         }
         old_table_index = table_index;
@@ -865,6 +868,8 @@ retry:
         s->free_cluster_index - 1 > (INT64_MAX >> s->cluster_bits))
     {
         return -EFBIG;
+    } else {
+        qcow2_update_data_end(bs, s->free_cluster_index << s->cluster_bits);
     }
 
 #ifdef DEBUG_ALLOC2
@@ -929,6 +934,8 @@ int64_t qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
 
     if (ret < 0) {
         return ret;
+    } else {
+        qcow2_update_data_end(bs, offset + (nb_clusters << s->cluster_bits));
     }
 
     return i;
diff --git a/block/qcow2.c b/block/qcow2.c
index 07c1706..7b4359b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1192,6 +1192,8 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    s->data_end = bdrv_getlength(bs->file->bs);
+
 #ifdef DEBUG_ALLOC
     {
         BdrvCheckResult result = {0};
@@ -1948,12 +1950,18 @@ static int qcow2_inactivate(BlockDriverState *bs)
 static void qcow2_close(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
+
     qemu_vfree(s->l1_table);
     /* else pre-write overlap checks in cache_destroy may crash */
     s->l1_table = NULL;
 
     if (!(s->flags & BDRV_O_INACTIVE)) {
         qcow2_inactivate(bs);
+
+        /* truncate preallocated space */
+        if (!bs->read_only && s->data_end < bdrv_getlength(bs->file->bs)) {
+            bdrv_truncate(bs->file, s->data_end, NULL);
+        }
     }
 
     cache_clean_timer_del(bs);
diff --git a/block/qcow2.h b/block/qcow2.h
index a0d222d..e28c54a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -297,6 +297,7 @@ typedef struct BDRVQcow2State {
     char *image_backing_format;
 
     uint64_t prealloc_size;
+    uint64_t data_end;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
@@ -607,4 +608,6 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 
+void qcow2_update_data_end(BlockDriverState *bs, uint64_t off);
+
 #endif
-- 
2.7.4
