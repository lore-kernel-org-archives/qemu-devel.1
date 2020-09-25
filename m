Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0663C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FDE21775
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="GJLXcfHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FDE21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkow-0002oF-8y
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknC-00012S-BZ; Fri, 25 Sep 2020 06:17:31 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLkn8-0007QJ-C6; Fri, 25 Sep 2020 06:17:30 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id E3E66C60F16;
 Fri, 25 Sep 2020 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029039;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=+i1IMBcfnyxNIfGLpyrczRRU6dqOLvpt9ZQFDVOdrsU=;
 b=GJLXcfHdChTy1BnExgSIf73pP5O399xYXRDkZtAEPWLnRgj3vULWFBw/9yJNvBNx2V9eJt
 Fs4Ev0YPGaKGtSXWEYpLq24KgVXbEYxdpsZjQZlj42mtiQagwoOLNjRH9YM3XPEu80Cw96
 ievT4dgD19hFayCOhYMjDCoe3X/COq/kqsgKaAj/sDeTa3k0WZGaUPjcUnw1EWsT9CAWYF
 QSnMF0w+U8+yO81mJl2p5Q0OV1HwwNsFlEVZB1M4NJIKjdAlJHT2baMJyztywQr2ML9vcu
 pv5DqFzYmtsySEExTed8hg3fb9oRvqfoa5S/xwIEjOiVQL0UTckwelJ26p/brQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/14] raspi: add the bcm2835 cprman clock manager
Date: Fri, 25 Sep 2020 12:17:17 +0200
Message-Id: <20200925101731.2159827-1-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029039;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=+i1IMBcfnyxNIfGLpyrczRRU6dqOLvpt9ZQFDVOdrsU=;
 b=VttaK9sXbsnsKYY7T0sqNV4pi+f9GKaSHgAtLkwQUO+0vAlJuKxvp1KnrnQ3GOJ++Zi0Zx
 70tVawx66iWcjDyRhZfq20OTs586wy74AnRHVq6jijlhRWPNZQH/vcSJiNnhPIcR7HV2Y5
 xtLAO6ZQbs43CX1Q60Kfa0AaAe9jBkO2/cZMG/wXKYCyG6zH8ttfh4U7AuZpJ/JwVqoEit
 05fkDOju49h5wlzhUCpKduqm5JxncoQrn3Dbh/WdhkdvWkElGVOWrJM6FKRiSEegJb220d
 tVnScOfeEptrTTKUWZPjlBRiBZ0cxof0E3wQB2EenuRo9TISmKQOJV3V55APrQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029039; a=rsa-sha256; cv=none;
 b=PTpJR9EXehRHHX5m0/ZM9ubtyBwXVCJRivwWMeyZIlb05Z93E1OnLkpTo7RLWMNFBmkFABihKAu8vykvdwSBbMLyjre1LYPrM10eF3SC/D63yjhlhj+/lBgLpO74jRVST8x6/BUc++7wuMTSXYE10vR9TGtucOeK3XCTXdTgOjaeUMOpxIrwLUhIWxImjz7XD+NzQjS3r0QSNbeNhGw7gEthgqN56d3UzT9+UVbiCwuUpGcsak6qvm9qsmKqg0mmeBHaz7nmUJkUjb/e4daU8i49DoHegaerhlz7jVGl6CqM9Q7MMtWIBEtknexRoEd4IC9ASyraziRi3wI8L9nBPw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series add the BCM2835 cprman clock manager peripheral to the
Raspberry Pi machine.

Patches 1-3 are preliminary changes, patches 4-12 are the actual
implementation.

The two last patches add a clock input to the PL011 and
connect it to the cprman and are RFC.

This series has been tested with Linux 5.4.61 (the current raspios
version). It fixes the kernel Oops at boot time due to invalid UART
clock value, and other warnings/errors here and there because of bad
clocks or lack of cprman.

