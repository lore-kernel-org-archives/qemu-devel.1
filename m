Received: from eggs.gnu.org ([2001:4830:134:3::10]:45105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSk-0004wj-0d
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSi-0005Bk-TB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSi-0005BS-M9
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:56 -0500
Received: by mail-wr0-x241.google.com with SMTP id y3so21002549wrh.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:57 +0100
Message-Id: <1517858941-5538-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/47] tests/test-filter-redirector: move close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Klim Kireev <klim.kireev@virtuozzo.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

Since we have separate handler on POLLHUP, which drops data
after closing the connection we need to fix this test, because
it sends data and instantly close the socket creating race condition.
In some cases on other end of socket client closes it faster than
reads data. To prevent it I suggest to close socket after recieving.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Message-Id: <20180201134831.17709-1-klim.kireev@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-filter-redirector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index f256614..fbaf19b 100644
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
1.8.3.1
