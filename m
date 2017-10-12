Received: from eggs.gnu.org ([2001:4830:134:3::10]:35440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FV-4b
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBE-0000Gj-V6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26996 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBE-0000DR-Jh
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:10 +0300
Message-Id: <20171012095319.136610-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 04/13] nbd/server: structurize simple reply
 header sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Use packed structure instead of pointer arithmetics.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  6 ++++++
 nbd/server.c        | 36 ++++++++++++++----------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 707fd37575..49008980f4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -63,6 +63,12 @@ struct NBDReply {
 };
 typedef struct NBDReply NBDReply;
 
+typedef struct NBDSimpleReply {
+    uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
+    uint32_t error;
+    uint64_t handle;
+} QEMU_PACKED NBDSimpleReply;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
diff --git a/nbd/server.c b/nbd/server.c
index bc7f9f0fd6..43ade30ba3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -902,26 +902,6 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     return 0;
 }
 
-static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
-{
-    uint8_t buf[NBD_REPLY_SIZE];
-
-    reply->error = system_errno_to_nbd_errno(reply->error);
-
-    trace_nbd_send_reply(reply->error, reply->handle);
-
-    /* Reply
-       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
-       [ 4 ..  7]    error   (0 == no error)
-       [ 7 .. 15]    handle
-     */
-    stl_be_p(buf, NBD_SIMPLE_REPLY_MAGIC);
-    stl_be_p(buf + 4, reply->error);
-    stq_be_p(buf + 8, reply->handle);
-
-    return nbd_write(ioc, buf, sizeof(buf), errp);
-}
-
 #define MAX_NBD_REQUESTS 16
 
 void nbd_client_get(NBDClient *client)
@@ -1208,24 +1188,36 @@ void nbd_export_close_all(void)
     }
 }
 
+static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
+                                       uint64_t handle)
+{
+    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
+    stl_be_p(&reply->error, error);
+    stq_be_p(&reply->handle, handle);
+}
+
 static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
                                     int len, Error **errp)
 {
     NBDClient *client = req->client;
+    NBDSimpleReply simple_reply;
     int ret;
 
     g_assert(qemu_in_coroutine());
 
     trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
 
+    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(reply->error),
+                        reply->handle);
+
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
 
     if (!len) {
-        ret = nbd_send_reply(client->ioc, reply, errp);
+        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), NULL);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        ret = nbd_send_reply(client->ioc, reply, errp);
+        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), NULL);
         if (ret == 0) {
             ret = nbd_write(client->ioc, req->data, len, errp);
             if (ret < 0) {
-- 
2.11.1
