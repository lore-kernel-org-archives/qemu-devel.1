Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CCAC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13E720880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQsKz5ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDaIp-0006S7-9x
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:51:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDZa4-0003SK-Bl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDZZy-0008UB-O0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hDZZu-0008OB-UP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38In077157615; Mon, 8 Apr 2019 19:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id; s=corp-2018-07-02;
	bh=ZNrDtSWIMlyI8qE2QjJMmr3wLtkOZtYqEK3sdY7bBes=;
	b=nQsKz5ihiyk2Abng6NGyBal5FYJNaNPzo3MTa9Ig9zS/0I5YONYbstwVuN1df71Cgfyt
	TkA9AgTIp5GmzeWUcC9Z6Ww6xQE9S9f3Ie0OIFhTTkj223jzxKwddkZXNJh0yCzVCFnR
	058Kz9u70tiEH7LXqXF2gxAlh3ZxjdzIds/ugdd+WMEY5OWTTwQlmA7A4NJRec1PrlGj
	BJi5Im3nrkjOsrPnXU4tNInvI9ytqv4tYj34KEfzwyGnQqoATYHz61mEgovkJYhuiP9Q
	xi3jEJH4kmddFhRNUWS4NsnpTpdZhzjSdF6rwS3Gvfdf7te5R4hpZntJyA5N+c60yq77
	GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2rpmrq0efv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 19:05:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38J4P3r141846; Mon, 8 Apr 2019 19:05:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2rph7s65d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 19:05:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38J513r024211;
	Mon, 8 Apr 2019 19:05:01 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 08 Apr 2019 12:05:01 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 15:04:36 -0400
Message-Id: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=849
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904080148
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=878
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904080148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
X-Mailman-Approved-At: Mon, 08 Apr 2019 15:50:38 -0400
Subject: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lidong.chen@oracle.com, darren.kenny@oracle.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408190436.qWP4FFUFM68mBZ65Efk4sBeyQGYXIkpFtaPKyqY7E68@z>

Due to an off-by-one error, the assert statements allow an
out-of-bounds array access.

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaab15f..818f86c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
     if (state == sd_inactive_state) {
         return "inactive";
     }
-    assert(state <= ARRAY_SIZE(state_name));
+    assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
 
@@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     if (rsp == sd_r1b) {
         rsp = sd_r1;
     }
-    assert(rsp <= ARRAY_SIZE(response_name));
+    assert(rsp < ARRAY_SIZE(response_name));
     return response_name[rsp];
 }
 
-- 
1.8.3.1


