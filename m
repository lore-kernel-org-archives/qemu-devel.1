Received: from eggs.gnu.org ([2001:4830:134:3::10]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOM-0000R3-RR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOK-0002uu-Nj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Feb 2017 20:40:26 +0100
Message-Id: <20170217194028.8398-2-pbonzini@redhat.com>
In-Reply-To: <20170217194028.8398-1-pbonzini@redhat.com>
References: <20170217194028.8398-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] curl: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com

Now that all bottom halves and callbacks take care of taking the
AioContext lock, we can migrate some users away from it and to a
specific QemuMutex or CoMutex.

Protect BDRVCURLState access with a QemuMutex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 2939cc7..e83dcd8 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -135,6 +135,7 @@ typedef struct BDRVCURLState {
     char *cookie;
     bool accept_range;
     AioContext *aio_context;
+    QemuMutex mutex;
     char *username;
     char *password;
     char *proxyusername;
@@ -333,6 +334,7 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
     return FIND_RET_NONE;
 }
 
+/* Called with s->mutex held.  */
 static void curl_multi_check_completion(BDRVCURLState *s)
 {
     int msgs_in_queue;
@@ -374,7 +376,9 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                         continue;
                     }
 
+                    qemu_mutex_unlock(&s->mutex);
                     acb->common.cb(acb->common.opaque, -EPROTO);
+                    qemu_mutex_lock(&s->mutex);
                     qemu_aio_unref(acb);
                     state->acb[i] = NULL;
                 }
@@ -386,6 +390,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
     }
 }
 
+/* Called with s->mutex held.  */
 static void curl_multi_do_locked(CURLState *s)
 {
     CURLSocket *socket, *next_socket;
@@ -409,19 +414,19 @@ static void curl_multi_do(void *arg)
 {
     CURLState *s = (CURLState *)arg;
 
-    aio_context_acquire(s->s->aio_context);
+    qemu_mutex_lock(&s->s->mutex);
     curl_multi_do_locked(s);
-    aio_context_release(s->s->aio_context);
+    qemu_mutex_unlock(&s->s->mutex);
 }
 
 static void curl_multi_read(void *arg)
 {
     CURLState *s = (CURLState *)arg;
 
-    aio_context_acquire(s->s->aio_context);
+    qemu_mutex_lock(&s->s->mutex);
     curl_multi_do_locked(s);
     curl_multi_check_completion(s->s);
-    aio_context_release(s->s->aio_context);
+    qemu_mutex_unlock(&s->s->mutex);
 }
 
 static void curl_multi_timeout_do(void *arg)
@@ -434,11 +439,11 @@ static void curl_multi_timeout_do(void *arg)
         return;
     }
 
-    aio_context_acquire(s->aio_context);
+    qemu_mutex_lock(&s->mutex);
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
 
     curl_multi_check_completion(s);
-    aio_context_release(s->aio_context);
+    qemu_mutex_unlock(&s->mutex);
 #else
     abort();
 #endif
@@ -771,6 +776,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     curl_easy_cleanup(state->curl);
     state->curl = NULL;
 
+    qemu_mutex_init(&s->mutex);
     curl_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     qemu_opts_del(opts);
@@ -801,12 +807,11 @@ static void curl_readv_bh_cb(void *p)
     CURLAIOCB *acb = p;
     BlockDriverState *bs = acb->common.bs;
     BDRVCURLState *s = bs->opaque;
-    AioContext *ctx = bdrv_get_aio_context(bs);
 
     size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
     size_t end;
 
-    aio_context_acquire(ctx);
+    qemu_mutex_lock(&s->mutex);
 
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
@@ -854,7 +859,7 @@ static void curl_readv_bh_cb(void *p)
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
 
 out:
-    aio_context_release(ctx);
+    qemu_mutex_unlock(&s->mutex);
     if (ret != -EINPROGRESS) {
         acb->common.cb(acb->common.opaque, ret);
         qemu_aio_unref(acb);
@@ -883,6 +888,7 @@ static void curl_close(BlockDriverState *bs)
 
     DPRINTF("CURL: Close\n");
     curl_detach_aio_context(bs);
+    qemu_mutex_destroy(&s->mutex);
 
     g_free(s->cookie);
     g_free(s->url);
-- 
2.9.3
