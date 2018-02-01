Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ehFEO-0001sz-Kj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ehFEM-0006V6-34
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:48:48 -0500
Received: from mail-eopbgr30105.outbound.protection.outlook.com
	([40.107.3.105]:60643
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ehFEK-0006Tr-RT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:48:46 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Thu,  1 Feb 2018 16:48:31 +0300
Message-Id: <20180201134831.17709-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] tests/test-filter-redirector: move close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com

Since we have separate handler on POLLHUP, which drops data
after closing the connection we need to fix this test, because
it sends data and instantly close the socket creating race condition.
In some cases on other end of socket client closes it faster than
reads data. To prevent it I suggest to close socket after recieving.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
 tests/test-filter-redirector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index f2566144cf..fbaf19bbd8 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -186,7 +186,6 @@ static void test_redirector_rx(void)
 
     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
-    close(send_sock);
 
     ret = qemu_recv(backend_sock[0], &len, sizeof(len), 0);
     g_assert_cmpint(ret, ==, sizeof(len));
@@ -197,6 +196,7 @@ static void test_redirector_rx(void)
     ret = qemu_recv(backend_sock[0], recv_buf, len, 0);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
+    close(send_sock);
     g_free(recv_buf);
     unlink(sock_path0);
     unlink(sock_path1);
-- 
2.14.3
