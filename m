Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoW-00007z-Bb
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoV-0004eg-Dw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:04 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com
	([40.107.4.133]:34349
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoV-0004d9-2O
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:03 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:22 +0300
Message-ID: <1496330073-51338-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 04/15] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: "Denis V. Lunev" <den@openvz.org>

Currently each single write operation can result in 3 write operations
if guest offsets are not cluster aligned. One write is performed for the
real payload and two for COW-ed areas. Thus the data possibly lays
non-contiguously on the host filesystem. This will reduce further
sequential read performance significantly.

The patch allocates the space in the file with cluster granularity,
ensuring
  1. better host offset locality
  2. less space allocation operations
     (which can be expensive on distributed storage)

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b3ba5da..cd5efba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1575,6 +1575,24 @@ fail:
     return ret;
 }
 
+static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *m;
+
+    for (m = l2meta; m != NULL; m = m->next) {
+        uint64_t bytes = m->nb_clusters << s->cluster_bits;
+
+        if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
+            continue;
+        }
+
+        /* try to alloc host space in one chunk for better locality */
+        bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset, bytes,
+                              BDRV_REQ_ALLOCATE);
+    }
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1656,8 +1674,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         if (ret < 0) {
             goto fail;
         }
-
         qemu_co_mutex_unlock(&s->lock);
+
+        if (bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE) {
+            handle_alloc_space(bs, l2meta);
+        }
+
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
         trace_qcow2_writev_data(qemu_coroutine_self(),
                                 cluster_offset + offset_in_cluster);
-- 
2.7.4
