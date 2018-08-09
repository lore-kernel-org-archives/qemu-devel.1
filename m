Received: from eggs.gnu.org ([2001:4830:134:3::10]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fnkuP-0007iw-NU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fnkuO-0002U8-OT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  9 Aug 2018 21:22:58 +0800
Message-Id: <20180809132259.18402-2-famz@redhat.com>
In-Reply-To: <20180809132259.18402-1-famz@redhat.com>
References: <20180809132259.18402-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] aio-posix: Don't count ctx->notifier as
 progress when polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, lersek@redhat.com

The same logic exists in fd polling. This change is especially important
to avoid busy loop once we limit aio_notify_accept() to blocking
aio_poll().

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/aio-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 118bf5784b..b5c7f463aa 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -494,7 +494,8 @@ static bool run_poll_handlers_once(AioContext *ctx)
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (!node->deleted && node->io_poll &&
             aio_node_check(ctx, node->is_external) &&
-            node->io_poll(node->opaque)) {
+            node->io_poll(node->opaque) &&
+            node->opaque != &ctx->notifier) {
             progress = true;
         }
 
-- 
2.17.1
