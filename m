Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UP-Cs
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJK-0007CZ-Pr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:44736 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-00077Z-CE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:26 +0300
Message-Id: <20170804151440.320927-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 03/17] nbd/client: refactor nbd_receive_reply
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

Refactor nbd_receive_reply to return 1 on success, 0 on eof, when no
data was read and <0 for other cases, because returned size of read
data is not actually used.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  2 +-
 nbd/client.c        | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 9c3d0a5868..f7450608b4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -164,7 +164,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
+int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 
diff --git a/nbd/client.c b/nbd/client.c
index 4556056daa..a1758a1931 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -914,11 +914,16 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     return nbd_write(ioc, buf, sizeof(buf), NULL);
 }
 
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
+/* nbd_receive_reply
+ * Returns 1 on success
+ *         0 on eof, when no data was read from @ioc (errp is not set)
+ *         < 0 on fail
+ */
+int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     uint8_t buf[NBD_REPLY_SIZE];
     uint32_t magic;
-    ssize_t ret;
+    int ret;
 
     ret = nbd_read_eof(ioc, buf, sizeof(buf), errp);
     if (ret <= 0) {
@@ -948,6 +953,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
-    return sizeof(buf);
+
+    return 1;
 }
 
-- 
2.11.1
