Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C5022283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="H/2h435d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C5022283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFO8-0002lD-TJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMz-0000x3-Kg; Sat, 10 Oct 2020 09:57:09 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMv-0004II-PS; Sat, 10 Oct 2020 09:57:09 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 4B079C6011D;
 Sat, 10 Oct 2020 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338222;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=Zc6xf717guizAAR9R4Xynk0iscqO/WXbuA1itrOeFrE=;
 b=H/2h435de8e3xkopQI6kRvxwqBd4trft06RvcNdhSr0lKS6HmhI0NRul2nnwef7QpbRrMx
 9FefjvEklzRCSjXkxxiKzJDa5fKAfDzxymJq/579ssqlux90EzYBWmawy09LKKRluARSTS
 bc/yiXzc+TjoCz8WxZ6Fo+pfeV7nMOE3FVE72FTMR7q97FoavOz2PU8oyzMniTd1sOFHDz
 NnDp9+KCzUmehsCOFnD0DX+pflF/05AmFA5PsHtH70d22BWkTV52o2vwyO5E919v+ZTSrW
 RZ7VPQF85bQe/EsLyLYzV8H//e1wbAjd6+QNGkoe6fyzdWAn4aApQXH3PIzYbw==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
Date: Sat, 10 Oct 2020 15:57:44 +0200
Message-Id: <20201010135759.437903-1-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338222;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=Zc6xf717guizAAR9R4Xynk0iscqO/WXbuA1itrOeFrE=;
 b=FdN1dt3fako21FvGtu2Mr4nnEdRGc27UAjM+Xrt/niv5u3nofMbCfqxtnzaQqch9+uq3V0
 3s6eRAvAt519qARsKyg6vfjAIZfYWC+BVIQDamwsCB8Hm6A+QgHDZNYe3wbekaVQabintG
 gqI6/Ug5PK4Z4v/wq5DQ+ve8+Bo1M34qcvCTt0k9iWW/elCtTujLVxuSJxSocbccmpGSOZ
 5KIvNE+vN2qRLef/KtIcOelteFjgcLMvQZio7n+ktWo+qYQ6IKE3fkADsxfHntYUisQmZM
 6u4CL4Tdhe+MYlQ+n7UD9Iws5GiAvz8zympuP+AJ5QvdpvTV2lnAnYkplYgg9g==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338222; a=rsa-sha256; cv=none;
 b=Z3hU/hi8SlrkLtwo5hY/6l3+c3qNB4WfOXHzwtBVgQo4ozr39w3DpkaibbEFLkY/hWTYi8S6LgKJTXy4rGCF/r1aeXN0ukppcTBRMwgDWteW7QbDfaTAIl1WCedynApjRUBY+uv0LoI9R2R2iRAA7k+4HTa5zQinb9VBKwd7xppdvppwTBH9UJ0i+uG34b3v0bIqnu/rGr30Wz2LwB3cPj6l/7ytm2j3KtxR1S2st7vxX8aEMLg22oH1BYX6+vrGoHwl5LV4+p8l1YiFSX7Dda6mWbJmpZ21N/Hc2xI2ypBNgfFo0cTe7OZOXZ/LaWVeH4c8kKXgicCmsG0SZVUFow==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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

v2 -> v3:
  - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
  - patch 03: commit message typo [Clement]
  - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
              reg_cm replaced with reg_ctl and reg_div. Add some
              comments for clarity. [Phil]
  - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
              correctly. [Phil]
  - patch 11: replaced manual bitfield extraction with extract32 [Phil]
  - patch 11: added a visual representation of CM_DIV for clarity [Phil]
  - patch 11: added a missing return in clock_mux_update.

v1 -> v2:
  - patch 05: Added a comment about MMIO .valid constraints [Phil]
  - patch 05: Added MMIO .impl [Phil]
  - patch 05: Moved init_internal_clock to the public clock API, renamed
    clock_new (new patch 03) [Phil]
  - patch 11: use muldiv64 for clock mux frequency output computation [Phil]
  - patch 11: add a check for null divisor (Phil: I dropped your r-b)
  - Typos, formatting, naming, style [Phil]

Patches without review: 03, 11, 13

Hi,

This series add the BCM2835 CPRMAN clock manager peripheral to the
Raspberry Pi machine.

Patches 1-4 are preliminary changes, patches 5-13 are the actual
implementation.

The two last patches add a clock input to the PL011 and
connect it to the CPRMAN.

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
 include/hw/clock.h                         |   18 +
 include/hw/misc/bcm2835_cprman.h           |  210 ++++
 include/hw/misc/bcm2835_cprman_internals.h | 1019 ++++++++++++++++++++
 hw/arm/bcm2835_peripherals.c               |   15 +-
 hw/char/pl011.c                            |   45 +
 hw/core/clock.c                            |   21 +-
 hw/misc/bcm2835_cprman.c                   |  808 ++++++++++++++++
 hw/char/trace-events                       |    1 +
 hw/core/trace-events                       |    4 +-
 hw/misc/meson.build                        |    1 +
 hw/misc/trace-events                       |    5 +
 14 files changed, 2146 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
 create mode 100644 hw/misc/bcm2835_cprman.c

-- 
2.28.0


