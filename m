Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1U-0005Kf-8W
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1T-0006oT-ER
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 28 Jun 2018 17:39:36 +0200
Message-Id: <20180628153937.26097-3-kwolf@redhat.com>
In-Reply-To: <20180628153937.26097-1-kwolf@redhat.com>
References: <20180628153937.26097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qcow2: Free allocated clusters on write
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

If we managed to allocate the clusters, but then failed to write the
data, there's a good chance that we'll still be able to free the
clusters again in order to avoid cluster leaks (the refcounts are
cached, so even if we can't write them out right now, we may be able to
do so when the VM is resumed after a werror=stop/enospc pause).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h         |  1 +
 block/qcow2-cluster.c | 11 +++++++++++
 block/qcow2.c         |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 01b5250415..1c9c0d3631 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -614,6 +614,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                          int compressed_size);
 
 int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
+void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
 int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, enum qcow2_discard_type type,
                           bool full_discard);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0d74584c9b..d37fe08b3d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -994,6 +994,17 @@ err:
     return ret;
  }
 
+/**
+ * Frees the allocated clusters because the request failed and they won't
+ * actually be linked.
+ */
+void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
+{
+    BDRVQcow2State *s = bs->opaque;
+    qcow2_free_clusters(bs, m->alloc_offset, m->nb_clusters << s->cluster_bits,
+                        QCOW2_DISCARD_NEVER);
+}
+
 /*
  * Returns the number of contiguous clusters that can be used for an allocating
  * write, but require COW to be performed (this includes yet unallocated space,
diff --git a/block/qcow2.c b/block/qcow2.c
index da54b2c8f8..7a4db12afd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1777,6 +1777,8 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
             if (ret) {
                 goto out;
             }
+        } else {
+            qcow2_alloc_cluster_abort(bs, l2meta);
         }
 
         /* Take the request off the list of running requests */
-- 
2.13.6
