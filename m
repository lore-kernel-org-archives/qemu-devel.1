Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDQ-00013Z-7s
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDP-00080I-Dx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 19 May 2017 11:32:44 +0100
Message-Id: <20170519103247.4405-2-stefanha@redhat.com>
In-Reply-To: <20170519103247.4405-1-stefanha@redhat.com>
References: <20170519103247.4405-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] block: count bdrv_co_rw_vmstate()
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 block/io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index fdd7485..cc56e90 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1988,17 +1988,24 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
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
2.9.3
