Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70EC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1C120863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2Zz/+LHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1C120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwwr-0000eR-4P
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwDk-0007VK-6t
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwDi-0003LG-31
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwDe-0003Ga-6k
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8kqW159089;
 Mon, 17 Jun 2019 18:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=9UgWmtvvAV/ZZCrYFl6U+Qd9jb1Xm7JEF6cA8cbvnzw=;
 b=2Zz/+LHaYm7wZks12HQ5QRKhV9ueWCDRaOHcs5MlUa8orfAxGdbw/puu2n7iYp1l8ssE
 bPX6O6DziDgtUDFLdLuDY9f6m3jUlFiqbJIHDmbDv9N1lofYKG6y98XkYlCmJhOI7o2S
 mdOEPrMG7OHwupV5bF+oWFwjywIFS3dFRa4EQEBLOokLnaQvKoc9PVtImEorx84mjdjb
 9noQv2VF0D6KWbl0UG3sPMHj5HfXJayegaHOcElgEOP+107OavOPWyKBauDusLmnJRAx
 yk2NwHuJjJLzKWSugpnj2e5thltJzxoh7ZnAZiuT74zo9bWWb9yKJAtFMkFKO/Bubnl7 Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7yu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:18:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGPCx181193;
 Mon, 17 Jun 2019 18:16:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgbaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIGtmZ032583;
 Mon, 17 Jun 2019 18:16:55 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:54 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:52 -0700
Message-Id: <20190617181653.30506-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 30/35] multi-process: handle heartbit
 messages in remote process
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

and reply back to proxy object.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index c1362be93e..43134762bc 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -353,6 +353,7 @@ static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
     Error *err = NULL;
+    int wait;
 
     if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
         error_setg(&err, "socket closed, cond is %d", cond);
@@ -432,6 +433,11 @@ static void process_msg(GIOCondition cond)
     case DEVICE_DEL:
         process_device_del_msg(msg);
         break;
+    case PROXY_PING:
+        wait = msg->fds[0];
+        notify_proxy(wait, (uint32_t)getpid());
+        PUT_REMOTE_WAIT(wait);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.17.1


