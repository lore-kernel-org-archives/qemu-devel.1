Received: from eggs.gnu.org ([2001:4830:134:3::10]:51816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXkC-0006oE-6j
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXkA-0008Lg-Ui
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  9 Aug 2017 15:38:06 -0500
Message-Id: <20170809203808.31725-4-eblake@redhat.com>
In-Reply-To: <20170809203808.31725-1-eblake@redhat.com>
References: <20170809203808.31725-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] qcow: Check failure of bdrv_getlength()
 and bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, Max Reitz <mreitz@redhat.com>

Omitting the check for whether bdrv_getlength() and bdrv_truncate()
failed meant that it was theoretically possible to return an
incorrect offset to the caller.  More likely, conditions for either
of these functions to fail would also cause one of our other calls
(such as bdrv_pread() or bdrv_pwrite_sync()) to also fail, but
auditing that we are safe is difficult compared to just patching
things to always forward on the error rather than ignoring it.

Use osdep.h macros instead of open-coded rounding while in the
area.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Rebase to new signature to not corrupt compressed clusters, and
fix lock handling [Kevin], check for truncate overflow [Jeff]
---
 block/qcow.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index d07bef6306..f450b00cfc 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -357,7 +357,8 @@ static int get_cluster_offset(BlockDriverState *bs,
 {
     BDRVQcowState *s = bs->opaque;
     int min_index, i, j, l1_index, l2_index, ret;
-    uint64_t l2_offset, *l2_table, cluster_offset, tmp;
+    int64_t l2_offset;
+    uint64_t *l2_table, cluster_offset, tmp;
     uint32_t min_count;
     int new_l2_table;

@@ -370,8 +371,11 @@ static int get_cluster_offset(BlockDriverState *bs,
             return 0;
         /* allocate a new l2 entry */
         l2_offset = bdrv_getlength(bs->file->bs);
+        if (l2_offset < 0) {
+            return l2_offset;
+        }
         /* round to cluster size */
-        l2_offset = (l2_offset + s->cluster_size - 1) & ~(s->cluster_size - 1);
+        l2_offset = QEMU_ALIGN_UP(l2_offset, s->cluster_size);
         /* update the L1 entry */
         s->l1_table[l1_index] = l2_offset;
         tmp = cpu_to_be64(l2_offset);
@@ -438,8 +442,10 @@ static int get_cluster_offset(BlockDriverState *bs,
                 return -EIO;
             }
             cluster_offset = bdrv_getlength(bs->file->bs);
-            cluster_offset = (cluster_offset + s->cluster_size - 1) &
-                ~(s->cluster_size - 1);
+            if ((int64_t) cluster_offset < 0) {
+                return cluster_offset;
+            }
+            cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
             /* write the cluster content */
             ret = bdrv_pwrite(bs->file, cluster_offset, s->cluster_cache,
                               s->cluster_size);
@@ -448,12 +454,20 @@ static int get_cluster_offset(BlockDriverState *bs,
             }
         } else {
             cluster_offset = bdrv_getlength(bs->file->bs);
+            if ((int64_t) cluster_offset < 0) {
+                return cluster_offset;
+            }
             if (allocate == 1) {
                 /* round to cluster size */
-                cluster_offset = (cluster_offset + s->cluster_size - 1) &
-                    ~(s->cluster_size - 1);
-                bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
-                              PREALLOC_MODE_OFF, NULL);
+                cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
+                if (cluster_offset + s->cluster_size > INT64_MAX) {
+                    return -E2BIG;
+                }
+                ret = bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
+                                    PREALLOC_MODE_OFF, NULL);
+                if (ret < 0) {
+                    return ret;
+                }
                 /* if encrypted, we must initialize the cluster
                    content which won't be written */
                 if (bs->encrypted &&
-- 
2.13.4
