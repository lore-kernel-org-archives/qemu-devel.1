Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D7C206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q+VaK9IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D7C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zWj-0004F4-Rl
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUY-0002JY-34; Tue, 18 Aug 2020 07:09:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076R-D2; Tue, 18 Aug 2020 07:09:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB1uI7013682;
 Tue, 18 Aug 2020 11:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DGibSnPPRTybN8Lroxn51SZUqADTznvzBnyQuSQV4EE=;
 b=q+VaK9IEBxUi+r4/5dnr9UFVgUQJUxR0w5Z3rHv3fuV/Mogf1uu8vnYOlxdZ8A2Ad+V1
 0nv7QryVuOUJNtdardTbxO/RmflS7+KhDaCE0dBnfZEgio6HN4RckzdewQN4v7eYm9NB
 go47uqgMJ7gUv9hDasxmoZd9fjV5mtVX8r7ht9avY7nFyz/u2+7hsrofvdIysI3rpAnH
 cxOCVaxCxkKTv6I5WNswhaITiuHUbHPNw3vlmI0agsk9iKY7XxszXGigU+p31hZmgHCt
 64JFyHAVjr/m340z6CuXCdyWNQmmC7pvJT5HxZv9ROYtCdnkry/7Se1qhuGnPW32VE/0 OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 32x7nmc1tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8BEM171757;
 Tue, 18 Aug 2020 11:08:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 32xs9mtyq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IB8tTU026571;
 Tue, 18 Aug 2020 11:08:55 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:55 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9d62ac22;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/9] block/curl: Perform IO in fixed size chunks
Date: Tue, 18 Aug 2020 12:08:40 +0100
Message-Id: <20200818110845.3825105-5-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=3 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180079
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=david.edmondson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 07:09:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do all IO requests to the remote server in 256kB chunks.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c       | 151 ++++++++++++++++++++++++++++++++-------------
 block/trace-events |   2 +
 2 files changed, 109 insertions(+), 44 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index d2f4de46c9..cfc518efda 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -78,6 +78,14 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
 
+/* Must be a non-zero power of 2. */
+#define CURL_BLOCK_SIZE (256 * 1024)
+
+/* Align "n" to the start of the containing block. */
+#define CURL_BLOCK_ALIGN(n) ((n) & ~(CURL_BLOCK_SIZE - 1))
+/* The offset of "n" within its' block. */
+#define CURL_BLOCK_OFFSET(n) ((n) & (CURL_BLOCK_SIZE - 1))
+
 struct BDRVCURLState;
 struct CURLState;
 
@@ -86,11 +94,18 @@ static bool libcurl_initialized;
 typedef struct CURLAIOCB {
     Coroutine *co;
     QEMUIOVector *qiov;
+    uint64_t qiov_offset; /* Offset in qiov to place data. */
 
     uint64_t offset;
     uint64_t bytes;
     int ret;
 
+    /*
+     * start and end indicate the subset of the surrounding
+     * CURL_BLOCK_SIZE sized block that is the subject of this
+     * IOCB. They are offsets from the beginning of the underlying
+     * buffer.
+     */
     size_t start;
     size_t end;
 } CURLAIOCB;
@@ -110,7 +125,6 @@ typedef struct CURLState
     char *orig_buf;
     uint64_t buf_start;
     size_t buf_off;
-    size_t buf_len;
     char range[128];
     char errmsg[CURL_ERROR_SIZE];
     char in_use;
@@ -259,11 +273,11 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
         goto read_end;
     }
 
