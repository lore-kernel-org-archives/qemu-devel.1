Received: from eggs.gnu.org ([2001:4830:134:3::10]:59014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqslP-0007FY-7S
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqslL-0007F2-6S
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:46:11 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cqslK-0007ET-ER
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:46:07 -0400
From: Wang Guang <wang.guang55@zte.com.cn>
Date: Thu, 23 Mar 2017 10:53:47 +0800
Message-Id: <1490237627-31312-1-git-send-email-wang.guang55@zte.com.cn>
Subject: [Qemu-devel] [Resend PATCH] migration: Fix colo hang in
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
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn, wang.liang82@zte.com.cn, Wang Guang <wang.guang55@zte.com.cn>

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
index f546c68..8344da4 100644
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
