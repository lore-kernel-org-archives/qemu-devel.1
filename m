Received: from eggs.gnu.org ([2001:4830:134:3::10]:54643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UO-CY
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007EC-CJ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34226 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-00079J-V6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:38 +0300
Message-Id: <20170804151440.320927-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 15/17] block/nbd-client: refactor reading reply
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

Read the whole reply in one place - in nbd_read_reply_entry.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  1 +
 block/nbd-client.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index aa36be8950..0f84ccc073 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -30,6 +30,7 @@ typedef struct NBDClientSession {
     struct {
         Coroutine *co;
         NBDRequest *request;
+        QEMUIOVector *qiov;
     } requests[MAX_NBD_REQUESTS];
     NBDReply reply;
 } NBDClientSession;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 0e12db4be3..61780c5df9 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -94,6 +94,18 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             break;
         }
 
+        if (s->reply.error == 0 &&
+            s->requests[i].request->type == NBD_CMD_READ)
+        {
+            assert(s->requests[i].qiov != NULL);
+            ret = nbd_rwv(s->ioc, s->requests[i].qiov->iov,
+                          s->requests[i].qiov->niov,
+                          s->requests[i].request->len, true, NULL);
+            if (ret != s->requests[i].request->len) {
+                break;
+            }
+        }
+
         /* We're woken up by the receiving coroutine itself.  Note that there
          * is no race between yielding and reentering read_reply_co.  This
          * is because:
@@ -138,6 +150,7 @@ static int nbd_co_request(BlockDriverState *bs,
     assert(i < MAX_NBD_REQUESTS);
     request->handle = INDEX_TO_HANDLE(s, i);
     s->requests[i].request = request;
+    s->requests[i].qiov = qiov;
 
     if (!s->ioc) {
         qemu_co_mutex_unlock(&s->send_mutex);
@@ -165,12 +178,6 @@ static int nbd_co_request(BlockDriverState *bs,
         goto out;
     }
 
-    if (request->type == NBD_CMD_READ) {
-        assert(qiov != NULL);
-    } else {
-        qiov = NULL;
-    }
-
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
     if (!s->ioc || s->reply.handle == 0) {
@@ -180,14 +187,6 @@ static int nbd_co_request(BlockDriverState *bs,
 
     assert(s->reply.handle == request->handle);
 
-    if (qiov && s->reply.error == 0) {
-        ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true, NULL);
-        if (ret != request->len) {
-            rc = -EIO;
-            goto out;
-        }
-    }
-
     rc = -s->reply.error;
 
 out:
-- 
2.11.1
