Received: from eggs.gnu.org ([2001:4830:134:3::10]:54840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXai-0001q7-7E
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXag-0002jw-UU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:15:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:33 -0500
Message-Id: <20170710121434.5047-11-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] nbd: refactor tracing
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

Reorganize traces: move, reword, add information, drop extra ones.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170707152918.23086-10-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c |  3 ---
 nbd/server.c | 30 +++++++++---------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 2125321..1ae4ff8 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -489,12 +489,10 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         TRACE("Global flags are %" PRIx32, globalflags);
         if (globalflags & NBD_FLAG_FIXED_NEWSTYLE) {
             fixedNewStyle = true;
-            TRACE("Server supports fixed new style");
             clientflags |= NBD_FLAG_C_FIXED_NEWSTYLE;
         }
         if (globalflags & NBD_FLAG_NO_ZEROES) {
             zeroes = false;
-            TRACE("Server supports no zeroes");
             clientflags |= NBD_FLAG_C_NO_ZEROES;
         }
         /* client requested flags */
@@ -565,7 +563,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
         *size = be64_to_cpu(s);
-        TRACE("Size is %" PRIu64, *size);

         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags");
diff --git a/nbd/server.c b/nbd/server.c
index c4d64fb..4bbce5f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1000,6 +1000,10 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
     int ret;

     g_assert(qemu_in_coroutine());
+
+    TRACE("Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d",
+          reply->handle, reply->error, len);
+
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();

@@ -1039,7 +1043,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         return -EIO;
     }

-    TRACE("Decoding type");
+    TRACE("Decoding type: handle = %" PRIu64 ", type = %" PRIu16,
+          request->handle, request->type);

     if (request->type != NBD_CMD_WRITE) {
         /* No payload, we are ready to read the next request.  */
@@ -1049,7 +1054,6 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
     if (request->type == NBD_CMD_DISC) {
         /* Special case: we're going to disconnect without a reply,
          * whether or not flags, from, or len are bogus */
-        TRACE("Request type is DISCONNECT");
         return -EIO;
     }

@@ -1076,13 +1080,14 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         }
     }
     if (request->type == NBD_CMD_WRITE) {
-        TRACE("Reading %" PRIu32 " byte(s)", request->len);
-
         if (nbd_read(client->ioc, req->data, request->len, errp) < 0) {
             error_prepend(errp, "reading from socket failed: ");
             return -EIO;
         }
         req->complete = true;
+
+        TRACE("Payload received: handle = %" PRIu64 ", len = %" PRIu32,
+              request->handle, request->len);
     }

     /* Sanity checks, part 2. */
@@ -1150,8 +1155,6 @@ static coroutine_fn void nbd_trip(void *opaque)

     switch (request.type) {
     case NBD_CMD_READ:
-        TRACE("Request type is READ");
-
         /* XXX: NBD Protocol only documents use of FUA with WRITE */
         if (request.flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
@@ -1171,20 +1174,14 @@ static coroutine_fn void nbd_trip(void *opaque)
         }

         reply_data_len = request.len;
-        TRACE("Read %" PRIu32" byte(s)", request.len);

         break;
     case NBD_CMD_WRITE:
-        TRACE("Request type is WRITE");
-
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            TRACE("Server is read-only, return error");
             reply.error = EROFS;
             break;
         }

-        TRACE("Writing to device");
-
         flags = 0;
         if (request.flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
@@ -1198,16 +1195,12 @@ static coroutine_fn void nbd_trip(void *opaque)

         break;
     case NBD_CMD_WRITE_ZEROES:
-        TRACE("Request type is WRITE_ZEROES");
-
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
             error_setg(&local_err, "Server is read-only, return error");
             reply.error = EROFS;
             break;
         }

-        TRACE("Writing to device");
-
         flags = 0;
         if (request.flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
@@ -1228,8 +1221,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         abort();

     case NBD_CMD_FLUSH:
-        TRACE("Request type is FLUSH");
-
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "flush failed");
@@ -1238,7 +1229,6 @@ static coroutine_fn void nbd_trip(void *opaque)

         break;
     case NBD_CMD_TRIM:
-        TRACE("Request type is TRIM");
         ret = blk_co_pdiscard(exp->blk, request.from + exp->dev_offset,
                               request.len);
         if (ret < 0) {
@@ -1274,8 +1264,6 @@ reply:
         goto disconnect;
     }

-    TRACE("Request/Reply complete");
-
 done:
     nbd_request_put(req);
     nbd_client_put(client);
-- 
2.9.4
