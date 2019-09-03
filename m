Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E042087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="es5N8pgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E042087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5FxF-0004CF-Vl
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa6-0007ia-8p
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa5-0000ZD-6k
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fa4-0000Yh-Ut
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXnO7062420;
 Tue, 3 Sep 2019 20:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Ysu5jn80UX+ZgnoT6SpiYiJ+o+4SFIvcyo89drIYcac=;
 b=es5N8pgbaH6W1OgB0CwTOtuWMf77eJuEbRnweWOqhA7oKixq3eACE0Z3yYLpOt56Momi
 8Z7w/Aiym1fsasSeyyI9N8pIOQwNwLi3O/iMBWrHkU2VkIxzvDknUPeOdKdrjQ52wsTd
 ClzncdbEmr68XrmtyK7dUQ2LdecZo9wp1A6wRw3ZbVtmau1oRYgj7MvFhvwGD5wNxRQC
 Bn5i4PthSdhnRGXMCHjZt/aLQ0H0vAxLt+FAzouXJO4twFQTg6xwDf6wIH+lXzFJtm4C
 LBtXkzeHjUgD5IxBQWMU82u2We+u321N5YRuukuOdGxdjOFVxdIqA/PwrYfrzXSJycyy Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2usy66r2gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcabZ178298;
 Tue, 3 Sep 2019 20:39:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegqvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:05 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kd4ng012751;
 Tue, 3 Sep 2019 20:39:04 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:04 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:52 -0400
Message-Id: <ba7fcae552bc5d96758f480be1e4ba1d03a297d7.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 26/45] multi-process: remote: add
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
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
index e284d5f..0c0e085 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -67,6 +67,7 @@
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
+bool create_done;
 
 static void process_config_write(ProcMsg *msg)
 {
@@ -369,21 +370,31 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
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
@@ -403,7 +414,7 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         qemu_mutex_lock_iothread();
         qemu_run_machine_init_done_notifiers();
         qemu_mutex_unlock_iothread();
-
+        create_done = true;
         break;
     case DRIVE_OPTS:
         if (setup_drive(msg, &err)) {
-- 
1.8.3.1


