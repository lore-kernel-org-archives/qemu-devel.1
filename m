Received: from eggs.gnu.org ([2001:4830:134:3::10]:51179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFD-0001XL-6l
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFA-000470-Kn
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16486 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ddeFA-00041K-8q
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:28 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri,  4 Aug 2017 18:10:11 +0300
Message-Id: <20170804151013.13057-2-den@openvz.org>
In-Reply-To: <20170804151013.13057-1-den@openvz.org>
References: <20170804151013.13057-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/3] block: respect error code from
 bdrv_getlength in handle_aiocb_write_zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Original idea beyond the code in question was the following: we have failed
to write zeroes with fallocate(FALLOC_FL_ZERO_RANGE) as the simplest
approach and via fallocate(FALLOC_FL_PUNCH_HOLE)/fallocate(0). We have the
only chance now: if the request comes beyond end of the file. Thus we
should calculate file length and respect the error code from that op.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cfbb236f6f..f4de022ae0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1339,6 +1339,9 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
     BDRVRawState *s = aiocb->bs->opaque;
 #endif
+#ifdef CONFIG_FALLOCATE
+    int64_t len;
+#endif
 
     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
         return handle_aiocb_write_zeroes_block(aiocb);
@@ -1381,7 +1384,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #endif
 
 #ifdef CONFIG_FALLOCATE
-    if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
+    /* Last resort: we are trying to extend the file with zeroed data. This
+     * can be done via fallocate(fd, 0) */
+    len = bdrv_getlength(aiocb->bs);
+    if (s->has_fallocate && len >= 0 && aiocb->aio_offset >= len) {
         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
         if (ret == 0 || ret != -ENOTSUP) {
             return ret;
-- 
2.11.0
