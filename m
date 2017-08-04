Received: from eggs.gnu.org ([2001:4830:134:3::10]:54660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UU-SW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007Ey-RK
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14774 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-0007Ba-Eu
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:27 +0300
Message-Id: <20170804151440.320927-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Fix nbd_send_request to return int, as it returns a return value
of nbd_write (which is int), and the only user of nbd_send_request's
return value (nbd_co_send_request) consider it as int too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 2 +-
 nbd/client.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index f7450608b4..040cdd2e60 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -163,7 +163,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
-ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
+int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
diff --git a/nbd/client.c b/nbd/client.c
index a1758a1931..00cba45853 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -896,7 +896,7 @@ int nbd_disconnect(int fd)
 }
 #endif
 
-ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
+int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];
 
-- 
2.11.1
