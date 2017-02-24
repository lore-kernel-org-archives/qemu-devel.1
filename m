Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQs-0006Pj-DH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQr-0002n5-FU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:17:00 +0100
Message-Id: <1487960230-18054-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/19] blockdev: Use BlockBackend to resize in
 qmp_block_resize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

In order to be able to do permission checking and to keep working with
the BdrvChild based bdrv_truncate() that this involves, we need to
create a temporary BlockBackend to resize the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index bbf9d4d..2b2f6ce 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2858,6 +2858,7 @@ void qmp_block_resize(bool has_device, const char *device,
                       int64_t size, Error **errp)
 {
     Error *local_err = NULL;
+    BlockBackend *blk = NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
     int ret;
@@ -2888,10 +2889,13 @@ void qmp_block_resize(bool has_device, const char *device,
         goto out;
     }
 
+    blk = blk_new();
+    blk_insert_bs(blk, bs);
+
     /* complete all in-flight operations before resizing the device */
     bdrv_drain_all();
 
-    ret = bdrv_truncate(bs, size);
+    ret = blk_truncate(blk, size);
     switch (ret) {
     case 0:
         break;
@@ -2913,6 +2917,7 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
 out:
+    blk_unref(blk);
     aio_context_release(aio_context);
 }
 
-- 
1.8.3.1
