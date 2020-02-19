Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F1C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ABD2465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xUtA9V2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ABD2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PPU-0007qI-D6
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1j4POX-0006WD-Uj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1j4POW-0004vb-TD
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:28:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1j4POU-0004uE-Lg; Wed, 19 Feb 2020 08:28:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JDS1tJ016061;
 Wed, 19 Feb 2020 13:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=7WygD6+kjiCue9xK0ryDh1l6dlgkKsAMTazxsr2Kvqk=;
 b=xUtA9V2SLFlIYdr+moO2/Bmcv9pm7o0JGRLYm5OWJ6hKh0pBls2N1Ty5V22CDtmfsHa0
 Lvu0U/AV9bO+vFQagPe8rxbeejFqFSVxcHqEL9LyfhGpvhW4BTGufO387JMLqqlyND/7
 Q8dp6mVQbiy3uIvBKPhpoJG91HbMy9BZ+gcgVe4KpuNdB7TXfu7eAADCQ/ilc12nrG8v
 SW2Tebofz4PV3MddDUHXNPzuk6efi068LRthQBZOVjYodyy9K7BxJkYjklItGF1yTAZD
 iwIiKj7pC7GBxxItUr41PXUtBErZ3U/ZKGuNLUBmB2zLgs9fEKIoPbwvcjOpSUw40f6W 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2y8ud12y2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 13:27:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JDRsv3175877;
 Wed, 19 Feb 2020 13:27:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2y8ud5eab2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 13:27:54 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JDRnuQ030143;
 Wed, 19 Feb 2020 13:27:49 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Feb 2020 05:27:48 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id c325e49d;
 Wed, 19 Feb 2020 13:27:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block/curl: HTTP header fields allow whitespace around
 values
Date: Wed, 19 Feb 2020 13:27:43 +0000
Message-Id: <20200219132745.315381-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219132745.315381-1-david.edmondson@oracle.com>
References: <20200219132745.315381-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
index f86299378e38..0cf99a4b31b8 100644
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
+        while (p < end && *p && isspace(*p)) {
+            p++;
+        }
+
+        if (end - p >= strlen(bytes)
+            && strncmp(p, bytes, strlen(bytes)) == 0) {
+
+            /* Check that there is nothing but whitespace after the value. */
+            p += strlen(bytes);
+            while (p < end && *p && isspace(*p)) {
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


