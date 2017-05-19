Received: from eggs.gnu.org ([2001:4830:134:3::10]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJT-0006hc-Lv
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJP-0006ho-Ou
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:11 -0400
Received: from mail-db5eur01on0095.outbound.protection.outlook.com
	([104.47.2.95]:23375
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJP-0006g9-F5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:07 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:28 +0300
Message-ID: <1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
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
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, "Denis V.
	Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

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
     (which can be expensive on distributed storages)

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0..2e6a0ec 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1575,6 +1575,32 @@ fail:
     return ret;
 }
 
+static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s = bs->opaque;
+    BlockDriverState *file = bs->file->bs;
+    QCowL2Meta *m;
+    int ret;
+
+    for (m = l2meta; m != NULL; m = m->next) {
+        uint64_t bytes = m->nb_clusters << s->cluster_bits;
+
+        if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
+            continue;
+        }
+
+        /* try to alloc host space in one chunk for better locality */
+        ret = file->drv->bdrv_co_pwrite_zeroes(file, m->alloc_offset, bytes, 0);
+
+        if (ret != 0) {
+            continue;
+        }
+
+        file->total_sectors = MAX(file->total_sectors,
+                                  (m->alloc_offset + bytes) / BDRV_SECTOR_SIZE);
+    }
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1656,8 +1682,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         if (ret < 0) {
             goto fail;
         }
-
         qemu_co_mutex_unlock(&s->lock);
+
+        if (bs->file->bs->drv->bdrv_co_pwrite_zeroes != NULL) {
+            handle_alloc_space(bs, l2meta);
+        }
+
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
         trace_qcow2_writev_data(qemu_coroutine_self(),
                                 cluster_offset + offset_in_cluster);
-- 
2.7.4
