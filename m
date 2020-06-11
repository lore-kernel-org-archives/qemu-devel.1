Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4853A2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIhMD19A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4853A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVkM-0005uj-G8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3g7DiXgsKCmwRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com>)
 id 1jjViZ-0003sb-52
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:40 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:42225)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3g7DiXgsKCmwRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com>)
 id 1jjViW-00040K-OE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:38 -0400
Received: by mail-yb1-xb49.google.com with SMTP id f130so8177025yba.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ogOrvC1z1s0qlceeHZibbvCNmk024v40cmb/1Cfzwlw=;
 b=pIhMD19AVk0Ar8TALUnz9EJIzGM95/AOjXeTlN3ddZUIRivgCpN03IyHwMqoMI+uj+
 UvIikWfhbpctMygow9C1+kmINBTpFCeXtEqvGwEqsOKCz4XcXOtmGu38vdj7Xg7dz2NN
 K2OjlrkRk2haGdgwPSGklKnboc9mxXI0awIjzRm4839M3jvmsRdgPz6l6Ym+PTZ5tq+h
 04TV3qu0Jql80zSKXpta1J0Kmko4kKeT+JEu3FmPXiM+Ckbg5l2ZPZZJ0Z3YqR7VfVtU
 IgYYaq650Kd7l+69JMEcxvv9uX/KEYbDK5PyNDF7sEs6BfAr2L/28iIh+1drEWwH5Wpp
 0lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ogOrvC1z1s0qlceeHZibbvCNmk024v40cmb/1Cfzwlw=;
 b=m9yJ3sPXUiVOYSs9AeiOZoKYjH8KZHzpe/ieDehkdY+q91dQfzHWhL5OPVt9vWfyvA
 MJm93l11V+FRSn8YyGdVPw/0Bp9+V64WVXMl6KQsUZ0OZC02+1rJ9mLCHwXc+z2B9sWi
 9cWbTEjEuhCUJrA+oAEP3Ubi+pMEPAIO4Ew5xElbvC13NYg1168Bgg9WEi58dWSOM+0K
 gKhopPz+tLf1IheMuqvafeoujSBTlq0eu36Hf+xQzpKqBG7PItY2GJcuhcU/kZR/Qonw
 sCgSBalUgMucx9QJ1GmdXp/mTmftN2ztblKazoobONJSHzdhzfXkZlYJU7KTvz8Mddiw
 4UYA==
X-Gm-Message-State: AOAM533CZzZGoemRm+6R0qPzyULTdBcKCW6mTAFWwQQXh0uognmLmxUh
 6qZLsBtGwH3cshbAEBl50LoVgIHkdpc68Nm7wg==
X-Google-Smtp-Source: ABdhPJzwdW/hH+q0Tu6SZJyIitUt0107gxV9rqSvvY3UDPNJA1LzF6RYFHwa4ZurSIZE63qqkziXEcAz6ub7BxM5Nw==
X-Received: by 2002:a05:6902:1006:: with SMTP id
 w6mr18630505ybt.411.1591914627881; 
 Thu, 11 Jun 2020 15:30:27 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:04 -0700
Message-Id: <20200611223016.259837-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3g7DiXgsKCmwRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
an OpenBMC image built for quanta-gsj. This includes device models for:

  - Global Configuration Registers
  - Clock Control
  - Timers
  - Fuses
  - Memory Controller
  - Flash Controller

These modules, along with the existing Cortex A9 CPU cores and built-in
peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
two SoCs are very similar; the only difference is that NPCM730 is missing some
peripherals that NPCM750 has, and which are not considered essential for
datacenter use (e.g. graphics controllers). For more information, see

https://www.nuvoton.com/products/cloud-computing/ibmc/

Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
While this initial series uses a stripped-down kernel for testing, future
series will be tested using OpenBMC images built from public sources. I'm
currently putting the finishing touches on flash controller support, which is
necessary to boot a full OpenBMC image, and will be enabled by the next series.

The patches in this series were developed by Google and reviewed by Nuvoton. We
will be maintaining the machine and peripheral support together.

