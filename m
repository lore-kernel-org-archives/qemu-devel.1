Received: from eggs.gnu.org ([2001:4830:134:3::10]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPsu-0000Zy-3J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPsp-00005t-8h
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPsp-00005e-1t
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:37:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:32:51 +0100
Message-Id: <20170718103251.20657-2-berrange@redhat.com>
In-Reply-To: <20170718103251.20657-1-berrange@redhat.com>
References: <20170718103251.20657-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/1] io: simplify
 qio_channel_attach_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

If properly preceded by qio_channel_detach_aio_context, this function really
has nothing to do except setting ioc->ctx.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/io/channel.c b/io/channel.c
index cdf74540c1..1cfb8b33a2 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -279,15 +279,9 @@ static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
 void qio_channel_attach_aio_context(QIOChannel *ioc,
                                     AioContext *ctx)
 {
-    AioContext *old_ctx;
-    if (ioc->ctx == ctx) {
-        return;
-    }
-
-    old_ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
-    qio_channel_set_aio_fd_handler(ioc, old_ctx, NULL, NULL, NULL);
+    assert(!ioc->read_coroutine);
+    assert(!ioc->write_coroutine);
     ioc->ctx = ctx;
-    qio_channel_set_aio_fd_handlers(ioc);
 }
 
 void qio_channel_detach_aio_context(QIOChannel *ioc)
-- 
2.13.0
