Received: from eggs.gnu.org ([2001:4830:134:3::10]:59925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQw-00049J-Vh
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQt-0005pc-Nx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQt-0005pM-H7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:31 -0400
Received: by mail-wm0-x243.google.com with SMTP id d127so11022233wmf.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:31 -0700 (PDT)
Received: from 640k.lan (94-39-157-43.adsl-ull.clienti.tiscali.it.
	[94.39.157.43]) by smtp.gmail.com with ESMTPSA id
	g46sm6271438wrg.69.2017.06.01.05.42.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 01 Jun 2017 05:42:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:50 +0200
Message-Id: <1496320911-51305-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/33] nbd: make it thread-safe,
 fix qcow2 over nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

NBD is not thread safe, because it accesses s->in_flight without
a CoMutex.  Fixing this will be required for multiqueue.
CoQueue doesn't have spurious wakeups but, when another coroutine can
run between qemu_co_queue_next's wakeup and qemu_co_queue_wait's
re-locking of the mutex, the wait condition can become false and
a loop is necessary.

In fact, it turns out that the loop is necessary even without this
multi-threaded scenario.  A particular sequence of coroutine wakeups
is happening ~80% of the time when starting a guest with qcow2 image
served over NBD (i.e. qemu-nbd --format=raw, and QEMU's -drive option
has -format=qcow2).  This patch fixes that issue too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 09d955b..87d19c7 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -119,6 +119,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, ret, i;
 
     qemu_co_mutex_lock(&s->send_mutex);
+    while (s->in_flight == MAX_NBD_REQUESTS) {
+        qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
+    }
+    s->in_flight++;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
         if (s->recv_coroutine[i] == NULL) {
@@ -181,20 +185,6 @@ static void nbd_co_receive_reply(NBDClientSession *s,
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
@@ -202,13 +192,16 @@ static void nbd_coroutine_end(BlockDriverState *bs,
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
@@ -226,7 +219,6 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -256,7 +248,6 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, qiov);
     if (ret < 0) {
         reply.error = -ret;
@@ -291,7 +282,6 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -316,7 +306,6 @@ int nbd_client_co_flush(BlockDriverState *bs)
     request.from = 0;
     request.len = 0;
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
@@ -342,7 +331,6 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
         return 0;
     }
 
-    nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         reply.error = -ret;
-- 
1.8.3.1
