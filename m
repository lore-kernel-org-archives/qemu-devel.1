Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELlM-0005NR-Mn
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELlL-0005L2-Qz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 26 May 2017 22:21:55 +0200
Message-Id: <1495830130-30611-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 14/29] qed: Make qed_aio_read_data() synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Note that this code is generally not running in coroutine context, so
this is an actual blocking synchronous operation. We'll fix this in a
moment.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index e9417d0..0972936 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1325,9 +1325,11 @@ static void qed_aio_read_data(void *opaque, int ret,
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-    bdrv_aio_readv(bs->file, offset / BDRV_SECTOR_SIZE,
-                   &acb->cur_qiov, acb->cur_qiov.size / BDRV_SECTOR_SIZE,
-                   qed_aio_next_io_cb, acb);
+    ret = bdrv_preadv(bs->file, offset, &acb->cur_qiov);
+    if (ret < 0) {
+        goto err;
+    }
+    qed_aio_next_io(acb, 0);
     return;
 
 err:
-- 
1.8.3.1
