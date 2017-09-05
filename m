Received: from eggs.gnu.org ([2001:4830:134:3::10]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD91-0004Wt-Gu
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD8s-0000AQ-0C
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpD8r-00009E-R5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:45 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 13:39:35 +0100
Message-Id: <20170905123935.26645-6-berrange@redhat.com>
In-Reply-To: <20170905123935.26645-1-berrange@redhat.com>
References: <20170905123935.26645-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 5/5] io: fix check for handshake completion
 in TLS test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The TLS I/O channel test had mistakenly used && instead
of || when checking for handshake completion. As a
result it could terminate the handshake process before
it had actually completed. This was harmless before but
changes in GNUTLS 3.6.0 exposed this bug and caused the
test suite to fail.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-io-channel-tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index ff96877323..a210d01ba5 100644
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
