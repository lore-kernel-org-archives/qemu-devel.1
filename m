Received: from eggs.gnu.org ([2001:4830:134:3::10]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3m-0000yb-Nj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3l-0002TI-PM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:34 +0200
Message-Id: <20171026131741.5059-29-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/35] qcow2: Use BDRV_SECTOR_BITS instead of
 its literal value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

BDRV_SECTOR_BITS is defined to be 9 in block.h (and BDRV_SECTOR_SIZE
is calculated from that), but there are still a couple of places where
we are using the literal value instead of the macro.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20171009153856.20387-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index fbf9464d3a..f77b490cc6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1139,7 +1139,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
-    s->cluster_sectors = 1 << (s->cluster_bits - 9);
+    s->cluster_sectors = 1 << (s->cluster_bits - BDRV_SECTOR_BITS);
 
     /* Initialise version 3 header fields */
     if (header.version == 2) {
@@ -1636,7 +1636,7 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
 
     bytes = MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SIZE);
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
+    ret = qcow2_get_cluster_offset(bs, sector_num << BDRV_SECTOR_BITS, &bytes,
                                    &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
-- 
2.13.6
