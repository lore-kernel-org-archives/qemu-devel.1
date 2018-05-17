Received: from eggs.gnu.org ([2001:4830:134:3::10]:42743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fJAgu-0004Hy-Vn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fJAgu-0002BK-5a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:39:01 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Thu, 17 May 2018 10:26:17 +0800
Message-ID: <1526523977-73930-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 2/2] iothread: let aio_epoll_disable fit to
 aio_context_destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, peterx@redhat.com, stefanha@redhat.com, eblake@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com, wangjie88@huawei.com

epoll_available will only be set if epollfd != -1, os we
can swap the two variables in aio_epoll_disable, and
aio_context_destroy can call aio_epoll_disable directly.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 util/aio-posix.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 0ade2c7..118bf57 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -45,11 +45,11 @@ struct AioHandler
 
 static void aio_epoll_disable(AioContext *ctx)
 {
-    ctx->epoll_available = false;
-    if (!ctx->epoll_enabled) {
+    ctx->epoll_enabled = false;
+    if (!ctx->epoll_available) {
         return;
     }
-    ctx->epoll_enabled = false;
+    ctx->epoll_available = false;
     close(ctx->epollfd);
 }
 
@@ -716,9 +716,7 @@ void aio_context_setup(AioContext *ctx)
 void aio_context_destroy(AioContext *ctx)
 {
 #ifdef CONFIG_EPOLL_CREATE1
-    if (ctx->epollfd >= 0) {
-        close(ctx->epollfd);
-    }
+    aio_epoll_disable(ctx);
 #endif
 }
 
-- 
1.8.3.1
