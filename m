Received: from eggs.gnu.org ([2001:4830:134:3::10]:38436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaR-0001iK-9i
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaN-0001QL-Me
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10237 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaN-0001Pg-B7
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:35 +0300
Message-Id: <20170918135935.255591-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-1-vsementsov@virtuozzo.com>
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
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

Refactor nbd client to not yield from nbd_read_reply_entry. It's
possible now as all reading is done in nbd_read_reply_entry and
all request-related data is stored in per-request s->requests[i].

We need here some additional work with s->requests[i].ret and
s->quit to not fail requests on normal disconnet and to not report
reading errors on normal disconnect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index f80a4c5564..bf20d5d5e6 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -79,7 +79,11 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     while (!s->quit) {
         ret = nbd_receive_reply(s->ioc, &reply, &local_err);
         if (ret < 0) {
-            error_report_err(local_err);
+            if (s->quit) {
+                error_free(local_err);
+            } else {
+                error_report_err(local_err);
+            }
         }
         if (ret <= 0 || s->quit) {
             break;
@@ -112,19 +116,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             }
         }
 
-        /* We're woken up again by the request itself.  Note that there
-         * is no race between yielding and reentering read_reply_co.  This
-         * is because:
-         *
-         * - if the request runs on the same AioContext, it is only
-         *   entered after we yield
-         *
-         * - if the request runs on a different AioContext, reentering
-         *   read_reply_co happens through a bottom half, which can only
-         *   run after we yield.
-         */
+        s->requests[i].receiving = false;
         aio_co_wake(s->requests[i].coroutine);
-        qemu_coroutine_yield();
     }
 
     s->quit = true;
@@ -157,6 +150,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
     s->requests[i].coroutine = qemu_coroutine_self();
     s->requests[i].receiving = false;
+    s->requests[i].ret = -EIO;
 
     request->handle = INDEX_TO_HANDLE(s, i);
     s->requests[i].request = request;
@@ -210,7 +204,7 @@ static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest *request)
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (!s->ioc || s->quit) {
+    if (!s->ioc) {
         ret = -EIO;
     } else {
         ret = s->requests[i].ret;
@@ -218,11 +212,6 @@ static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest *request)
 
     s->requests[i].coroutine = NULL;
 
-    /* Kick the read_reply_co to get the next reply.  */
-    if (s->read_reply_co) {
-        aio_co_wake(s->read_reply_co);
-    }
-
     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
@@ -364,6 +353,8 @@ void nbd_client_close(BlockDriverState *bs)
 
     nbd_send_request(client->ioc, &request);
 
+    client->quit = true;
+
     nbd_teardown_connection(bs);
 }
 
-- 
2.11.1
