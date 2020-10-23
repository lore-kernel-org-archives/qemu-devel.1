Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589CC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A101208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JZ8jWW5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A101208E4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW4JR-0004nF-V7
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 17:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34UWTXwsKCrwjumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gs-0000W0-7e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:46 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:42419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34UWTXwsKCrwjumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gp-0002CT-Tz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:45 -0400
Received: by mail-pg1-x549.google.com with SMTP id 1so2302430pgd.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=BcWlM65XM0AJmQPnrbCqbi2frM12dvXHvxEJRRIHk+8=;
 b=JZ8jWW5W4XarKCgbfvEA4hbRO4uwMdFIV0HouWaz52ZIPRLmFIcwSqmFcaU5wf9Y/o
 TYVF7J+8kaTHn2hcK+Vj91F96QeWk4mbjQbdEE7yMeNWI6Ha9WJEku7fo93gZQiOjCA6
 yJc+yFMrCCOK8JtXUsPicg5e+EkHYGraitmR/3F0bUIa1Lv/nW9AA2iMl2ltlyuRt96D
 LWOynzOqwGOxRwpI7YCWGEdZEdhyE84MvNP7BbNuDqcAXxrqOKtdaUcdZ8FsnWTG9Ril
 bVC7pYUZ26bxV2pDeIWjx6N64GOXgRbXb7k2M86isBWqIcf0XtA2IUfCnLU9DTWTsl9d
 i5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=BcWlM65XM0AJmQPnrbCqbi2frM12dvXHvxEJRRIHk+8=;
 b=Bx0pGFOGPJa9IA/qcZIunKro6ue2gnn9diUaefXevRxn6+RTue8gcd5/r43/NcIWGT
 93z2g8/+iyK4j7+w8jUvsBxfJNAvTkymL8loCtBZZHce5wg4lOY2uVPifSWyc/kamP8T
 ZNzrmdvIlYzId8v9Aq5HIbHsQvk9hz4p54aBFdq4+FDT12b+8RARDL1c44K1GcOxCma2
 /VhkGqJXEAd5BK97bmFVOpSxdZjnZzLET+nnr17kog3Hr9vsgAVECwW0IvX8sPvMtXD1
 zQ7wVZpknhTK53pEXLPwhAcQKm6Al1R+5J2JrZhz02KGkUU6VTcKquwFl7uOrvzTUNoe
 ACLQ==
X-Gm-Message-State: AOAM530ou1hO0u1MUthdewSXTvtidemO8tYgxMQDNHgL6AAqjg99Es1M
 HJurM3mTv9yNtSFG2PB/s6nheJq/PosfA9ZbOQ==
X-Google-Smtp-Source: ABdhPJx1osAiGje+EzxRhO3a7aR1BQRQJxAKOYN5Y90ka/+xGsPQigTQ5FgHbOZoj96CIn5T6noElGVqe8CrYn/g6A==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a17:90a:7f03:: with SMTP id
 k3mr528507pjl.1.1603487201189;
 Fri, 23 Oct 2020 14:06:41 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:06:31 -0700
Message-Id: <20201023210637.351238-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v3 0/6] Additional NPCM7xx features, devices and tests
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, thuth@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=34UWTXwsKCrwjumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This is an update to the initial NPCM7xx patch series adding

  - Watchdog timer support. This makes the reboot command work.
  - Random Number Generator device.
  - USB Host Controllers.
  - GPIO Controllers.

The watchdog was implemented by my new teammate Hao Wu. Expect to see more
patches from him in the near future.

This series has also been pushed to the npcm7xx-5.2-update branch of my github
repository at

  https://github.com/hskinnemoen/qemu

Changes since v2:

  - Watchdog timer test now uses libqos/libqtest.h API consistently instead of
    a mix of that and libqtest-single.h.
  - Made all npcm7xx-related tests conditional on CONFIG_NPCM7XX. An extra
    patch was added for the previously submitted timer test.

Changes since v1:

  - Dropped the timer test since it's already applied (thanks Peter).
  - Watchdog reset signaling is now using GPIOs instead of a custom API
    (thanks Peter for suggesting, and Hao for implementing it).
  - Various comment updates for the timer.
  - VMState added to GPIO device.
  - Missing VMstate terminator added to RNG device.
  - Include order in RNG test fixed.

Again, thanks a lot for reviewing!

Havard

Hao Wu (1):
  hw/timer: Adding watchdog for NPCM7XX Timer.

Havard Skinnemoen (5):
  tests/qtest: Make npcm7xx_timer-test conditional on CONFIG_NPCM7XX
  Move npcm7xx_timer_reached_zero call out of npcm7xx_timer_pause
  hw/misc: Add npcm7xx random number generator
  hw/arm/npcm7xx: Add EHCI and OHCI controllers
  hw/gpio: Add GPIO model for Nuvoton NPCM7xx

 docs/system/arm/nuvoton.rst               |   6 +-
 hw/usb/hcd-ehci.h                         |   1 +
 include/hw/arm/npcm7xx.h                  |   8 +
 include/hw/gpio/npcm7xx_gpio.h            |  55 +++
 include/hw/misc/npcm7xx_clk.h             |   2 +
 include/hw/misc/npcm7xx_rng.h             |  34 ++
 include/hw/timer/npcm7xx_timer.h          |  48 ++-
 hw/arm/npcm7xx.c                          | 126 ++++++-
 hw/gpio/npcm7xx_gpio.c                    | 424 ++++++++++++++++++++++
 hw/misc/npcm7xx_clk.c                     |  28 ++
 hw/misc/npcm7xx_rng.c                     | 180 +++++++++
 hw/timer/npcm7xx_timer.c                  | 270 +++++++++++---
 hw/usb/hcd-ehci-sysbus.c                  |  19 +
 tests/qtest/npcm7xx_gpio-test.c           | 385 ++++++++++++++++++++
 tests/qtest/npcm7xx_rng-test.c            | 278 ++++++++++++++
 tests/qtest/npcm7xx_watchdog_timer-test.c | 320 ++++++++++++++++
 MAINTAINERS                               |   1 +
 hw/gpio/meson.build                       |   1 +
 hw/gpio/trace-events                      |   7 +
 hw/misc/meson.build                       |   1 +
 hw/misc/trace-events                      |   4 +
 tests/qtest/meson.build                   |   7 +-
 22 files changed, 2143 insertions(+), 62 deletions(-)
 create mode 100644 include/hw/gpio/npcm7xx_gpio.h
 create mode 100644 include/hw/misc/npcm7xx_rng.h
 create mode 100644 hw/gpio/npcm7xx_gpio.c
 create mode 100644 hw/misc/npcm7xx_rng.c
 create mode 100644 tests/qtest/npcm7xx_gpio-test.c
 create mode 100644 tests/qtest/npcm7xx_rng-test.c
 create mode 100644 tests/qtest/npcm7xx_watchdog_timer-test.c

-- 
2.29.0.rc1.297.gfa9743e501-goog


