Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCL-0004ll-Gz
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCI-0001eF-AU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCH-0001d6-WA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbuE064509
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:56 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bgh8h40k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:56 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:55 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:51 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-58-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 57/67] block/curl: Do not wait for data beyond
 EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Max Reitz <mreitz@redhat.com>

libcurl will only give us as much data as there is, not more. The block
layer will deny requests beyond the end of file for us; but since this
block driver is still using a sector-based interface, we can still get
in trouble if the file size is not a multiple of 512.

While we have already made sure not to attempt transfers beyond the end
of the file, we are currently still trying to receive data from there if
the original request exceeds the file size. This patch fixes this issue
and invokes qemu_iovec_memset() on the iovec's tail.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20161025025431.24714-5-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 4e504535c16dfa66290281e704384abfaca08673)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 600d032..db0b25b 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -254,8 +254,17 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
             continue;
 
         if ((s->buf_off >= acb->end)) {
+            size_t request_length = acb->nb_sectors * BDRV_SECTOR_SIZE;
+
             qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
                                 acb->end - acb->start);
+
+            if (acb->end - acb->start < request_length) {
+                size_t offset = acb->end - acb->start;
+                qemu_iovec_memset(acb->qiov, offset, 0,
+                                  request_length - offset);
+            }
+
             acb->common.cb(acb->common.opaque, 0);
             qemu_aio_unref(acb);
             s->acb[i] = NULL;
@@ -272,6 +281,8 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
 {
     int i;
     size_t end = start + len;
+    size_t clamped_end = MIN(end, s->len);
+    size_t clamped_len = clamped_end - start;
 
     for (i=0; i<CURL_NUM_STATES; i++) {
         CURLState *state = &s->states[i];
@@ -286,12 +297,15 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
         // Does the existing buffer cover our section?
         if ((start >= state->buf_start) &&
             (start <= buf_end) &&
-            (end >= state->buf_start) &&
-            (end <= buf_end))
+            (clamped_end >= state->buf_start) &&
+            (clamped_end <= buf_end))
         {
             char *buf = state->orig_buf + (start - state->buf_start);
 
-            qemu_iovec_from_buf(acb->qiov, 0, buf, len);
+            qemu_iovec_from_buf(acb->qiov, 0, buf, clamped_len);
+            if (clamped_len < len) {
+                qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
+            }
             acb->common.cb(acb->common.opaque, 0);
 
             return FIND_RET_OK;
@@ -301,13 +315,13 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
         if (state->in_use &&
             (start >= state->buf_start) &&
             (start <= buf_fend) &&
-            (end >= state->buf_start) &&
-            (end <= buf_fend))
+            (clamped_end >= state->buf_start) &&
+            (clamped_end <= buf_fend))
         {
             int j;
 
             acb->start = start - state->buf_start;
-            acb->end = acb->start + len;
+            acb->end = acb->start + clamped_len;
 
             for (j=0; j<CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
@@ -786,13 +800,13 @@ static void curl_readv_bh_cb(void *p)
     }
 
     acb->start = 0;
-    acb->end = (acb->nb_sectors * BDRV_SECTOR_SIZE);
+    acb->end = MIN(acb->nb_sectors * BDRV_SECTOR_SIZE, s->len - start);
 
     state->buf_off = 0;
     g_free(state->orig_buf);
     state->buf_start = start;
-    state->buf_len = acb->end + s->readahead_size;
-    end = MIN(start + state->buf_len, s->len) - 1;
+    state->buf_len = MIN(acb->end + s->readahead_size, s->len - start);
+    end = start + state->buf_len - 1;
     state->orig_buf = g_try_malloc(state->buf_len);
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
-- 
1.9.1
