Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF88FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C93206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXNZogih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C93206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5IS3-0000D1-SP
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VeoxXwsKCvAZkcaffWegWfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQl-0006vz-8v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:19 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:37130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VeoxXwsKCvAZkcaffWegWfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQi-0004gA-Qa
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:18 -0400
Received: by mail-pg1-x549.google.com with SMTP id x3so2303345pga.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=vHecJPJoAi9bnfUUclQxvlcEQbztqI627ADIGlzbloM=;
 b=tXNZogihX1/oBpLy59HZ/X3s4szAprBGfiYLox1OkLtY4hY2HbKv6v893I5I53PA54
 JnO/ejwfMJQdgH6V/3hZ8f1hdkhtoA0bPPxWL2YVDkvQSqJxTRrrP6sdOzpoX2LKQYsK
 xMi0eFDfQwEtkbPL4Ct2U2VkLT76E6kQArwWgMctMW3VWWkz7iZvVm9EeaLf4cuOdzBN
 w4N6QGSdP1kfIan1iyV5ZFJS62mb3YKJx41psSH67L2/gcUfUhyWWjGSRHyI7G34dy6s
 GrxM3kXY9m8bvxl3DiGdeEjuyFofA88z2SlwZdI/BR/aCNp+ScaX5IPI5OGpt6hjJ1wg
 6IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=vHecJPJoAi9bnfUUclQxvlcEQbztqI627ADIGlzbloM=;
 b=ZA4UxI9hQU4MLR+oauEXnKwlQQ3shR5jn4oYYAf/xY8WIOAxcio2AAH803gpkxmcqQ
 37jy7Kf4U2tJgm9K+yB24NStZCMiSgyd7sV4174U0sH3k+syND4tHx80arqegPEttOig
 GASIDiZ1+oDvffshN5oIpXsfIj/JzEY+bkCtk/YXQ7+AdU83m61WLLJ3QUIZZYx58ih+
 pGjjboZXudCN+Jur4f+oQeP56zqBw8XAltqyRaivdiblfSqZ2HbII5I1Ez/kTCIgb6eG
 vwiFrovzgQsZtJ63oVy5Ch/nt+veSonq7TLqJ50Tc7EZbFwN8Y+/WAR9FNfyobe9l+dw
 Mydw==
X-Gm-Message-State: AOAM532w7WDPLPg9Oe6089Pbs35Wrz0jLomanlC1tWhmLGN92PN6nGJS
 qhRMxxhBbsts+uNV5ZRnNhot91Qvi19HCfVsGQ==
X-Google-Smtp-Source: ABdhPJwF94Hwt96+7xOIf0CF7OW+A0Yjh4oajxQ3JN1UxiRNbFg2xpuEOmBhhdAPOII+pnfCXsp/9Cvmf5NfqaCItA==
X-Received: by 2002:a17:90a:f014:: with SMTP id
 bt20mr283988pjb.0.1597106773704; 
 Mon, 10 Aug 2020 17:46:13 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:45:54 +0000
Message-Id: <20200811004607.2133149-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v7 00/13] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3VeoxXwsKCvAZkcaffWegWfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

I also pushed this and the previous two patchsets to my qemu fork on github=
.
The branches are named npcm7xx-v[1-7].

  https://github.com/hskinnemoen/qemu

This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to =
boot
an OpenBMC image built for quanta-gsj. This includes device models for:

  - Global Configuration Registers
  - Clock Control
  - Timers
  - Fuses
  - Memory Controller
  - Flash Controller

These modules, along with the existing Cortex A9 CPU cores and built-in
peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn fo=
rm
the foundation for the quanta-gsj and npcm750-evb machines, respectively. T=
he
two SoCs are very similar; the only difference is that NPCM730 is missing s=
ome
peripherals that NPCM750 has, and which are not considered essential for
datacenter use (e.g. graphics controllers). For more information, see

https://www.nuvoton.com/products/cloud-computing/ibmc/

Both quanta-gsj and npcm750-evb correspond to real boards supported by Open=
BMC.
At the end of the series, qemu can boot an OpenBMC image built for one of t=
hese
boards with some minor modifications.

