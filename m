Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoK-0003dE-I4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoJ-0001jA-HW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:56 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:18 -0400
Message-Id: <20170516155420.10106-7-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] curl: convert CURLAIOCB to byte values
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

This is in preparation for the conversion from bdrv_aio_readv to
bdrv_co_preadv, and it also requires changing some of the size_t values
to uint64_t.  This was broken before for disks > 2TB, but now it would
break at 4GB.

Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170515100059.15795-6-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index a522381..a71a428 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -97,8 +97,8 @@ typedef struct CURLAIOCB {
     BlockAIOCB common;
     QEMUIOVector *qiov;
 
-    int64_t sector_num;
-    int nb_sectors;
+    uint64_t offset;
+    uint64_t bytes;
 
     size_t start;
     size_t end;
@@ -116,7 +116,7 @@ typedef struct CURLState
     CURL *curl;
     QLIST_HEAD(, CURLSocket) sockets;
     char *orig_buf;
-    size_t buf_start;
+    uint64_t buf_start;
     size_t buf_off;
     size_t buf_len;
     char range[128];
@@ -127,7 +127,7 @@ typedef struct CURLState
 typedef struct BDRVCURLState {
     CURLM *multi;
     QEMUTimer timer;
-    size_t len;
+    uint64_t len;
     CURLState states[CURL_NUM_STATES];
     char *url;
     size_t readahead_size;
@@ -258,7 +258,7 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
             continue;
 
         if ((s->buf_off >= acb->end)) {
-            size_t request_length = acb->nb_sectors * BDRV_SECTOR_SIZE;
+            size_t request_length = acb->bytes;
 
             qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
                                 acb->end - acb->start);
@@ -283,18 +283,18 @@ read_end:
 }
 
 /* Called with s->mutex held.  */
-static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
+static int curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
                          CURLAIOCB *acb)
 {
     int i;
-    size_t end = start + len;
-    size_t clamped_end = MIN(end, s->len);
-    size_t clamped_len = clamped_end - start;
+    uint64_t end = start + len;
+    uint64_t clamped_end = MIN(end, s->len);
+    uint64_t clamped_len = clamped_end - start;
 
     for (i=0; i<CURL_NUM_STATES; i++) {
         CURLState *state = &s->states[i];
-        size_t buf_end = (state->buf_start + state->buf_off);
-        size_t buf_fend = (state->buf_start + state->buf_len);
+        uint64_t buf_end = (state->buf_start + state->buf_off);
+        uint64_t buf_fend = (state->buf_start + state->buf_len);
 
         if (!state->orig_buf)
             continue;
@@ -810,7 +810,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 #endif
 
-    s->len = (size_t)d;
+    s->len = d;
 
     if ((!strncasecmp(s->url, "http://", strlen("http://"))
         || !strncasecmp(s->url, "https://", strlen("https://")))
@@ -819,7 +819,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
                 "Server does not support 'range' (byte ranges).");
         goto out;
     }
-    DPRINTF("CURL: Size = %zd\n", s->len);
+    DPRINTF("CURL: Size = %" PRIu64 "\n", s->len);
 
     qemu_mutex_lock(&s->mutex);
     curl_clean_state(state);
@@ -859,14 +859,14 @@ static void curl_readv_bh_cb(void *p)
     BlockDriverState *bs = acb->common.bs;
     BDRVCURLState *s = bs->opaque;
 
-    size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
-    size_t end;
+    uint64_t start = acb->offset;
+    uint64_t end;
 
     qemu_mutex_lock(&s->mutex);
 
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
-    switch (curl_find_buf(s, start, acb->nb_sectors * BDRV_SECTOR_SIZE, acb)) {
+    switch (curl_find_buf(s, start, acb->bytes, acb)) {
         case FIND_RET_OK:
             ret = 0;
             goto out;
@@ -894,7 +894,7 @@ static void curl_readv_bh_cb(void *p)
     }
 
     acb->start = 0;
-    acb->end = MIN(acb->nb_sectors * BDRV_SECTOR_SIZE, s->len - start);
+    acb->end = MIN(acb->bytes, s->len - start);
 
     state->buf_off = 0;
     g_free(state->orig_buf);
@@ -909,9 +909,9 @@ static void curl_readv_bh_cb(void *p)
     }
     state->acb[0] = acb;
 
-    snprintf(state->range, 127, "%zd-%zd", start, end);
-    DPRINTF("CURL (AIO): Reading %llu at %zd (%s)\n",
-            (acb->nb_sectors * BDRV_SECTOR_SIZE), start, state->range);
+    snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64, start, end);
+    DPRINTF("CURL (AIO): Reading %" PRIu64 " at %" PRIu64 " (%s)\n",
+            acb->bytes, start, state->range);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
     curl_multi_add_handle(s->multi, state->curl);
@@ -936,8 +936,8 @@ static BlockAIOCB *curl_aio_readv(BlockDriverState *bs,
     acb = qemu_aio_get(&curl_aiocb_info, bs, cb, opaque);
 
     acb->qiov = qiov;
-    acb->sector_num = sector_num;
-    acb->nb_sectors = nb_sectors;
+    acb->offset = sector_num * BDRV_SECTOR_SIZE;
+    acb->bytes = nb_sectors * BDRV_SECTOR_SIZE;
 
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), curl_readv_bh_cb, acb);
     return &acb->common;
-- 
2.9.3
