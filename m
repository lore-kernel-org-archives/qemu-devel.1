Received: from eggs.gnu.org ([2001:4830:134:3::10]:36651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQrAh-00009W-VE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQrAe-0007rQ-U4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:53:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eQrAe-0007qp-N5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:53:12 -0500
Received: by mail-wm0-x244.google.com with SMTP id g75so27737966wme.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 00:53:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Dec 2017 09:53:08 +0100
Message-Id: <20171218085308.23241-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] io: fix QIONetListener memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The sources array does not escape out of qio_net_listener_wait_client, so
we have to free it.

Reported by Coverity.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 io/net-listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 77a4e2831c..de38dfae99 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -234,6 +234,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     for (i = 0; i < listener->nsioc; i++) {
         g_source_unref(sources[i]);
     }
+    g_free(sources);
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
 
-- 
2.14.3
