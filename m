Received: from eggs.gnu.org ([2001:4830:134:3::10]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLY-0000Jq-4u
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLX-0007RS-B4
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:02 +0200
Message-Id: <1498234919-27316-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/61] block: count bdrv_co_rw_vmstate() requests
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Call bdrv_inc/dec_in_flight() for vmstate reads/writes.  This seems
unnecessary at first glance because vmstate reads/writes are done
synchronously while the guest is stopped.  But we need the bdrv_wakeup()
in bdrv_dec_in_flight() so the main loop sees request completion.
Besides, it's cleaner to count vmstate reads/writes like ordinary
read/write requests.

The bdrv_wakeup() partially fixes a 'savevm' hang with -object iothread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 91611ff..684ea46 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1980,17 +1980,24 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv = bs->drv;
+    int ret = -ENOTSUP;
+
+    bdrv_inc_in_flight(bs);
 
     if (!drv) {
-        return -ENOMEDIUM;
+        ret = -ENOMEDIUM;
     } else if (drv->bdrv_load_vmstate) {
-        return is_read ? drv->bdrv_load_vmstate(bs, qiov, pos)
-                       : drv->bdrv_save_vmstate(bs, qiov, pos);
+        if (is_read) {
+            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
+        } else {
+            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
+        }
     } else if (bs->file) {
-        return bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
     }
 
-    return -ENOTSUP;
+    bdrv_dec_in_flight(bs);
+    return ret;
 }
 
 static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
-- 
1.8.3.1
