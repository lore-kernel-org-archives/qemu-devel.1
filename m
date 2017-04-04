Received: from eggs.gnu.org ([2001:4830:134:3::10]:40160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQG3-0007CK-A2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQG1-0005ho-Tw
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvQG1-0005hS-MZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:33 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  4 Apr 2017 16:20:10 +0100
Message-Id: <20170404152011.16119-2-berrange@redhat.com>
In-Reply-To: <20170404152011.16119-1-berrange@redhat.com>
References: <20170404152011.16119-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/2] io: fix incoming client socket
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wang guang <wang.guang55@zte.com.cn>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Wang guang <wang.guang55@zte.com.cn>

The channel socket was initialized manually, but forgot to set
QIO_CHANNEL_FEATURE_SHUTDOWN. Thus, the colo_process_incoming_thread
would hang at recvmsg. This patch just call qio_channel_socket_new to
get channel, Which set QIO_CHANNEL_FEATURE_SHUTDOWN already.

Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-socket.c            | 8 +-------
 tests/test-io-channel-socket.c | 8 ++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index f546c68..64b36f5 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -331,16 +331,10 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
 {
     QIOChannelSocket *cioc;
 
-    cioc = QIO_CHANNEL_SOCKET(object_new(TYPE_QIO_CHANNEL_SOCKET));
-    cioc->fd = -1;
+    cioc = qio_channel_socket_new();
     cioc->remoteAddrLen = sizeof(ioc->remoteAddr);
     cioc->localAddrLen = sizeof(ioc->localAddr);
 
-#ifdef WIN32
-    QIO_CHANNEL(cioc)->event = CreateEvent(NULL, FALSE, FALSE, NULL);
-#endif
-
-
  retry:
     trace_qio_channel_socket_accept(ioc);
     cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index aaa9116..c5c1314 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -234,6 +234,8 @@ static void test_io_channel(bool async,
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PASS));
         g_assert(!passFD ||
                  qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_FD_PASS));
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
 
         test = qio_channel_test_new();
         qio_channel_test_run_threads(test, true, src, dst);
@@ -248,6 +250,8 @@ static void test_io_channel(bool async,
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PASS));
         g_assert(!passFD ||
                  qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_FD_PASS));
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
 
         test = qio_channel_test_new();
         qio_channel_test_run_threads(test, false, src, dst);
@@ -262,6 +266,8 @@ static void test_io_channel(bool async,
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PASS));
         g_assert(!passFD ||
                  qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_FD_PASS));
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
 
         test = qio_channel_test_new();
         qio_channel_test_run_threads(test, true, src, dst);
@@ -276,6 +282,8 @@ static void test_io_channel(bool async,
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PASS));
         g_assert(!passFD ||
                  qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_FD_PASS));
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
 
         test = qio_channel_test_new();
         qio_channel_test_run_threads(test, false, src, dst);
-- 
2.9.3