The data sheet for these SoCs is not generally available. Please let me know if
more comments are needed to understand the device behavior.

Changes since v1 (requested by reviewers):

  - Clarify the source of CLK reset values.
  - Made smpboot a constant byte array, eliinated byte swapping.
  - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMCPUs.
  - Clarify why EL3 is disabled.
  - Introduce NPCM7XX_NUM_IRQ constant.
  - Set the number of CPUs according to SoC variant, and disallow command line
    overrides (i.e. you can no longer override the number of CPUs with the -smp
    parameter). This is trying to follow the spirit of
    https://patchwork.kernel.org/patch/11595407/.
  - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
  - Machine documentation added (new patch).

Changes since v1 to support flash booting:

  - GCR reset value changes to get past memory initialization when booting
    from flash (patches 2 and 5):
      - INTCR2 now indicates that the DDR controller is initialized.
      - INTCR3 is initialized according to DDR memory size. A realize()
	method was implemented to achieve this.
  - Refactor the machine initialization a bit to make it easier to drop in
    machine-specific flash initialization (patch 6).
  - Extend the series with additional patches to enable booting from flash:
      - Boot ROM (through the -bios option).
      - OTP (fuse) controller.
      - Memory Controller stub (just enough to skip memory training).
      - Flash controller.
      - Board-specific flash initialization.

Thanks for reviewing,

Havard

Havard Skinnemoen (12):
  npcm7xx: Add config symbol
  hw/misc: Add NPCM7xx System Global Control Registers device model
  hw/misc: Add NPCM7xx Clock Controller device model
  hw/timer: Add NPCM7xx Timer device model
  hw/arm: Add NPCM730 and NPCM750 SoC models
  hw/arm: Add two NPCM7xx-based machines
  hw/arm: Load -bios image as a boot ROM for npcm7xx
  hw/nvram: NPCM7xx OTP device model
  hw/mem: Stubbed out NPCM7xx Memory Controller model
  hw/ssi: NPCM7xx Flash Interface Unit device model
  hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
  docs/system: Add Nuvoton machine documentation

 MAINTAINERS                      |  18 ++
 default-configs/arm-softmmu.mak  |   1 +
 docs/system/arm/nuvoton.rst      |  89 ++++++
 docs/system/target-arm.rst       |   1 +
 hw/arm/Kconfig                   |   9 +
 hw/arm/Makefile.objs             |   1 +
 hw/arm/npcm7xx.c                 | 449 ++++++++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c          | 168 +++++++++++
 hw/mem/Makefile.objs             |   1 +
 hw/mem/npcm7xx_mc.c              |  83 ++++++
 hw/misc/Makefile.objs            |   2 +
 hw/misc/npcm7xx_clk.c            | 216 ++++++++++++++
 hw/misc/npcm7xx_gcr.c            | 211 +++++++++++++
 hw/misc/trace-events             |   8 +
 hw/nvram/Makefile.objs           |   1 +
 hw/nvram/npcm7xx_otp.c           | 391 ++++++++++++++++++++++++
 hw/ssi/Makefile.objs             |   1 +
 hw/ssi/npcm7xx_fiu.c             | 497 +++++++++++++++++++++++++++++++
 hw/ssi/trace-events              |   9 +
 hw/timer/Makefile.objs           |   1 +
 hw/timer/npcm7xx_timer.c         | 437 +++++++++++++++++++++++++++
 hw/timer/trace-events            |   5 +
 include/hw/arm/npcm7xx.h         | 106 +++++++
 include/hw/mem/npcm7xx_mc.h      |  35 +++
 include/hw/misc/npcm7xx_clk.h    |  65 ++++
 include/hw/misc/npcm7xx_gcr.h    |  76 +++++
 include/hw/nvram/npcm7xx_otp.h   |  93 ++++++
 include/hw/ssi/npcm7xx_fiu.h     |  99 ++++++
 include/hw/timer/npcm7xx_timer.h |  95 ++++++
 29 files changed, 3168 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/nvram/npcm7xx_otp.h
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h

-- 
2.27.0.290.gba653c62da-goog


