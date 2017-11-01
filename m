Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCK-0008Gs-5Q
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCE-0006ka-78
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:56 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:04 +0300
Message-Id: <1509551048-129830-12-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 11/15] qcow2: truncate preallocated space
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

This could be done after calculation of the end of data and metadata in
the qcow2 image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.h          | 3 +++
 block/qcow2-cluster.c  | 9 +++++++++
 block/qcow2-refcount.c | 7 +++++++
 block/qcow2.c          | 7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9a2711e..579838d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -330,6 +330,7 @@ typedef struct BDRVQcow2State {
     char *image_backing_format;
 
     uint64_t prealloc_size;
+    uint64_t data_end;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
@@ -693,4 +694,6 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           const char *name,
                                           Error **errp);
 
+void qcow2_update_data_end(BlockDriverState *bs, uint64_t off);
+
 #endif
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e364116..9b24cab 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2080,3 +2080,12 @@ fail:
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
index aa3fd6c..5797666 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -834,6 +834,9 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
             ret = alloc_refcount_block(bs, cluster_index, &refcount_block);
             if (ret < 0) {
                 goto fail;
+            } else {
+                qcow2_update_data_end(bs, s->refcount_table_offset +
+                        s->refcount_table_size * sizeof(uint64_t));
             }
         }
         old_table_index = table_index;
@@ -971,6 +974,8 @@ retry:
         s->free_cluster_index - 1 > (INT64_MAX >> s->cluster_bits))
     {
         return -EFBIG;
+    } else {
+        qcow2_update_data_end(bs, s->free_cluster_index << s->cluster_bits);
     }
 
 #ifdef DEBUG_ALLOC2
@@ -1035,6 +1040,8 @@ int64_t qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
 
     if (ret < 0) {
         return ret;
+    } else {
+        qcow2_update_data_end(bs, offset + (nb_clusters << s->cluster_bits));
     }
 
     return i;
diff --git a/block/qcow2.c b/block/qcow2.c
index f41aaac..5e2b543 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1488,6 +1488,8 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    s->data_end = bdrv_getlength(bs->file->bs);
+
 #ifdef DEBUG_ALLOC
     {
         BdrvCheckResult result = {0};
@@ -2184,6 +2186,11 @@ static int qcow2_inactivate(BlockDriverState *bs)
 
     if (result == 0) {
         qcow2_mark_clean(bs);
+
+        /* truncate preallocated space */
+        if (!bs->read_only && s->data_end < bdrv_getlength(bs->file->bs)) {
+            bdrv_truncate(bs->file, s->data_end, PREALLOC_MODE_OFF, NULL);
+        }
         s->flags |= BDRV_O_INACTIVE;
     }
 
-- 
2.7.4
