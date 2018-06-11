Received: from eggs.gnu.org ([2001:4830:134:3::10]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fSIz7-0003nn-5R
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fSIz6-0006L0-F1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:19:33 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Mon, 11 Jun 2018 15:04:07 +0800
Message-ID: <1528700647-58638-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] util/async: avoid NULL pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, eblake@redhat.com, eric.fangyi@huawei.com, wu.wubin@huawei.com, wangjie88@huawei.com

if laio_init create linux_aio failed and return NULL, NULL pointer
dereference will occur when laio_attach_aio_context dereference
linux_aio in aio_get_linux_aio, so add assert to avoid it.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 util/async.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/async.c b/util/async.c
index 03f62787f2..7766bcd8bc 100644
--- a/util/async.c
+++ b/util/async.c
@@ -327,6 +327,7 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 {
     if (!ctx->linux_aio) {
         ctx->linux_aio = laio_init();
+        assert(ctx->linux_aio);
         laio_attach_aio_context(ctx->linux_aio, ctx);
     }
     return ctx->linux_aio;
-- 
2.15.0.windows.1
