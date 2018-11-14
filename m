Received: from eggs.gnu.org ([2001:4830:134:3::10]:38033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN2MU-00035i-E9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 16:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN2MS-0002ws-DH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 16:06:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 15:05:48 -0600
Message-Id: <20181114210548.1098207-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1?] file-posix: Better checks of 64-bit
 copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, Max Reitz <mreitz@redhat.com>

file-posix.c was taking a 64-bit bytes in raw_co_copy_range_to(),
passing it through a 32-bit parameter of paio_submit_co_full(),
then widening it back to size_t when assigning into acb->aio_nbytes.

Looking at io.c, I can't quickly tell if bdrv_co_copy_range_internal()
is fragmenting things to honor bs->bl.max_transfer, or if it can
accidentally send requests larger than 2G down to the driver. If
the former, then this is a no-op; if the latter, then someone needs
to find a way to trigger this assertion and patch the block layer
to properly fragment copy_range requests.  Either way, we're better
off with an assertion than the risk of silent data corruption.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 58c86a01eaa..48ad3bb372a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1821,7 +1821,7 @@ static int aio_worker(void *arg)
 static int paio_submit_co_full(BlockDriverState *bs, int fd,
                                int64_t offset, int fd2, int64_t offset2,
                                QEMUIOVector *qiov,
-                               int bytes, int type)
+                               uint64_t bytes, int type)
 {
     RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
     ThreadPool *pool;
@@ -1832,6 +1832,7 @@ static int paio_submit_co_full(BlockDriverState *bs, int fd,
     acb->aio_fd2 = fd2;
     acb->aio_offset2 = offset2;

+    assert(bytes <= SIZE_MAX);
     acb->aio_nbytes = bytes;
     acb->aio_offset = offset;

@@ -1848,7 +1849,7 @@ static int paio_submit_co_full(BlockDriverState *bs, int fd,

 static inline int paio_submit_co(BlockDriverState *bs, int fd,
                                  int64_t offset, QEMUIOVector *qiov,
-                                 int bytes, int type)
+                                 uint64_t bytes, int type)
 {
     return paio_submit_co_full(bs, fd, offset, -1, 0, qiov, bytes, type);
 }
-- 
2.17.2
