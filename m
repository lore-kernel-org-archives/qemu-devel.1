Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF1E212CC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Y1s7LgZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF1E212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWyA-0004u1-U4
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZu-00042y-DI; Mon, 05 Oct 2020 15:55:22 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZo-0007S3-U1; Mon, 05 Oct 2020 15:55:22 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 45620C60F16;
 Mon,  5 Oct 2020 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=iR4KXb62I/k5aldm3ydk7GV+/axR6FSrHl7HyK9S/UM=;
 b=Y1s7LgZJPp3GnPWQmniwTosEZggQvxD+rx2k4GMEQkdqC+Q7JvdEh7bMwlvseJ5NmZ/l06
 N+J+Y3pkUgkkKRKPsDeBeV0hYEOpEKjgdGek9FgluXK9ATg7td3HuNcRnJww9GmhcVF4am
 Dyj4BFXDNW6j9rtMh4L1cnC81gDUI1dOUmKpqIP/biUwsgrg+zwxxteYXYbOTZC4lSu9cU
 C1vSd2ZD7Lc8bioSLk7s1I3gpyamglSUa0Ffq2aWkUoOoe2e2ZABQqMLm578r6LXim1wO7
 4Kz6Ke4EN7yzN7Bql3urPqcbS/8V46s19cKC0Dp1RplwgjHaguT29nGS/3UcEA==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] raspi: add the bcm2835 cprman clock manager
Date: Mon,  5 Oct 2020 21:55:57 +0200
Message-Id: <20201005195612.1999165-1-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=iR4KXb62I/k5aldm3ydk7GV+/axR6FSrHl7HyK9S/UM=;
 b=EcNFv3wEJBDFP4k3tZJCrwRrULNUIW/0E6Y36iowqzzsJ4v5D0Vnc07ykZswI1mep2Ek7c
 gPu5/KEBhFWyaByB5MpiAufl6TucK6O9P+/6BSLzCFlQzagXCosIIvn2lRWoXF+NIvlnH8
 AjhKaykGesNuRq62pty7HH1c/Yz7LtUJvVRewtQ+nMoF0JWKGg5zUm2zLiLa9uCpluARO3
 TG26lnu8URiOCaS9ECoywnvTiFkj5Ax/Rz84lTifR/kBgY9WXI2MzBUYC+vI53dF6xjHXl
 0oRwElna/2MxHqL7PC3nJU+zDLqE/HYPkVkLb77/DZ57Jtmjux19BqWkceL/hQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927714; a=rsa-sha256; cv=none;
 b=V8nZ2B2oK8JAMSbsUmGt4GHLN9hG6qf5WHZ2ds8Ws9InqExoPAvyhIeSwGxopF7QFI4hxgUoinK2Ff9cna3zPzld7BNRSdbTu3BuW1gnRxHczSq8mwVY5e+bCGt3/2j912zjbp1Z7uwsV3sLuYLcmKAHjqphY+neStg1TrOAbON6d9di530Jqv5itLcNkTpm0IHk1wSsmIJZ4DdiYyjWArvcYz2kLVwMATuxotjdrUYBHLn9STrCy1vN0WrKiSZcCz2FE1D/IKa43MarX9bGNLRjmGL7ue11VC4qu5JS6dOoXR0Uv/I4DZkShENw2yUmTMiHcleCj/bm1/QLwUNMag==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 -> v2:
  - patch 05: Added a comment about MMIO .valid constraints [Phil]
  - patch 05: Added MMIO .impl [Phil]
  - patch 05: Moved init_internal_clock to the public clock API, renamed
    clock_new (new patch 03) [Phil]
  - patch 11: use muldiv64 for clock mux frequency output computation [Phil]
  - patch 11: add a check for null divisor (Phil: I dropped your r-b)
  - Typos, formatting, naming, style [Phil]

Patches without review: 03, 09, 10, 11, 13, 15

Hi,

This series add the BCM2835 CPRMAN clock manager peripheral to the
Raspberry Pi machine.

Patches 1-3 are preliminary changes, patches 4-12 are the actual
implementation.

The two last patches add a clock input to the PL011 and
connect it to the CPRMAN and are RFC.

This series has been tested with Linux 5.4.61 (the current raspios
version). It fixes the kernel Oops at boot time due to invalid UART
clock value, and other warnings/errors here and there because of bad
clocks or lack of CPRMAN.

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

Luc Michel (15):
  hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
  hw/core/clock: trace clock values in Hz instead of ns
  hw/core/clock: add the clock_new helper function
  hw/arm/raspi: fix CPRMAN base address
  hw/arm/raspi: add a skeleton implementation of the CPRMAN
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
 include/hw/clock.h                         |   31 +
 include/hw/misc/bcm2835_cprman.h           |  209 ++++
 include/hw/misc/bcm2835_cprman_internals.h | 1018 ++++++++++++++++++++
 hw/arm/bcm2835_peripherals.c               |   15 +-
 hw/char/pl011.c                            |   45 +
 hw/core/clock.c                            |    6 +-
 hw/misc/bcm2835_cprman.c                   |  798 +++++++++++++++
 hw/char/trace-events                       |    1 +
 hw/core/trace-events                       |    4 +-
 hw/misc/meson.build                        |    1 +
 hw/misc/trace-events                       |    5 +
 14 files changed, 2132 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
 create mode 100644 hw/misc/bcm2835_cprman.c

-- 
2.28.0


