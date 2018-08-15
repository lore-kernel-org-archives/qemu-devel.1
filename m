Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFB-00070R-5q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF9-0000xD-Na
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmF9-0000vq-Ce
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:36 +0800
Message-Id: <20180815031248.14908-6-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 05/17] aio-posix: Don't count ctx->notifier as
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
Cc: Peter Maydell <peter.maydell@linaro.org>

The same logic exists in fd polling. This change is especially important
to avoid busy loop once we limit aio_notify_accept() to blocking
aio_poll().

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180809132259.18402-2-famz@redhat.com>
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