-    if (s->buf_off >= s->buf_len) {
+    if (s->buf_off >= CURL_BLOCK_SIZE) {
         /* buffer full, read nothing */
         goto read_end;
     }
-    realsize = MIN(realsize, s->buf_len - s->buf_off);
+    realsize = MIN(realsize, CURL_BLOCK_SIZE - s->buf_off);
     memcpy(s->orig_buf + s->buf_off, ptr, realsize);
     s->buf_off += realsize;
 
@@ -281,35 +295,44 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
     uint64_t clamped_end = MIN(end, s->len);
     uint64_t clamped_len = clamped_end - start;
 
-    for (i=0; i<CURL_NUM_STATES; i++) {
+    for (i = 0; i < CURL_NUM_STATES; i++) {
         CURLState *state = &s->states[i];
-        uint64_t buf_end = (state->buf_start + state->buf_off);
-        uint64_t buf_fend = (state->buf_start + state->buf_len);
+        /* The end of the currently valid data. */
+        uint64_t buf_end = state->buf_start + state->buf_off;
+        /* The end of the valid data when the IO completes. */
+        uint64_t buf_fend = state->buf_start + CURL_BLOCK_SIZE;
 
         if (!state->orig_buf)
             continue;
         if (!state->buf_off)
             continue;
 
-        // Does the existing buffer cover our section?
+        /*
+         * Does the existing buffer cover our section?
+         */
         if ((start >= state->buf_start) &&
             (start <= buf_end) &&
             (clamped_end >= state->buf_start) &&
             (clamped_end <= buf_end))
         {
-            char *buf = state->orig_buf + (start - state->buf_start);
+            char *buf = state->orig_buf + CURL_BLOCK_OFFSET(start);
 
             trace_curl_pending_hit(qemu_coroutine_self(),
                                    start, len);
-            qemu_iovec_from_buf(acb->qiov, 0, buf, clamped_len);
+            qemu_iovec_from_buf(acb->qiov, acb->qiov_offset, buf, clamped_len);
             if (clamped_len < len) {
-                qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
+                qemu_iovec_memset(acb->qiov, acb->qiov_offset + clamped_len,
+                                  0, len - clamped_len);
             }
             acb->ret = 0;
             return true;
         }
 
-        // Wait for unfinished chunks
+        /*
+         * If an in-progress IO will provide the required data, wait
+         * for it to complete - the initiator will complete this
+         * aiocb.
+         */
         if (state->in_use &&
             (start >= state->buf_start) &&
             (start <= buf_fend) &&
@@ -320,10 +343,10 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
 
             trace_curl_pending_piggyback(qemu_coroutine_self(),
                                          start, len);
-            acb->start = start - state->buf_start;
+            acb->start = CURL_BLOCK_OFFSET(start);
             acb->end = acb->start + clamped_len;
 
-            for (j=0; j<CURL_NUM_ACB; j++) {
+            for (j = 0; j < CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
                     state->acb[j] = acb;
                     return true;
@@ -377,7 +400,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
             for (i = 0; i < CURL_NUM_ACB; i++) {
                 CURLAIOCB *acb = state->acb[i];
 
-                if (acb == NULL) {
+                if (!acb) {
                     continue;
                 }
 
@@ -385,14 +408,15 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                     /* Assert that we have read all data */
                     assert(state->buf_off >= acb->end);
 
-                    qemu_iovec_from_buf(acb->qiov, 0,
+                    qemu_iovec_from_buf(acb->qiov, acb->qiov_offset,
                                         state->orig_buf + acb->start,
                                         acb->end - acb->start);
 
                     if (acb->end - acb->start < acb->bytes) {
                         size_t offset = acb->end - acb->start;
-                        qemu_iovec_memset(acb->qiov, offset, 0,
-                                          acb->bytes - offset);
+
+                        qemu_iovec_memset(acb->qiov, acb->qiov_offset + offset,
+                                          0, acb->bytes - offset);
                     }
                 }
 
@@ -539,6 +563,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 static void curl_clean_state(CURLState *s)
 {
     int j;
+
     for (j = 0; j < CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
     }
@@ -856,18 +881,26 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     BDRVCURLState *s = bs->opaque;
 
-    uint64_t start = acb->offset;
-    uint64_t end;
+    /*
+     * Our caller must ensure that this request does not span two
+     * blocks.
+     */
+    assert(CURL_BLOCK_ALIGN(acb->offset) ==
+           CURL_BLOCK_ALIGN(acb->offset + acb->bytes - 1));
 
     qemu_mutex_lock(&s->mutex);
 
-    // In case we have the requested data already (e.g. read-ahead),
-    // we can just call the callback and be done.
-    if (curl_find_buf(s, start, acb->bytes, acb)) {
+    /*
+     * Check whether the requested data can be found in an existing or
+     * pending IO request.
+     */
+    if (curl_find_buf(s, acb->offset, acb->bytes, acb)) {
         goto out;
     }
 
-    // No cache found, so let's start a new request
+    /*
+     * No cache found, so let's start a new request.
+     */
     for (;;) {
         state = curl_find_state(s);
         if (state) {
@@ -882,16 +915,15 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         goto out;
     }
 
-    acb->start = 0;
-    acb->end = MIN(acb->bytes, s->len - start);
+    acb->start = CURL_BLOCK_OFFSET(acb->offset);
+    acb->end = acb->start + MIN(acb->bytes, s->len - acb->offset);
 
     state->buf_off = 0;
-    g_free(state->orig_buf);
-    state->buf_start = start;
-    state->buf_len = MIN(acb->end, s->len - start);
-    end = start + state->buf_len - 1;
-    state->orig_buf = g_try_malloc(state->buf_len);
-    if (state->buf_len && state->orig_buf == NULL) {
+    state->buf_start = CURL_BLOCK_ALIGN(acb->offset);
+    if (!state->orig_buf) {
+        state->orig_buf = g_try_malloc(CURL_BLOCK_SIZE);
+    }
+    if (!state->orig_buf) {
         curl_clean_state(state);
         acb->ret = -ENOMEM;
         goto out;
@@ -899,8 +931,10 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     state->acb[0] = acb;
 
     snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64,
-             s->offset + start, s->offset + end);
-    trace_curl_setup_preadv(qemu_coroutine_self(), start, acb->bytes);
+             s->offset + state->buf_start,
+             s->offset + state->buf_start + CURL_BLOCK_SIZE);
+    trace_curl_setup_preadv(qemu_coroutine_self(), state->buf_start,
+                            CURL_BLOCK_SIZE);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
     if (curl_multi_add_handle(s->multi, state->curl) != CURLM_OK) {
@@ -921,21 +955,50 @@ out:
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    CURLAIOCB acb = {
-        .co = qemu_coroutine_self(),
-        .ret = -EINPROGRESS,
-        .qiov = qiov,
-        .offset = offset,
-        .bytes = bytes
-    };
+    /*
+     * The lower layer does all IO in single CURL_BLOCK_SIZE sized and
+     * aligned chunks and cannot handle an IO that spans two blocks,
+     * so split the request here.
+     */
+    int ret = 0;
+    uint64_t qiov_offset = 0;
+    uint64_t off = offset;
 
     trace_curl_co_preadv(qemu_coroutine_self(), offset, bytes);
-    curl_setup_preadv(bs, &acb);
-    while (acb.ret == -EINPROGRESS) {
-        qemu_coroutine_yield();
+
+    while (bytes > 0) {
+        uint64_t len = MIN(bytes, CURL_BLOCK_SIZE - CURL_BLOCK_OFFSET(off));
+        CURLAIOCB acb = {
+            .co = qemu_coroutine_self(),
+            .ret = -EINPROGRESS,
+            .qiov = qiov,
+            .qiov_offset = qiov_offset,
+            .offset = off,
+            .bytes = len,
+        };
+
+        trace_curl_co_preadv_segment(qemu_coroutine_self(), off, len);
+
+        curl_setup_preadv(bs, &acb);
+        while (acb.ret == -EINPROGRESS) {
+            qemu_coroutine_yield();
+        }
+
+        ret = acb.ret;
+        if (ret != 0) {
+            return ret;
+        }
+
+        trace_curl_co_preadv_segment_done(qemu_coroutine_self());
+
+        qiov_offset += len;
+        off += len;
+        bytes -= len;
     }
+
     trace_curl_co_preadv_done(qemu_coroutine_self());
-    return acb.ret;
+
+    return ret;
 }
 
 static void curl_close(BlockDriverState *bs)
diff --git a/block/trace-events b/block/trace-events
index 0b52d2ca1d..72b1e927bf 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -200,6 +200,8 @@ curl_open(const char *file) "opening %s"
 curl_open_size(uint64_t size) "size = %" PRIu64
 curl_co_preadv(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%" PRIx64 " + 0x%" PRIx64
 curl_co_preadv_done(void *co) "co %p done"
+curl_co_preadv_segment(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%" PRIx64 " + 0x%" PRIx64
+curl_co_preadv_segment_done(void *co) "co %p done"
 curl_setup_preadv(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%" PRIx64 " + 0x%" PRIx64
 curl_pending_hit(void *co, uint64_t start, uint64_t len) "co %p finds 0x%" PRIx64 " + 0x%" PRIx64
 curl_pending_piggyback(void *co, uint64_t start, uint64_t len) "co %p pending 0x%" PRIx64 " + 0x%" PRIx64
-- 
2.27.0


