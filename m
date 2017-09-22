Received: from eggs.gnu.org ([2001:4830:134:3::10]:39562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvKRL-00007A-52
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvKRG-0004O4-LS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:07 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 22 Sep 2017 12:39:26 +0300
Message-Id: <20170922093926.9723-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/2] qcow2: truncate the tail of the image
 file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

Now after shrinking the image, at the end of the image file, there might be a
tail that probably will never be used. So we can find the last used cluster and
cut the tail.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/qcow2-refcount.c | 22 ++++++++++++++++++++++
 block/qcow2.c          | 23 +++++++++++++++++++++++
 block/qcow2.h          |  1 +
 3 files changed, 46 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 88d5a3f1ad..aa3fd6cf17 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3181,3 +3181,25 @@ out:
     g_free(reftable_tmp);
     return ret;
 }
+
+int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int64_t i;
+
+    for (i = size_to_clusters(s, size) - 1; i >= 0; i--) {
+        uint64_t refcount;
+        int ret = qcow2_get_refcount(bs, i, &refcount);
+        if (ret < 0) {
+            fprintf(stderr, "Can't get refcount for cluster %" PRId64 ": %s\n",
+                    i, strerror(-ret));
+            return ret;
+        }
+        if (refcount > 0) {
+            return i;
+        }
+    }
+    qcow2_signal_corruption(bs, true, -1, -1,
+                            "There are no references in the refcount table.");
+    return -EIO;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 8a4311d338..8dfb5393a7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3106,6 +3106,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
     new_l1_size = size_to_l1(s, offset);
 
     if (offset < old_length) {
+        int64_t last_cluster, old_file_size;
         if (prealloc != PREALLOC_MODE_OFF) {
             error_setg(errp,
                        "Preallocation can't be used for shrinking an image");
@@ -3134,6 +3135,28 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                              "Failed to discard unused refblocks");
             return ret;
         }
+
+        old_file_size = bdrv_getlength(bs->file->bs);
+        if (old_file_size < 0) {
+            error_setg_errno(errp, -old_file_size,
+                             "Failed to inquire current file length");
+            return old_file_size;
+        }
+        last_cluster = qcow2_get_last_cluster(bs, old_file_size);
+        if (last_cluster < 0) {
+            error_setg_errno(errp, -last_cluster,
+                             "Failed to find the last cluster");
+            return last_cluster;
+        }
+        if ((last_cluster + 1) * s->cluster_size < old_file_size) {
+            ret = bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
+                                PREALLOC_MODE_OFF, NULL);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to truncate the tail of the image");
+                return ret;
+            }
+        }
     } else {
         ret = qcow2_grow_l1_table(bs, new_l1_size, true);
         if (ret < 0) {
diff --git a/block/qcow2.h b/block/qcow2.h
index 5a289a81e2..782a206ecb 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -597,6 +597,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
                                 void *cb_opaque, Error **errp);
 int qcow2_shrink_reftable(BlockDriverState *bs);
+int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
 
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
-- 
2.14.1
