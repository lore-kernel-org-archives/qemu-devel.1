Received: from eggs.gnu.org ([2001:4830:134:3::10]:37863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxV-0006Hp-Sh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxU-0004uP-Ty
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:09 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 24 Feb 2017 12:46:59 -0500
Message-Id: <20170224174700.30816-3-jcody@redhat.com>
In-Reply-To: <20170224174700.30816-1-jcody@redhat.com>
References: <20170224174700.30816-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] block/nfs: try to avoid the bounce buffer
 in pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: Peter Lieven <pl@kamp.de>

if the passed qiov contains exactly one iov we can
pass the buffer directly.

Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 1487349541-10201-3-git-send-email-pl@kamp.de
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/nfs.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index c11c4c9..ffb54be 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -302,30 +302,39 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
     NFSClient *client = bs->opaque;
     NFSRPC task;
     char *buf = NULL;
+    bool my_buffer = false;
 
     nfs_co_init_task(bs, &task);
 
-    buf = g_try_malloc(bytes);
-    if (bytes && buf == NULL) {
-        return -ENOMEM;
+    if (iov->niov != 1) {
+        buf = g_try_malloc(bytes);
+        if (bytes && buf == NULL) {
+            return -ENOMEM;
+        }
+        qemu_iovec_to_buf(iov, 0, buf, bytes);
+        my_buffer = true;
+    } else {
+        buf = iov->iov[0].iov_base;
     }
 
-    qemu_iovec_to_buf(iov, 0, buf, bytes);
-
     if (nfs_pwrite_async(client->context, client->fh,
                          offset, bytes, buf,
                          nfs_co_generic_cb, &task) != 0) {
+        if (my_buffer) {
+            g_free(buf);
+        }
+        return -ENOMEM;
+    }
+
+    nfs_set_events(client);
+    while (!task.complete) {
+        qemu_coroutine_yield();
+    }
+
+    if (my_buffer) {
         g_free(buf);
-        return -ENOMEM;
     }
 
-    nfs_set_events(client);
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
-
-    g_free(buf);
-
     if (task.ret != bytes) {
         return task.ret < 0 ? task.ret : -EIO;
     }
-- 
2.9.3
