Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70u-0002QC-OG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70r-0005ky-Kl
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:31 -0600
Message-Id: <20181115020334.1189829-11-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/13] file-posix: Audit for read/write
 64-bit cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

Any use of aio is inherently limited by size_t aio_nbytes in struct
aiocb.  read() is similarly limited to size_t bytes, although in
practice, the ssize_t return means any read attempt on a 32-bit
platform for more than 2G will likely return a short read (if that
much memory was even available to begin with).  And while preadv()
can technically read more than size_t bytes by use of more than one
iov, the fact that you can only pass a finite number of iov each of
which is limited to size_t bytes is a limiting factor.

While we already attempt other methods at populating a more reasonable
max_transfer limit in the cases where the kernel makes that
information available, it is important that we at least let the block
layer know about our hard limitation of size_t bytes (mainly
applicable to 32-bit compilation).  At the same time, on 64-bit
platforms, that means we are now advertising that we don't have any
other unintended size-botching problems, if the block layer were to
start handing us requests larger than 2G.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 48ad3bb372a..4b43ff8cb5c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1073,6 +1073,9 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     raw_probe_alignment(bs, s->fd, errp);
     bs->bl.min_mem_alignment = s->buf_align;
     bs->bl.opt_mem_alignment = MAX(s->buf_align, getpagesize());
+    if (!bs->bl.max_transfer) {
+        bs->bl.max_transfer = SIZE_MAX;
+    }
 }

 static int check_for_dasd(int fd)
-- 
2.17.2
