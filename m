Received: from eggs.gnu.org ([2001:4830:134:3::10]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRR-0002Oo-3O
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRN-0007Xk-3P
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:25 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 15 Feb 2018 18:30:54 +0200
Message-Id: <894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
In-Reply-To: <cover.1518711805.git.berto@igalia.com>
References: <cover.1518711805.git.berto@igalia.com>
In-Reply-To: <cover.1518711805.git.berto@igalia.com>
References: <cover.1518711805.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 1/2] qcow2: Allow checking and repairing
 corrupted internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

The L1 table parameters of internal snapshots are generally not
checked by QEMU. This patch allows 'qemu-img check' to detect broken
snapshots and to skip them when doing the refcount consistency check.

Since without an L1 table we don't have a reliable way to recover the
data from the snapshot, when 'qemu-img check' runs in repair mode this
patch simply removes the corrupted snapshots.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-snapshot.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  7 ++++++-
 block/qcow2.h          |  2 ++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index cee25f582b..7a36073e3e 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -736,3 +736,56 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
 
     return 0;
 }
+
+/* Check the snapshot table and optionally delete the corrupted entries */
+int qcow2_snapshot_table_check(BlockDriverState *bs, BdrvCheckResult *result,
+                               BdrvCheckMode fix)
+{
+    BDRVQcow2State *s = bs->opaque;
+    bool keep_checking;
+    int ret, i;
+
+    do {
+        keep_checking = false;
+
+        for (i = 0; i < s->nb_snapshots; i++) {
+            QCowSnapshot *sn = s->snapshots + i;
+            bool found_corruption = false;
+
+            if (offset_into_cluster(s, sn->l1_table_offset)) {
+                fprintf(stderr, "%s snapshot %s (%s) l1_offset=%#" PRIx64 ": "
+                        "L1 table is not cluster aligned; snapshot table entry "
+                        "corrupted\n",
+                        (fix & BDRV_FIX_ERRORS) ? "Deleting" : "ERROR",
+                        sn->id_str, sn->name, sn->l1_table_offset);
+                found_corruption = true;
+            } else if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+                fprintf(stderr, "%s snapshot %s (%s) l1_size=%#" PRIx32 ": "
+                        "L1 table is too large; snapshot table entry corrupted\n",
+                        (fix & BDRV_FIX_ERRORS) ? "Deleting" : "ERROR",
+                        sn->id_str, sn->name, sn->l1_size);
+                found_corruption = true;
+            }
+
+            if (found_corruption) {
+                result->corruptions++;
+                sn->l1_size = 0; /* Prevent this L1 table from being used */
+                if (fix & BDRV_FIX_ERRORS) {
+                    ret = qcow2_snapshot_delete(bs, sn->id_str, sn->name, NULL);
+                    if (ret < 0) {
+                        return ret;
+                    }
+                    result->corruptions_fixed++;
+                    /* If we modified the snapshot table we can't keep
+                     * iterating. We have to start again from the
+                     * beginning instead. */
+                    keep_checking = true;
+                    break;
+                }
+            }
+        }
+
+    } while (keep_checking);
+
+    return 0;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 2c6c33b67c..20e16ea602 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -546,7 +546,12 @@ int qcow2_mark_consistent(BlockDriverState *bs)
 static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
                        BdrvCheckMode fix)
 {
-    int ret = qcow2_check_refcounts(bs, result, fix);
+    int ret = qcow2_snapshot_table_check(bs, result, fix);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = qcow2_check_refcounts(bs, result, fix);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index 1a84cc77b0..19f14bfc1e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -637,6 +637,8 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
                             const char *snapshot_id,
                             const char *name,
                             Error **errp);
+int qcow2_snapshot_table_check(BlockDriverState *bs, BdrvCheckResult *result,
+                               BdrvCheckMode fix);
 
 void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
-- 
2.11.0
