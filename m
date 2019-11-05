Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF97C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B0C21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B0C21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6RO-0008T8-FC
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pc-0001Mv-Dh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pa-0002ST-1D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pZ-00026k-Ea; Tue, 05 Nov 2019 15:53:37 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpUxp056536; Tue, 5 Nov 2019 15:53:16 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3b2ettrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:16 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KpXkq056645;
 Tue, 5 Nov 2019 15:53:15 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3b2ettqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:15 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnuYl025651;
 Tue, 5 Nov 2019 20:53:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 2w11e797ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:14 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrD9v47907234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:13 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71147124064;
 Tue,  5 Nov 2019 20:53:13 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E3FB124058;
 Tue,  5 Nov 2019 20:53:13 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:13 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/55] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
Date: Tue,  5 Nov 2019 14:52:34 -0600
Message-Id: <20191105205243.3766-47-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Hikaru Nishida <hikarupsp@gmail.com>, qemu-stable@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hikaru Nishida <hikarupsp@gmail.com>

macOS API documentation says that before applicationDidFinishLaunching
is called, any events will not be processed. However, some events are
fired before it is called in macOS Catalina. This causes deadlock of
iothread_lock in handleEvent while it will be released after the
app_started_sem is posted.
This patch avoids processing events before the app_started_sem is
posted to prevent this deadlock.

Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
Message-id: 20191015010734.85229-1-hikarupsp@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit dff742ad27efa474ec04accdbf422c9acfd3e30e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/cocoa.m | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c2984028c5..3026ead621 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -132,6 +132,7 @@ NSArray * supportedImageFileTypes;
 
 static QemuSemaphore display_init_sem;
 static QemuSemaphore app_started_sem;
+static bool allow_events;
 
 // Utility functions to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
@@ -727,6 +728,16 @@ QemuCocoaView *cocoaView;
 
 - (bool) handleEvent:(NSEvent *)event
 {
+    if(!allow_events) {
+        /*
+         * Just let OSX have all events that arrive before
+         * applicationDidFinishLaunching.
+         * This avoids a deadlock on the iothread lock, which cocoa_display_init()
+         * will not drop until after the app_started_sem is posted. (In theory
+         * there should not be any such events, but OSX Catalina now emits some.)
+         */
+        return false;
+    }
     return bool_with_iothread_lock(^{
         return [self handleEventLocked:event];
     });
@@ -1154,6 +1165,7 @@ QemuCocoaView *cocoaView;
 - (void)applicationDidFinishLaunching: (NSNotification *) note
 {
     COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
+    allow_events = true;
     /* Tell cocoa_display_init to proceed */
     qemu_sem_post(&app_started_sem);
 }
-- 
2.17.1


