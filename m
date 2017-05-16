Received: from eggs.gnu.org ([2001:4830:134:3::10]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoC-0003U8-CC
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoB-0001dU-C7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:48 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:15 -0400
Message-Id: <20170516155420.10106-4-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] curl: never invoke callbacks with s->mutex
 held
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

All curl callbacks go through curl_multi_do, and hence are called with
s->mutex held.  Note that with comments, and make curl_read_cb drop the
lock before invoking the callback.

Likewise for curl_find_buf, where the callback can be invoked by the
caller.

Cc: qemu-stable@nongnu.org
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170515100059.15795-3-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 562340f..18b82bc 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -148,6 +148,7 @@ static void curl_multi_do(void *arg);
 static void curl_multi_read(void *arg);
 
 #ifdef NEED_CURL_TIMER_CALLBACK
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 {
     BDRVCURLState *s = opaque;
@@ -164,6 +165,7 @@ static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 }
 #endif
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
                         void *userp, void *sp)
 {
@@ -213,6 +215,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
     return 0;
 }
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
@@ -227,6 +230,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     return realsize;
 }
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     CURLState *s = ((CURLState*)opaque);
@@ -265,7 +269,9 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
                                   request_length - offset);
             }
 
+            qemu_mutex_unlock(&s->s->mutex);
             acb->common.cb(acb->common.opaque, 0);
+            qemu_mutex_lock(&s->s->mutex);
             qemu_aio_unref(acb);
             s->acb[i] = NULL;
         }
@@ -306,8 +312,6 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
             if (clamped_len < len) {
                 qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
             }
-            acb->common.cb(acb->common.opaque, 0);
-
             return FIND_RET_OK;
         }
 
@@ -854,8 +858,8 @@ static void curl_readv_bh_cb(void *p)
     // we can just call the callback and be done.
     switch (curl_find_buf(s, start, acb->nb_sectors * BDRV_SECTOR_SIZE, acb)) {
         case FIND_RET_OK:
-            qemu_aio_unref(acb);
-            // fall through
+            ret = 0;
+            goto out;
         case FIND_RET_WAIT:
             goto out;
         default:
-- 
2.9.3
