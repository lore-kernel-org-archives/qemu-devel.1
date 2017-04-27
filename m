Received: from eggs.gnu.org ([2001:4830:134:3::10]:33789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW7-0007dH-GQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW6-0004AK-7g
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:47 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:21 -0500
Message-Id: <20170427014626.11553-13-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v10 12/17] blkdebug: Sanity check block layer
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
v10: no change
v5-v9: no change
v4: no change
v3: rebase to byte-based interfaces
v2: new patch
---
 block/blkdebug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c795ae9..14d3fc5 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -431,6 +431,13 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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

@@ -455,6 +462,13 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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
