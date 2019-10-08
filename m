Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0684C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5B321721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXXzBDnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5B321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHt9Z-0008UR-8B
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7M-0006Ym-1X
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7J-0002AY-AH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7I-00029m-W2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w12so20348459wro.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8AuF6SMXMBBdT0XSJXR/ilON3JQ4cBrYF0nDxaIc89g=;
 b=xXXzBDnEHqoGfk1Igk6dXc+vq+j8g8yqHEHwEBphqK6mid76AvbXkyauyf4TndMdOS
 VYaB4PZB1Iy+/XVgERbquT0NEN9Z+u7081JbFXZ73ocvmoc7m0BOdPEztGY5+gIxyTLh
 HBIXeNHLpnRr5xuAh44aekNs7vIyznUrsa9rf1NKAH3/cT8bt0VDiGZJ3q+pWQ/zmIi3
 qb+VrcchbqplnffReb1QjeCkxVbM5LPVCFQlH933At2TYdN25jBTpY2cGVgRaSl/P0Zr
 hdVGoq5T0aqoAZ55K9EFR1F56uOB2gSOBaApmOa+02u4oOLhZeOfNPDf31W7Q4W2Z7vR
 NADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8AuF6SMXMBBdT0XSJXR/ilON3JQ4cBrYF0nDxaIc89g=;
 b=OHHmsAAg7Lq28fnGD6hmMNhB1erS4RxvOrUqjfOMYoOFYfLWt3GQgn6vdKp/lFu/b7
 voB4oFpu2/gwYR8ouipHNTI3bHqqY85OLQPvEreAqVxoVkvXf2jbwpRdXhkZJTEz8YuS
 trh57yefwXXCsSbIhuOGKJ66nvKhqNMNag3LshCQc9aDMcOfviwXcgEcacvCnFlU4tdP
 OEAnmFA1qj318ONpERZ/EgSJyl41++sC9GnWxZ1lRpBQDLHsmBJE2pWnr37Iz+R1xXr0
 sKRx0NWm3aB08F9xRwU3zxQWvFsQz9jZQL2vTEOxK0lJrbyWmEhMwI3JO2TwzUTfdxUA
 rImQ==
X-Gm-Message-State: APjAAAWRxFn5g7molN3AQ3KKLHhtg93bCCtO3Fu/wLVSxFrhN6IJeFq2
 9aUSUhUP0mLkHaAqeErcYEPSQw==
X-Google-Smtp-Source: APXvYqyQI7HhLvc5g7N9oZfrHBXd2jkBYQkJqL4+DsYk3LCPCYjURhLYZW2w5nhRKJ2SHxXnJkxzzQ==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr3135822wrc.182.1570555063310; 
 Tue, 08 Oct 2019 10:17:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/21] transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:19 +0100
Message-Id: <20191008171740.9679-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

This patchset introduces a change to the ptimer API so that instead
of using a bottom-half for the trigger a device can choose to use a
new 'transaction' based approach.  In this design (suggested by RTH)
all calls which modify ptimer state:
     - ptimer_set_period()
     - ptimer_set_freq()
     - ptimer_set_limit()
     - ptimer_set_count()
     - ptimer_run()
     - ptimer_stop()
must be between matched calls to ptimer_transaction_begin() and
ptimer_transaction_commit().  When ptimer_transaction_commit() is
called it will evaluate the state of the timer after all the changes
in the transaction, and call the callback if necessary.
The callback itself is called from within a transaction block,
so any changes it makes to ptimer state that re-trigger the
timer will mean the callback is called again once it has returned.

Changes since the v1 RFC patchset:
 - In the ptimer implementation patch itself:
     * ptimer_transaction_begin() now sets need_reload to false
     * fixed assert condition in ptimer_transaction_begin()
     * ptimer_transaction_commit() now has a loop to call
       ptimer_reload() again if the callback function updated
       the ptimer state such that it needs to trigger again
     * fixed callback_opaque arg name mismatch in doc comment
     * don't cache delta, period, etc across ptimer_trigger() call,
       because the device's trigger function might update ptimer
       state
 - New patches which update all the devices used in various
   Arm boards to the new transaction-based API

(Most of the bugfixes listed are the result of the extra testing
in the wider variety of ptimer use cases. Thanks in particular
to Philippe for putting together a test image for the exynos4210,
which has several ptimer-using devices some of which are pretty
complicated.)

There are ten non-arm devices using ptimer:

microblaze and ppc:
  hw/timer/xilinx_timer.c
