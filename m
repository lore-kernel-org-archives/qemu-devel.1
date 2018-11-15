Received: from eggs.gnu.org ([2001:4830:134:3::10]:53686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70p-0002N2-Lg
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70n-0005it-Nv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:07 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:27 -0600
Message-Id: <20181115020334.1189829-7-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/13] blkdebug: Audit for read/write 64-bit
 cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Since the block layer is never supposed to hand us an offset + bytes
that would exceed off_t, we can assert this in rule_check(). With
that in place, there is nothing else in the pread, pwrite, or
pwrite_zeroes code paths that can't handle inputs larger than 2G
(even if the block layer currently never hands us something
that large); update the refresh_limits callback to document this
fact, when the user doesn't specify an override.

For a user override, we have to change the QAPI type to 'uint64'
instead of 'int'. At the same time, we can also change 'align'
to 'int32' to match the existing checks in blkdebug_open() that
alignment is always smaller than 2G.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json |  2 +-
 block/blkdebug.c     | 17 +++++------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710836e..32f0edd189f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3122,7 +3122,7 @@
 { 'struct': 'BlockdevOptionsBlkdebug',
   'data': { 'image': 'BlockdevRef',
             '*config': 'str',
-            '*align': 'int', '*max-transfer': 'int32',
+            '*align': 'int32', '*max-transfer': 'uint64',
             '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
             '*opt-discard': 'int32', '*max-discard': 'int32',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452925b..be4d65f86a0 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -415,9 +415,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     align = MAX(s->align, bs->file->bs->bl.request_alignment);

     s->max_transfer = qemu_opt_get_size(opts, "max-transfer", 0);
-    if (s->max_transfer &&
-        (s->max_transfer >= INT_MAX ||
-         !QEMU_IS_ALIGNED(s->max_transfer, align))) {
+    if (s->max_transfer && !QEMU_IS_ALIGNED(s->max_transfer, align)) {
         error_setg(errp, "Cannot meet constraints with max-transfer %" PRIu64,
                    s->max_transfer);
         goto out;
@@ -477,6 +475,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
     int error;
     bool immediately;

+    assert(offset <= INT64_MAX - bytes);
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset = rule->options.inject.offset;

@@ -517,9 +516,7 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
     assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
-    if (bs->bl.max_transfer) {
-        assert(bytes <= bs->bl.max_transfer);
-    }
+    assert(bytes <= bs->bl.max_transfer);

     err = rule_check(bs, offset, bytes);
     if (err) {
@@ -538,9 +535,7 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
     assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
-    if (bs->bl.max_transfer) {
-        assert(bytes <= bs->bl.max_transfer);
-    }
+    assert(bytes <= bs->bl.max_transfer);

     err = rule_check(bs, offset, bytes);
     if (err) {
@@ -865,9 +860,7 @@ static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
     if (s->align) {
         bs->bl.request_alignment = s->align;
     }
-    if (s->max_transfer) {
-        bs->bl.max_transfer = s->max_transfer;
-    }
+    bs->bl.max_transfer = s->max_transfer ?: INT64_MAX;
     if (s->opt_write_zero) {
         bs->bl.pwrite_zeroes_alignment = s->opt_write_zero;
     }
-- 
2.17.2
