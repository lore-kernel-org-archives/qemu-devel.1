Received: from eggs.gnu.org ([2001:4830:134:3::10]:42565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuK-000861-8S
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuJ-0007lu-Fi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:57:57 +0100
Message-Id: <1487689130-30373-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 01/54] blockdev: Use BlockBackend to resize in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In order to be able to do permission checking and to keep working with
the BdrvChild based bdrv_truncate() that this involves, we need to
create a temporary BlockBackend to resize the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index db82ac9..3596d87 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2855,6 +2855,7 @@ void qmp_block_resize(bool has_device, const char *device,
                       int64_t size, Error **errp)
 {
     Error *local_err = NULL;
+    BlockBackend *blk = NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
     int ret;
@@ -2885,10 +2886,13 @@ void qmp_block_resize(bool has_device, const char *device,
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
@@ -2910,6 +2914,7 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
 out:
+    blk_unref(blk);
     aio_context_release(aio_context);
 }
 
-- 
1.8.3.1
