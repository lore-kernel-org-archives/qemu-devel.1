Received: from eggs.gnu.org ([2001:4830:134:3::10]:38536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaW-0001nk-Dz
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaS-0001TY-IF
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:52 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2677 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaS-0001SD-6o
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:32 +0300
Message-Id: <20170918135935.255591-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-1-vsementsov@virtuozzo.com>
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/7] block/nbd-client: drop reply field from
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

Drop 'reply' from NBDClientSession. It's used to only deliver request
return code to receiving coroutine. Instead introduce per-request ret
variable to simplify the scheme and make further refactoring possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  2 +-
 block/nbd-client.c | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 3f97d31013..4bc8fe3993 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -22,6 +22,7 @@ typedef struct {
     bool receiving;         /* waiting for read_reply_co? */
     NBDRequest *request;
     QEMUIOVector *qiov;
+    int ret;
 } NBDClientRequest;
 
 typedef struct NBDClientSession {
@@ -35,7 +36,6 @@ typedef struct NBDClientSession {
     int in_flight;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
-    NBDReply reply;
     bool quit;
 } NBDClientSession;
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index f7b642f079..f331f08a9a 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -74,10 +74,10 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     uint64_t i;
     int ret = 0;
     Error *local_err = NULL;
+    NBDReply reply;
 
     while (!s->quit) {
-        assert(s->reply.handle == 0);
-        ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        ret = nbd_receive_reply(s->ioc, &reply, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
         }
@@ -89,18 +89,18 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
          * handler acts as a synchronization point and ensures that only
          * one coroutine is called until the reply finishes.
          */
-        i = HANDLE_TO_INDEX(s, s->reply.handle);
+        i = HANDLE_TO_INDEX(s, reply.handle);
         if (i >= MAX_NBD_REQUESTS ||
             !s->requests[i].coroutine ||
             !s->requests[i].receiving ||
-            s->reply.handle != s->requests[i].request->handle)
+            reply.handle != s->requests[i].request->handle)
         {
             break;
         }
 
-        if (s->reply.error == 0 &&
-            s->requests[i].request->type == NBD_CMD_READ)
-        {
+        s->requests[i].ret = -reply.error;
+
+        if (reply.error == 0 && s->requests[i].request->type == NBD_CMD_READ) {
             QEMUIOVector *qiov = s->requests[i].qiov;
             assert(qiov != NULL);
             assert(s->requests[i].request->len ==
@@ -108,7 +108,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
                                       NULL) < 0)
             {
-                s->reply.error = EIO;
+                s->requests[i].ret = -EIO;
                 break;
             }
         }
@@ -211,11 +211,7 @@ static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest *request)
     if (!s->ioc || s->quit) {
         ret = -EIO;
     } else {
-        assert(s->reply.handle == request->handle);
-        ret = -s->reply.error;
-
-        /* Tell the read handler to read another header.  */
-        s->reply.handle = 0;
+        ret = s->requests[i].ret;
     }
 
     s->requests[i].coroutine = NULL;
-- 
2.11.1
