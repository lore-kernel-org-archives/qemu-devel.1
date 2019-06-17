Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F79C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A82B2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dOin0zfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A82B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwir-0003Kv-MB
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBc-0005kI-P4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBb-0002CQ-4W
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBa-00027T-Pb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8pLO149263;
 Mon, 17 Jun 2019 18:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=LzNHre/dMqP+ulT94D53LrSVfQM6ghTZ76CN8SCm75g=;
 b=dOin0zfyVRK/MPR5PBCF6MbPjYutewOqRVdhLzbWJ2QCHPDo2pIr9JJ/LZhbtTMbHm8o
 b+OrtrJarLYtiVBoC+yFU9OijI9pFgpHElBXUy5XTSc+3yQsdBwFdOLpoIWfFmj2osiB
 kEocWFIaB7PxKm3xYWxHp6NHW3zS8PcFgtORcQ+Puee/XL3s7BqCjf65Pc5iYR3ZrV7U
 JEc5xeLsGlkkUBAksS1Qf+e19VdUueEbxMOrSaxUW3rQnei/USXO7ONN6o+LT/rJU+l+
 XXpb3uWGtX/FLcIuf8edfdLEfd6R1AUcltpzEZfp8ppa61yuuKYG1mdH3+e4WWcXsd4D Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t4r3tg30j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIG86K188001;
 Mon, 17 Jun 2019 18:16:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t59gdcd6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:48 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIGlK1028429;
 Mon, 17 Jun 2019 18:16:47 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:47 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:45 -0700
Message-Id: <20190617181645.30370-1-elena.ufimtseva@oracle.com>
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
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 27/35] multi-process: remote: add
 create_done condition
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

Do not allow BAR,MMIO handlers and irq setup to run before
the configuration of the devices completes.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 5c26339ed7..c1362be93e 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -67,6 +67,7 @@
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
+bool create_done;
 
 static void process_config_write(ProcMsg *msg)
 {
@@ -369,21 +370,31 @@ static void process_msg(GIOCondition cond)
     case INIT:
         break;
     case CONF_WRITE:
-        process_config_write(msg);
+        if (create_done) {
+            process_config_write(msg);
+        }
+
         break;
     case CONF_READ:
-        process_config_read(msg);
+        if (create_done) {
+            process_config_read(msg);
+        }
+
         break;
     case BAR_WRITE:
-        process_bar_write(msg, &err);
-        if (err) {
-            goto finalize_loop;
+        if (create_done) {
+            process_bar_write(msg, &err);
+            if (err) {
+                error_report_err(err);
+            }
         }
         break;
     case BAR_READ:
-        process_bar_read(msg, &err);
-        if (err) {
-            goto finalize_loop;
+        if (create_done) {
+            process_bar_read(msg, &err);
+            if (err) {
+                error_report_err(err);
+            }
         }
         break;
     case SYNC_SYSMEM:
@@ -403,7 +414,7 @@ static void process_msg(GIOCondition cond)
         qemu_mutex_lock_iothread();
         qemu_run_machine_init_done_notifiers();
         qemu_mutex_unlock_iothread();
-
+        create_done = true;
         break;
     case DRIVE_OPTS:
         if (setup_drive(msg, &err)) {
-- 
2.17.1


