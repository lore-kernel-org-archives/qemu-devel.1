Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB0C206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xih7/ny0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB0C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zYg-00088z-8e
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUZ-0002K7-TH; Tue, 18 Aug 2020 07:09:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076n-C1; Tue, 18 Aug 2020 07:09:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB37h8087478;
 Tue, 18 Aug 2020 11:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=7/kBEdH53UzGC4I5US1PReepZYrcyE/+D//lQ4pRBTA=;
 b=Xih7/ny0Y0x9JzPP0czXZmf0pJbV3D2E3CXUwdoRTSLbf/2h5W2KGUqbPH/GW6gnr7Vk
 L5+aj8hcqjvRioFFeFPgw8/CFta90kafPCT3Z6NhLFJX4FcejepE/MmrdmuhIUDDmRp3
 /9lwZ9AY1s+tzzrJYCFHD77ajGrjhmzS0p1xfiX2gRaNvGwW0fRjDMteS8jvb7XI3oBo
 pW1e+jk4EdHUAZWJuNNNeD3gjsudso3HCPe2k8BbaMsFJn0fPHdgYL2S/CaEbBPgPLRf
 eaf9GUcqfPWdPInr3wCgg7dnU71xoxWWISpIpc7PB5EJJTV+bG/1GYrs5K8gQOGUur17 Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 32x8bn3y8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8AwZ171557;
 Tue, 18 Aug 2020 11:08:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 32xs9mtyq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:57 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IB8tNl024328;
 Tue, 18 Aug 2020 11:08:55 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:55 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 50f392d8;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 5/9] block/curl: Allow the blocksize to be specified by
 the user
Date: Tue, 18 Aug 2020 12:08:41 +0100
Message-Id: <20200818110845.3825105-6-david.edmondson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 impostorscore=0 suspectscore=3 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180079
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 07:09:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Rather than a fixed 256kB blocksize, allow the user to specify the
size used. It must be a non-zero power of two, defaulting to 256kB.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c                          | 73 +++++++++++++++++----------
 docs/system/device-url-syntax.rst.inc |  7 +++
 qapi/block-core.json                  |  4 ++
 3 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index cfc518efda..b2d02818a9 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -74,17 +74,12 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
 #define CURL_BLOCK_OPT_OFFSET "offset"
+#define CURL_BLOCK_OPT_BLOCKSIZE "blocksize"
 
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
-
 /* Must be a non-zero power of 2. */
-#define CURL_BLOCK_SIZE (256 * 1024)
-
-/* Align "n" to the start of the containing block. */
-#define CURL_BLOCK_ALIGN(n) ((n) & ~(CURL_BLOCK_SIZE - 1))
-/* The offset of "n" within its' block. */
-#define CURL_BLOCK_OFFSET(n) ((n) & (CURL_BLOCK_SIZE - 1))
+#define CURL_BLOCK_OPT_BLOCKSIZE_DEFAULT (256 * 1024)
 
 struct BDRVCURLState;
 struct CURLState;
@@ -102,7 +97,7 @@ typedef struct CURLAIOCB {
 
     /*
      * start and end indicate the subset of the surrounding
-     * CURL_BLOCK_SIZE sized block that is the subject of this
+     * BDRVCURLState.blocksize sized block that is the subject of this
      * IOCB. They are offsets from the beginning of the underlying
      * buffer.
      */
@@ -148,11 +143,24 @@ typedef struct BDRVCURLState {
     char *proxyusername;
     char *proxypassword;
     size_t offset;
+    size_t blocksize;
 } BDRVCURLState;
 
 static void curl_clean_state(CURLState *s);
 static void curl_multi_do(void *arg);
 
+/* Align "n" to the start of the containing block. */
+static inline uint64_t curl_block_align(BDRVCURLState *s, uint64_t n)
+{
+    return n & ~(s->blocksize - 1);
+}
+
+/* The offset of "n" within its' block. */
+static inline uint64_t curl_block_offset(BDRVCURLState *s, uint64_t n)
+{
+    return n & (s->blocksize - 1);
+}
+
 #ifdef NEED_CURL_TIMER_CALLBACK
 /* Called from curl_multi_do_locked, with s->mutex held.  */
 static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
@@ -264,22 +272,23 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 /* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
-    CURLState *s = ((CURLState*)opaque);
+    CURLState *state = (CURLState *)opaque;
+    BDRVCURLState *s = state->s;
     size_t realsize = size * nmemb;
 
     trace_curl_read_cb(realsize);
 
-    if (!s || !s->orig_buf) {
+    if (!state || !state->orig_buf) {
         goto read_end;
     }
 
-    if (s->buf_off >= CURL_BLOCK_SIZE) {
+    if (state->buf_off >= s->blocksize) {
         /* buffer full, read nothing */
         goto read_end;
     }
-    realsize = MIN(realsize, CURL_BLOCK_SIZE - s->buf_off);
-    memcpy(s->orig_buf + s->buf_off, ptr, realsize);
-    s->buf_off += realsize;
+    realsize = MIN(realsize, s->blocksize - state->buf_off);
+    memcpy(state->orig_buf + state->buf_off, ptr, realsize);
+    state->buf_off += realsize;
 
 read_end:
     /* curl will error out if we do not return this value */
