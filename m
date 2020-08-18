Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F296C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6DF206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZVuhhAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6DF206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zZ7-0000Ws-6s
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUU-0002H6-BS; Tue, 18 Aug 2020 07:09:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076a-9g; Tue, 18 Aug 2020 07:09:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB1PsG013475;
 Tue, 18 Aug 2020 11:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=nxZvi48tkMZkkBSRefc2A3GcM21RFm1nupS8Lhc90J8=;
 b=NZVuhhAp9K+PjBV0RIXsATRfU8fSOnpR1qzSR4hJwLFI26OBNm9wbj8XWaNEjsRukw+f
 KidGxKKORjv0Xo8yrGXY/NJK31A5vGQfDqT/nG98cp11Rt5YqJW3A+wjzaQ4gI/A3mBJ
 uB7Of6g7aBT8i2t3cfwdgVo3S077ZsFJNQ06YUJTMFzRGrRjPzPx5YDZyUKPxlVtkDgA
 zE+SZO0smmwleP4o8dZa9RcHqhW2DPTFoBWChg9BYhIuzTqxOU64uffq1KmDAvTcISBB
 8T5bjzLxaIZ/gdyhujn3oZ9pLISay0NnVvvB2r8LCA3uZP/1eUZiJLgtdDkU07kmmJbM gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 32x7nmc1th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8A1k171495;
 Tue, 18 Aug 2020 11:08:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 32xs9mtyqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IB8vNq001397;
 Tue, 18 Aug 2020 11:08:57 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:57 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 49300d21;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/9] block/curl: Cache downloaded blocks
Date: Tue, 18 Aug 2020 12:08:42 +0100
Message-Id: <20200818110845.3825105-7-david.edmondson@oracle.com>
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

In the hope that they will be referred to multiple times, cache the
blocks downloaded from the remote server.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c       | 321 +++++++++++++++++++++++++++++++++++++++------
 block/trace-events |   3 +
 2 files changed, 287 insertions(+), 37 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index b2d02818a9..0ea9eedebd 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -81,11 +81,29 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 /* Must be a non-zero power of 2. */
 #define CURL_BLOCK_OPT_BLOCKSIZE_DEFAULT (256 * 1024)
 
+/* The maximum number of blocks to store in the cache. */
+#define CURL_BLOCK_CACHE_MAX_BLOCKS 100
+/* The number of heads in the hash table. */
+#define CURL_BLOCK_CACHE_HASH 37
+
 struct BDRVCURLState;
 struct CURLState;
 
 static bool libcurl_initialized;
 
