Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq7-0000VP-2V
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004ei-Ad
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:39 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32899 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZA-UL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:11 +0300
Message-Id: <20171009172723.190282-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/7] block/nbd-client: refactor reading reply
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

Read the whole reply in one place - in nbd_read_reply_entry.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  1 +
 block/nbd-client.c | 42 ++++++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index b1900e6a6d..3f97d31013 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -21,6 +21,7 @@ typedef struct {
     Coroutine *coroutine;
     bool receiving;         /* waiting for read_reply_co? */
     NBDRequest *request;
+    QEMUIOVector *qiov;
 } NBDClientRequest;
 
 typedef struct NBDClientSession {
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 5f241ecc22..f7b642f079 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -98,6 +98,21 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             break;
         }
 
+        if (s->reply.error == 0 &&
+            s->requests[i].request->type == NBD_CMD_READ)
+        {
+            QEMUIOVector *qiov = s->requests[i].qiov;
+            assert(qiov != NULL);
+            assert(s->requests[i].request->len ==
+                   iov_size(qiov->iov, qiov->niov));
+            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+                                      NULL) < 0)
+            {
+                s->reply.error = EIO;
+                break;
+            }
+        }
+
         /* We're woken up again by the request itself.  Note that there
          * is no race between yielding and reentering read_reply_co.  This
          * is because:
@@ -118,6 +133,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     s->read_reply_co = NULL;
 }
 
+/* qiov should be provided for READ and WRITE */
 static int nbd_co_send_request(BlockDriverState *bs,
                                NBDRequest *request,
                                QEMUIOVector *qiov)
@@ -145,6 +161,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
     request->handle = INDEX_TO_HANDLE(s, i);
     s->requests[i].request = request;
+    s->requests[i].qiov = qiov;
 
     if (s->quit) {
         rc = -EIO;
@@ -155,7 +172,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
         goto err;
     }
 
-    if (qiov) {
+    if (s->requests[i].request->type == NBD_CMD_WRITE) {
+        assert(qiov);
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0 && !s->quit) {
@@ -181,9 +199,7 @@ err:
     return rc;
 }
 
-static int nbd_co_receive_reply(NBDClientSession *s,
-                                NBDRequest *request,
-                                QEMUIOVector *qiov)
+static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest *request)
 {
     int ret;
     int i = HANDLE_TO_INDEX(s, request->handle);
@@ -197,14 +213,6 @@ static int nbd_co_receive_reply(NBDClientSession *s,
     } else {
         assert(s->reply.handle == request->handle);
         ret = -s->reply.error;
-        if (qiov && s->reply.error == 0) {
-            assert(request->len == iov_size(qiov->iov, qiov->niov));
-            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                      NULL) < 0) {
-                ret = -EIO;
-                s->quit = true;
-            }
-        }
 
         /* Tell the read handler to read another header.  */
         s->reply.handle = 0;
@@ -232,16 +240,14 @@ static int nbd_co_request(BlockDriverState *bs,
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
 
-    assert(!qiov || request->type == NBD_CMD_WRITE ||
-           request->type == NBD_CMD_READ);
-    ret = nbd_co_send_request(bs, request,
-                              request->type == NBD_CMD_WRITE ? qiov : NULL);
+    assert((qiov == NULL) !=
+           (request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ));
+    ret = nbd_co_send_request(bs, request, qiov);
     if (ret < 0) {
         return ret;
     }
 
-    return nbd_co_receive_reply(client, request,
-                                request->type == NBD_CMD_READ ? qiov : NULL);
+    return nbd_co_receive_reply(client, request);
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-- 
2.11.1
