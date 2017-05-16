Received: from eggs.gnu.org ([2001:4830:134:3::10]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoC-0003Ul-VG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoB-0001dy-Ub
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:49 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:17 -0400
Message-Id: <20170516155420.10106-6-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] curl: split curl_find_state/curl_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

If curl_easy_init fails, a CURLState is left with s->in_use = 1.  Split
curl_init_state in two, so that we can distinguish the two failures and
call curl_clean_state if needed.

While at it, simplify curl_find_state, removing a dummy loop.  The
aio_poll loop is moved to the sole caller that needs it.

Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170515100059.15795-5-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index c160810..a522381 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -456,34 +456,27 @@ static void curl_multi_timeout_do(void *arg)
 }
 
 /* Called with s->mutex held.  */
-static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
+static CURLState *curl_find_state(BDRVCURLState *s)
 {
     CURLState *state = NULL;
-    int i, j;
-
-    do {
-        for (i=0; i<CURL_NUM_STATES; i++) {
-            for (j=0; j<CURL_NUM_ACB; j++)
-                if (s->states[i].acb[j])
-                    continue;
-            if (s->states[i].in_use)
-                continue;
+    int i;
 
+    for (i = 0; i < CURL_NUM_STATES; i++) {
+        if (!s->states[i].in_use) {
             state = &s->states[i];
             state->in_use = 1;
             break;
         }
-        if (!state) {
-            qemu_mutex_unlock(&s->mutex);
-            aio_poll(bdrv_get_aio_context(bs), true);
-            qemu_mutex_lock(&s->mutex);
-        }
-    } while(!state);
+    }
+    return state;
+}
 
+static int curl_init_state(BDRVCURLState *s, CURLState *state)
+{
     if (!state->curl) {
         state->curl = curl_easy_init();
         if (!state->curl) {
-            return NULL;
+            return -EIO;
         }
         curl_easy_setopt(state->curl, CURLOPT_URL, s->url);
         curl_easy_setopt(state->curl, CURLOPT_SSL_VERIFYPEER,
@@ -536,7 +529,7 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
     QLIST_INIT(&state->sockets);
     state->s = s;
 
-    return state;
+    return 0;
 }
 
 /* Called with s->mutex held.  */
@@ -778,13 +771,18 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
     qemu_mutex_lock(&s->mutex);
-    state = curl_init_state(bs, s);
+    state = curl_find_state(s);
     qemu_mutex_unlock(&s->mutex);
-    if (!state)
+    if (!state) {
         goto out_noclean;
+    }
 
     // Get file size
 
+    if (curl_init_state(s, state) < 0) {
+        goto out;
+    }
+
     s->accept_range = false;
     curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1);
     curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION,
@@ -879,8 +877,18 @@ static void curl_readv_bh_cb(void *p)
     }
 
     // No cache found, so let's start a new request
-    state = curl_init_state(acb->common.bs, s);
-    if (!state) {
+    for (;;) {
+        state = curl_find_state(s);
+        if (state) {
+            break;
+        }
+        qemu_mutex_unlock(&s->mutex);
+        aio_poll(bdrv_get_aio_context(bs), true);
+        qemu_mutex_lock(&s->mutex);
+    }
+
+    if (curl_init_state(s, state) < 0) {
+        curl_clean_state(state);
         ret = -EIO;
         goto out;
     }
-- 
2.9.3
