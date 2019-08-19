Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F2C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0FD2184E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD70Zasf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0FD2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza2e-0001yz-MP
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxl-0004q8-23
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxg-0006sR-OQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxg-0006pM-IN; Mon, 19 Aug 2019 01:12:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so386924plr.1;
 Sun, 18 Aug 2019 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FBRSic83EX4nE84a1WGl68BGwlkOljtRQTk9b1+qbY0=;
 b=dD70ZasfwNyAnqY+gXjr5NprIqf0MnMt+U0966kqst5qNW9fxTtya12sOozMPZcDSv
 jjBk+feO9zFHj/1+yXWgu8AMocjVG9KgTXRXuTT20j660yX5gSEtsniJN97OuxrNmWuz
 HQcwV7+9iNLiSxo+Qwe9TjZcRmSpsVnCHzkYkwovYcRYekSyk4EThlcg3RH2Rq3nipay
 SQdhbvzUi86ALSZbGVCM9dbIS1u0wMeLAiAFrDsimFEus0KCCO6pmK8For0sD2ikSMO0
 69JdpVfQB+Oo4uOkKPLZ+kNuYb8v6+EiOXOuSzXxuNPrDv7JeVIAA5JxPNMzbcm7iwsz
 4fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FBRSic83EX4nE84a1WGl68BGwlkOljtRQTk9b1+qbY0=;
 b=G4drbkU1m3mx38Nd8oS+r+Vl4nCIztHpVqSCRdnIPUDQJGOejhaeXEi/RjHQ7DHRhW
 ccqwG3AnLNYx/W41yJTnnpX7UOhW9HazWbGSOSCQ9rLKt63Q619BMcNaizQ+mhqgqfEI
 IvGQHFIDIxRzKD0HW5hJCl3yg7Krb68UdNmTRuf3aO1zpuNp23EfhzMwU+9YrLVXZArL
 mA4CY5rdQ6wRDA3dDLVO1z5hugRaC2eats04RhW3+KeNiYTsJd4QNU85KSaOHp6J+wJg
 ktWcxJWn6JAwQUaxrCof8/Z7NPIW+f61s4mctyEgZk8TWzWVwPWzlOyAY8x2ivWh3miZ
 sQug==
X-Gm-Message-State: APjAAAXFwxLl6MKElubrnSBVfNvO2/rGG8xnvKy/UMFlkaa+xuJqPdye
 qoOKaNm3fFcNYOzcZXA8Tz0=
X-Google-Smtp-Source: APXvYqzRUT15gl+ogKiQEC6z12SNgqsuYT5asvR2uua2sheKpXron3CBQljko9zXFm7sBm7Qfs2UZw==
X-Received: by 2002:a17:902:7c8a:: with SMTP id
 y10mr20438690pll.65.1566191527145; 
 Sun, 18 Aug 2019 22:12:07 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.05
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:06 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:33 -0700
Message-Id: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 00/28] riscv: sifive_u: Improve the
 emulation fidelity of sifive_u machine
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

As of today, the QEMU 'sifive_u' machine is a special target that does
not boot the upstream OpenSBI/U-Boot firmware images built for the real
SiFive HiFive Unleashed board. Hence OpenSBI supports a special platform
"qemu/sifive_u". For U-Boot, the sifive_fu540_defconfig is referenced
in the OpenSBI doc as its payload, but that does not boot at all due
to various issues in current QEMU 'sifive_u' machine codes.

This series aims to improve the emulation fidelity of sifive_u machine,
so that the upstream OpenSBI, U-Boot and kernel images built for the
SiFive HiFive Unleashed board can be used out of the box without any
special hack.

The major changes include:
- Heterogeneous harts creation supported, so that we can create a CPU
  that exactly mirrors the real hardware: 1 E51 + 4 U54.
- Implemented a PRCI model for FU540
- Implemented an OTP model for FU540, primarily used for storing serial
  number of the board
- Fixed GEM support that was seriously broken on sifive_u
- Synced device tree with upstream Linux kernel on sifive_u

OpenSBI v0.4 image built for sifive/fu540 is included as the default
bios image for 'sifive_u' machine.

The series is tested against OpenSBI v0.4 image for sifive/fu540
paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
and Linux kernel v5.3-rc3 image with the following patch:

macb: Update compatibility string for SiFive FU540-C000 [1]

OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
Boot Linux 64-bit defconfig image, verified that system console on
the serial 0 and ping host work pretty well.

An OpenSBI patch [2] was sent to drop the special "qemu/sifive_u" platform
support in OpenSBI. The original plan was to get the drop patch applied
after this QEMU series is merged. However after discussion in the OpenSBI
mailing list, it seems the best option for us is to let OpenSBI continue
shipping the special "qemu/sifive_u" platform support to work with QEMU
version <= 4.1 and deprecate the support sometime in the future. A patch
will need to be sent to OpenSBI mailing list to update its document.

v4 is now rebased on Palmer's QEMU RISC-V repo "for-master" branch.
Dropped the following v3 patch that was already done by someone else.
- riscv: sifive_u: Generate an aliases node in the device tree
- riscv: sifive_u: Support loading initramfs

