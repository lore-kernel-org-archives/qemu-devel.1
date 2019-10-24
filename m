Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19245CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E29205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N/Uob2or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E29205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZMs-00044M-Cr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8w-0006vZ-Lu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8v-0004Nz-GI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8v-0004NI-8T
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94W6c116458;
 Thu, 24 Oct 2019 09:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=CfeS7iUSG1xTfxKr2e8mFCrwRrKlSOQSZckWDmK6o5k=;
 b=N/Uob2or97TR3xzlrHzsQPggk8JtEjnChajKXA3YMQ0ccN+RcN1QIX56IA8PVk1+9e3m
 brk1N/ZqXjyEna8Y5WrPny9yUbf/LAvekJYm5KarItW1AurvktTpM3gr3FTH3qQ5rXEG
 3XHY4ncb1F07zIa3ID9qtS517PwLxtvs9+W13kyB2Yumvwhd/9NeqsE8dHmAxNL67oAV
 5E1oX9I9oYW4qPjOJvsys3AUO/rgahmLhN94tDfNqE5H7EPah0DZUbsz9Whz0OzKm3ky
 zCv9i5kNCLvr+yxbZCUc2XsJp9Jf559fmgVrq5OOUl6+YsSRvCKzRubiv9e28TtW2bAS Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2vqswtte07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97j1R170537;
 Thu, 24 Oct 2019 09:10:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2vtsk486v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9AkAO002271;
 Thu, 24 Oct 2019 09:10:46 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:46 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 23/49] multi-process: remote: add create_done condition
Date: Thu, 24 Oct 2019 05:09:04 -0400
Message-Id: <4f39a3190d10eef9341cc0b2b7a43f90ceeb17b2.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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
index cb2829e..80d8c02 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -68,6 +68,7 @@
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
+bool create_done;
 
 static void process_config_write(MPQemuMsg *msg)
 {
@@ -370,21 +371,31 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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
@@ -404,7 +415,7 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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


