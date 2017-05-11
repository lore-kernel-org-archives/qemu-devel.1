Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAj-0002dX-PW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAj-0007rP-1L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:43 +0200
Message-Id: <1494513181-7900-41-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/58] blkdebug: Sanity check block layer
 guarantees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Commits 04ed95f4 and 1a62d0ac updated the block layer to auto-fragment
any I/O to fit within device boundaries. Additionally, when using a
minimum alignment of 4k, we want to ensure the block layer does proper
read-modify-write rather than requesting I/O on a slice of a sector.
Let's enforce that the contract is obeyed when using blkdebug.  For
now, blkdebug only allows alignment overrides, and just inherits other
limits from whatever device it is wrapping, but a future patch will
further enhance things.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170429191419.30051-5-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 3c08893..a562e2e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -429,6 +429,13 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
+    /* Sanity check block layer guarantees */
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+    if (bs->bl.max_transfer) {
+        assert(bytes <= bs->bl.max_transfer);
+    }
+
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset = rule->options.inject.offset;
 
@@ -453,6 +460,13 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
+    /* Sanity check block layer guarantees */
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+    if (bs->bl.max_transfer) {
+        assert(bytes <= bs->bl.max_transfer);
+    }
+
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset = rule->options.inject.offset;
 
-- 
1.8.3.1
