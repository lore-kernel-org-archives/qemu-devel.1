Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F02C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164B3207EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QUbAdChX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164B3207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbWF-0007uE-Vz
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RQlbXwsKCsQr2usxxowyoxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--hskinnemoen.bounces.google.com>)
 id 1kGbUr-0006FF-Du
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:17 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a]:37404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RQlbXwsKCsQr2usxxowyoxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--hskinnemoen.bounces.google.com>)
 id 1kGbUn-0002KC-4h
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:17 -0400
Received: by mail-pj1-x104a.google.com with SMTP id p11so1453121pjv.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=dHrYskZv46cboxYPmcq8GllZV9QH9+AVrRe1MSpml14=;
 b=QUbAdChXFz2Dc20J2NvdRs3g6I6URMrJBkBbAqopP3f5T4UahNktheHW/S/qerKeui
 hC/oa79uc5HITYl4xj83D6weMMbyn56kMhjlZbY6LUEbenUe259PpIqxyOzWp0u1MZsZ
 T8cFjQ0euzh7ArS8lmJDPGT6M5hQnb//pqSu5amT26uX8aOOHIWWuaOUjjoERkR51z8B
 V4hV0o/BDCxs5MZxq2QGs7T6Jc+2wvKuICk0CHvnHjaVRm870JGFq4qqONKVaKvKqHWP
 boR+SVnPOiWkFABZ9ZRmmjl1ysgfotV8nP2x+hHwNzhw+bLikHJVQtLFwGYEP4swhuJd
 VeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc:content-transfer-encoding;
 bh=dHrYskZv46cboxYPmcq8GllZV9QH9+AVrRe1MSpml14=;
 b=Zk6B4ZdDLqQbM6jiVlGDT6Qx+ThVUT+1xfahzTrQQXbOtKapNpl+tjfP5nFrVZMxN2
 VzUHeKnzsHdGUrvZsVcNUanjqDboDGAKorjupcSWjFZXjUlBRDEwb+R0jw+ZmGb8QKOm
 dAbph4V5Ti84aSiF3+uAi7BFaM4vMqPQCK+Scxhge7MsXpBUZiihyF9eFpl8MJEsY2c7
 xxYVn73cSe60JIQZm4Jzl9jCsKrz7PTqFrjfZfqgtx7rsfFtPOjyUKSXWPlN138n7gjf
 M5zuya4/yl1y2LUs10g5FjTIoEhrlRWFQgFXwnetF5KEEcCYDoe+gSREApBacSAY7Ruv
 /okw==
X-Gm-Message-State: AOAM531mO5AaFOLu4TvHxImnWwJve2oCSeyE9qDsMdexa56jstsS2pTQ
 7mz60bbgEUUbGuFvmh/XowY9RE5hGDLa31PrGQ==
X-Google-Smtp-Source: ABdhPJxlS6jMbb5AAkTzv/I8UmQmTQaHUR8iQ5EJD3vK66NujHj0f+LCQUD1LRPk84N2zksxnxYyHIa3T/3/O02d9g==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a17:90a:e513:: with SMTP id
 t19mr652739pjy.137.1599801669896;
 Thu, 10 Sep 2020 22:21:09 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:20:47 -0700
Message-Id: <20200911052101.2602693-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3RQlbXwsKCsQr2usxxowyoxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--hskinnemoen.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

This should be fully reviewed now, but the Timer patch may deserve another
look, as I fixed a few bugs in it. Huge thanks to everyone who reviewed and=
/or
tested this patchset, it has clearly improved a lot since I started.

I also pushed this and the previous patchsets to my qemu fork on github.  T=
he
branches are named npcm7xx-v[1-9].

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

Changes since v8:

  - Add missing class_size initializer for TYPE_NPCM7XX_OTP.
  - Timer bug fixes:
    - Interrupt Enable bit should not be reserved.
    - Update expiration time and/or time remaining on prescaler changes.
    - Warn when CEN and CRST are both set, and force CEN to zero.
    - Fix crash when the timer is loaded with zero cycles, and CEN is set a=
nd
      cleared in the same cycle (found by Alexander Bulekov's fuzz testing)=
.
    - Update CACT when CEN changes.
    - De-assert interrupts when TISR bits are cleared by guest writes.
  - Load the bootrom for direct kernel boot if it's available, but don't er=
ror
    out if it's not.
  - Add the usual openbmc password to the arm/nuvoton docs.

Changes since v7:

  - Move register enums to .c files throughout, leaving a single
    NPCM7XX_FOO_NR_REGS definition behind in the .h file. A QEMU_BUILD_BUG_=
ON
    should alert anyone accidentally expanding the register enum that they =
need
    to update the corresponding NR_REGS define, which in turn has a comment
    reminding them to update the vmstate version_id as well.
  - Skip loading the bootrom if a kernel filename is provided by the user.
  - New patch adding a board setup stub to tweak clocks before booting dire=
ctly
    into the kernel.
  - Add stuff to meson files instead of Makefiles.
  - Try to disable the slowest drivers and services to speed up the flash b=
oot
    acceptance test a bit. This is somewhat based on the following
    systemd-analyze blame report:
    https://gist.github.com/hskinnemoen/475cb0676530cd2cebaa1754cf16ca97

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

Havard Skinnemoen (14):
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
  hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
  docs/system: Add Nuvoton machine documentation
  tests/acceptance: console boot tests for quanta-gsj

 docs/system/arm/nuvoton.rst            |  92 ++++
 docs/system/target-arm.rst             |   1 +
 default-configs/arm-softmmu.mak        |   1 +
 include/hw/arm/npcm7xx.h               | 112 +++++
 include/hw/mem/npcm7xx_mc.h            |  36 ++
 include/hw/misc/npcm7xx_clk.h          |  48 +++
 include/hw/misc/npcm7xx_gcr.h          |  43 ++
 include/hw/nvram/npcm7xx_otp.h         |  79 ++++
 include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
 include/hw/timer/npcm7xx_timer.h       |  78 ++++
 hw/arm/npcm7xx.c                       | 532 +++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c                | 197 +++++++++
 hw/mem/npcm7xx_mc.c                    |  84 ++++
 hw/misc/npcm7xx_clk.c                  | 266 ++++++++++++
 hw/misc/npcm7xx_gcr.c                  | 269 ++++++++++++
 hw/nvram/npcm7xx_otp.c                 | 440 +++++++++++++++++++
 hw/ssi/npcm7xx_fiu.c                   | 572 +++++++++++++++++++++++++
 hw/timer/npcm7xx_timer.c               | 543 +++++++++++++++++++++++
 .gitmodules                            |   3 +
 MAINTAINERS                            |  10 +
 hw/arm/Kconfig                         |   9 +
 hw/arm/meson.build                     |   1 +
 hw/mem/meson.build                     |   1 +
 hw/misc/meson.build                    |   4 +
 hw/misc/trace-events                   |   8 +
 hw/nvram/meson.build                   |   1 +
 hw/ssi/meson.build                     |   1 +
 hw/ssi/trace-events                    |  11 +
 hw/timer/meson.build                   |   1 +
 hw/timer/trace-events                  |   5 +
 pc-bios/README                         |   6 +
 pc-bios/meson.build                    |   1 +
 pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
 roms/Makefile                          |   7 +
 roms/vbootrom                          |   1 +
 tests/acceptance/boot_linux_console.py |  83 ++++
 36 files changed, 3619 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/nvram/npcm7xx_otp.h
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

--=20
2.28.0.526.ge36021eeef-goog


