Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA8AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8804C20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wwCahuGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zcv-0004pN-Nb
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zWG-0003fo-3g; Tue, 18 Aug 2020 07:11:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zWE-0007T6-71; Tue, 18 Aug 2020 07:11:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB1VSf013529;
 Tue, 18 Aug 2020 11:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=IqaSwqqFiLggpnInP8SeCftORg7ZLFYTCdjzdpFzBKk=;
 b=wwCahuGW2f6NH1NkIk2hmcO1Zn4ST5dkb38aMo/dUkXGLUoYSJOFV3V2KAMQ3JzOEYCv
 WVpFZNEqh7eHTHPkdabTuTTVWrsmpvFtIP28x9It/QhyO+dSt1mDYNk8MZr+ILPWqmH9
 hZ4CiMt2bDTI+qbhAQikXkNFtIgU1+7ezOcbt1isuQqhrwZrDwe05DLf3eT52ou91nSz
 MucsZO7ePwQMSR7s619JFBNiO0wOCpH1VntlXY5bXAp06x5myBLFjuvgIbZAMkrrwa4Y
 XGQtHl5gtTNGqAFZMh93p39k6805bc/zYXgi3STPuW51S7GEr9d6efctsmhCcgeKecPe 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 32x7nmc21y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:11:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8ASF171477;
 Tue, 18 Aug 2020 11:09:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 32xs9mtyrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:09:01 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IB8xI2026590;
 Tue, 18 Aug 2020 11:08:59 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:59 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id f2f05530;
 Tue, 18 Aug 2020 11:08:46 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 9/9] block/curl: Add readahead support
Date: Tue, 18 Aug 2020 12:08:45 +0100
Message-Id: <20200818110845.3825105-10-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=1 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
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

Re-add support for a readahead parameter, which is the number of bytes
added to the request from the upper layer before breaking the request
into blocks. The default is zero. The number of bytes specified has no
alignment requirements.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c                          | 11 +++++++++++
 docs/system/device-url-syntax.rst.inc |  7 +++++++
 qapi/block-core.json                  |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 8ee314739a..a182a55b93 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -65,6 +65,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_TIMEOUT_MAX 10000
 
 #define CURL_BLOCK_OPT_URL       "url"
+#define CURL_BLOCK_OPT_READAHEAD "readahead"
 #define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
 #define CURL_BLOCK_OPT_TIMEOUT "timeout"
 #define CURL_BLOCK_OPT_COOKIE    "cookie"
@@ -149,6 +150,7 @@ typedef struct BDRVCURLState {
     uint64_t len;
     CURLState states[CURL_NUM_STATES];
     char *url;
+    size_t readahead_size;
     bool sslverify;
     uint64_t timeout;
     char *cookie;
@@ -881,6 +883,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "URL to open",
         },
+        {
+            .name = CURL_BLOCK_OPT_READAHEAD,
+            .type = QEMU_OPT_SIZE,
+            .help = "Readahead size",
+        },
         {
             .name = CURL_BLOCK_OPT_SSLVERIFY,
             .type = QEMU_OPT_BOOL,
@@ -976,6 +983,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out_noclean;
     }
 
+    s->readahead_size = qemu_opt_get_size(opts, CURL_BLOCK_OPT_READAHEAD, 0);
+
     s->timeout = qemu_opt_get_number(opts, CURL_BLOCK_OPT_TIMEOUT,
                                      CURL_BLOCK_OPT_TIMEOUT_DEFAULT);
     if (s->timeout > CURL_TIMEOUT_MAX) {
@@ -1247,6 +1256,8 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
 
     trace_curl_co_preadv(qemu_coroutine_self(), offset, bytes);
 
+    bytes += s->readahead_size;
+
     while (bytes > 0) {
         uint64_t len = MIN(bytes, s->blocksize - curl_block_offset(s, off));
         CURLAIOCB acb = {
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 56843cb38f..58245e017c 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -174,6 +174,13 @@ These are specified using a special URL syntax.
    ``url``
       The full URL when passing options to the driver explicitly.
 
+   ``readahead``
+      The amount of data to read ahead with each range request to the
+      remote server. This value may optionally have the suffix 'T', 'G',
+      'M', 'K', 'k' or 'b'. If it does not have a suffix, it will be
+      assumed to be in bytes. The value must be a multiple of 512 bytes.
+      It defaults to 256k.
+
    ``sslverify``
       Whether to verify the remote server's certificate when connecting
       over SSL. It can have the value 'on' or 'off'. It defaults to
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91888166fa..f4092ccc14 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3752,6 +3752,8 @@
 #
 # @url: URL of the image file
 #
+# @readahead: Amount of read-ahead (defaults to 0)
+#
 # @timeout: Timeout for connections, in seconds (defaults to 5)
 #
 # @username: Username for authentication (defaults to none)
@@ -3776,6 +3778,7 @@
   'data': { 'url': 'str',
             '*blocksize': 'int',
             '*blockcount': 'int',
+            '*readahead': 'int',
             '*timeout': 'int',
             '*username': 'str',
             '*password-secret': 'str',
-- 
2.27.0


