Received: from eggs.gnu.org ([2001:4830:134:3::10]:56907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3gSW-0007ae-NV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3gSR-0001Qt-QF
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3gSR-0001QM-KJ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:31 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4F3B80483
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 10:15:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Apr 2017 12:15:28 +0200
Message-Id: <20170427101528.12356-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] io: simplify qio_channel_attach_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If properly preceded by qio_channel_detach_aio_context, this function really
has nothing to do except setting ioc->ctx.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.12.2
