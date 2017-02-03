Received: from eggs.gnu.org ([2001:4830:134:3::10]:36694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nX-Bg
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5i-00080f-Bj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:40088 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007xa-0N
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:41 +0300
Message-Id: <20170203154757.36140-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 02/18] nbd-server: refactor simple reply sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Rename functions appropriately and also make a separate copy of NBDReply
- NBDSimpleReply, to replace NBDReply for the server. NBDReply itself
will be upgraded in future patches to handle both simple and structured
replies in the client.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  7 +++++++
 nbd/server.c        | 25 +++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3e373f0498..3c65cf8d87 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -63,6 +63,13 @@ struct NBDReply {
 };
 typedef struct NBDReply NBDReply;
 
+struct NBDSimpleReply {
+    /* uint32_t NBD_SIMPLE_REPLY_MAGIC */
+    uint64_t handle;
+    uint32_t error;
+};
+typedef struct NBDSimpleReply NBDSimpleReply;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
diff --git a/nbd/server.c b/nbd/server.c
index b63a8b85e3..4cfc02123b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -738,7 +738,7 @@ static ssize_t nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
     return 0;
 }
 
-static ssize_t nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
+static ssize_t nbd_send_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply)
 {
     uint8_t buf[NBD_REPLY_SIZE];
     ssize_t ret;
@@ -1036,8 +1036,8 @@ void nbd_export_close_all(void)
     }
 }
 
-static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
-                                 int len)
+static ssize_t nbd_co_send_simple_reply(NBDRequestData *req,
+                                        NBDSimpleReply *reply, int len)
 {
     NBDClient *client = req->client;
     ssize_t rc, ret;
@@ -1048,10 +1048,10 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
     nbd_set_handlers(client);
 
     if (!len) {
-        rc = nbd_send_reply(client->ioc, reply);
+        rc = nbd_send_simple_reply(client->ioc, reply);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        rc = nbd_send_reply(client->ioc, reply);
+        rc = nbd_send_simple_reply(client->ioc, reply);
         if (rc >= 0) {
             ret = write_sync(client->ioc, req->data, len);
             if (ret != len) {
@@ -1174,7 +1174,7 @@ static void nbd_trip(void *opaque)
     NBDExport *exp = client->exp;
     NBDRequestData *req;
     NBDRequest request;
-    NBDReply reply;
+    NBDSimpleReply reply;
     ssize_t ret;
     int flags;
 
@@ -1231,8 +1231,9 @@ static void nbd_trip(void *opaque)
         }
 
         TRACE("Read %" PRIu32" byte(s)", request.len);
-        if (nbd_co_send_reply(req, &reply, request.len) < 0)
+        if (nbd_co_send_simple_reply(req, &reply, request.len) < 0) {
             goto out;
+        }
         break;
     case NBD_CMD_WRITE:
         TRACE("Request type is WRITE");
@@ -1257,7 +1258,7 @@ static void nbd_trip(void *opaque)
             goto error_reply;
         }
 
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
+        if (nbd_co_send_simple_reply(req, &reply, 0) < 0) {
             goto out;
         }
         break;
@@ -1288,7 +1289,7 @@ static void nbd_trip(void *opaque)
             goto error_reply;
         }
 
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
+        if (nbd_co_send_simple_reply(req, &reply, 0) < 0) {
             goto out;
         }
         break;
@@ -1305,7 +1306,7 @@ static void nbd_trip(void *opaque)
             LOG("flush failed");
             reply.error = -ret;
         }
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
+        if (nbd_co_send_simple_reply(req, &reply, 0) < 0) {
             goto out;
         }
         break;
@@ -1317,7 +1318,7 @@ static void nbd_trip(void *opaque)
             LOG("discard failed");
             reply.error = -ret;
         }
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
+        if (nbd_co_send_simple_reply(req, &reply, 0) < 0) {
             goto out;
         }
         break;
@@ -1328,7 +1329,7 @@ static void nbd_trip(void *opaque)
         /* We must disconnect after NBD_CMD_WRITE if we did not
          * read the payload.
          */
-        if (nbd_co_send_reply(req, &reply, 0) < 0 || !req->complete) {
+        if (nbd_co_send_simple_reply(req, &reply, 0) < 0 || !req->complete) {
             goto out;
         }
         break;
-- 
2.11.0
