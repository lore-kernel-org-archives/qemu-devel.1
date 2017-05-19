Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJm-0006v1-Qf
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJi-0006pd-R0
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:30 -0400
Received: from mail-db5eur01on0106.outbound.protection.outlook.com
	([104.47.2.106]:27443
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJi-0006pK-5s
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:26 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:39 +0300
Message-ID: <1495186480-114192-13-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 12/13] qcow2: allow concurrent unaligned
 writes to the same clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

If COW area of a write request to unallocated cluster is empty,
concurrent write requests can be allowed with a little bit of
extra synchronization; so they don't have to wait until L2 is filled.

Let qcow2_cluster.c::handle_dependencies() do the most of the job:
  if there is an in-flight request to the same cluster,
  and the current request wants to write in its COW area,
  and its COW area is marked empty,
  - steal the allocated offset and write concurrently. Let the original
    request update L2 later when it likes.

This gives an improvement for parallel misaligned writes to
unallocated clusters with no backing data:

HDD fio over xfs iodepth=4:
  seqwrite 4k:   18400 -> 22800 IOPS ( x1.24 )
  seqwrite 68k:   1600 ->  2300 IOPS ( x1.44 )

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c | 169 +++++++++++++++++++++++++++++++++++++++++++-------
 block/qcow2.c         |  28 ++++++++-
 block/qcow2.h         |  12 +++-
 3 files changed, 181 insertions(+), 28 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index c0974e8..7cffdd4 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -898,20 +898,32 @@ out:
 
 /*
  * Check if there already is an AIO write request in flight which allocates
- * the same cluster. In this case we need to wait until the previous
- * request has completed and updated the L2 table accordingly.
+ * the same cluster.
+ * In this case, check if that request has explicitly allowed to write
+ * in its COW area(s).
+ *   If yes - fill the meta to point to the same cluster.
+ *   If no  - we need to wait until the previous request has completed and
+ *            updated the L2 table accordingly or
+ *            has allowed writing in its COW area(s).
  * Returns:
  *   0       if there was no dependency. *cur_bytes indicates the number of
  *           bytes from guest_offset that can be read before the next
  *           dependency must be processed (or the request is complete).
- *           *m is not modified
+ *           *m, *host_offset are not modified
+ *
+ *   1       if there is a dependency but it is possible to write concurrently
+ *           *m is filled accordingly,
+ *           *cur_bytes may have decreased and describes
+ *             the length of the area that can be written to,
+ *           *host_offset contains the starting host image offset to write to
  *
  *   -EAGAIN if we had to wait for another request. The caller
- *           must start over, so consider *cur_bytes undefined.
+ *           must start over, so consider *cur_bytes and *host_offset undefined.
  *           *m is not modified
  */
 static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
-    uint64_t *cur_bytes, QCowL2Meta **m)
+                               uint64_t *host_offset, uint64_t *cur_bytes,
+                               QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowL2Meta *old_alloc;
@@ -924,7 +936,7 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
         const uint64_t old_start = l2meta_cow_start(old_alloc);
         const uint64_t old_end = l2meta_cow_end(old_alloc);
 
-        if (end <= old_start || start >= old_end) {
+        if (end <= old_start || start >= old_end || old_alloc->piggybacked) {
             /* No intersection */
             continue;
         }
@@ -936,21 +948,95 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
             continue;
         }
 
