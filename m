Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjYw-0005xR-8Y
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjYs-0004af-3z
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmjYr-0004ZD-Se
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:40:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1BD4ACBD
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:40:20 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 29 Aug 2017 17:40:17 +0100
Message-Id: <20170829164017.14178-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] io: fix check for handshake completion in TLS
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The TLS I/O channel test had mistakenly used && instead
of || when checking for handshake completion. As a
result it could terminate the handshake process before
it had actually completed. This was harmless before but
changes in GNUTLS 3.6.0 exposed this bug and caused the
test suite to fail.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-io-channel-tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 8eaa208e1b..e7c80f46cf 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -218,7 +218,7 @@ static void test_io_channel_tls(const void *opaque)
     mainloop = g_main_context_default();
     do {
         g_main_context_iteration(mainloop, TRUE);
-    } while (!clientHandshake.finished &&
+    } while (!clientHandshake.finished ||
              !serverHandshake.finished);
 
     g_assert(clientHandshake.failed == data->expectClientFail);
-- 
2.13.5