The patches in this series were developed by Google and reviewed by Nuvoton=
. We
will be maintaining the machine and peripheral support together.

The data sheet for these SoCs is not generally available. Please let me kno=
w if
more comments are needed to understand the device behavior.

Changes since v6:

  - Use size_to_str to report DRAM sizes in npcm7xx_gcr.
  - Simplify the interrupt logic in npcm7xx_timer.
  - Update global bios_name instead of temporary.
  - Add npcm7xx_bootrom to MAINTAINERS and pc-bios/README.
  - Use a predefined name for the gsj boot image in the acceptance test.

Changes since v5:

  - Boot ROM included, as a git submodule and a binary blob, and loaded by
    default, so the -bios option is usually not necessary anymore.
  - Two acceptance tests added (openbmc image boot, and direct kernel boot)=
.
  - npcm7xx_load_kernel() moved to SoC code.
  - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
  - Comments added clarifying available SPI flash chip selects.
  - Error handling adjustments:
      - Errors from CPU and GCR realization are propagated through the SoC
        since they may be triggered by user-configurable parameters.
      - Machine init uses error_fatal instead of error_abort for SoC
        realization flash init. This makes error messages more helpful.
      - Comments added to indicate whether peripherals may fail to realize.
      - Use ERRP_GUARD() instead of Error *err when possible.
  - Default CPU type is now set, and attempting to set it to anything else
    will fail.
  - Format string fixes (use HWADDR_PRIx, etc.)
  - Simplified memory size encoding and error checking in npcm7xx_gcr.
  - Encapsulate non-obvious pointer subtraction into helper functions in th=
e
    FIU and TIMER modules.
  - Incorporate review feedback into the FIU module:
      - Add select/deselect trace events.
      - Use npcm7xx_fiu_{de,}select() consistently.
      - Use extract/deposit in more places for consistency.
      - Use -Wimplicit-fallthrough compatible fallthrough comments.
      - Use qdev_init_gpio_out_named instead of sysbus_init_irq for chip
        selects.
  - Incorporate review feedback into the TIMER module:
      - Assert that we never pause a timer that has already expired, instea=
d of
        trying to handle it. This should be safe since QEMU_CLOCK_VIRTUAL i=
s
        stopped while this code is running.
      - Simplify the switch blocks in the read and write handlers.

I made a change to error out if a flash drive was not specified, but revert=
ed
it because it caused make check to fail (qom-test). When specifying a NULL
block device, the m25p flash device initializes its in-memory storage with =
0xff
and doesn't attempt to write anything back. This seems correct to me.

Changes since v4:

  - OTP cleanups suggested by Philippe Mathieu-Daud=C3=A9.
      - Added fuse array definitions based on public Nuvoton bootblock code=
.
      - Moved class structure to .c file since it's only used internally.
      - Readability improvements.
  - Split the first patch and folded parts of it into three other patches s=
o
    that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx machine
    support is added.
  - DRAM init moved to machine init code.
  - Consistently use lower-case hex literals.
  - Switched to fine-grained unimplemented devices, based on public bootblo=
ck
    source code. Added a tiny SRAM that got left out previously.
  - Simplified error handling in npcm7xx_realize() since the board code wil=
l
    abort anyway, and SoCs are not hot-pluggable.

Changes since v3:

  - License headers are now GPL v2-or-later throughout.
  - Added vmstate throughout (except the memory controller, which doesn't
    really have any state worth saving). Successfully booted a gsj image
    with two stop/savevm/quit/loadvm cycles along the way.
      - JFFS2 really doesn't like it if I let qemu keep running after savev=
m,
        and then jump back in time with loadvm. I assume this is expected.
  - Fixed an error API violation in npcm7xx_realize, removed pointless erro=
r
    check after object_property_set_link().
  - Switched the OTP device to use an embedded array instead of a g_malloc0=
'd
    one because I couldn't figure out how to set up vmstate for the latter.