-        /* Stop if already an l2meta exists. After yielding, it wouldn't
-         * be valid any more, so we'd have to clean up the old L2Metas
-         * and deal with requests depending on them before starting to
-         * gather new ones. Not worth the trouble. */
-        if (*m) {
+        /* offsets of the cluster we're intersecting in */
+        const uint64_t cluster_start = start_of_cluster(s, start);
+        const uint64_t cluster_end = cluster_start + s->cluster_size;
+
+        const uint64_t old_data_start = old_start
+            + old_alloc->cow_start.nb_bytes;
+        const uint64_t old_data_end = old_alloc->offset
+            + old_alloc->cow_end.offset;
+
+        const bool conflict_in_data_area =
+            end > old_data_start && start < old_data_end;
+        const bool conflict_in_old_cow_start =
+            /* 1). new write request area is before the old */
+            start < old_data_start
+            && /* 2). old request did not allow writing in its cow area */
+            !old_alloc->cow_start.reduced;
+        const bool conflict_in_old_cow_end =
+            /* 1). new write request area is after the old */
+            start > old_data_start
+            && /* 2). old request did not allow writing in its cow area */
+            !old_alloc->cow_end.reduced;
+
+        if (conflict_in_data_area ||
+            conflict_in_old_cow_start || conflict_in_old_cow_end) {
+
+            /* Stop if already an l2meta exists. After yielding, it wouldn't
+             * be valid any more, so we'd have to clean up the old L2Metas
+             * and deal with requests depending on them before starting to
+             * gather new ones. Not worth the trouble. */
+            if (*m) {
+                /* start must be cluster aligned at this point */
+                assert(start == cluster_start);
+                *cur_bytes = 0;
+                return 0;
+            }
+
+            /* Wait for the dependency to complete. We need to recheck
+             * the free/allocated clusters when we continue. */
+            qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
+            return -EAGAIN;
+        }
+
+        /* allocations do conflict, but the competitor kindly allowed us
+         * to write concurrently (our data area only, not the whole cluster!)
+         * Inter alia, this means we must not touch the COW areas */
+
+        if (*host_offset) {
             /* start must be cluster aligned at this point */
-            assert(start == start_of_cluster(s, start));
-            *cur_bytes = 0;
-            return 0;
+            assert(start == cluster_start);
+            if ((old_alloc->alloc_offset + (start - old_start))
+                != *host_offset) {
+                /* can't extend contiguous allocation */
+                *cur_bytes = 0;
+                return 0;
+            }
         }
 
-        /* Wait for the dependency to complete. We need to recheck
-         * the free/allocated clusters when we continue. */
-        qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
-        return -EAGAIN;
+        QCowL2Meta *old_m = *m;
+        *m = g_malloc0(sizeof(**m));
+
+        **m = (QCowL2Meta) {
+            .next           = old_m,
+
+            .alloc_offset   = old_alloc->alloc_offset
+                              + (cluster_start - old_start),
+            .offset         = old_alloc->offset
+                              + (cluster_start - old_start),
+            .nb_clusters    = 1,
+            .piggybacked    = true,
+            .clusters_are_trailing = false,
+
+            /* reduced COW areas. see above */
+            .cow_start = {
+                .offset   = 0,
+                .nb_bytes = start - cluster_start,
+                .reduced  = true,
+            },
+            .cow_end = {
+                .offset   = MIN(end - cluster_start, s->cluster_size),
+                .nb_bytes = end < cluster_end ? cluster_end - end : 0,
+                .reduced  = true,
+            },
+        };
+        qemu_co_queue_init(&(*m)->dependent_requests);
+        QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
+
+        *host_offset = old_alloc->alloc_offset + (start - old_start);
+        *cur_bytes = MIN(*cur_bytes, cluster_end - start);
+        return 1;
     }
 
     /* Make sure that existing clusters and new allocations are only used up to
@@ -1264,6 +1350,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .alloc_offset   = alloc_cluster_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,
+        .piggybacked    = false,
         .clusters_are_trailing = alloc_cluster_offset >= old_data_end,
 
         .keep_old_clusters  = keep_old_clusters,
@@ -1364,13 +1451,12 @@ again:
          *         for contiguous clusters (the situation could have changed
          *         while we were sleeping)
          *
-         *      c) TODO: Request starts in the same cluster as the in-flight
-         *         allocation ends. Shorten the COW of the in-fight allocation,
-         *         set cluster_offset to write to the same cluster and set up
-         *         the right synchronisation between the in-flight request and
-         *         the new one.
+         *      c) Overlap with another request's writeable COW area. Use
+         *         the stolen offset (and let the original request update L2
+         *         when it pleases)
+         *
          */
