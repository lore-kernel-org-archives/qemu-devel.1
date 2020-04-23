Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C346C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640732075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+YgvsrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640732075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTPK-0007ct-HO
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGq-00019O-AA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGp-00086E-LR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGp-00083w-1V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DF3K064448;
 Thu, 23 Apr 2020 04:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=HfeRmG6K9nkKRkIY5gOQdWsLyLw6GvbDT6AISfqUr44=;
 b=S+YgvsrFC7sRyP4o0WmPdN38MDh4MbRVTbMr3l1+fxRhfLyfDX+BEqwBUXAFUQwKIWFb
 s9fM6slQkrDVygTNEgwFegrdfQegdf4HKWkgxWn2Y7mm0xFtYe5Yh9yGB9caNy5a13bq
 nsJ6UGD2QuoyxNeVRldwDhb0yz6kWoWPxFKPzpB02bQj8508hmT3E15DxHqJERDJMVgs
 +SkuVbWRKNzZWjQLra8OYFlM4RETgn9KEhzCJClwmAcIrgAHVYLPCfAmG05YMg7r810X
 DnG/8a4vhSOG+B3uATayIsU13C6Smp6x97E/5xOdCto3XN/5IheNmTeNtcOSmgU5Fc8N rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30grpgtrtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DWKq168843;
 Thu, 23 Apr 2020 04:15:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 30gb942hcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4FHxB020966;
 Thu, 23 Apr 2020 04:15:17 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:17 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 29/36] multi-process: handle heartbeat messages in
 remote process
Date: Wed, 22 Apr 2020 21:14:04 -0700
Message-Id: <5c66c9f8df2278401b7ad58ff8606ae027f1fcec.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=1 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

If the remote process is alive, it responds to proxy's heartbeat
messages

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index b37802151a..beac591fac 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -216,6 +216,7 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     g_autofree gchar *pid_exec = NULL;
 
     pid_exec = g_malloc(PROC_INFO_LENGTH);
+    int wait;
 
     if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
         goto finalize_loop;
@@ -269,6 +270,10 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     case GET_PCI_INFO:
         process_get_pci_info_msg(link, msg);
         break;
+    case PROXY_PING:
+        wait = msg->fds[0];
+        notify_proxy(wait, 0);
+        break;
     default:
         error_setg(&err, "Unknown command in %s", print_pid_exec(pid_exec));
         goto finalize_loop;
-- 
2.25.GIT


