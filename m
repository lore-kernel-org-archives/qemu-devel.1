Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCL-000162-7n
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCI-0005J6-0I
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32792
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCH-0005IC-PX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBme044267
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:01 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpe34-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:01 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:00 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:04 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-30-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 29/79] curl: never invoke callbacks with
 s->mutex held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>

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
(cherry picked from commit 34db05e7ffe8d61ca7288b9532ad6e8300853318)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index c6dc4c0..59e69c6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -147,6 +147,7 @@ static void curl_multi_do(void *arg);
 static void curl_multi_read(void *arg);
 
 #ifdef NEED_CURL_TIMER_CALLBACK
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 {
     BDRVCURLState *s = opaque;
@@ -163,6 +164,7 @@ static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 }
 #endif
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
                         void *userp, void *sp)
 {
@@ -212,6 +214,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
     return 0;
 }
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
@@ -226,6 +229,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     return realsize;
 }
 
+/* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     CURLState *s = ((CURLState*)opaque);
@@ -264,7 +268,9 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
                                   request_length - offset);
             }
 
+            qemu_mutex_unlock(&s->s->mutex);
             acb->common.cb(acb->common.opaque, 0);
+            qemu_mutex_lock(&s->s->mutex);
             qemu_aio_unref(acb);
             s->acb[i] = NULL;
         }
@@ -305,8 +311,6 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
             if (clamped_len < len) {
                 qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
             }
-            acb->common.cb(acb->common.opaque, 0);
-
             return FIND_RET_OK;
         }
 
@@ -832,8 +836,8 @@ static void curl_readv_bh_cb(void *p)
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
2.7.4