Here is the clock tree as seen by Linux when booted in QEMU:
(/sys/kernel/debug/clk/clk_summary with some columns removed)

                        enable  prepare              
   clock                 count    count          rate
-----------------------------------------------------
 otg                         0        0     480000000
 osc                         5        5      19200000
    gp2                      1        1         32768
    tsens                    0        0       1920000
    otp                      0        0       4800000
    timer                    0        0       1000002
    pllh                     4        4     864000000
       pllh_pix_prediv       1        1       3375000
          pllh_pix           0        0        337500
       pllh_aux              1        1     216000000
          vec                0        0     108000000
       pllh_rcal_prediv      1        1       3375000
          pllh_rcal          0        0        337500
    plld                     3        3    2000000024
       plld_dsi1             0        0       7812501
       plld_dsi0             0        0       7812501
       plld_per              3        3     500000006
          gp1                1        1      25000000
          uart               1        2      47999625
       plld_core             2        2     500000006
          sdram              0        0     166666668
    pllc                     3        3    2400000000
       pllc_per              1        1    1200000000
          emmc               0        0     200000000
       pllc_core2            0        0       9375000
       pllc_core1            0        0       9375000
       pllc_core0            2        2    1200000000
          vpu                1        1     700000000
             aux_spi2        0        0     700000000
             aux_spi1        0        0     700000000
             aux_uart        0        0     700000000
             peri_image      0        0     700000000
    plla                     2        2    2250000000
       plla_ccp2             0        0       8789063
       plla_dsi0             0        0       8789063
       plla_core             1        1     750000000
          h264               0        0     250000000
          isp                0        0     250000000
 dsi1p                       0        0             0
 dsi0p                       0        0             0
 dsi1e                       0        0             0
 dsi0e                       0        0             0
 cam1                        0        0             0
 cam0                        0        0             0
 dpi                         0        0             0
 tec                         0        0             0
 smi                         0        0             0
 slim                        0        0             0
 gp0                         0        0             0
 dft                         0        0             0
 aveo                        0        0             0
 pcm                         0        0             0
 pwm                         0        0             0
 hsm                         0        0             0

It shows small differences with real hardware due other missing
peripherals for which the driver turn the clock off (like tsens).

Luc Michel (14):
  hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
  hw/core/clock: trace clock values in Hz instead of ns
  hw/arm/raspi: fix cprman base address
  hw/arm/raspi: add a skeleton implementation of the cprman
  hw/misc/bcm2835_cprman: add a PLL skeleton implementation
  hw/misc/bcm2835_cprman: implement PLLs behaviour
  hw/misc/bcm2835_cprman: add a PLL channel skeleton implementation
  hw/misc/bcm2835_cprman: implement PLL channels behaviour
  hw/misc/bcm2835_cprman: add a clock mux skeleton implementation
  hw/misc/bcm2835_cprman: implement clock mux behaviour
  hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
  hw/misc/bcm2835_cprman: add sane reset values to the registers
  hw/char/pl011: add a clock input
  hw/arm/bcm2835_peripherals: connect the UART clock

 include/hw/arm/bcm2835_peripherals.h       |    5 +-
 include/hw/arm/raspi_platform.h            |    5 +-
 include/hw/char/pl011.h                    |    1 +
 include/hw/clock.h                         |    5 +
 include/hw/misc/bcm2835_cprman.h           |  209 ++++
 include/hw/misc/bcm2835_cprman_internals.h | 1018 ++++++++++++++++++++
 hw/arm/bcm2835_peripherals.c               |   15 +-
 hw/char/pl011.c                            |   45 +
 hw/core/clock.c                            |    6 +-
 hw/misc/bcm2835_cprman.c                   |  810 ++++++++++++++++
 hw/char/trace-events                       |    1 +
 hw/core/trace-events                       |    4 +-
 hw/misc/meson.build                        |    1 +
 hw/misc/trace-events                       |    5 +
 14 files changed, 2118 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
 create mode 100644 hw/misc/bcm2835_cprman.c

-- 
2.28.0


