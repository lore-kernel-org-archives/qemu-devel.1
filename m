Received: from eggs.gnu.org ([2001:4830:134:3::10]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4XpA-0007fP-BC
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Xp9-0006uq-6C
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 29 Apr 2017 14:14:14 -0500
Message-Id: <20170429191419.30051-5-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-1-eblake@redhat.com>
References: <20170429191419.30051-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v11 4/9] blkdebug: Sanity check block layer
 guarantees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

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

---
v11: no change
v10: no change
v5-v9: no change
v4: no change
v3: rebase to byte-based interfaces
v2: new patch
---
 block/blkdebug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index d2a7561..30ecb9d 100644
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
2.9.3
