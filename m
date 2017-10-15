Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz8-0006bt-BT
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz7-0003pz-8e
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:29 -0500
Message-Id: <20171015004033.3248-6-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] nbd/server: structurize simple reply header
 sending
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

Use packed structure instead of pointer arithmetics.

Also, merge two redundant traces into one.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171012095319.136610-5-vsementsov@virtuozzo.com>
[eblake: tweak and mention impact on traces, fix errp usage]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  6 ++++++
 nbd/server.c        | 37 ++++++++++++++-----------------------
 nbd/trace-events    |  1 -
 3 files changed, 20 insertions(+), 24 deletions(-)

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
index ea2f0fa476..4f765ba992 100644
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
@@ -1208,24 +1188,35 @@ void nbd_export_close_all(void)
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
+    int nbd_err = system_errno_to_nbd_errno(reply->error);
     int ret;

     g_assert(qemu_in_coroutine());

-    trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
+    trace_nbd_co_send_simple_reply(reply->handle, nbd_err, len);
+    set_be_simple_reply(&simple_reply, nbd_err, reply->handle);

     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();

     if (!len) {
-        ret = nbd_send_reply(client->ioc, reply, errp);
+        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), errp);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        ret = nbd_send_reply(client->ioc, reply, errp);
+        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), errp);
         if (ret == 0) {
             ret = nbd_write(client->ioc, req->data, len, errp);
             if (ret < 0) {
diff --git a/nbd/trace-events b/nbd/trace-events
index 4d6f86c2d4..e27614f050 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -51,7 +51,6 @@ nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_success(void) "Negotiation succeeded"
 nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
-nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .error = %" PRId32 ", handle = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
-- 
2.13.6
