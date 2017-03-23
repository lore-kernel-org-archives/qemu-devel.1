Received: from eggs.gnu.org ([2001:4830:134:3::10]:40030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqwf5-00083v-9y
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqwf1-0002QV-OK
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:55:55 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:57228)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqwf1-0002Md-4m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:55:51 -0400
From: Guang Wang <wang.guang55@zte.com.cn>
Date: Fri, 24 Mar 2017 07:14:23 +0800
Message-Id: <1490310863-12890-1-git-send-email-wang.guang55@zte.com.cn>
Subject: [Qemu-devel] [PATCH RESEND] migration: Fix colo hang in
 socket_accept_incoming_migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, Wang guang <wang.guang55@zte.com.cn>

From: Wang guang <wang.guang55@zte.com.cn>

Due to the feature of accept channel does not support QIO_CHANNEL_FEATURE_SHUTDOWN.
when failover,channel_shutdown could not shut down the channel.
So the colo_process_incoming_thread will hang at recvmsg.
This patch just call qio_channel_socket_new to get channel,
Which set QIO_CHANNEL_FEATURE_SHUTDOWN already.

Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 io/channel-socket.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

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
-- 
1.8.3.1