@@ -300,7 +309,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
         /* The end of the currently valid data. */
         uint64_t buf_end = state->buf_start + state->buf_off;
         /* The end of the valid data when the IO completes. */
-        uint64_t buf_fend = state->buf_start + CURL_BLOCK_SIZE;
+        uint64_t buf_fend = state->buf_start + s->blocksize;
 
         if (!state->orig_buf)
             continue;
@@ -315,7 +324,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             (clamped_end >= state->buf_start) &&
             (clamped_end <= buf_end))
         {
-            char *buf = state->orig_buf + CURL_BLOCK_OFFSET(start);
+            char *buf = state->orig_buf + curl_block_offset(s, start);
 
             trace_curl_pending_hit(qemu_coroutine_self(),
                                    start, len);
@@ -343,7 +352,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
 
             trace_curl_pending_piggyback(qemu_coroutine_self(),
                                          start, len);
-            acb->start = CURL_BLOCK_OFFSET(start);
+            acb->start = curl_block_offset(s, start);
             acb->end = acb->start + clamped_len;
 
             for (j = 0; j < CURL_NUM_ACB; j++) {
@@ -688,6 +697,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Offset into underlying content"
         },
+        {
+            .name = CURL_BLOCK_OPT_BLOCKSIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Block size for IO requests"
+        },
         { /* end of list */ }
     },
 };
@@ -792,6 +806,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->offset = qemu_opt_get_size(opts, CURL_BLOCK_OPT_OFFSET, 0);
+    s->blocksize = qemu_opt_get_size(opts, CURL_BLOCK_OPT_BLOCKSIZE,
+                                     CURL_BLOCK_OPT_BLOCKSIZE_DEFAULT);
+    if ((s->blocksize & (s->blocksize - 1)) != 0) {
+        error_setg(errp, "blocksize must be a non-zero power of two");
+        goto out_noclean;
+    }
 
     trace_curl_open(file);
     qemu_co_queue_init(&s->free_state_waitq);
@@ -885,8 +905,8 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
      * Our caller must ensure that this request does not span two
      * blocks.
      */
-    assert(CURL_BLOCK_ALIGN(acb->offset) ==
-           CURL_BLOCK_ALIGN(acb->offset + acb->bytes - 1));
+    assert(curl_block_align(s, acb->offset) ==
+           curl_block_align(s, acb->offset + acb->bytes - 1));
 
     qemu_mutex_lock(&s->mutex);
 
@@ -915,13 +935,13 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         goto out;
     }
 
-    acb->start = CURL_BLOCK_OFFSET(acb->offset);
+    acb->start = curl_block_offset(s, acb->offset);
     acb->end = acb->start + MIN(acb->bytes, s->len - acb->offset);
 
     state->buf_off = 0;
-    state->buf_start = CURL_BLOCK_ALIGN(acb->offset);
+    state->buf_start = curl_block_align(s, acb->offset);
     if (!state->orig_buf) {
-        state->orig_buf = g_try_malloc(CURL_BLOCK_SIZE);
+        state->orig_buf = g_try_malloc(s->blocksize);
     }
     if (!state->orig_buf) {
         curl_clean_state(state);
@@ -932,9 +952,9 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64,
              s->offset + state->buf_start,
-             s->offset + state->buf_start + CURL_BLOCK_SIZE);
+             s->offset + state->buf_start + s->blocksize);
     trace_curl_setup_preadv(qemu_coroutine_self(), state->buf_start,
-                            CURL_BLOCK_SIZE);
+                            s->blocksize);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
     if (curl_multi_add_handle(s->multi, state->curl) != CURLM_OK) {
@@ -955,8 +975,9 @@ out:
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
+    BDRVCURLState *s = bs->opaque;
     /*
-     * The lower layer does all IO in single CURL_BLOCK_SIZE sized and
+     * The lower layer does all IO in single s->blocksize sized and
      * aligned chunks and cannot handle an IO that spans two blocks,
      * so split the request here.
      */
@@ -967,7 +988,7 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
     trace_curl_co_preadv(qemu_coroutine_self(), offset, bytes);
 
     while (bytes > 0) {
-        uint64_t len = MIN(bytes, CURL_BLOCK_SIZE - CURL_BLOCK_OFFSET(off));
+        uint64_t len = MIN(bytes, s->blocksize - curl_block_offset(s, off));
         CURLAIOCB acb = {
             .co = qemu_coroutine_self(),
             .ret = -EINPROGRESS,
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index bc38b9df38..ee504ee41a 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -194,6 +194,13 @@ These are specified using a special URL syntax.
       Add an offset, in bytes, to all range requests sent to the
       remote server.
 
+   ``blocksize``
+      The size of all IO requests sent to the remote server. This
+      value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or
+      'b'. If it does not have a suffix, it will be assumed to be in
+      bytes. The value must be a non-zero power of two.  It defaults
+      to 256kB.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d6f5e91cc3..cd16197e1e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3764,10 +3764,14 @@
 # @proxy-password-secret: ID of a QCryptoSecret object providing a password
 #                         for proxy authentication (defaults to no password)
 #
+# @blocksize: Size of all IO requests sent to the remote server; must
+#             be a non-zero power of two (defaults to 1 256kB)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlBase',
   'data': { 'url': 'str',
+            '*blocksize': 'int',
             '*timeout': 'int',
             '*username': 'str',
             '*password-secret': 'str',
-- 
2.27.0


