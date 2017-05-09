Received: from eggs.gnu.org ([2001:4830:134:3::10]:34885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yl-0004wL-O0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yk-0004sV-Cv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:35:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 May 2017 11:35:48 +0200
Message-Id: <20170509093549.25157-4-pbonzini@redhat.com>
In-Reply-To: <20170509093549.25157-1-pbonzini@redhat.com>
References: <20170509093549.25157-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] curl: avoid recursive locking of
 BDRVCURLState mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, jcody@redhat.com, rjones@redhat.com

The curl driver has a ugly hack where, if it cannot find an empty CURLState,
it just uses aio_poll to wait for one to be empty.  This is probably
buggy when used together with dataplane, and a fix is in the next patch.

A more immediate effect of the bug however is that it can cause a
recursive call to curl_readv_bh_cb and recursively taking the
BDRVCURLState mutex.  This causes a deadlock.

The fix is to unlock the mutex around aio_poll, but for cleanliness we
should also take the mutex around all calls to curl_init_state, even if
reaching the unlock/lock pair is impossible.  The same is true for
curl_clean_state.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Cc: jcody@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index a362c1b2a6..e8fcc5ca34 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -281,6 +281,7 @@ read_end:
     return size * nmemb;
 }
 
+/* Called with s->mutex held.  */
 static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
                          CURLAIOCB *acb)
 {
@@ -453,6 +454,7 @@ static void curl_multi_timeout_do(void *arg)
 #endif
 }
 
+/* Called with s->mutex held.  */
 static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 {
     CURLState *state = NULL;
@@ -471,7 +473,9 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
             break;
         }
         if (!state) {
+            qemu_mutex_unlock(&s->mutex);
             aio_poll(bdrv_get_aio_context(bs), true);
+            qemu_mutex_lock(&s->mutex);
         }
     } while(!state);
 
@@ -534,6 +538,7 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
     return state;
 }
 
+/* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
     int j;
@@ -565,6 +570,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
     BDRVCURLState *s = bs->opaque;
     int i;
 
+    qemu_mutex_lock(&s->mutex);
     for (i = 0; i < CURL_NUM_STATES; i++) {
         if (s->states[i].in_use) {
             curl_clean_state(&s->states[i]);
@@ -580,6 +586,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
         curl_multi_cleanup(s->multi);
         s->multi = NULL;
     }
+    qemu_mutex_unlock(&s->mutex);
 
     timer_del(&s->timer);
 }
@@ -745,9 +752,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     DPRINTF("CURL: Opening %s\n", file);
+    qemu_mutex_init(&s->mutex);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
+    qemu_mutex_lock(&s->mutex);
     state = curl_init_state(bs, s);
+    qemu_mutex_unlock(&s->mutex);
     if (!state)
         goto out_noclean;
 
@@ -791,11 +801,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
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
-- 
2.12.2
