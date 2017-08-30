Received: from eggs.gnu.org ([2001:4830:134:3::10]:53157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Om-0001xL-Mp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ol-0001ch-Nh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:08 -0500
Message-Id: <20170830180711.7974-9-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] nbd/client: fix nbd_send_request to
 return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix nbd_send_request to return int, as it returns a return value
of nbd_write (which is int), and the only user of nbd_send_request's
return value (nbd_co_send_request) consider it as int too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170804151440.320927-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
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
index f8c213bc96..68a0bc1ffc 100644
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
2.13.5
