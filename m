Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC2DC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7F820CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwzgAdqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7F820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L1d-0007St-2n
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmO-0006oh-6V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmN-0003PN-3z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmM-0003OT-Rb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKsmt1033177;
 Mon, 24 Feb 2020 20:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=zaDOAuNzb7bSFTKfgqg9CoM++Bom7NI1IY7I/uCiA4w=;
 b=FwzgAdqgdq2oRBXSuKp0zYKIvSK3DY6vCFhHC0qJ2UWIyIdoXxraL/j4ev9Qao3/+HcU
 geDT9O6Ow8qMm4RpZZlxHRQf+CFNqDcFI1aoFWm57Kl/caa+l8bPooc5Fu8X/up+rK/n
 5kmPJDSRECHN+RyRasFAVAXHyEhFp9FZaXWS3kuyNHztlrdOBt/OjD26Eq3UYTMgQ07F
 lxz+piRCUGr623xUCJb4ky6umzf5xAeb7tZeAxNImNMZg1GAq3d1+P9h3DCtGEKJIOJm
 IqJBwzOwAoWAiNgEQDecedFANyodEzLOBWEqCWyAk8rSZSWqnZ80y+cgDCES+JQX3Zix gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yauqua0mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq5Vx171254;
 Mon, 24 Feb 2020 20:56:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ybdshks1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuW94028545;
 Mon, 24 Feb 2020 20:56:32 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:31 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 23/50] multi-process: remote: add create_done condition
Date: Mon, 24 Feb 2020 15:55:14 -0500
Message-Id: <40aa4a8ee828c39081dcec67c029bb665ec3f0d4.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
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

Do not allow BAR,MMIO handlers and irq setup to run before
the configuration of the devices completes.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 455cfb6..ec1ce2c 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -55,6 +55,7 @@
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
+bool create_done;
 
 static void process_config_write(MPQemuMsg *msg)
 {
@@ -332,21 +333,29 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         process_get_pci_info_msg(remote_pci_dev, msg);
         break;
     case PCI_CONFIG_WRITE:
-        process_config_write(msg);
+        if (create_done) {
+            process_config_write(msg);
+        }
         break;
     case PCI_CONFIG_READ:
-        process_config_read(msg);
+        if (create_done) {
+            process_config_read(msg);
+        }
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
@@ -366,7 +375,7 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         qemu_mutex_lock_iothread();
         qemu_run_machine_init_done_notifiers();
         qemu_mutex_unlock_iothread();
-
+        create_done = true;
         break;
     case DEV_OPTS:
         if (setup_device(msg, &err)) {
-- 
1.8.3.1


