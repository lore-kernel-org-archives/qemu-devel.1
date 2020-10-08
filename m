Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3695C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECCD20708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bFtF0F1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECCD20708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfGw-0005Si-3Q
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Ip9_XwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEl-0003p1-Ji
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:15 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:41718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Ip9_XwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEj-0002rt-26
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:15 -0400
Received: by mail-pg1-x54a.google.com with SMTP id 24so4958181pgm.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=58MsYfVPTykH+Uq+RyP2WGX8cjctL3dx/QC7x4Rsb40=;
 b=bFtF0F1lKvfJF45AKX+rpDQ91xLvZGR673vb7ska+44jVKReysMF3hquAWseAvl2Ew
 bVlbdCr5SlPv8gxngZRRSmEz2xKX35f/GF/7YGtYiuKE7Uie19JomQcqJ8Ma/xCPw4uc
 hY1+NJtvx5abFVQPIvodITnxMpo+tbcdYzuA82qQxAOqn9kIQHkRJIcWswlbFAP13T8b
 q6lOKXrM6ZQ7mNP//qrB1ANkKdFI0/6AaxnmroVQaH5yFDovMf0zVwQkYj7/96dJHrPR
 3VvBN8l8qF3cUy3nUuQlXYKs4ggEZYTqSG1BohlVQnPVfLDYVT5WKwNK+Y/RwgIRpd50
 szqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=58MsYfVPTykH+Uq+RyP2WGX8cjctL3dx/QC7x4Rsb40=;
 b=q2LiBMULAxWf4aJtWMaZgntMkAUoyXP3CMB1gyLJK7NpP4vdTUeFOJC5SH5xePf7yX
 cGtKlOcExZ25w2GbD3UFq1Z8QTQrV+BPEMamEpV5+RC3nABHd6VnGLzeOcwCA5lGIkBQ
 civPBUKgPXJyIzjXOvVxPxuOpLC/AgQ/jCpwOdEcFGTjcokjD4CpfOlQQKD5ZjchBYCl
 YHhZn2+JbawPeTLFzs4/B4AauEPTUuNJ41MZR7E6bx1XacHzVtfOGCDC64pcjItIEgDR
 8oW4oXZfQxM/e6DSllRo0UG1Rt+fKPP7ATRH9X/0c70RA33AzIywyqjKm1GWA3IPtdOz
 F0kA==
X-Gm-Message-State: AOAM532G8mIEXYkhiNwi4IHTo7ky95FDG1cWdoFRWWkBz5WGPxleaTQm
 GPMfaAawy8VOC058gGl0Ukh8GOEfiEcd7kmrCwbL9Ovzk3Kv+4Zf3Fk1ivufKYwbToFSldZ8X+a
 fB79pk7CaHXPlIhQ79GNEn7OQ4qR+0/V0LUmBJ7IpWVELZKGu6KhjrBcpW9vRbiLEGFuAfFFBLg
 ==
X-Google-Smtp-Source: ABdhPJxz1JBT2J5Ywl7aS7+6IHYzIScGiU85wfej23qKUkHDgw+jpubMCI3T6KyhlJZmIJYfqj91UO8glS0C6i4yAw==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a63:7d8:: with SMTP id
 207mr1027106pgh.173.1602199330154; Thu, 08 Oct 2020 16:22:10 -0700 (PDT)
Date: Thu,  8 Oct 2020 16:21:48 -0700
Message-Id: <20201008232154.94221-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 0/6] Additional NPCM7xx features, devices and tests
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, f4bug@amsat.org, clg@kaod.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3Ip9_XwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

  - A timer test that found several issues that were fixed in the final version
    of the series (see
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg739516.html).
  - Watchdog timer support. This makes the reboot command work.
  - Random Number Generator device.
  - USB Host Controllers.
  - GPIO Controllers.

The watchdog was implemented by my new teammate Hao Wu. Expect to see more
patches from him in the near future.

This series has also been pushed to the npcm7xx-5.2-update branch of my github
repository at

  https://github.com/hskinnemoen/qemu

Again, thanks a lot for reviewing!

Havard

Hao Wu (1):
  hw/timer: Adding watchdog for NPCM7XX Timer.

Havard Skinnemoen (5):
  tests/qtest: Add npcm7xx timer test
  Move npcm7xx_timer_reached_zero call out of npcm7xx_timer_pause
  hw/misc: Add npcm7xx random number generator
  hw/arm/npcm7xx: Add EHCI and OHCI controllers
  hw/gpio: Add GPIO model for Nuvoton NPCM7xx

 docs/system/arm/nuvoton.rst               |   6 +-
 hw/usb/hcd-ehci.h                         |   1 +
 include/hw/arm/npcm7xx.h                  |   8 +
 include/hw/gpio/npcm7xx_gpio.h            |  55 +++
 include/hw/misc/npcm7xx_clk.h             |   9 +
 include/hw/misc/npcm7xx_rng.h             |  34 ++
 include/hw/timer/npcm7xx_timer.h          |  43 +-
 hw/arm/npcm7xx.c                          | 125 ++++-
 hw/gpio/npcm7xx_gpio.c                    | 409 ++++++++++++++++
 hw/misc/npcm7xx_clk.c                     |  20 +
 hw/misc/npcm7xx_rng.c                     | 179 +++++++
 hw/timer/npcm7xx_timer.c                  | 279 +++++++++--
 hw/usb/hcd-ehci-sysbus.c                  |  19 +
 tests/qtest/npcm7xx_gpio-test.c           | 385 +++++++++++++++
 tests/qtest/npcm7xx_rng-test.c            | 278 +++++++++++
 tests/qtest/npcm7xx_timer-test.c          | 562 ++++++++++++++++++++++
 tests/qtest/npcm7xx_watchdog_timer-test.c | 313 ++++++++++++
 MAINTAINERS                               |   1 +
 hw/gpio/meson.build                       |   1 +
 hw/gpio/trace-events                      |   7 +
 hw/misc/meson.build                       |   1 +
 hw/misc/trace-events                      |   4 +
 tests/qtest/meson.build                   |   4 +
 23 files changed, 2682 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/gpio/npcm7xx_gpio.h
 create mode 100644 include/hw/misc/npcm7xx_rng.h
 create mode 100644 hw/gpio/npcm7xx_gpio.c
 create mode 100644 hw/misc/npcm7xx_rng.c
 create mode 100644 tests/qtest/npcm7xx_gpio-test.c
 create mode 100644 tests/qtest/npcm7xx_rng-test.c
 create mode 100644 tests/qtest/npcm7xx_timer-test.c
 create mode 100644 tests/qtest/npcm7xx_watchdog_timer-test.c

-- 
2.28.0.1011.ga647a8990f-goog


