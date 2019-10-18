Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14102CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4982064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4982064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPOC-0001nm-V5
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLPJt-0005N8-Ab
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLPJs-0002W9-6M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLPJs-0002V8-0W
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 380D63090FEC;
 Fri, 18 Oct 2019 10:17:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4823619C77;
 Fri, 18 Oct 2019 10:17:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 341699D69; Fri, 18 Oct 2019 12:17:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] ui: Fix hanging up Cocoa display on macOS 10.15 (Catalina)
Date: Fri, 18 Oct 2019 12:17:08 +0200
Message-Id: <20191018101711.24105-2-kraxel@redhat.com>
In-Reply-To: <20191018101711.24105-1-kraxel@redhat.com>
References: <20191018101711.24105-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 10:17:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hikaru Nishida <hikarupsp@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
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
---
 ui/cocoa.m | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index f12e21df6e10..fbb5b1b45f81 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -134,6 +134,7 @@ NSArray * supportedImageFileTypes;
 
 static QemuSemaphore display_init_sem;
 static QemuSemaphore app_started_sem;
+static bool allow_events;
 
 // Utility functions to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
@@ -729,6 +730,16 @@ QemuCocoaView *cocoaView;
 
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
@@ -1156,6 +1167,7 @@ QemuCocoaView *cocoaView;
 - (void)applicationDidFinishLaunching: (NSNotification *) note
 {
     COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
+    allow_events = true;
     /* Tell cocoa_display_init to proceed */
     qemu_sem_post(&app_started_sem);
 }
-- 
2.18.1