+typedef struct block {
+    QLIST_ENTRY(block) hash; /* Blocks with the same hash value. */
+    QLIST_ENTRY(block) free; /* Block free list. */
+    QTAILQ_ENTRY(block) lru; /* LRU list. */
+    bool hashed; /* block_t contains data and is hashed. */
+    int use;     /* Use count. */
+
+    uint64_t start; /* Offset of first byte. */
+    uint64_t count; /* Valid bytes. */
+
+    char *buf;      /* Data. */
+} block_t;
+
 typedef struct CURLAIOCB {
     Coroutine *co;
     QEMUIOVector *qiov;
@@ -117,12 +135,11 @@ typedef struct CURLState
     CURLAIOCB *acb[CURL_NUM_ACB];
     CURL *curl;
     QLIST_HEAD(, CURLSocket) sockets;
-    char *orig_buf;
-    uint64_t buf_start;
     size_t buf_off;
     char range[128];
     char errmsg[CURL_ERROR_SIZE];
     char in_use;
+    block_t *cache_block;
 } CURLState;
 
 typedef struct BDRVCURLState {
@@ -144,11 +161,17 @@ typedef struct BDRVCURLState {
     char *proxypassword;
     size_t offset;
     size_t blocksize;
+    int cache_allocated; /* The number of block_t currently allocated. */
+    QLIST_HEAD(, block) cache_free;
+    QTAILQ_HEAD(, block) cache_lru;
+    QLIST_HEAD(, block) * cache_hash;
 } BDRVCURLState;
 
 static void curl_clean_state(CURLState *s);
 static void curl_multi_do(void *arg);
 
+static void curl_cache_free(BDRVCURLState *s, block_t *b);
+
 /* Align "n" to the start of the containing block. */
 static inline uint64_t curl_block_align(BDRVCURLState *s, uint64_t n)
 {
@@ -161,6 +184,198 @@ static inline uint64_t curl_block_offset(BDRVCURLState *s, uint64_t n)
     return n & (s->blocksize - 1);
 }
 
+static uint64_t curl_cache_hash(BDRVCURLState *s, uint64_t n)
+{
+    return curl_block_align(s, n) % CURL_BLOCK_CACHE_HASH;
+}
+
+static bool curl_cache_init(BDRVCURLState *s)
+{
+    s->cache_allocated = 0;
+
+    QLIST_INIT(&s->cache_free);
+    QTAILQ_INIT(&s->cache_lru);
+
+    s->cache_hash = g_try_malloc(CURL_BLOCK_CACHE_HASH * sizeof(s->cache_hash));
+    if (!s->cache_hash) {
+        return false;
+    }
+
+    for (int i = 0; i < CURL_BLOCK_CACHE_HASH; i++) {
+        QLIST_INIT(&s->cache_hash[i]);
+    }
+
+    return true;
+}
+
+static void curl_cache_deinit(BDRVCURLState *s)
+{
+    block_t *b;
+
+    /*
+     * Cache blocks are either in the hash table or on the free list.
+     */
+    for (int i = 0; i < CURL_BLOCK_CACHE_HASH; i++) {
+        while (!QLIST_EMPTY(&s->cache_hash[i])) {
+            b = QLIST_FIRST(&s->cache_hash[i]);
+            QLIST_REMOVE(b, hash);
+            b->hashed = false;
+            curl_cache_free(s, b);
+        }
+    }
+
+    while (!QLIST_EMPTY(&s->cache_free)) {
+        b = QLIST_FIRST(&s->cache_free);
+        QLIST_REMOVE(b, free);
+        curl_cache_free(s, b);
+    }
+
+    assert(s->cache_allocated == 0);
+
+    g_free(s->cache_hash);
+    s->cache_hash = NULL;
+}
+
+static block_t *curl_cache_alloc(BDRVCURLState *s)
+{
+    block_t *b = g_try_malloc0(sizeof(*b));
+
+    if (!b) {
+        return NULL;
+    }
+
+    b->buf = g_try_malloc(s->blocksize);
+    if (!b->buf) {
+        g_free(b);
+        return NULL;
+    }
+
+    s->cache_allocated++;
+
+    trace_curl_cache_alloc(s->cache_allocated);
+
+    return b;
+}
+
+static void curl_cache_free(BDRVCURLState *s, block_t *b)
+{
+    assert(b->use == 0);
+    assert(!b->hashed);
+
+    g_free(b->buf);
+    g_free(b);
+
+    s->cache_allocated--;
+
+    trace_curl_cache_free(s->cache_allocated);
+}
+
+static block_t *curl_cache_get(BDRVCURLState *s)
+{
+    block_t *b = NULL;
+
+    /* If there is one on the free list, use it. */
+    if (!QLIST_EMPTY(&s->cache_free)) {
+        b = QLIST_FIRST(&s->cache_free);
+        QLIST_REMOVE(b, free);
+
+        assert(b->use == 0);
+        assert(!b->hashed);
+
+        b->use++;
+        goto done;
+    }
+
+    /* If not at the limit, try get a new one. */
+    if (s->cache_allocated < CURL_BLOCK_CACHE_MAX_BLOCKS) {
+        b = curl_cache_alloc(s);
+        if (b) {
+            b->use++;
+            goto done;
+        }
+    }
+
+    /* Take one from the LRU list. */
+    if (!QTAILQ_EMPTY(&s->cache_lru)) {
+        b = QTAILQ_FIRST(&s->cache_lru);
+        QTAILQ_REMOVE(&s->cache_lru, b, lru);
+
+        /* Remove it from the hash. */
+        QLIST_REMOVE(b, hash);
+
+        assert(b->use == 0);
+
+        b->hashed = false;
+        b->use++;
+        goto done;
+    }
+
+ done:
+    return b;
+}
+
+static void curl_cache_put(BDRVCURLState *s, block_t *b, bool valid)
+{
+    b->use--;
+
+    if (valid) {
+        /* If it's not hashed, hash it now. */
+        if (!b->hashed) {
+            b->hashed = true;
+            QLIST_INSERT_HEAD(&s->cache_hash[curl_cache_hash(s, b->start)],
+                              b, hash);
+        }
+
+        /* If the block is no longer being used, put it on the LRU list. */
+        if (b->use == 0) {
+            QTAILQ_INSERT_TAIL(&s->cache_lru, b, lru);
+        }
+    } else {
+        b->hashed = false;
+        QLIST_INSERT_HEAD(&s->cache_free, b, free);
+    }
+}
+
+static block_t *cache_lookup(BDRVCURLState *s, uint64_t start)
+{
+    block_t *b;
+
+    QLIST_FOREACH(b, &s->cache_hash[curl_cache_hash(s, start)], hash) {
+        if (b->start <= start && start < b->start + b->count) {
+            assert(b->hashed);
+            b->use++;
+
+            /* Remove from the LRU list. */
+            QTAILQ_REMOVE(&s->cache_lru, b, lru);
+
+            return b;
+        }
+    }
+
+    return NULL;
+}
+
+static bool curl_cache_find(BDRVCURLState *s, CURLAIOCB *acb)
+{
+    block_t *b;
+
+    b = cache_lookup(s, acb->offset);
+    if (!b) {
+        return false;
+    }
+
+    trace_curl_cache_hit(qemu_coroutine_self(), acb->offset, acb->bytes);
+
+    qemu_iovec_from_buf(acb->qiov, acb->qiov_offset,
+                        b->buf + curl_block_offset(s, acb->offset),
+                        acb->bytes);
+
+    curl_cache_put(s, b, true);
+
+    acb->ret = 0;
+    return true;
+}
+
 #ifdef NEED_CURL_TIMER_CALLBACK
 /* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
@@ -274,11 +489,12 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     CURLState *state = (CURLState *)opaque;
     BDRVCURLState *s = state->s;
+    block_t *b = state->cache_block;
     size_t realsize = size * nmemb;
 
     trace_curl_read_cb(realsize);
 
-    if (!state || !state->orig_buf) {
+    if (!state || !b) {
         goto read_end;
     }
 
@@ -287,8 +503,9 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
         goto read_end;
     }
     realsize = MIN(realsize, s->blocksize - state->buf_off);
-    memcpy(state->orig_buf + state->buf_off, ptr, realsize);
+    memcpy(b->buf + state->buf_off, ptr, realsize);
     state->buf_off += realsize;
+    b->count += realsize;
 
 read_end:
     /* curl will error out if we do not return this value */
@@ -296,35 +513,38 @@ read_end:
 }
 
 /* Called with s->mutex held.  */