The following v3 patch was dropped too due to a different cluster approach
suggested by Richard Henderson is used in v4:
- riscv: hart: Support heterogeneous harts population

[1]: https://patchwork.kernel.org/patch/11050003/
[2]: http://lists.infradead.org/pipermail/opensbi/2019-August/000335.html

Changes in v4:
- remove 2 more "linux,phandle" instances in sifive_u.c and spike.c
  after rebasing on Palmer's QEMU RISC-V tree
- change create_fdt() to return void in sifive_u.c too, after rebasing
  on Palmer's QEMU RISC-V tree
- new patch to remove executable attribute of opensbi images
- prefix all macros/variables/functions with SIFIVE_E/sifive_e
  in the sifive_e_prci driver
- new patch to add a "hartid-base" property to RISC-V hart array
- changed to create clusters for each cpu type
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_prci driver
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_otp driver
- new patch to remove handcrafted clock nodes for UART and ethernet

Changes in v3:
- changed to use macros for management and compute cpu count
- use management cpu count + 1 for the min_cpus
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2:
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up
- drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
- new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"
- fixed the "interrupts-extended" property size
- update the file header to indicate at least 2 harts are created
- use create_unimplemented_device() to create the GEM management
  block instead of sifive_mmio_emulate()
- add "phy-handle" property to the ethernet node

Bin Meng (28):
  riscv: hw: Remove superfluous "linux,phandle" property
  riscv: hw: Use qemu_fdt_setprop_cell() for property with only 1 cell
  riscv: hw: Remove not needed PLIC properties in device tree
  riscv: hw: Change create_fdt() to return void
  riscv: roms: Remove executable attribute of opensbi images
  riscv: sifive_u: Remove the unnecessary include of prci header
  riscv: sifive: Rename sifive_prci.{c,h} to sifive_e_prci.{c,h}
  riscv: sifive_e: prci: Fix a typo of hfxosccfg register programming
  riscv: sifive_e: prci: Update the PRCI register block size
  riscv: sifive_e: Drop sifive_mmio_emulate()
  riscv: Add a sifive_cpu.h to include both E and U cpu type defines
  riscv: hart: Extract hart realize to a separate routine
  riscv: hart: Add a "hartid-base" property to RISC-V hart array
  riscv: sifive_u: Update hart configuration to reflect the real FU540
    SoC
  riscv: sifive_u: Set the minimum number of cpus to 2
  riscv: sifive_u: Update PLIC hart topology configuration string
  riscv: sifive: Implement PRCI model for FU540
  riscv: sifive_u: Generate hfclk and rtcclk nodes
  riscv: sifive_u: Add PRCI block to the SoC
  riscv: sifive_u: Reference PRCI clocks in UART and ethernet nodes
  riscv: sifive_u: Update UART base addresses and IRQs
  riscv: sifive_u: Change UART node name in device tree
  riscv: roms: Update default bios for sifive_u machine
  riscv: sifive: Implement a model for SiFive FU540 OTP
  riscv: sifive_u: Instantiate OTP memory with a serial number
  riscv: sifive_u: Fix broken GEM support
  riscv: sifive_u: Remove handcrafted clock nodes for UART and ethernet
  riscv: sifive_u: Update model and compatible strings in device tree

 hw/riscv/Makefile.objs                       |   4 +-
 hw/riscv/riscv_hart.c                        |  35 ++--
 hw/riscv/sifive_e.c                          |  27 ++-
 hw/riscv/{sifive_prci.c => sifive_e_prci.c}  |  79 +++++----
 hw/riscv/sifive_u.c                          | 252 ++++++++++++++++++---------
 hw/riscv/sifive_u_otp.c                      | 194 +++++++++++++++++++++
 hw/riscv/sifive_u_prci.c                     | 165 ++++++++++++++++++
 hw/riscv/spike.c                             |   1 -
 hw/riscv/virt.c                              |  40 ++---
 include/hw/riscv/riscv_hart.h                |   1 +
 include/hw/riscv/sifive_cpu.h                |  31 ++++
 include/hw/riscv/sifive_e.h                  |   7 +-
 include/hw/riscv/sifive_e_prci.h             |  71 ++++++++
 include/hw/riscv/sifive_prci.h               |  69 --------
 include/hw/riscv/sifive_u.h                  |  27 +--
 include/hw/riscv/sifive_u_otp.h              |  90 ++++++++++
 include/hw/riscv/sifive_u_prci.h             | 100 +++++++++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 40968 -> 45064 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 roms/Makefile                                |   4 +-
 21 files changed, 929 insertions(+), 268 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (50%)
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_cpu.h
 create mode 100644 include/hw/riscv/sifive_e_prci.h
 delete mode 100644 include/hw/riscv/sifive_prci.h
 create mode 100644 include/hw/riscv/sifive_u_otp.h
 create mode 100644 include/hw/riscv/sifive_u_prci.h
 mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

-- 
2.7.4


