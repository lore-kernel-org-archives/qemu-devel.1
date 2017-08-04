Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJO-0005Uz-En
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007F8-Sj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:50 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:19287 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-0007Bw-G9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:39 +0300
Message-Id: <20170804151440.320927-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 16/17] block/nbd-client: drop reply field from
 NBDClientSession
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Drop 'reply' from NBDClientSession. It's usage is not very transparent:

1. it is used to deliver error to receiving coroutine, and receiving
   coroutine must save or handle it somehow and then zero out
   it in NBDClientSession.
2. it is used to inform receiving coroutines that nbd_read_reply_entry
   is out for some reason (error or disconnect)

To simplify this scheme:
- drop NBDClientSession.reply
- introduce NBDClientSession.requests[...].ret for (1)
- introduce NBDClientSession.eio_to_all for (2)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  3 ++-
 block/nbd-client.c | 25 ++++++++++---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 0f84ccc073..0b0aa67342 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -31,8 +31,9 @@ typedef struct NBDClientSession {
         Coroutine *co;
         NBDRequest *request;
         QEMUIOVector *qiov;
+        int ret;
     } requests[MAX_NBD_REQUESTS];
-    NBDReply reply;
+    bool eio_to_all;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 61780c5df9..7c151b3dd3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -72,10 +72,10 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     uint64_t i;
     int ret;
     Error *local_err = NULL;
+    NBDReply reply;
 
     for (;;) {
-        assert(s->reply.handle == 0);
-        ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        ret = nbd_receive_reply(s->ioc, &reply, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
         }
@@ -87,16 +87,14 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
          * handler acts as a synchronization point and ensures that only
          * one coroutine is called until the reply finishes.
          */
-        i = HANDLE_TO_INDEX(s, s->reply.handle);
+        i = HANDLE_TO_INDEX(s, reply.handle);
         if (i >= MAX_NBD_REQUESTS || !s->requests[i].co ||
-            s->reply.handle != s->requests[i].request->handle)
+            reply.handle != s->requests[i].request->handle)
         {
             break;
         }
 
-        if (s->reply.error == 0 &&
-            s->requests[i].request->type == NBD_CMD_READ)
-        {
+        if (reply.error == 0 && s->requests[i].request->type == NBD_CMD_READ) {
             assert(s->requests[i].qiov != NULL);
             ret = nbd_rwv(s->ioc, s->requests[i].qiov->iov,
                           s->requests[i].qiov->niov,
@@ -106,6 +104,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             }
         }
 
+        s->requests[i].ret = -reply.error;
+
         /* We're woken up by the receiving coroutine itself.  Note that there
          * is no race between yielding and reentering read_reply_co.  This
          * is because:
@@ -121,7 +121,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
-    s->reply.handle = 0;
+    s->eio_to_all = true;
     nbd_recv_coroutines_wake_all(s);
     s->read_reply_co = NULL;
 }
@@ -180,19 +180,14 @@ static int nbd_co_request(BlockDriverState *bs,
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
-    if (!s->ioc || s->reply.handle == 0) {
+    if (!s->ioc || s->eio_to_all) {
         rc = -EIO;
         goto out;
     }
 
-    assert(s->reply.handle == request->handle);
-
-    rc = -s->reply.error;
+    rc = s->requests[i].ret;
 
 out:
-    /* Tell the read handler to read another header.  */
-    s->reply.handle = 0;
-
     s->requests[i].co = NULL;
 
     /* Kick the read_reply_co to get the next reply.  */
-- 
2.11.1
