Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C3ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9693D206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIYL-0002KH-62
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1iIGtB-0004S1-Gv
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1iIGtA-0004sn-H0
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1iIGtA-0004sH-BM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB6052A09AC;
 Wed,  9 Oct 2019 18:40:41 +0000 (UTC)
Received: from amt.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FFAD61F24;
 Wed,  9 Oct 2019 18:40:41 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id 7993310516E;
 Wed,  9 Oct 2019 15:40:23 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x99IeIIi027715;
 Wed, 9 Oct 2019 15:40:18 -0300
Date: Wed, 9 Oct 2019 15:40:14 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191009184011.GA26234@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 09 Oct 2019 18:40:42 +0000 (UTC)
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
Cc: Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest. 

In that case, old_period is 0, which ends up zeroing irq_coalesced
(counter of reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

Fix by not updating s->irq_coalesced when old_period is 0.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb378751b..aabffa8c67 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -241,7 +241,10 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
 
             s->period = period;
             lost_clock += old_irq_coalesced * old_period;
-            s->irq_coalesced = lost_clock / s->period;
+            if (old_period) {
+                s->irq_coalesced = lost_clock / s->period;
+            }
+
             lost_clock %= s->period;
             if (old_irq_coalesced != s->irq_coalesced ||
                 old_period != s->period) {



