Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yn-0004wh-26
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yl-0004u9-Qv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:36:00 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 May 2017 11:35:49 +0200
Message-Id: <20170509093549.25157-5-pbonzini@redhat.com>
In-Reply-To: <20170509093549.25157-1-pbonzini@redhat.com>
References: <20170509093549.25157-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] curl: improve search for unused CURLState
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

The main change here is to pull the search loop to a new function,
making it easier to switch from aio_poll to BDRV_POLL_WHILE.

However, the "for (j...)" loop is also dead (there is no other
read of "j" outside the loop), so remove it.

Cc: jcody@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index e8fcc5ca34..79e504a2cc 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -455,29 +455,41 @@ static void curl_multi_timeout_do(void *arg)
 }
 
 /* Called with s->mutex held.  */
+static bool curl_find_unused_state_locked(BDRVCURLState *s, CURLState **state)
+{
+    int i;
+
+    for (i = 0; i < CURL_NUM_STATES; i++) {
+        if (!s->states[i].in_use) {
+            s->states[i].in_use = 1;
+            *state = &s->states[i];
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool curl_find_unused_state(BDRVCURLState *s, CURLState **state)
+{
+    bool ret;
+
+    qemu_mutex_lock(&s->mutex);
+    ret = curl_find_unused_state_locked(s, state);
+    qemu_mutex_unlock(&s->mutex);
+    return ret;
+}
+
+/* Called with s->mutex held.  */
 static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
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
-
-            state = &s->states[i];
-            state->in_use = 1;
-            break;
-        }
-        if (!state) {
-            qemu_mutex_unlock(&s->mutex);
-            aio_poll(bdrv_get_aio_context(bs), true);
-            qemu_mutex_lock(&s->mutex);
-        }
-    } while(!state);
+
+    if (!curl_find_unused_state_locked(s, &state)) {
+        qemu_mutex_unlock(&s->mutex);
+        BDRV_POLL_WHILE(bs, !curl_find_unused_state(s, &state));
+        qemu_mutex_lock(&s->mutex);
+    }
 
     if (!state->curl) {
         state->curl = curl_easy_init();
-- 
2.12.2