-        ret = handle_dependencies(bs, start, &cur_bytes, m);
+        ret = handle_dependencies(bs, start, &cluster_offset, &cur_bytes, m);
         if (ret == -EAGAIN) {
             /* Currently handle_dependencies() doesn't yield if we already had
              * an allocation. If it did, we would have to clean up the L2Meta
@@ -1379,6 +1465,8 @@ again:
             goto again;
         } else if (ret < 0) {
             return ret;
+        } else if (ret) {
+            continue;
         } else if (cur_bytes == 0) {
             break;
         } else {
@@ -1967,3 +2055,36 @@ void qcow2_update_data_end(BlockDriverState *bs, uint64_t off)
         s->data_end = off;
     }
 }
+
+/*
+ * For each @m, wait for its dependency request to finish and check for its
+ * success, i.e. that L2 table is updated as expected.
+ */
+int qcow2_wait_l2table_update(BlockDriverState *bs, const QCowL2Meta *m)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *old_alloc;
+    uint64_t alloc_offset;
+    unsigned int bytes;
+    int ret;
+
+    for (; m != NULL; m = m->next) {
+        assert(m->piggybacked);
+        QLIST_FOREACH(old_alloc, &s->cluster_allocs, next_in_flight) {
+            uint64_t a_off;
+            a_off = old_alloc->alloc_offset + (m->offset - old_alloc->offset);
+            if (!old_alloc->piggybacked && m->offset >= old_alloc->offset &&
+                a_off == m->alloc_offset) {
+
+                qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
+                break;
+            }
+        }
+        ret = qcow2_get_cluster_offset(bs, m->offset, &bytes, &alloc_offset);
+        if (ret != QCOW2_CLUSTER_NORMAL ||
+            alloc_offset != m->alloc_offset) {
+            return -1;
+        }
+    }
+    return 0;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 97a66a0..0f28a4b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1625,6 +1625,8 @@ fail:
 
 static void handle_cow_reduce(BlockDriverState *bs, QCowL2Meta *m)
 {
+    bool trimmed = false;
+
     if (bs->encrypted) {
         return;
     }
@@ -1633,12 +1635,19 @@ static void handle_cow_reduce(BlockDriverState *bs, QCowL2Meta *m)
                         (m->offset + m->cow_start.offset) >> BDRV_SECTOR_BITS,
                         m->cow_start.nb_bytes >> BDRV_SECTOR_BITS)) {
         m->cow_start.reduced = true;
+        trimmed = true;
     }
     if (!m->cow_end.reduced && m->cow_end.nb_bytes != 0 &&
         is_zero_sectors(bs,
                         (m->offset + m->cow_end.offset) >> BDRV_SECTOR_BITS,
                         m->cow_end.nb_bytes >> BDRV_SECTOR_BITS)) {
         m->cow_end.reduced = true;
+        trimmed = true;
+    }
+    /* The request is trimmed. Let's try to start dependent
+       ones, may be we will be lucky */
+    if (trimmed) {
+        qemu_co_queue_restart_all(&m->dependent_requests);
     }
 }
 
@@ -1787,6 +1796,10 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     for (m = l2meta; m != NULL; m = m->next) {
         uint64_t bytes = m->nb_clusters << s->cluster_bits;
 
+        if (m->piggybacked) {
+            continue;
+        }
+
         if (s->prealloc_size != 0 && handle_prealloc(bs, m)) {
             handle_cow_reduce(bs, m);
             continue;
@@ -1910,9 +1923,18 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         while (l2meta != NULL) {
             QCowL2Meta *next;
 
-            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
-            if (ret < 0) {
-                goto fail;
+            if (!l2meta->piggybacked) {
+                ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+                if (ret < 0) {
+                    goto fail;
+                }
+            } else {
+                ret = qcow2_wait_l2table_update(bs, l2meta);
+                if (ret < 0) {
+                    /* dependency request failed, return general EIO */
+                    ret = -EIO;
+                    goto fail;
+                }
             }
 
             /* Take the request off the list of running requests */
diff --git a/block/qcow2.h b/block/qcow2.h
index 2fd8510..5947045 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -310,7 +310,8 @@ typedef struct Qcow2COWRegion {
     /** Number of bytes to copy */
     int         nb_bytes;
 
-    /** The region is filled with zeroes and does not require COW
+    /** The region does not require COW
+     *  (either filled with zeroes or busy with other request)
      */
     bool        reduced;
 } Qcow2COWRegion;
@@ -338,6 +339,13 @@ typedef struct QCowL2Meta
     bool clusters_are_trailing;
 
     /**
+     * True if the described clusters are being allocated by
+     * the other concurrent request; so this one must not actually update L2
+     * or COW but only write its data
+     */
+    bool piggybacked;
+
+    /**
      * Requests that overlap with this allocation and wait to be restarted
      * when the allocating request has completed.
      */
@@ -575,6 +583,8 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
                                BlockDriverAmendStatusCB *status_cb,
                                void *cb_opaque);
 
+int qcow2_wait_l2table_update(BlockDriverState *bs, const QCowL2Meta *m);
+
 /* qcow2-snapshot.c functions */
 int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info);
 int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id);
-- 
2.7.4
