Received: from eggs.gnu.org ([2001:4830:134:3::10]:48114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCV-0001KK-HJ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCS-0005V2-Id
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCS-0005U3-9h
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EA97042733
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmr8nf038-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:11 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:09 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:15 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-41-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/79] blkdebug: Add pass-through write_zero
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
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Eric Blake <eblake@redhat.com>

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
Message-id: 20170429191419.30051-7-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 63188c245013dbe383e8b031e665f813e2452ea5)
* prereq for 81c219a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c5d2edb..a3dc5f6 100644
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
2.7.4
