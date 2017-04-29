Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4XpB-0007hD-K6
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4XpA-0006vV-8X
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 29 Apr 2017 14:14:16 -0500
Message-Id: <20170429191419.30051-7-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-1-eblake@redhat.com>
References: <20170429191419.30051-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v11 6/9] blkdebug: Add pass-through write_zero
 and discard support
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

In order to test the effects of artificial geometry constraints
on operations like write zero or discard, we first need blkdebug
to manage these actions.  It also allows us to inject errors on
those operations, just like we can for read/write/flush.

We can also test the contract promised by the block layer; namely,
if a device has specified limits on alignment or maximum size,
then those limits must be obeyed (for now, the blkdebug driver
merely inherits limits from whatever it is wrapping, but the next
patch will further enhance it to allow specific limit overrides).

This patch intentionally refuses to service requests smaller than
the requested alignments; this is because an upcoming patch adds
a qemu-iotest to prove that the block layer is correctly handling
fragmentation, but the test only works if there is a way to tell
the difference at artificial alignment boundaries when blkdebug is
using a larger-than-default alignment.  If we let the blkdebug
layer always defer to the underlying layer, which potentially has
a smaller granularity, the iotest will be thwarted.

Tested by setting up an NBD server with export 'foo', then invoking:
$ ./qemu-io
qemu-io> open -o driver=blkdebug blkdebug::nbd://localhost:10809/foo
qemu-io> d 0 15M
qemu-io> w -z 0 15M

Pre-patch, the server never sees the discard (it was silently
eaten by the block layer); post-patch it is passed across the
wire.  Likewise, pre-patch the write is always passed with
NBD_WRITE (with 15M of zeroes on the wire), while post-patch
it can utilize NBD_WRITE_ZEROES (for less traffic).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v11: no change
v10: no change
v9: no change
v7-v8: not submitted (earlier half of series sent for 2.9)
v6: tighten check of unaligned requests, rebase on rule check
refactoring, drop R-b
v5: include 2017 copyright
v4: correct error injection to respect byte range, tweak formatting
v3: rebase to byte-based read/write, improve docs on why no
partial write zero passthrough
v2: new patch
---
 block/blkdebug.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a2905ca..6414f1c 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -1,6 +1,7 @@
 /*
  * Block protocol for I/O error injection
  *
+ * Copyright (C) 2016-2017 Red Hat, Inc.
  * Copyright (c) 2010 Kevin Wolf <kwolf@redhat.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
@@ -382,6 +383,11 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }

+    bs->supported_write_flags = BDRV_REQ_FUA &
+        bs->file->bs->supported_write_flags;
+    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        bs->file->bs->supported_zero_flags;
+
     /* Set request alignment */
     align = qemu_opt_get_size(opts, "align", 0);
     if (align < INT_MAX && is_power_of_2(align)) {
@@ -494,6 +500,72 @@ static int blkdebug_co_flush(BlockDriverState *bs)
     return bdrv_co_flush(bs->file->bs);
 }

+static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
+                                                  int64_t offset, int count,
+                                                  BdrvRequestFlags flags)
+{
+    uint32_t align = MAX(bs->bl.request_alignment,
+                         bs->bl.pwrite_zeroes_alignment);
+    int err;
+
+    /* Only pass through requests that are larger than requested
+     * preferred alignment (so that we test the fallback to writes on
+     * unaligned portions), and check that the block layer never hands
+     * us anything unaligned that crosses an alignment boundary.  */
+    if (count < align) {
+        assert(QEMU_IS_ALIGNED(offset, align) ||
+               QEMU_IS_ALIGNED(offset + count, align) ||
+               DIV_ROUND_UP(offset, align) ==
+               DIV_ROUND_UP(offset + count, align));
+        return -ENOTSUP;
+    }
+    assert(QEMU_IS_ALIGNED(offset, align));
+    assert(QEMU_IS_ALIGNED(count, align));
+    if (bs->bl.max_pwrite_zeroes) {
+        assert(count <= bs->bl.max_pwrite_zeroes);
+    }
+
+    err = rule_check(bs, offset, count);
+    if (err) {
+        return err;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
+}
+
+static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
+                                             int64_t offset, int count)
+{
+    uint32_t align = bs->bl.pdiscard_alignment;
+    int err;
+
+    /* Only pass through requests that are larger than requested
+     * minimum alignment, and ensure that unaligned requests do not
+     * cross optimum discard boundaries. */
+    if (count < bs->bl.request_alignment) {
+        assert(QEMU_IS_ALIGNED(offset, align) ||
+               QEMU_IS_ALIGNED(offset + count, align) ||
+               DIV_ROUND_UP(offset, align) ==
+               DIV_ROUND_UP(offset + count, align));
+        return -ENOTSUP;
+    }
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(count, bs->bl.request_alignment));
+    if (align && count >= align) {
+        assert(QEMU_IS_ALIGNED(offset, align));
+        assert(QEMU_IS_ALIGNED(count, align));
+    }
+    if (bs->bl.max_pdiscard) {
+        assert(count <= bs->bl.max_pdiscard);
+    }
+
+    err = rule_check(bs, offset, count);
+    if (err) {
+        return err;
+    }
+
+    return bdrv_co_pdiscard(bs->file->bs, offset, count);
+}

 static void blkdebug_close(BlockDriverState *bs)
 {
@@ -748,6 +820,8 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_preadv         = blkdebug_co_preadv,
     .bdrv_co_pwritev        = blkdebug_co_pwritev,
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
+    .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
+    .bdrv_co_pdiscard       = blkdebug_co_pdiscard,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
-- 
2.9.3
