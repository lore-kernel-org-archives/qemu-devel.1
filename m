Received: from eggs.gnu.org ([2001:4830:134:3::10]:35444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FY-5j
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBF-0000HH-2f
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34797 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBE-0000DZ-JT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:09 +0300
Message-Id: <20171012095319.136610-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 03/13] nbd: rename some simple-request
 related objects to be _simple_
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

To be consistent when their _structured_analogs will be introduced.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/nbd-internal.h                       |  2 +-
 nbd/client.c                             |  4 ++--
 nbd/server.c                             | 12 ++++++------
 nbd/trace-events                         |  2 +-
 tests/qemu-iotests/nbd-fault-injector.py |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 8a609a227f..2d6663de23 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -47,7 +47,7 @@
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
 
 #define NBD_REQUEST_MAGIC       0x25609513
-#define NBD_REPLY_MAGIC         0x67446698
+#define NBD_SIMPLE_REPLY_MAGIC  0x67446698
 #define NBD_OPTS_MAGIC          0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC        0x0000420281861253LL
 #define NBD_REP_MAGIC           0x0003e889045565a9LL
diff --git a/nbd/client.c b/nbd/client.c
index 68a0bc1ffc..cd5a2c80ac 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -931,7 +931,7 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     }
 
     /* Reply
-       [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
+       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
        [ 7 .. 15]    handle
      */
@@ -949,7 +949,7 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     }
     trace_nbd_receive_reply(magic, reply->error, reply->handle);
 
-    if (magic != NBD_REPLY_MAGIC) {
+    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
diff --git a/nbd/server.c b/nbd/server.c
index 993ade30bb..bc7f9f0fd6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -911,11 +911,11 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     trace_nbd_send_reply(reply->error, reply->handle);
 
     /* Reply
-       [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
+       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
        [ 7 .. 15]    handle
      */
-    stl_be_p(buf, NBD_REPLY_MAGIC);
+    stl_be_p(buf, NBD_SIMPLE_REPLY_MAGIC);
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
@@ -1208,15 +1208,15 @@ void nbd_export_close_all(void)
     }
 }
 
-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
-                             Error **errp)
+static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
+                                    int len, Error **errp)
 {
     NBDClient *client = req->client;
     int ret;
 
     g_assert(qemu_in_coroutine());
 
-    trace_nbd_co_send_reply(reply->handle, reply->error, len);
+    trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
 
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
@@ -1465,7 +1465,7 @@ reply:
         local_err = NULL;
     }
 
-    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
+    if (nbd_co_send_simple_reply(req, &reply, reply_data_len, &local_err) < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }
diff --git a/nbd/trace-events b/nbd/trace-events
index 48a4f27682..c5f2d97be2 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -54,7 +54,7 @@ nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from
 nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .error = %" PRId32 ", handle = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
-nbd_co_send_reply(uint64_t handle, uint32_t error, int len) "Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
+nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len) "Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 1c10dcb51c..8a04d979aa 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -56,7 +56,7 @@ NBD_CMD_READ = 0
 NBD_CMD_WRITE = 1
 NBD_CMD_DISC = 2
 NBD_REQUEST_MAGIC = 0x25609513
-NBD_REPLY_MAGIC = 0x67446698
+NBD_SIMPLE_REPLY_MAGIC = 0x67446698
 NBD_PASSWD = 0x4e42444d41474943
 NBD_OPTS_MAGIC = 0x49484156454F5054
 NBD_CLIENT_MAGIC = 0x0000420281861253
@@ -166,7 +166,7 @@ def read_request(conn):
     return req
 
 def write_reply(conn, error, handle):
-    buf = reply_struct.pack(NBD_REPLY_MAGIC, error, handle)
+    buf = reply_struct.pack(NBD_SIMPLE_REPLY_MAGIC, error, handle)
     conn.send(buf, event='reply')
 
 def handle_connection(conn, use_export):
-- 
2.11.1
