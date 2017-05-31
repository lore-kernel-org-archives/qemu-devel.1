Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AJ-0002Uk-Tf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AJ-0001lZ-4v
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:43 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 11:43:25 +0200
Message-Id: <20170531094330.1808-7-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-1-pbonzini@redhat.com>
References: <20170531094330.1808-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] nbd: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e2952fdae..43e0292ac1 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -114,6 +114,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, ret, i;
 
     qemu_co_mutex_lock(&s->send_mutex);
+    while (s->in_flight == MAX_NBD_REQUESTS) {
+        qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
+    }
+    s->in_flight++;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
         if (s->recv_coroutine[i] == NULL) {
@@ -176,20 +180,6 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     }
 }
 
-static void nbd_coroutine_start(NBDClientSession *s,
-                                NBDRequest *request)
-{
-    /* Poor man semaphore.  The free_sema is locked when no other request
-     * can be accepted, and unlocked after receiving one reply.  */
-    if (s->in_flight == MAX_NBD_REQUESTS) {
-        qemu_co_queue_wait(&s->free_sema, NULL);
-        assert(s->in_flight < MAX_NBD_REQUESTS);
-    }
-    s->in_flight++;
-
-    /* s->recv_coroutine[i] is set as soon as we get the send_lock.  */
-}
-
 static void nbd_coroutine_end(BlockDriverState *bs,
                               NBDRequest *request)
 {
@@ -197,13 +187,16 @@ static void nbd_coroutine_end(BlockDriverState *bs,
     int i = HANDLE_TO_INDEX(s, request->handle);
 
     s->recv_coroutine[i] = NULL;
-    s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
 
     /* Kick the read_reply_co to get the next reply.  */
     if (s->read_reply_co) {
         aio_co_wake(s->read_reply_co);
     }
+
+    qemu_co_mutex_lock(&s->send_mutex);
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
+    qemu_co_mutex_unlock(&s->send_mutex);
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
@@ -221,7 +214,6 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -251,7 +243,6 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, qiov);
     if (ret < 0) {
         reply.error = -ret;
@@ -286,7 +277,6 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -311,7 +301,6 @@ int nbd_client_co_flush(BlockDriverState *bs)
     request.from = 0;
     request.len = 0;
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -337,7 +326,6 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
         return 0;
     }
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
-- 
2.13.0
