Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBD120706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BdTlm+xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBD120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zap-0002Zv-OF
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUW-0002Io-4C; Tue, 18 Aug 2020 07:09:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076c-7z; Tue, 18 Aug 2020 07:09:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB2Uka014178;
 Tue, 18 Aug 2020 11:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/GfoqlYNk9s8Hm4+FVj4dp5mroP259zhYnqOoqe3G9s=;
 b=BdTlm+xmtdRPYsKIhBZ9nwAcRpiWdMHgTPxRUdTu9hz5RjIdUxt4y2wY417hiG5yfImo
 n3OlLduLgmVabKWQgo0vx1FG3mOfZ3gAGBZaseqYbTNGOuL+k/gLj9SOB1msXZSmizXX
 XFiNgCXT0z3gpyJ569RRAkUvlpo91Bn7x5bvah0NxRtGOkUI9jjVh2YTQDCqJ3SjZ2XA
 64yrfijD9sKcDy2yH2fQ+rEf/Bwp1U0rQZ2gVaS+Zlme1qoS15oOm56bv5txYt3+qcCD
 lPJYlt3/w9RuYub6jCJyBKBHsgie0c/NsweqR/NM52vOu0CQkMLipElUR9S+ixosxg6D rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 32x7nmc1st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8DNS002955;
 Tue, 18 Aug 2020 11:08:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32xsfrqxkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IB8q09024317;
 Tue, 18 Aug 2020 11:08:52 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:52 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id d42e6542;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/9] block/curl: Remove readahead support
Date: Tue, 18 Aug 2020 12:08:38 +0100
Message-Id: <20200818110845.3825105-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180080
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
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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

Block based caching and the current readahead support do not interact
well, so remove readahead support before adding block
caching. Readahead will be re-added later.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c                          | 23 ++++-------------------
 docs/system/device-url-syntax.rst.inc |  7 -------
 qapi/block-core.json                  |  4 ----
 3 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 32ec760f66..d0c74d7de5 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -65,7 +65,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_TIMEOUT_MAX 10000
 
 #define CURL_BLOCK_OPT_URL       "url"
-#define CURL_BLOCK_OPT_READAHEAD "readahead"
 #define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
 #define CURL_BLOCK_OPT_TIMEOUT "timeout"
 #define CURL_BLOCK_OPT_COOKIE    "cookie"
@@ -76,7 +75,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
 #define CURL_BLOCK_OPT_OFFSET "offset"
 
-#define CURL_BLOCK_OPT_READAHEAD_DEFAULT (256 * 1024)
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
 
@@ -124,7 +122,6 @@ typedef struct BDRVCURLState {
     uint64_t len;
     CURLState states[CURL_NUM_STATES];
     char *url;
-    size_t readahead_size;
     bool sslverify;
     uint64_t timeout;
     char *cookie;
@@ -615,11 +612,6 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "URL to open",
         },
-        {
-            .name = CURL_BLOCK_OPT_READAHEAD,
-            .type = QEMU_OPT_SIZE,
-            .help = "Readahead size",
-        },
         {
             .name = CURL_BLOCK_OPT_SSLVERIFY,
             .type = QEMU_OPT_BOOL,
@@ -705,14 +697,6 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out_noclean;
     }
 
-    s->readahead_size = qemu_opt_get_size(opts, CURL_BLOCK_OPT_READAHEAD,
-                                          CURL_BLOCK_OPT_READAHEAD_DEFAULT);
-    if ((s->readahead_size & 0x1ff) != 0) {
-        error_setg(errp, "HTTP_READAHEAD_SIZE %zd is not a multiple of 512",
-                   s->readahead_size);
-        goto out_noclean;
-    }
-
     s->timeout = qemu_opt_get_number(opts, CURL_BLOCK_OPT_TIMEOUT,
                                      CURL_BLOCK_OPT_TIMEOUT_DEFAULT);
     if (s->timeout > CURL_TIMEOUT_MAX) {
@@ -898,7 +882,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     state->buf_off = 0;
     g_free(state->orig_buf);
     state->buf_start = start;
-    state->buf_len = MIN(acb->end + s->readahead_size, s->len - start);
+    state->buf_len = MIN(acb->end, s->len - start);
     end = start + state->buf_len - 1;
     state->orig_buf = g_try_malloc(state->buf_len);
     if (state->buf_len && state->orig_buf == NULL) {
@@ -971,8 +955,9 @@ static void curl_refresh_filename(BlockDriverState *bs)
 {
     BDRVCURLState *s = bs->opaque;
 
-    /* "readahead" and "timeout" do not change the guest-visible data,
-     * so ignore them */
+    /*
+     * "timeout" does not change the guest-visible data, so ignore it.
+     */
     if (s->sslverify != CURL_BLOCK_OPT_SSLVERIFY_DEFAULT ||
         s->cookie || s->username || s->password || s->proxyusername ||
         s->proxypassword)
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 33f1ddfe6d..bc38b9df38 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -174,13 +174,6 @@ These are specified using a special URL syntax.
    ``url``
       The full URL when passing options to the driver explicitly.
 
-   ``readahead``
-      The amount of data to read ahead with each range request to the
-      remote server. This value may optionally have the suffix 'T', 'G',
-      'M', 'K', 'k' or 'b'. If it does not have a suffix, it will be
-      assumed to be in bytes. The value must be a multiple of 512 bytes.
-      It defaults to 256k.
-
    ``sslverify``
       Whether to verify the remote server's certificate when connecting
       over SSL. It can have the value 'on' or 'off'. It defaults to
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1c36..d6f5e91cc3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3752,9 +3752,6 @@
 #
 # @url: URL of the image file
 #
-# @readahead: Size of the read-ahead cache; must be a multiple of
-#             512 (defaults to 256 kB)
-#
 # @timeout: Timeout for connections, in seconds (defaults to 5)
 #
 # @username: Username for authentication (defaults to none)
@@ -3771,7 +3768,6 @@
 ##
 { 'struct': 'BlockdevOptionsCurlBase',
   'data': { 'url': 'str',
-            '*readahead': 'int',
             '*timeout': 'int',
             '*username': 'str',
             '*password-secret': 'str',
-- 
2.27.0


