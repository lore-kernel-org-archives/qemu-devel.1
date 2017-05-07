Received: from eggs.gnu.org ([2001:4830:134:3::10]:45712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79i9-0002bI-Vr
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79i8-0007hy-UQ
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  6 May 2017 19:05:42 -0500
Message-Id: <20170507000552.20847-3-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
References: <20170507000552.20847-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v13 02/12] qcow2: Use consistent switch
 indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Fix a couple of inconsistent indentations, before an upcoming
patch further tweaks the switch statements.
(best viewed with 'git diff -b').

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v13: split off non-indentation changes
v12: new patch
---
 block/qcow2-cluster.c  | 32 +++++++++----------
 block/qcow2-refcount.c | 84 +++++++++++++++++++++++++-------------------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 31077d8..335a505 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1504,25 +1504,25 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
          * but rather fall through to the backing file.
          */
         switch (qcow2_get_cluster_type(old_l2_entry)) {
-            case QCOW2_CLUSTER_UNALLOCATED:
-                if (full_discard || !bs->backing) {
-                    continue;
-                }
-                break;
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (full_discard || !bs->backing) {
+                continue;
+            }
+            break;

-            case QCOW2_CLUSTER_ZERO:
-                /* Preallocated zero clusters should be discarded in any case */
-                if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
-                    continue;
-                }
-                break;
+        case QCOW2_CLUSTER_ZERO:
+            /* Preallocated zero clusters should be discarded in any case */
+            if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
+                continue;
+            }
+            break;

-            case QCOW2_CLUSTER_NORMAL:
-            case QCOW2_CLUSTER_COMPRESSED:
-                break;
+        case QCOW2_CLUSTER_NORMAL:
+        case QCOW2_CLUSTER_COMPRESSED:
+            break;

-            default:
-                abort();
+        default:
+            abort();
         }

         /* First remove L2 entries */
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index db0af2c..908dbe5 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1128,61 +1128,61 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 offset = entry & L2E_OFFSET_MASK;

                 switch (qcow2_get_cluster_type(entry)) {
-                    case QCOW2_CLUSTER_COMPRESSED:
-                        nb_csectors = ((entry >> s->csize_shift) &
-                                       s->csize_mask) + 1;
-                        if (addend != 0) {
-                            ret = update_refcount(bs,
+                case QCOW2_CLUSTER_COMPRESSED:
+                    nb_csectors = ((entry >> s->csize_shift) &
+                                   s->csize_mask) + 1;
+                    if (addend != 0) {
+                        ret = update_refcount(bs,
                                 (entry & s->cluster_offset_mask) & ~511,
                                 nb_csectors * 512, abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
-                            if (ret < 0) {
-                                goto fail;
-                            }
-                        }
-                        /* compressed clusters are never modified */
-                        refcount = 2;
-                        break;
-
-                    case QCOW2_CLUSTER_NORMAL:
-                    case QCOW2_CLUSTER_ZERO:
-                        if (offset_into_cluster(s, offset)) {
-                            qcow2_signal_corruption(bs, true, -1, -1, "Data "
-                                                    "cluster offset %#" PRIx64
-                                                    " unaligned (L2 offset: %#"
-                                                    PRIx64 ", L2 index: %#x)",
-                                                    offset, l2_offset, j);
-                            ret = -EIO;
+                        if (ret < 0) {
                             goto fail;
                         }
+                    }
+                    /* compressed clusters are never modified */
+                    refcount = 2;
+                    break;

-                        cluster_index = offset >> s->cluster_bits;
-                        if (!cluster_index) {
-                            /* unallocated */
-                            refcount = 0;
-                            break;
-                        }
-                        if (addend != 0) {
-                            ret = qcow2_update_cluster_refcount(bs,
+                case QCOW2_CLUSTER_NORMAL:
+                case QCOW2_CLUSTER_ZERO:
+                    if (offset_into_cluster(s, offset)) {
+                        qcow2_signal_corruption(bs, true, -1, -1, "Data "
+                                                "cluster offset %#" PRIx64
+                                                " unaligned (L2 offset: %#"
+                                                PRIx64 ", L2 index: %#x)",
+                                                offset, l2_offset, j);
+                        ret = -EIO;
+                        goto fail;
+                    }
+
+                    cluster_index = offset >> s->cluster_bits;
+                    if (!cluster_index) {
+                        /* unallocated */
+                        refcount = 0;
+                        break;
+                    }
+                    if (addend != 0) {
+                        ret = qcow2_update_cluster_refcount(bs,
                                     cluster_index, abs(addend), addend < 0,
                                     QCOW2_DISCARD_SNAPSHOT);
-                            if (ret < 0) {
-                                goto fail;
-                            }
-                        }
-
-                        ret = qcow2_get_refcount(bs, cluster_index, &refcount);
                         if (ret < 0) {
                             goto fail;
                         }
-                        break;
+                    }

-                    case QCOW2_CLUSTER_UNALLOCATED:
-                        refcount = 0;
-                        break;
+                    ret = qcow2_get_refcount(bs, cluster_index, &refcount);
+                    if (ret < 0) {
+                        goto fail;
+                    }
+                    break;

-                    default:
-                        abort();
+                case QCOW2_CLUSTER_UNALLOCATED:
+                    refcount = 0;
+                    break;
+
+                default:
+                    abort();
                 }

                 if (refcount == 1) {
-- 
2.9.3