ppc:
  hw/net/fsl_etsec/etsec.c
nios2:
  hw/timer/altera_timer.c
cris:
  hw/timer/etraxfs_timer.c
lm32:
  hw/timer/lm32_timer.c
  hw/timer/milkymist-sysctl.c
sparc:
  hw/timer/grlib_gptimer.c
  hw/timer/slavio_timer.c
sh4:
  hw/timer/sh_timer.c
unicore32:
  hw/timer/puv3_ost.c

I do plan to convert those as well but this series seems big
enough to be going on with, and it means I can avoid the
awkwardness of getting acks from multiple submaintainers
on top of wrangling a big patchset.

thanks
-- PMM

Peter Maydell (21):
  ptimer: Rename ptimer_init() to ptimer_init_with_bh()
  ptimer: Provide new transaction-based API
  tests/ptimer-test: Switch to transaction-based ptimer API
  hw/timer/arm_timer.c: Switch to transaction-based ptimer API
  hw/arm/musicpal.c: Switch to transaction-based ptimer API
  hw/timer/allwinner-a10-pit.c: Switch to transaction-based ptimer API
  hw/timer/arm_mptimer.c: Switch to transaction-based ptimer API
  hw/timer/cmsdk-apb-dualtimer.c: Switch to transaction-based ptimer API
  hw/timer/cmsdk-apb-timer.c: Switch to transaction-based ptimer API
  hw/timer/digic-timer.c: Switch to transaction-based ptimer API
  hw/timer/exynos4210_mct.c: Switch GFRC to transaction-based ptimer API
  hw/timer/exynos4210_mct.c: Switch LFRC to transaction-based ptimer API
  hw/timer/exynos4210_mct.c: Switch ltick to transaction-based ptimer
    API
  hw/timer/exynos4210_pwm.c: Switch to transaction-based ptimer API
  hw/timer/exynos4210_rtc.c: Switch 1Hz ptimer to transaction-based API
  hw/timer/exynos4210_rtc.c: Switch main ptimer to transaction-based API
  hw/timer/imx_epit.c: Switch to transaction-based ptimer API
  hw/timer/imx_gpt.c: Switch to transaction-based ptimer API
  hw/timer/mss-timerc: Switch to transaction-based ptimer API
  hw/watchdog/cmsdk-apb-watchdog.c: Switch to transaction-based ptimer
    API
  hw/net/lan9118.c: Switch to transaction-based ptimer API

 include/hw/ptimer.h              |  83 ++++++++++++++++-
 include/hw/timer/mss-timer.h     |   1 -
 hw/arm/musicpal.c                |  16 ++--
 hw/core/ptimer.c                 | 154 +++++++++++++++++++++++++++----
 hw/dma/xilinx_axidma.c           |   2 +-
 hw/m68k/mcf5206.c                |   2 +-
 hw/m68k/mcf5208.c                |   2 +-
 hw/net/fsl_etsec/etsec.c         |   2 +-
 hw/net/lan9118.c                 |  11 ++-
 hw/timer/allwinner-a10-pit.c     |  12 ++-
 hw/timer/altera_timer.c          |   2 +-
 hw/timer/arm_mptimer.c           |  18 +++-
 hw/timer/arm_timer.c             |  16 +++-
 hw/timer/cmsdk-apb-dualtimer.c   |  14 ++-
 hw/timer/cmsdk-apb-timer.c       |  15 ++-
 hw/timer/digic-timer.c           |  16 +++-
 hw/timer/etraxfs_timer.c         |   6 +-
 hw/timer/exynos4210_mct.c        | 107 ++++++++++++++++++---
 hw/timer/exynos4210_pwm.c        |  17 +++-
 hw/timer/exynos4210_rtc.c        |  22 +++--
 hw/timer/grlib_gptimer.c         |   2 +-
 hw/timer/imx_epit.c              |  32 ++++++-
 hw/timer/imx_gpt.c               |  21 ++++-
 hw/timer/lm32_timer.c            |   2 +-
 hw/timer/milkymist-sysctl.c      |   4 +-
 hw/timer/mss-timer.c             |  11 ++-
 hw/timer/puv3_ost.c              |   2 +-
 hw/timer/sh_timer.c              |   2 +-
 hw/timer/slavio_timer.c          |   2 +-
 hw/timer/xilinx_timer.c          |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c |  13 ++-
 tests/ptimer-test.c              | 106 ++++++++++++++++-----
 32 files changed, 584 insertions(+), 133 deletions(-)

-- 
2.20.1


