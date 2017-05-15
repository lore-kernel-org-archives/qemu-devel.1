Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACob-0000cr-3K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACoZ-0005v5-W6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:21 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 May 2017 12:00:58 +0200
Message-Id: <20170515100059.15795-7-pbonzini@redhat.com>
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
References: <20170515100059.15795-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] curl: convert readv to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is pretty simple.  The bottom half goes away because, unlike
bdrv_aio_readv, coroutine-based read can return immediately without
yielding.  However, for simplicity I kept the former bottom half
handler in a separate function.

Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 94 ++++++++++++++++++++++++------------------------------------
 1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 401a1b1015..86a4a73834 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -76,10 +76,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_TIMEOUT_DEFAULT 5
 #define CURL_TIMEOUT_MAX 10000
 
-#define FIND_RET_NONE   0
-#define FIND_RET_OK     1
-#define FIND_RET_WAIT   2
-
 #define CURL_BLOCK_OPT_URL       "url"
 #define CURL_BLOCK_OPT_READAHEAD "readahead"
 #define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
@@ -93,11 +89,12 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 struct BDRVCURLState;
 
 typedef struct CURLAIOCB {
-    BlockAIOCB common;
+    Coroutine *co;
     QEMUIOVector *qiov;
 
     uint64_t offset;
     uint64_t bytes;
+    int ret;
 
     size_t start;
     size_t end;
@@ -268,11 +265,11 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
                                   request_length - offset);
             }
 
+            acb->ret = 0;
+            s->acb[i] = NULL;
             qemu_mutex_unlock(&s->s->mutex);
-            acb->common.cb(acb->common.opaque, 0);
+            aio_co_wake(acb->co);
             qemu_mutex_lock(&s->s->mutex);
-            qemu_aio_unref(acb);
-            s->acb[i] = NULL;
         }
     }
 
@@ -282,8 +279,8 @@ read_end:
 }
 
 /* Called with s->mutex held.  */
-static int curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
-                         CURLAIOCB *acb)
+static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
+                          CURLAIOCB *acb)
 {
     int i;
     uint64_t end = start + len;
@@ -312,7 +309,8 @@ static int curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             if (clamped_len < len) {
                 qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
             }
-            return FIND_RET_OK;
+            acb->ret = 0;
+            return true;
         }
 
         // Wait for unfinished chunks
@@ -330,13 +328,13 @@ static int curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             for (j=0; j<CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
                     state->acb[j] = acb;
-                    return FIND_RET_WAIT;
+                    return true;
                 }
             }
         }
     }
 
-    return FIND_RET_NONE;
+    return false;
 }
 
 /* Called with s->mutex held.  */
@@ -381,11 +379,11 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                         continue;
                     }
 
+                    acb->ret = -EIO;
+                    state->acb[i] = NULL;
                     qemu_mutex_unlock(&s->mutex);
-                    acb->common.cb(acb->common.opaque, -EIO);
+                    aio_co_wake(acb->co);
                     qemu_mutex_lock(&s->mutex);
-                    qemu_aio_unref(acb);
-                    state->acb[i] = NULL;
                 }
             }
 
@@ -822,19 +820,11 @@ out_noclean:
     return -EINVAL;
 }
 
-static const AIOCBInfo curl_aiocb_info = {
-    .aiocb_size         = sizeof(CURLAIOCB),
-};
-
-
-static void curl_readv_bh_cb(void *p)
+static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 {
     CURLState *state;
     int running;
-    int ret = -EINPROGRESS;
 
-    CURLAIOCB *acb = p;
-    BlockDriverState *bs = acb->common.bs;
     BDRVCURLState *s = bs->opaque;
 
     uint64_t start = acb->offset;
@@ -844,14 +834,8 @@ static void curl_readv_bh_cb(void *p)
 
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
-    switch (curl_find_buf(s, start, acb->bytes, acb)) {
-        case FIND_RET_OK:
-            ret = 0;
-            goto out;
-        case FIND_RET_WAIT:
-            goto out;
-        default:
-            break;
+    if (curl_find_buf(s, start, acb->bytes, acb)) {
+        goto out;
     }
 
     // No cache found, so let's start a new request
@@ -867,7 +851,7 @@ static void curl_readv_bh_cb(void *p)
 
     if (curl_init_state(s, state) < 0) {
         curl_clean_state(state);
-        ret = -EIO;
+        acb->ret = -EIO;
         goto out;
     }
 
@@ -882,7 +866,7 @@ static void curl_readv_bh_cb(void *p)
     state->orig_buf = g_try_malloc(state->buf_len);
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
-        ret = -ENOMEM;
+        acb->ret = -ENOMEM;
         goto out;
     }
     state->acb[0] = acb;
@@ -899,26 +883,24 @@ static void curl_readv_bh_cb(void *p)
 
 out:
     qemu_mutex_unlock(&s->mutex);
-    if (ret != -EINPROGRESS) {
-        acb->common.cb(acb->common.opaque, ret);
-        qemu_aio_unref(acb);
-    }
 }
 
-static BlockAIOCB *curl_aio_readv(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque)
+static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    CURLAIOCB *acb;
-
-    acb = qemu_aio_get(&curl_aiocb_info, bs, cb, opaque);
-
-    acb->qiov = qiov;
-    acb->offset = sector_num * BDRV_SECTOR_SIZE;
-    acb->bytes = nb_sectors * BDRV_SECTOR_SIZE;
-
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), curl_readv_bh_cb, acb);
-    return &acb->common;
+    CURLAIOCB acb = {
+        .co = qemu_coroutine_self(),
+        .ret = -EINPROGRESS,
+        .qiov = qiov,
+        .offset = offset,
+        .bytes = bytes
+    };
+
+    curl_setup_preadv(bs, &acb);
+    while (acb.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+    return acb.ret;
 }
 
 static void curl_close(BlockDriverState *bs)
@@ -949,7 +931,7 @@ static BlockDriver bdrv_http = {
     .bdrv_close                 = curl_close,
     .bdrv_getlength             = curl_getlength,
 
-    .bdrv_aio_readv             = curl_aio_readv,
+    .bdrv_co_preadv             = curl_co_preadv,
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
@@ -965,7 +947,7 @@ static BlockDriver bdrv_https = {
     .bdrv_close                 = curl_close,
     .bdrv_getlength             = curl_getlength,
 
-    .bdrv_aio_readv             = curl_aio_readv,
+    .bdrv_co_preadv             = curl_co_preadv,
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
@@ -981,7 +963,7 @@ static BlockDriver bdrv_ftp = {
     .bdrv_close                 = curl_close,
     .bdrv_getlength             = curl_getlength,
 
-    .bdrv_aio_readv             = curl_aio_readv,
+    .bdrv_co_preadv             = curl_co_preadv,
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
@@ -997,7 +979,7 @@ static BlockDriver bdrv_ftps = {
     .bdrv_close                 = curl_close,
     .bdrv_getlength             = curl_getlength,
 
-    .bdrv_aio_readv             = curl_aio_readv,
+    .bdrv_co_preadv             = curl_co_preadv,
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
-- 
2.12.2
