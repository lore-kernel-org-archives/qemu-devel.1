Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08761204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08761204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiwYW-0007K3-4i
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vav@vav-lap.sysgo.cz>)
 id 1jiwXe-0006Rm-3M; Wed, 10 Jun 2020 04:57:03 -0400
Received: from mail.sysgo.com ([176.9.12.79]:38124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vav@vav-lap.sysgo.cz>)
 id 1jiwXd-0000Tr-4P; Wed, 10 Jun 2020 04:57:01 -0400
Received: from vav by vav-lap with local (Exim 4.92)
 (envelope-from <vav@vav-lap.sysgo.cz>)
 id 1jiwNa-0007Mi-5a; Wed, 10 Jun 2020 10:46:38 +0200
From: Vaclav Vanc <vav@sysgo.com>
To: 
Subject: [PATCH] hw/timer/a9gtimer: Clear pending interrupt,
 after the clear of Event flag
Date: Wed, 10 Jun 2020 10:45:51 +0200
Message-Id: <20200610084551.28222-1-vav@sysgo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=176.9.12.79; envelope-from=vav@vav-lap.sysgo.cz;
 helo=mail.sysgo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 04:46:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Vaclav Vanc <vav@sysgo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A9 Global Timer is used with Edge triggered interrupts (This is true
at least for Zynq and i.MX6 processors).
When Event Flag is cleared in Interrupt Status Register and new interrupt
was supposed to be scheduled, interrupt request is never cleared.
Since interrupt in GIC is configured as Edge triggered, new interrupts
are not registered (because interrupt is stuck at pending and GIC thinks
it was already serviced). As a result interrupts from timer does not work
anymore.

Note: This happens only when interrupt was not serviced before the next
interrupt is suppose to be scheduled. This happens for example during
the increased load of the host system.

Interrupt is now always cleared when Event Flag is cleared.
This is in accordance to A9 Global Timer documentation.

Signed-off-by: Vaclav Vanc <vav@sysgo.com>
---
 hw/timer/a9gtimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 7233068a37..732889105e 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -206,6 +206,9 @@ static void a9_gtimer_write(void *opaque, hwaddr addr, uint64_t value,
     case R_INTERRUPT_STATUS:
         a9_gtimer_update(s, false);
         gtb->status &= ~value;
+        if (gtb->status == 0) {
+            qemu_set_irq(gtb->irq, 0);
+        }
         break;
     case R_COMPARATOR_HI:
         shift = 32;
-- 
2.20.1


