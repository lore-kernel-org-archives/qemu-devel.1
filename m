Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QI-37
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000QC-Sz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21678 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAm-0000NG-1M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:44 +0300
Message-Id: <20170530143052.165002-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/19] io/channel-socket:
 qio_channel_socket_writev handle EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Return QIO_CHANNEL_ERR_EPIPE on EPIPE, we will need it to improve error
path in nbd server.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/io/channel.h | 1 +
 io/channel-socket.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5d48906998..5529c2da31 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -38,6 +38,7 @@ typedef struct QIOChannel QIOChannel;
 typedef struct QIOChannelClass QIOChannelClass;
 
 #define QIO_CHANNEL_ERR_BLOCK -2
+#define QIO_CHANNEL_ERR_EPIPE -3
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7ba3..50f9f966c6 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -542,7 +542,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
         }
         error_setg_errno(errp, errno,
                          "Unable to write to socket");
-        return -1;
+        return errno == EPIPE ? QIO_CHANNEL_ERR_EPIPE : -1;
     }
     return ret;
 }
-- 
2.11.1
