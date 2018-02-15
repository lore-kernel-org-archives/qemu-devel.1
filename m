Received: from eggs.gnu.org ([2001:4830:134:3::10]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022m-Qd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003KI-0e
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Jg-Rn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:38 +0000
Message-Id: <20180215175044.8159-2-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] io: fix QIONetListener memory leak
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

The sources array does not escape out of qio_net_listener_wait_client, so
we have to free it.

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