Changes since v2:

  - Simplified the MAINTAINERS entry.
  - Added link to OpenPOWER jenkins for gsj BMC images.
  - Reverted the smpboot change, back to byte swapping.
  - Adapted to upstream API changes:
      - sysbus_init_child_obj -> object_initialize_child
      - object_property_set_bool -> qdev_realize / sysbus_realize
      - ssi_create_slave_no_init -> qdev_new
      - qdev_init_nofail -> qdev_realize_and_unref
      - ssi_auto_connect_slaves removed
  - Moved Boot ROM loading from soc to machine init.
  - Plumbed power-on-straps property from GCR to the machine init code so i=
t
    can be properly initialized. Turns out npcm750 memory init doesn't work
    without this. npcm730 is fine either way, though I'm not sure why.
  - Reworked the flash init code so it looks more like aspeed (i.e. the fla=
sh
    device gets added even if there's no drive).

Changes since v1 (requested by reviewers):

  - Clarify the source of CLK reset values.
  - Made smpboot a constant byte array, eliinated byte swapping.
  - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMCPUs.
  - Clarify why EL3 is disabled.
  - Introduce NPCM7XX_NUM_IRQ constant.
  - Set the number of CPUs according to SoC variant, and disallow command l=
ine
    overrides (i.e. you can no longer override the number of CPUs with the =
-smp
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

Havard Skinnemoen (13):
  hw/misc: Add NPCM7xx System Global Control Registers device model
  hw/misc: Add NPCM7xx Clock Controller device model
  hw/timer: Add NPCM7xx Timer device model
  hw/arm: Add NPCM730 and NPCM750 SoC models
  hw/arm: Add two NPCM7xx-based machines
  roms: Add virtual Boot ROM for NPCM7xx SoCs
  hw/arm: Load -bios image as a boot ROM for npcm7xx
  hw/nvram: NPCM7xx OTP device model
  hw/mem: Stubbed out NPCM7xx Memory Controller model
  hw/ssi: NPCM7xx Flash Interface Unit device model
  hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
  docs/system: Add Nuvoton machine documentation
  tests/acceptance: console boot tests for quanta-gsj

 .gitmodules                            |   3 +
 MAINTAINERS                            |  10 +
 Makefile                               |   1 +
 default-configs/arm-softmmu.mak        |   1 +
 docs/system/arm/nuvoton.rst            |  90 +++++
 docs/system/target-arm.rst             |   1 +
 hw/arm/Kconfig                         |   9 +
 hw/arm/Makefile.objs                   |   1 +
 hw/arm/npcm7xx.c                       | 500 +++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c                | 192 +++++++++
 hw/mem/Makefile.objs                   |   1 +
 hw/mem/npcm7xx_mc.c                    |  84 ++++
 hw/misc/Makefile.objs                  |   2 +
 hw/misc/npcm7xx_clk.c                  | 234 +++++++++++
 hw/misc/npcm7xx_gcr.c                  | 228 +++++++++++
 hw/misc/trace-events                   |   8 +
 hw/nvram/Makefile.objs                 |   1 +
 hw/nvram/npcm7xx_otp.c                 | 424 +++++++++++++++++++
 hw/ssi/Makefile.objs                   |   1 +
 hw/ssi/npcm7xx_fiu.c                   | 539 +++++++++++++++++++++++++
 hw/ssi/trace-events                    |  11 +
 hw/timer/Makefile.objs                 |   1 +
 hw/timer/npcm7xx_timer.c               | 485 ++++++++++++++++++++++
 hw/timer/trace-events                  |   5 +
 include/hw/arm/npcm7xx.h               | 111 +++++
 include/hw/mem/npcm7xx_mc.h            |  36 ++
 include/hw/misc/npcm7xx_clk.h          |  72 ++++
 include/hw/misc/npcm7xx_gcr.h          |  76 ++++
 include/hw/nvram/npcm7xx_otp.h         |  88 ++++
 include/hw/ssi/npcm7xx_fiu.h           | 100 +++++
 include/hw/timer/npcm7xx_timer.h       |  96 +++++
 pc-bios/README                         |   6 +
 pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
 roms/Makefile                          |   7 +
 roms/vbootrom                          |   1 +
 tests/acceptance/boot_linux_console.py |  65 +++
 36 files changed, 3490 insertions(+)
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
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

--=20
2.28.0.236.gb10cc79966-goog


