Received: from eggs.gnu.org ([2001:4830:134:3::10]:46796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoC-0003UX-Tg
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoB-0001dt-Tl
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:48 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:16 -0400
Message-Id: <20170516155420.10106-5-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] curl: avoid recursive locking of
 BDRVCURLState mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The curl driver has a ugly hack where, if it cannot find an empty CURLState,
it just uses aio_poll to wait for one to be empty.  This is probably
buggy when used together with dataplane, and the simplest way to fix it
is to use coroutines instead.

A more immediate effect of the bug however is that it can cause a
recursive call to curl_readv_bh_cb and recursively taking the
BDRVCURLState mutex.  This causes a deadlock.

The fix is to unlock the mutex around aio_poll, but for cleanliness we
should also take the mutex around all calls to curl_init_state, even if
reaching the unlock/lock pair is impossible.  The same is true for
curl_clean_state.

Reported-by: Kun Wei <kuwei@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170515100059.15795-4-pbonzini@redhat.com
Cc: qemu-stable@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 18b82bc..c160810 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -282,6 +282,7 @@ read_end:
     return size * nmemb;
 }
 
+/* Called with s->mutex held.  */
 static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
                          CURLAIOCB *acb)
 {
@@ -454,6 +455,7 @@ static void curl_multi_timeout_do(void *arg)
 #endif
 }
 
+/* Called with s->mutex held.  */
 static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 {
     CURLState *state = NULL;
@@ -472,7 +474,9 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
             break;
         }
         if (!state) {
+            qemu_mutex_unlock(&s->mutex);
             aio_poll(bdrv_get_aio_context(bs), true);
+            qemu_mutex_lock(&s->mutex);
         }
     } while(!state);
 
@@ -535,6 +539,7 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
     return state;
 }
 
+/* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
     int j;
@@ -566,6 +571,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
     BDRVCURLState *s = bs->opaque;
     int i;
 
+    qemu_mutex_lock(&s->mutex);
     for (i = 0; i < CURL_NUM_STATES; i++) {
         if (s->states[i].in_use) {
             curl_clean_state(&s->states[i]);
@@ -581,6 +587,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
         curl_multi_cleanup(s->multi);
         s->multi = NULL;
     }
+    qemu_mutex_unlock(&s->mutex);
 
     timer_del(&s->timer);
 }
@@ -684,6 +691,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         return -EROFS;
     }
 
+    qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -769,7 +777,9 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     DPRINTF("CURL: Opening %s\n", file);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
+    qemu_mutex_lock(&s->mutex);
     state = curl_init_state(bs, s);
+    qemu_mutex_unlock(&s->mutex);
     if (!state)
         goto out_noclean;
 
@@ -813,11 +823,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
     DPRINTF("CURL: Size = %zd\n", s->len);
 
+    qemu_mutex_lock(&s->mutex);
     curl_clean_state(state);
+    qemu_mutex_unlock(&s->mutex);
     curl_easy_cleanup(state->curl);
     state->curl = NULL;
 
-    qemu_mutex_init(&s->mutex);
     curl_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     qemu_opts_del(opts);
@@ -828,6 +839,7 @@ out:
     curl_easy_cleanup(state->curl);
     state->curl = NULL;
 out_noclean:
+    qemu_mutex_destroy(&s->mutex);
     g_free(s->cookie);
     g_free(s->url);
     qemu_opts_del(opts);
-- 
2.9.3