-static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
-                          CURLAIOCB *acb)
+static bool curl_pending_find(BDRVCURLState *s, CURLAIOCB *acb)
 {
     int i;
+    uint64_t start = acb->offset;
+    uint64_t len = acb->bytes;
     uint64_t end = start + len;
     uint64_t clamped_end = MIN(end, s->len);
     uint64_t clamped_len = clamped_end - start;
 
     for (i = 0; i < CURL_NUM_STATES; i++) {
         CURLState *state = &s->states[i];
-        /* The end of the currently valid data. */
-        uint64_t buf_end = state->buf_start + state->buf_off;
-        /* The end of the valid data when the IO completes. */
-        uint64_t buf_fend = state->buf_start + s->blocksize;
+        block_t *b = state->cache_block;
+        uint64_t buf_end, buf_fend;
 
-        if (!state->orig_buf)
-            continue;
-        if (!state->buf_off)
+        if (!b) {
             continue;
+        }
+
+        /* The end of the currently valid data. */
+        buf_end = b->start + state->buf_off;
+        /* The end of the valid data when the IO completes. */
+        buf_fend = b->start + s->blocksize;
 
         /*
          * Does the existing buffer cover our section?
          */
-        if ((start >= state->buf_start) &&
+        if ((start >= b->start) &&
             (start <= buf_end) &&
-            (clamped_end >= state->buf_start) &&
+            (clamped_end >= b->start) &&
             (clamped_end <= buf_end))
         {
-            char *buf = state->orig_buf + curl_block_offset(s, start);
+            char *buf = b->buf + curl_block_offset(s, start);
 
             trace_curl_pending_hit(qemu_coroutine_self(),
                                    start, len);
@@ -343,9 +563,9 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
          * aiocb.
          */
         if (state->in_use &&
-            (start >= state->buf_start) &&
+            (start >= b->start) &&
             (start <= buf_fend) &&
-            (clamped_end >= state->buf_start) &&
+            (clamped_end >= b->start) &&
             (clamped_end <= buf_fend))
         {
             int j;
@@ -388,10 +608,10 @@ static void curl_multi_check_completion(BDRVCURLState *s)
             int i;
             CURLState *state = NULL;
             bool error = msg->data.result != CURLE_OK;
+            block_t *b;
 
             curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
                               (char **)&state);
-
             if (error) {
                 static int errcount = 100;
 
@@ -406,6 +626,8 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                 }
             }
 
+            b = state->cache_block;
+
             for (i = 0; i < CURL_NUM_ACB; i++) {
                 CURLAIOCB *acb = state->acb[i];
 
@@ -418,7 +640,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                     assert(state->buf_off >= acb->end);
 
                     qemu_iovec_from_buf(acb->qiov, acb->qiov_offset,
-                                        state->orig_buf + acb->start,
+                                        b->buf + acb->start,
                                         acb->end - acb->start);
 
                     if (acb->end - acb->start < acb->bytes) {
@@ -436,6 +658,9 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                 qemu_mutex_lock(&s->mutex);
             }
 
+            curl_cache_put(s, b, true);
+            state->cache_block = NULL;
+
             curl_clean_state(state);
             break;
         }
@@ -612,8 +837,10 @@ static void curl_detach_aio_context(BlockDriverState *bs)
             curl_easy_cleanup(s->states[i].curl);
             s->states[i].curl = NULL;
         }
-        g_free(s->states[i].orig_buf);
-        s->states[i].orig_buf = NULL;
+        if (s->states[i].cache_block) {
+            curl_cache_free(s, s->states[i].cache_block);
+            s->states[i].cache_block = NULL;
+        }
     }
     if (s->multi) {
         curl_multi_cleanup(s->multi);
@@ -868,6 +1095,10 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
     trace_curl_open_size(s->len);
 
+    if (!curl_cache_init(s)) {
+        goto out;
+    }
+
     qemu_mutex_lock(&s->mutex);
     curl_clean_state(state);
     qemu_mutex_unlock(&s->mutex);
@@ -898,6 +1129,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 {
     CURLState *state;
     int running;
+    block_t *b;
 
     BDRVCURLState *s = bs->opaque;
 
@@ -910,11 +1142,16 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     qemu_mutex_lock(&s->mutex);
 
+    /* Can this request be handled using a cached block? */
+    if (curl_cache_find(s, acb)) {
+        goto out;
+    }
+
     /*
-     * Check whether the requested data can be found in an existing or
-     * pending IO request.
+     * Check whether the requested data can be found in a pending IO
+     * request.
      */
-    if (curl_find_buf(s, acb->offset, acb->bytes, acb)) {
+    if (curl_pending_find(s, acb)) {
         goto out;
     }
 
@@ -935,25 +1172,34 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         goto out;
     }
 
-    acb->start = curl_block_offset(s, acb->offset);
-    acb->end = acb->start + MIN(acb->bytes, s->len - acb->offset);
-
-    state->buf_off = 0;
-    state->buf_start = curl_block_align(s, acb->offset);
-    if (!state->orig_buf) {
-        state->orig_buf = g_try_malloc(s->blocksize);
-    }
-    if (!state->orig_buf) {
+    b = curl_cache_get(s);
+    if (!b) {
         curl_clean_state(state);
         acb->ret = -ENOMEM;
         goto out;
     }
+
+    state->cache_block = b;
+
+    /*
+     * Any already cached or in-progress IO for
+     * curl_cache_base(acb->offset) would have been found by
+     * curl_cache_find() or curl_pending_find() respectively, so this
+     * must be a new request for that block.
+     */
+    b->start = curl_block_align(s, acb->offset);
+    b->count = 0; /* Nothing read so far. */
+
+    acb->start = curl_block_offset(s, acb->offset);
+    acb->end = acb->start + MIN(acb->bytes, s->len - acb->offset);
+
+    state->buf_off = 0;
     state->acb[0] = acb;
 
     snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64,
-             s->offset + state->buf_start,
-             s->offset + state->buf_start + s->blocksize);
-    trace_curl_setup_preadv(qemu_coroutine_self(), state->buf_start,
+             s->offset + b->start,
+             s->offset + b->start + s->blocksize);
+    trace_curl_setup_preadv(qemu_coroutine_self(), b->start,
                             s->blocksize);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
@@ -1027,6 +1273,7 @@ static void curl_close(BlockDriverState *bs)
     BDRVCURLState *s = bs->opaque;
 
     trace_curl_close();
+    curl_cache_deinit(s);
     curl_detach_aio_context(bs);
     qemu_mutex_destroy(&s->mutex);
 
diff --git a/block/trace-events b/block/trace-events
index 72b1e927bf..deac37c4ad 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -206,7 +206,10 @@ curl_setup_preadv(void *co, uint64_t offset, uint64_t bytes) "co %p requests 0x%
 curl_pending_hit(void *co, uint64_t start, uint64_t len) "co %p finds 0x%" PRIx64 " + 0x%" PRIx64
 curl_pending_piggyback(void *co, uint64_t start, uint64_t len) "co %p pending 0x%" PRIx64 " + 0x%" PRIx64
 curl_pending_miss(void *co, uint64_t start, uint64_t len) "co %p misses 0x%" PRIx64 " + 0x%" PRIx64
+curl_cache_hit(void *co, uint64_t start, uint64_t len) "co %p finds 0x%" PRIx64 " + 0x%" PRIx64
 curl_close(void) "close"
+curl_cache_alloc(size_t n) "%zu cache blocks allocated"
+curl_cache_free(size_t n) "%zu cache blocks allocated"
 
 # file-posix.c
 file_xfs_write_zeroes(const char *error) "cannot write zero range (%s)"
-- 
2.27.0


