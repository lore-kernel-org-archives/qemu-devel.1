Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847AFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEE4206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PLb3dLVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEE4206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zXR-0005Mo-IV
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUY-0002JX-18; Tue, 18 Aug 2020 07:09:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zUQ-00076o-96; Tue, 18 Aug 2020 07:09:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB2v9R087354;
 Tue, 18 Aug 2020 11:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=x3Dh2/JmRtxmh5OeI1BYJUv8aun0xV+VgwW8SIM7KlM=;
 b=PLb3dLVZR7fprmsOnX6yJ9oHyVF37eohhE7G6hvkd82I6vA9fHU+23m/4KR3mH5xR7EP
 72iII/DNV9y+2DH1zkPUnlbYWBIhjr5xLkdFT1bsN5FiAkPTjhMtxqe3cw+nCZi9DVJ4
 2w3u+oTqjOvSHsT/5Aj9IcJDYPK9m4AC3ZJL7BLcn3iTVK+le8hD1g5qtmHeUMci4g7o
 0yw5dqRH2u+d0b7B+l89s9+Ff0M8ABh53gIRt9BMHbixCYbiQ7ubgXMyHUvZ1d3+72o+
 rp6XCnl15XpCGkG4IQCaR79oHewCD7lRvPZTFFIiWN2rCQJV869cW397wMzBV5sUeIv5 FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32x8bn3y82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:08:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB7kOD157095;
 Tue, 18 Aug 2020 11:08:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32xsm2k60v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:51 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IB8o0a001371;
 Tue, 18 Aug 2020 11:08:50 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:50 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 57458c2b;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/9] block/curl: Add an 'offset' parameter,
 affecting all range requests
Date: Tue, 18 Aug 2020 12:08:37 +0100
Message-Id: <20200818110845.3825105-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=3
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 impostorscore=0 suspectscore=3 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
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

A new 'offset' parameter affects all range requests that are sent to
the remote server. The value, in bytes, is simply added to any byte
offset values passed in to the driver.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c                          | 12 +++++++++++-
 docs/system/device-url-syntax.rst.inc |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 4f907c47be..32ec760f66 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -74,6 +74,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
+#define CURL_BLOCK_OPT_OFFSET "offset"
 
 #define CURL_BLOCK_OPT_READAHEAD_DEFAULT (256 * 1024)
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
@@ -135,6 +136,7 @@ typedef struct BDRVCURLState {
     char *password;
     char *proxyusername;
     char *proxypassword;
+    size_t offset;
 } BDRVCURLState;
 
 static void curl_clean_state(CURLState *s);
@@ -658,6 +660,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of secret used as password for HTTP proxy auth",
         },
+        {
+            .name = CURL_BLOCK_OPT_OFFSET,
+            .type = QEMU_OPT_SIZE,
+            .help = "Offset into underlying content"
+        },
         { /* end of list */ }
     },
 };
@@ -769,6 +776,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    s->offset = qemu_opt_get_size(opts, CURL_BLOCK_OPT_OFFSET, 0);
+
     trace_curl_open(file);
     qemu_co_queue_init(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
@@ -899,7 +908,8 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     }
     state->acb[0] = acb;
 
-    snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64, start, end);
+    snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64,
+             s->offset + start, s->offset + end);
     trace_curl_setup_preadv(acb->bytes, start, state->range);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 88d7a372a7..33f1ddfe6d 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -197,6 +197,10 @@ These are specified using a special URL syntax.
       get the size of the image to be downloaded. If not set, the
       default timeout of 5 seconds is used.
 
+   ``offset``
+      Add an offset, in bytes, to all range requests sent to the
+      remote server.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
-- 
2.27.0


