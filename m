Received: from eggs.gnu.org ([2001:4830:134:3::10]:41541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fIahp-0000ap-BW
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fIahk-0007aD-JG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:13:33 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Tue, 15 May 2018 20:00:43 +0800
Message-ID: <1526385643-69675-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] iothread: fix epollfd leak in the process of
 delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, eblake@redhat.com, peterx@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

When we call addIOThread, the epollfd created in aio_context_setup,
but not close it in the process of delIOThread, so the epollfd will leak.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 iothread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/iothread.c b/iothread.c
index aff1281..23ac0a8 100644
--- a/iothread.c
+++ b/iothread.c
@@ -128,6 +128,7 @@ static void iothread_instance_finalize(Object *obj)
      * GSources first before destroying any GMainContext.
      */
     if (iothread->ctx) {
+        close(iothread->ctx->epollfd);
         aio_context_unref(iothread->ctx);
         iothread->ctx = NULL;
     }
-- 
1.8.3.1
