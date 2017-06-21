Received: from eggs.gnu.org ([2001:4830:134:3::10]:50422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheN-0007vj-H4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheI-0008Qa-GN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43174 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dNheI-0008Ow-4Y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Jun 2017 18:34:21 +0300
Message-Id: <20170621153424.16690-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-1-vsementsov@virtuozzo.com>
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/6] nbd/server: add errp to nbd_send_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index fa493602dd..0671ebc50a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -693,7 +693,7 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     return 0;
 }
 
-static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
+static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     uint8_t buf[NBD_REPLY_SIZE];
 
@@ -712,7 +712,7 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
-    return nbd_write(ioc, buf, sizeof(buf), NULL);
+    return nbd_write(ioc, buf, sizeof(buf), errp);
 }
 
 #define MAX_NBD_REQUESTS 16
@@ -999,7 +999,8 @@ void nbd_export_close_all(void)
     }
 }
 
-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
+static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
+                             Error **errp)
 {
     NBDClient *client = req->client;
     int ret;
@@ -1009,12 +1010,12 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
     client->send_coroutine = qemu_coroutine_self();
 
     if (!len) {
-        ret = nbd_send_reply(client->ioc, reply);
+        ret = nbd_send_reply(client->ioc, reply, errp);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        ret = nbd_send_reply(client->ioc, reply);
+        ret = nbd_send_reply(client->ioc, reply, errp);
         if (ret == 0) {
-            ret = nbd_write(client->ioc, req->data, len, NULL);
+            ret = nbd_write(client->ioc, req->data, len, errp);
             if (ret < 0) {
                 ret = -EIO;
             }
@@ -1266,8 +1267,8 @@ reply:
         local_err = NULL;
     }
 
-    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
-        error_setg(&local_err, "Failed to send reply");
+    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
+        error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }
 
-- 
2.11.1
