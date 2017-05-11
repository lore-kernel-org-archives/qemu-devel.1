Received: from eggs.gnu.org ([2001:4830:134:3::10]:37002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAd-0002WA-Eg
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAc-0007h1-D5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:39 +0200
Message-Id: <1494513181-7900-37-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 36/58] blockdev: use drained_begin/end for
 qmp_block_resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1447551

If one tries to issue a block_resize while a guest is busy
accessing the disk, it is possible that qemu may deadlock
when invoking aio_poll from both the main loop and the iothread.

Replace another instance of bdrv_drain_all that doesn't
quite belong.

Cc: qemu-stable@nongnu.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 0d3773b..c63f4e8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2923,10 +2923,9 @@ void qmp_block_resize(bool has_device, const char *device,
         goto out;
     }
 
-    /* complete all in-flight operations before resizing the device */
-    bdrv_drain_all();
-
+    bdrv_drained_begin(bs);
     ret = blk_truncate(blk, size, errp);
+    bdrv_drained_end(bs);
 
 out:
     blk_unref(blk);
-- 
1.8.3.1
