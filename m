Received: from eggs.gnu.org ([2001:4830:134:3::10]:52864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xs-00056E-DB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xr-0008KG-2A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:04 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fW7xq-0008J1-Ru
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:02 -0400
Received: by mail-pg0-x241.google.com with SMTP id a14-v6so2030825pgw.10
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:22:02 -0700 (PDT)
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Thu, 21 Jun 2018 15:21:43 -0700
Message-Id: <20180621222143.27266-3-naravamudan@digitalocean.com>
In-Reply-To: <20180621222143.27266-1-naravamudan@digitalocean.com>
References: <20180621222143.27266-1-naravamudan@digitalocean.com>
Subject: [Qemu-devel] [PATCH v3 2/2] block/file-posix: reconfigure aio on
 iothread start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: naravamudan@digitalocean.com
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

When the AioContext changes, we need to associate a LinuxAioState with
the new AioContext. Use the bdrv_attach_aio_context callback and call
the new aio_setup_linux_aio(), which will allocate a new AioContext if
needed, and return errors on failures. If it fails for any reason,
fallback to threaded AIO with an error message, as the device is already
in-use by the guest.

Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
---
Note this patch didn't exist in v2, but is a result of feedback to that
posting.

 block/file-posix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 6a1714d4a8..ce24950acf 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1730,6 +1730,21 @@ static BlockAIOCB *raw_aio_flush(BlockDriverState *bs,
     return paio_submit(bs, s->fd, 0, NULL, 0, cb, opaque, QEMU_AIO_FLUSH);
 }
 
+static void raw_aio_attach_aio_context(BlockDriverState *bs,
+                                       AioContext *new_context)
+{
+#ifdef CONFIG_LINUX_AIO
+    BDRVRawState *s = bs->opaque;
+    if (s->use_linux_aio) {
+        if (aio_setup_linux_aio(new_context) != 0) {
+            error_report("Unable to use native AIO, falling back to "
+                         "thread pool");
+            s->use_linux_aio = false;
+        }
+    }
+#endif
+}
+
 static void raw_close(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
@@ -2608,6 +2623,7 @@ BlockDriver bdrv_file = {
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
+    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_truncate = raw_truncate,
     .bdrv_getlength = raw_getlength,
-- 
2.17.1
