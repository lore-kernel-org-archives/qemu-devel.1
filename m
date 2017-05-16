Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3J-0001VM-Mx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3I-0004xJ-Rn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:01 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14468 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dAZ3I-0004vf-EU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 May 2017 12:45:31 +0300
Message-Id: <20170516094533.6160-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170516094533.6160-1-vsementsov@virtuozzo.com>
References: <20170516094533.6160-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] nbd: add errp parameter to nbd_wr_syncv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Will be used in following patch to provide actual error message in
some cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c  |  4 ++--
 include/block/nbd.h |  3 ++-
 nbd/common.c        | 12 +++++-------
 nbd/nbd-internal.h  |  4 ++--
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e2952fdae..538d95e031 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -136,7 +136,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0) {
             ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
-                               false);
+                               false, NULL);
             if (ret != request->len) {
                 rc = -EIO;
             }
@@ -165,7 +165,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     } else {
         if (qiov && reply->error == 0) {
             ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
-                               true);
+                               true, NULL);
             if (ret != request->len) {
                 reply->error = EIO;
             }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3e373f0498..a96fb5fceb 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -127,7 +127,8 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
                      size_t length,
-                     bool do_read);
+                     bool do_read,
+                     Error **errp);
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
diff --git a/nbd/common.c b/nbd/common.c
index 4db45b3ede..bd81637ab9 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -28,10 +28,10 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
                      size_t length,
-                     bool do_read)
+                     bool do_read,
+                     Error **errp)
 {
     ssize_t done = 0;
-    Error *local_err = NULL;
     struct iovec *local_iov = g_new(struct iovec, niov);
     struct iovec *local_iov_head = local_iov;
     unsigned int nlocal_iov = niov;
@@ -41,19 +41,17 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
     while (nlocal_iov > 0) {
         ssize_t len;
         if (do_read) {
-            len = qio_channel_readv(ioc, local_iov, nlocal_iov, &local_err);
+            len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
         } else {
-            len = qio_channel_writev(ioc, local_iov, nlocal_iov, &local_err);
+            len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
         }
         if (len == QIO_CHANNEL_ERR_BLOCK) {
+            /* errp should not be set */
             assert(qemu_in_coroutine());
             qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
             continue;
         }
         if (len < 0) {
-            TRACE("I/O error: %s", error_get_pretty(local_err));
-            error_free(local_err);
-            /* XXX handle Error objects */
             done = -EIO;
             goto cleanup;
         }
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index e6bbc7c4b4..1d479fe135 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -108,7 +108,7 @@ static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size)
      * our request/reply.  Synchronization is done with recv_coroutine, so
      * that this is coroutine-safe.
      */
-    return nbd_wr_syncv(ioc, &iov, 1, size, true);
+    return nbd_wr_syncv(ioc, &iov, 1, size, true, NULL);
 }
 
 /* read_sync
@@ -132,7 +132,7 @@ static inline int write_sync(QIOChannel *ioc, const void *buffer, size_t size)
 {
     struct iovec iov = { .iov_base = (void *) buffer, .iov_len = size };
 
-    ssize_t ret = nbd_wr_syncv(ioc, &iov, 1, size, false);
+    ssize_t ret = nbd_wr_syncv(ioc, &iov, 1, size, false, NULL);
 
     assert(ret < 0 || ret == size);
 
-- 
2.11.1
