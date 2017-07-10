Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaY-0001fH-Td
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaX-0002cE-TV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:28 -0500
Message-Id: <20170710121434.5047-6-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] nbd/server: add errp to nbd_send_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707152918.23086-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 00a7c60..e3fd0ca 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -687,7 +687,7 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     return 0;
 }

-static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
+static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     uint8_t buf[NBD_REPLY_SIZE];

@@ -706,7 +706,7 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);

-    return nbd_write(ioc, buf, sizeof(buf), NULL);
+    return nbd_write(ioc, buf, sizeof(buf), errp);
 }

 #define MAX_NBD_REQUESTS 16
@@ -993,7 +993,8 @@ void nbd_export_close_all(void)
     }
 }

-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
+static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
+                             Error **errp)
 {
     NBDClient *client = req->client;
     int ret;
@@ -1003,12 +1004,12 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
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
@@ -1260,8 +1261,8 @@ reply:
         local_err = NULL;
     }

-    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
-        error_setg(&local_err, "Failed to send reply");
+    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
+        error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }

-- 
2.9.4
