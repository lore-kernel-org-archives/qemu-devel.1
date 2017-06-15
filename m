Received: from eggs.gnu.org ([2001:4830:134:3::10]:41083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPK-000069-L9
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPJ-0007fu-Ob
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:46 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPJ-0007fI-Ef
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:45 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so16400104wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:50 +0200
Message-Id: <1497523981-38449-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/41] nbd/server: refactor
 nbd_co_receive_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move function tail, about receiving next request out of the function.
Error path is simplified and nbd_co_receive_request becomes more
corresponding to its name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-8-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 00a19f6..9fb03ce 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1006,14 +1006,11 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 {
     NBDClient *client = req->client;
-    int rc;
 
     g_assert(qemu_in_coroutine());
     assert(client->recv_coroutine == qemu_coroutine_self());
-    rc = nbd_receive_request(client->ioc, request);
-    if (rc < 0) {
-        rc = -EIO;
-        goto out;
+    if (nbd_receive_request(client->ioc, request) < 0) {
+        return -EIO;
     }
 
     TRACE("Decoding type");
@@ -1027,8 +1024,7 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
         /* Special case: we're going to disconnect without a reply,
          * whether or not flags, from, or len are bogus */
         TRACE("Request type is DISCONNECT");
-        rc = -EIO;
-        goto out;
+        return -EIO;
     }
 
     /* Check for sanity in the parameters, part 1.  Defer as many
@@ -1036,22 +1032,19 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
      * payload, so we can try and keep the connection alive.  */
     if ((request->from + request->len) < request->from) {
         LOG("integer overflow detected, you're probably being attacked");
-        rc = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE) {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
             LOG("len (%" PRIu32" ) is larger than max len (%u)",
                 request->len, NBD_MAX_BUFFER_SIZE);
-            rc = -EINVAL;
-            goto out;
+            return -EINVAL;
         }
 
         req->data = blk_try_blockalign(client->exp->blk, request->len);
         if (req->data == NULL) {
-            rc = -ENOMEM;
-            goto out;
+            return -ENOMEM;
         }
     }
     if (request->type == NBD_CMD_WRITE) {
@@ -1059,8 +1052,7 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 
         if (nbd_read(client->ioc, req->data, request->len, NULL) < 0) {
             LOG("reading from socket failed");
-            rc = -EIO;
-            goto out;
+            return -EIO;
         }
         req->complete = true;
     }
@@ -1070,28 +1062,19 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
         LOG("operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
             ", Size: %" PRIu64, request->from, request->len,
             (uint64_t)client->exp->size);
-        rc = request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
-        goto out;
+        return request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
     }
     if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {
         LOG("unsupported flags (got 0x%x)", request->flags);
-        rc = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
     if (request->type != NBD_CMD_WRITE_ZEROES &&
         (request->flags & NBD_CMD_FLAG_NO_HOLE)) {
         LOG("unexpected flags (got 0x%x)", request->flags);
-        rc = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
-    rc = 0;
-
-out:
-    client->recv_coroutine = NULL;
-    nbd_client_receive_next_request(client);
-
-    return rc;
+    return 0;
 }
 
 /* Owns a reference to the NBDClient passed as opaque.  */
@@ -1113,6 +1096,8 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     req = nbd_request_get(client);
     ret = nbd_co_receive_request(req, &request);
+    client->recv_coroutine = NULL;
+    nbd_client_receive_next_request(client);
     if (ret == -EIO) {
         goto out;
     }
-- 
1.8.3.1
