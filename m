Received: from eggs.gnu.org ([2001:4830:134:3::10]:54300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QD-26
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000P5-3g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22448 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000Na-JE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:49 +0300
Message-Id: <20170530143052.165002-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 16/19] nbd/server: add errp to nbd_send_reply()
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3035fb6586..6c0702287e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -714,7 +714,7 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     return 0;
 }
 
-static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
+static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     uint8_t buf[NBD_REPLY_SIZE];
 
@@ -733,7 +733,7 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
-    return write_sync(ioc, buf, sizeof(buf), NULL);
+    return write_sync(ioc, buf, sizeof(buf), errp);
 }
 
 #define MAX_NBD_REQUESTS 16
@@ -1020,7 +1020,8 @@ void nbd_export_close_all(void)
     }
 }
 
-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
+static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
+                             Error **errp)
 {
     NBDClient *client = req->client;
     int ret;
@@ -1030,12 +1031,12 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
     client->send_coroutine = qemu_coroutine_self();
 
     if (!len) {
-        ret = nbd_send_reply(client->ioc, reply);
+        ret = nbd_send_reply(client->ioc, reply, errp);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        ret = nbd_send_reply(client->ioc, reply);
+        ret = nbd_send_reply(client->ioc, reply, errp);
         if (ret == 0) {
-            ret = write_sync(client->ioc, req->data, len, NULL);
+            ret = write_sync(client->ioc, req->data, len, errp);
             if (ret < 0) {
                 ret = ret;
             }
@@ -1285,8 +1286,8 @@ reply:
         local_err = NULL;
     }
 
-    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
-        error_setg(&local_err, "Failed to send reply");
+    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
+        error_prepend(&local_err, "Failed to send reply");
         goto disconnect;
     }
 
-- 
2.11.1
