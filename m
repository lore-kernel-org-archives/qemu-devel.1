Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B70C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49A520836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPTTh9dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49A520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Akn-0002EW-2h
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1j6Ajy-0001An-Dk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1j6Ajx-00085w-7X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:13:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1j6Ajv-00084Y-10; Mon, 24 Feb 2020 05:13:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OA9GLk151243;
 Mon, 24 Feb 2020 10:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=iBNQeoHxQwvpeGKNBw3AigaYz1rA0uTaMhD0FMSxPgc=;
 b=dPTTh9dqpZFVD14S6aErbJ6z9h5PilQ44qhHjU8lSnyrrrMQApVMDbuX5fvPqrWO50CJ
 NluTIRQniXZuO/H5pkwdkVg+p6k92cfs3rcnwU754XB6Rk7RrachYLsLiYIjIWMIpT0E
 ZBFt7kAu/pA1cW0XW3R/o0ub8jRh6Jm881yicFXlEexVlJN50chbdW4a4T/9A3QVh6e2
 tskZZzk3lh933vN49FoqxWhM5lJ5YepBeo5rlj6w0g8tQpYvakTVqTlqWHkaT7T21lAf
 wpmdzH9z5z2EJmpxW5Vyk4lJs98QiDfRZyODMc6D6j1EXSOqFuW9NvYY6SnVCUl+ZRCB Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2yauqu6ckd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:13:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OADODV052180;
 Mon, 24 Feb 2020 10:13:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yby5bbkkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:13:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OADDJE023138;
 Mon, 24 Feb 2020 10:13:13 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 02:13:13 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id beb9d708;
 Mon, 24 Feb 2020 10:13:10 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] block/curl: HTTP header fields allow whitespace around
 values
Date: Mon, 24 Feb 2020 10:13:09 +0000
Message-Id: <20200224101310.101169-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224101310.101169-1-david.edmondson@oracle.com>
References: <20200224101310.101169-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=995 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: Kevin Wolf <kwolf@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC 7230 section 3.2 indicates that whitespace is permitted between
the field name and field value and after the field value.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index f86299378e38..f9ffb7f4e2bf 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -214,11 +214,34 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
     size_t realsize = size * nmemb;
-    const char *accept_line = "Accept-Ranges: bytes";
+    const char *header = (char *)ptr;
+    const char *end = header + realsize;
+    const char *accept_ranges = "Accept-Ranges:";
+    const char *bytes = "bytes";
 
-    if (realsize >= strlen(accept_line)
-        && strncmp((char *)ptr, accept_line, strlen(accept_line)) == 0) {
-        s->accept_range = true;
+    if (realsize >= strlen(accept_ranges)
+        && strncmp(header, accept_ranges, strlen(accept_ranges)) == 0) {
+
+        char *p = strchr(header, ':') + 1;
+
+        /* Skip whitespace between the header name and value. */
+        while (p < end && *p && g_ascii_isspace(*p)) {
+            p++;
+        }
+
+        if (end - p >= strlen(bytes)
+            && strncmp(p, bytes, strlen(bytes)) == 0) {
+
+            /* Check that there is nothing but whitespace after the value. */
+            p += strlen(bytes);
+            while (p < end && *p && g_ascii_isspace(*p)) {
+                p++;
+            }
+
+            if (p == end || !*p) {
+                s->accept_range = true;
+            }
+        }
     }
 
     return realsize;
-- 
2.24.1


