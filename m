Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211E4C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E320620836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vbk5ecxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E320620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Amn-0004YW-4n
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1j6Alq-0003nE-1A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1j6Alp-00008f-0Z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:15:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1j6Alm-00007s-PQ; Mon, 24 Feb 2020 05:15:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OA8hBn181774;
 Mon, 24 Feb 2020 10:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vd5sFw3qNEnV1Mixjp2eKzNcxIzP27mp+jXhLzL8VWA=;
 b=vbk5ecxWB4SBb/N1zlavYQg22xBU9OVy97y7APBP3tAJyjzG6/U1lmEL0pr3npGCn9tt
 vWCVR6mhqXrkd00CMj+4rdsD3pxqLJliZWyFq+MHkyymCn4daes0/DStAO81RA6CXkK3
 dGYXR5W0Z/abvYviB/uwn+Y3aSK7bHzfwgEjhKwEaUx0I+oMO5f++AqB6mFcZpAYVElu
 a/O0dnVpFUjugoN4B8wHxFRaM+Tj+v8qXqzZXz/sMqRAvWIe8qwBrDOcPRUbb1SIdVvk
 Rh2TM1YY/mKJh6XoQQ1Ou456E2M+swJIsT6PeefCj8hjeLPAnDjtcFnZj3zO5RDqC1Lz 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yavxreba9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:15:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OADLxD105885;
 Mon, 24 Feb 2020 10:13:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2ybe10vvyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:13:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OADE35023148;
 Mon, 24 Feb 2020 10:13:14 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 02:13:14 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 14582e65;
 Mon, 24 Feb 2020 10:13:10 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] block/curl: HTTP header field names are case
 insensitive
Date: Mon, 24 Feb 2020 10:13:10 +0000
Message-Id: <20200224101310.101169-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224101310.101169-1-david.edmondson@oracle.com>
References: <20200224101310.101169-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240087
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

RFC 7230 section 3.2 indicates that HTTP header field names are case
insensitive.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 block/curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index f9ffb7f4e2bf..6e325901dc68 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -216,11 +216,12 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     size_t realsize = size * nmemb;
     const char *header = (char *)ptr;
     const char *end = header + realsize;
-    const char *accept_ranges = "Accept-Ranges:";
+    const char *accept_ranges = "accept-ranges:";
     const char *bytes = "bytes";
 
     if (realsize >= strlen(accept_ranges)
-        && strncmp(header, accept_ranges, strlen(accept_ranges)) == 0) {
+        && g_ascii_strncasecmp(header, accept_ranges,
+                               strlen(accept_ranges)) == 0) {
 
         char *p = strchr(header, ':') + 1;
 
-- 
2.24.1


