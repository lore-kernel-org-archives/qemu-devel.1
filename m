Received: from eggs.gnu.org ([2001:4830:134:3::10]:36813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzSd8-0002BV-6v
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzSd2-000614-7m
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dzSd2-00060a-1C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  3 Oct 2017 15:12:27 -0400
Message-Id: <20171003191227.11845-6-stefanha@redhat.com>
In-Reply-To: <20171003191227.11845-1-stefanha@redhat.com>
References: <20171003191227.11845-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] aio: fix assert when remove poll during
 destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>

After iothread is enabled internally inside QEMU with GMainContext, we
may encounter this warning when destroying the iothread:

(qemu-system-x86_64:19925): GLib-CRITICAL **: g_source_remove_poll:
 assertion '!SOURCE_DESTROYED (source)' failed

The problem is that g_source_remove_poll() does not allow to remove one
source from array if the source is detached from its owner
context. (peterx: which IMHO does not make much sense)

Fix it on QEMU side by avoid calling g_source_remove_poll() if we know
the object is during destruction, and we won't leak anything after all
since the array will be gone soon cleanly even with that fd.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20170928025958.1420-6-peterx@redhat.com
[peterx: write the commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2d51239ec6..5946ac09f0 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -223,7 +223,14 @@ void aio_set_fd_handler(AioContext *ctx,
             return;
         }
 
-        g_source_remove_poll(&ctx->source, &node->pfd);
+        /* If the GSource is in the process of being destroyed then
+         * g_source_remove_poll() causes an assertion failure.  Skip
+         * removal in that case, because glib cleans up its state during
+         * destruction anyway.
+         */
+        if (!g_source_is_destroyed(&ctx->source)) {
+            g_source_remove_poll(&ctx->source, &node->pfd);
+        }
 
         /* If the lock is held, just mark the node as deleted */
         if (qemu_lockcnt_count(&ctx->list_lock)) {
-- 
2.13.6
