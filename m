Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8154BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E641206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jREoPBkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E641206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zXv-0006S0-HC
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUT-0002Go-D9; Tue, 18 Aug 2020 07:09:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076f-8g; Tue, 18 Aug 2020 07:09:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB2u1H087325;
 Tue, 18 Aug 2020 11:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ctheGkrx6Z2y80wz3SfvN0VobCBlXVpiKlb2oxEZfOQ=;
 b=jREoPBkMUdGBreZTHkx3E/kVejbwB2yraYf5B0xv7065UmWkNC4tl5ZEbSmWRkR/uOLr
 LAIkwQIT2jVSciz+DQdiJ/ptSr9kM8ozdfREfCDQDUR2KLqd+kH8M0ZDRYgn/4+G1rzT
 l2/+9RjrCypj+kIkIpE8XgvVeKD+t0ZAbyzBTUwUW4MmGM4KD2fvXXhZFNQ88xXb6gOL
 FfIAZHfbjvk2l5EJV1Kq4Yobq/rtFqWfgeUPFcZK01jiqB7POQpIHxxDm83CAjbzIrtX
 4IoqFozCcyS3N+ofECNNOKSs7TdzC1T/+3ZR2lMsegrkJ221NHZMYPcjaTjo1L9yOOwJ kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 32x8bn3y92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8D3Q003000;
 Tue, 18 Aug 2020 11:08:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 32xsfrqxnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IB8vko001400;
 Tue, 18 Aug 2020 11:08:57 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:57 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 38ad3745;
 Tue, 18 Aug 2020 11:08:46 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 7/9] block/curl: Allow the user to control the number of
 cache blocks
Date: Tue, 18 Aug 2020 12:08:43 +0100
Message-Id: <20200818110845.3825105-8-david.edmondson@oracle.com>
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

Rather than using a fixed number, allow the user to specify the number
of cache blocks allocated. This cannot be less than the number of Curl
states and defaults to that value.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c                          | 20 +++++++++++++++++---
 docs/system/device-url-syntax.rst.inc |  4 ++++
 qapi/block-core.json                  |  4 ++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 0ea9eedebd..27fa77c351 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -75,14 +75,15 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
 #define CURL_BLOCK_OPT_OFFSET "offset"
 #define CURL_BLOCK_OPT_BLOCKSIZE "blocksize"
+#define CURL_BLOCK_OPT_BLOCKCOUNT "blockcount"
 
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
 /* Must be a non-zero power of 2. */
 #define CURL_BLOCK_OPT_BLOCKSIZE_DEFAULT (256 * 1024)
+/* The defaultnumber of blocks to store in the cache. */
+#define CURL_BLOCK_OPT_BLOCKCOUNT_DEFAULT (CURL_NUM_STATES)
 
-/* The maximum number of blocks to store in the cache. */
-#define CURL_BLOCK_CACHE_MAX_BLOCKS 100
 /* The number of heads in the hash table. */
 #define CURL_BLOCK_CACHE_HASH 37
 
@@ -161,6 +162,7 @@ typedef struct BDRVCURLState {
     char *proxypassword;
     size_t offset;
     size_t blocksize;
+    int cache_max;
     int cache_allocated; /* The number of block_t currently allocated. */
     QLIST_HEAD(, block) cache_free;
     QTAILQ_HEAD(, block) cache_lru;
@@ -287,7 +289,7 @@ static block_t *curl_cache_get(BDRVCURLState *s)
     }
 
     /* If not at the limit, try get a new one. */
-    if (s->cache_allocated < CURL_BLOCK_CACHE_MAX_BLOCKS) {
+    if (s->cache_allocated < s->cache_max) {
         b = curl_cache_alloc(s);
         if (b) {
             b->use++;
@@ -929,6 +931,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Block size for IO requests"
         },
+        {
+            .name = CURL_BLOCK_OPT_BLOCKCOUNT,
+            .type = QEMU_OPT_SIZE,
+            .help = "Maximum number of cached blocks"
+        },
         { /* end of list */ }
     },
 };
@@ -1039,6 +1046,13 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "blocksize must be a non-zero power of two");
         goto out_noclean;
     }
+    s->cache_max = qemu_opt_get_size(opts, CURL_BLOCK_OPT_BLOCKCOUNT,
+                                     CURL_BLOCK_OPT_BLOCKCOUNT_DEFAULT);
+    if (s->cache_max < CURL_NUM_STATES) {
+        error_setg(errp, "blockcount must be larger than %d",
+            CURL_NUM_STATES - 1);
+        goto out_noclean;
+    }
 
     trace_curl_open(file);
     qemu_co_queue_init(&s->free_state_waitq);
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index ee504ee41a..56843cb38f 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -201,6 +201,10 @@ These are specified using a special URL syntax.
       bytes. The value must be a non-zero power of two.  It defaults
       to 256kB.
 
+   ``blockcount``
+      The number of ``blocksize`` blocks that the system may allocate
+      to store data read from the remote server.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index cd16197e1e..91888166fa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3767,11 +3767,15 @@
 # @blocksize: Size of all IO requests sent to the remote server; must
 #             be a non-zero power of two (defaults to 1 256kB)
 #
+# @blockcount: The number of IO blocks used to cache data from the
+#              remote server.
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlBase',
   'data': { 'url': 'str',
             '*blocksize': 'int',
+            '*blockcount': 'int',
             '*timeout': 'int',
             '*username': 'str',
             '*password-secret': 'str',
-- 
2.27.0


