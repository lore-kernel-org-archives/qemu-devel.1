Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB033C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81B12465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wmZ60gmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81B12465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PPc-0008DG-Tr
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1j4POZ-0006Yh-Hk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1j4POY-0004wB-Ff
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:28:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1j4POS-0004ou-IA; Wed, 19 Feb 2020 08:28:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JDJE2h097137;
 Wed, 19 Feb 2020 13:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5ocdY08IEE1IEW6dKvI5l6OPdlNgoONwqxta5oLdrSQ=;
 b=wmZ60gmx1TZ/J2mV0bnc4pdtA0QWQDIQNJo4mcBkEz8IkyBfm4PqusXFcrThusHIBCts
 yr6ArVF5xtWWS7+a7YcCT4Zzky+263tLkYAgUN4qLDKrazzmUymQ9cngiBeRXlCmMs1Q
 st+wgipeD1t5LZWzD0SAi2SHxG8J9h79dQEI2Tq90xzN2r9/o6Jql+0RS8PRj1hK/+9i
 IJa7mdJj4bbzi9uVw1TfhBMggq7D53IqMGizgNKxZOSYnHyfBihYJHG9JzeA0ywCkibx
 CQbu3+wpqnp599YRocTpD6e4CS8QqkLpE/eYWA8LzoR/JyO8iSxCNr8rQgfkNVuvA1Du Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2y8udkaxp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 13:27:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JDIp0Z113257;
 Wed, 19 Feb 2020 13:27:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2y8udageyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 13:27:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JDRoQK005652;
 Wed, 19 Feb 2020 13:27:50 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Feb 2020 05:27:49 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 44951f96;
 Wed, 19 Feb 2020 13:27:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block/curl: HTTP header field names are case insensitive
Date: Wed, 19 Feb 2020 13:27:44 +0000
Message-Id: <20200219132745.315381-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219132745.315381-1-david.edmondson@oracle.com>
References: <20200219132745.315381-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=1
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
 block/curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 0cf99a4b31b8..4256659cd85b 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -216,11 +216,11 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     size_t realsize = size * nmemb;
     const char *header = (char *)ptr;
     const char *end = header + realsize;
-    const char *accept_ranges = "Accept-Ranges:";
+    const char *accept_ranges = "accept-ranges:";
     const char *bytes = "bytes";
 
     if (realsize >= strlen(accept_ranges)
-        && strncmp(header, accept_ranges, strlen(accept_ranges)) == 0) {
+        && strncasecmp(header, accept_ranges, strlen(accept_ranges)) == 0) {
 
         char *p = strchr(header, ':') + 1;
 
-- 
2.24.1


