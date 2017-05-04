Received: from eggs.gnu.org ([2001:4830:134:3::10]:52469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677g-0002tr-Nz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677f-0001FN-1W
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 May 2017 22:07:46 -0500
Message-Id: <20170504030755.1001-2-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
References: <20170504030755.1001-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v12 01/10] qcow2: Use consistent switch
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
patch further tweaks the switch statements.  While at it, make
some tweaks for shorter lines to keep checkpatch happy (best
viewed with 'git diff -b').

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v12: new patch
---
 block/qcow2-cluster.c  | 32 ++++++++---------
 block/qcow2-refcount.c | 96 ++++++++++++++++++++++++++------------------------
 2 files changed, 65 insertions(+), 63 deletions(-)

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
index 4efca7e..a5a0076 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1117,70 +1117,72 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 goto fail;
             }

-            for(j = 0; j < s->l2_size; j++) {
+            for (j = 0; j < s->l2_size; j++) {
                 uint64_t cluster_index;
+                uint64_t offset_masked;

                 offset = be64_to_cpu(l2_table[j]);
                 old_offset = offset;
+                offset_masked = offset & L2E_OFFSET_MASK;
                 offset &= ~QCOW_OFLAG_COPIED;

                 switch (qcow2_get_cluster_type(offset)) {
-                    case QCOW2_CLUSTER_COMPRESSED:
-                        nb_csectors = ((offset >> s->csize_shift) &
-                                       s->csize_mask) + 1;
-                        if (addend != 0) {
-                            ret = update_refcount(bs,
-                                (offset & s->cluster_offset_mask) & ~511,
-                                nb_csectors * 512, abs(addend), addend < 0,
-                                QCOW2_DISCARD_SNAPSHOT);
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
-                        if (offset_into_cluster(s, offset & L2E_OFFSET_MASK)) {
-                            qcow2_signal_corruption(bs, true, -1, -1, "Data "
-                                                    "cluster offset %#llx "
-                                                    "unaligned (L2 offset: %#"
-                                                    PRIx64 ", L2 index: %#x)",
-                                                    offset & L2E_OFFSET_MASK,
-                                                    l2_offset, j);
-                            ret = -EIO;
+                case QCOW2_CLUSTER_COMPRESSED:
+                    nb_csectors = ((offset >> s->csize_shift) &
+                                   s->csize_mask) + 1;
+                    if (addend != 0) {
+                        ret = update_refcount(bs,
+                            (offset & s->cluster_offset_mask) & ~511,
+                            nb_csectors * 512, abs(addend), addend < 0,
+                            QCOW2_DISCARD_SNAPSHOT);
+                        if (ret < 0) {
                             goto fail;
                         }
+                    }
+                    /* compressed clusters are never modified */
+                    refcount = 2;
+                    break;

-                        cluster_index = (offset & L2E_OFFSET_MASK) >> s->cluster_bits;
-                        if (!cluster_index) {
-                            /* unallocated */
-                            refcount = 0;
-                            break;
-                        }
-                        if (addend != 0) {
-                            ret = qcow2_update_cluster_refcount(bs,
+                case QCOW2_CLUSTER_NORMAL:
+                case QCOW2_CLUSTER_ZERO:
+                    if (offset_into_cluster(s, offset_masked)) {
+                        qcow2_signal_corruption(bs, true, -1, -1, "Data "
+                                                "cluster offset %#" PRIx64
+                                                " unaligned (L2 offset: %#"
+                                                PRIx64 ", L2 index: %#x)",
+                                                offset_masked,
+                                                l2_offset, j);
+                        ret = -EIO;
+                        goto fail;
+                    }
+
+                    cluster_index = offset_masked >> s->cluster_bits;
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
