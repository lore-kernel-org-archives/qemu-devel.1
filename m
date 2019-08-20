Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF42EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A193B22CF5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A193B22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyNv-00072U-AX
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8W-0005g9-Up
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8Q-0003Gg-2o
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8P-0003Fj-Pb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCBFE307D962
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:48 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A71107E032;
 Tue, 20 Aug 2019 07:00:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:35 +0200
Message-Id: <1566284395-30287-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 20 Aug 2019 07:00:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/36] mc146818rtc: Remove reset notifiers
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The reset notifiers are unreliable and recalculating the offsets
after boot causes problems with migration in cases where explicit
base times are set on the destination.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190724115823.4199-2-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index ce4550b..352ff9d 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -92,7 +92,6 @@ typedef struct RTCState {
     uint32_t irq_coalesced;
     uint32_t period;
     QEMUTimer *coalesced_timer;
-    Notifier clock_reset_notifier;
     LostTickPolicy lost_tick_policy;
     Notifier suspend_notifier;
     QLIST_ENTRY(RTCState) link;
@@ -885,20 +884,6 @@ static const VMStateDescription vmstate_rtc = {
     }
 };
 
-static void rtc_notify_clock_reset(Notifier *notifier, void *data)
-{
-    RTCState *s = container_of(notifier, RTCState, clock_reset_notifier);
-    int64_t now = *(int64_t *)data;
-
-    rtc_set_date_from_host(ISA_DEVICE(s));
-    periodic_timer_update(s, now, 0);
-    check_update_timer(s);
-
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-        rtc_coalesced_timer_update(s);
-    }
-}
-
 /* set CMOS shutdown status register (index 0xF) as S3_resume(0xFE)
    BIOS will read it and start S3 resume at POST Entry */
 static void rtc_notify_suspend(Notifier *notifier, void *data)
@@ -984,10 +969,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
     check_update_timer(s);
 
-    s->clock_reset_notifier.notify = rtc_notify_clock_reset;
-    qemu_clock_register_reset_notifier(rtc_clock,
-                                       &s->clock_reset_notifier);
-
     s->suspend_notifier.notify = rtc_notify_suspend;
     qemu_register_suspend_notifier(&s->suspend_notifier);
 
-- 
1.8.3.1



