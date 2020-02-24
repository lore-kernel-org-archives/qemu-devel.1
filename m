Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF4EC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FC721556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLP/0Er8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FC721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kmx-0007fO-25
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kll-0005ao-Qk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Klk-0002fF-Bn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Klk-0002ea-7t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KY0G2gAT7ify0bjXNUXV8FEj1UQWbwwkL92DRJ4rUII=;
 b=KLP/0Er81mG9vITcI2qpG25f3uTI3fhaAlbDiVtUm88VkndvEBN+sS6bvbfXJKQhh+6pOs
 +QX65drU17XDxj0cLz3xrFjQ+PD232DwX8c4o80McXu+KzjB8g3yIBHXf65wOcYvebBtUQ
 Jhxm+IOC2H+1rsEGGKXzPidm0d2/otc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-5P_0sCfFPsKylxj2cbCFAQ-1; Mon, 24 Feb 2020 15:55:57 -0500
X-MC-Unique: 5P_0sCfFPsKylxj2cbCFAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A6C800053;
 Mon, 24 Feb 2020 20:55:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-162.brq.redhat.com [10.40.205.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B1575C21B;
 Mon, 24 Feb 2020 20:55:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RESEND v2 00/32] hw: Sanitize various MemoryRegion calls
Date: Mon, 24 Feb 2020 21:55:01 +0100
Message-Id: <20200224205533.23798-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Resending after being kicked by gsmtp...

 4.3.0 Temporary System Problem.  Try again later (10). t81sm863436wmg.6 - =
gsmtp

This series simplifies various memory API calls when creating
memory regions.

Most of the patches are generated with Coccinelle semantic
patches (provided).
Few more cleanups added while writting the patches have been
added.

v1 was 'Let devices own the MemoryRegion they create':
https://www.mail-archive.com/qemu-devel@nongnu.org/msg681960.html

Since v1:
- understood a bit more Peter Maydell comments regarding
  how memory devices are migrated.

Supersedes: <20200221173049.18134-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (32):
  memory: Correctly return alias region type
  memory: Simplify memory_region_init_rom_nomigrate() to ease review
  scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
  scripts/cocci: Patch to replace memory_region_init_{ram,readonly ->
    rom}
  hw/arm: Use memory_region_init_rom() with read-only regions
  hw/display: Use memory_region_init_rom() with read-only regions
  hw/mips: Use memory_region_init_rom() with read-only regions
  hw/m68k: Use memory_region_init_rom() with read-only regions
  hw/net: Use memory_region_init_rom() with read-only regions
  hw/pci-host: Use memory_region_init_rom() with read-only regions
  hw/ppc: Use memory_region_init_rom() with read-only regions
  hw/riscv: Use memory_region_init_rom() with read-only regions
  hw/sh4: Use memory_region_init_rom() with read-only regions
  hw/sparc: Use memory_region_init_rom() with read-only regions
  scripts/cocci: Patch to detect potential use of memory_region_init_rom
  hw/arm/stm32: Use memory_region_init_rom() with read-only regions
  hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
  hw/i386/pc_sysfw: Simplify using memory_region_init_alias()
  hw/i386/pc_sysfw: Remove unused 'ram_size' argument
  scripts/cocci: Patch to remove unnecessary
    memory_region_set_readonly()
  hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alias
  scripts/cocci: Patch to let devices own their MemoryRegions
  hw/arm: Let devices own the MemoryRegion they create
  hw/char: Let devices own the MemoryRegion they create
  hw/core: Let devices own the MemoryRegion they create
  hw/display: Let devices own the MemoryRegion they create
  hw/dma: Let devices own the MemoryRegion they create
  hw/riscv: Let devices own the MemoryRegion they create
  hw/input/milkymist-softusb: Remove unused 'pmem_ptr' field
  hw/input/milkymist-softusb: Let devices own the MemoryRegion they
    create
  hw/net/milkymist-minimac2: Let devices own the MemoryRegion they
    create
  hw/block/onenand: Let devices own the MemoryRegion they create

 .../memory-region-housekeeping.cocci          | 159 ++++++++++++++++++
 .../coccinelle/memory-region-init-ram.cocci   |  38 -----
 hw/arm/exynos4210.c                           |  14 +-
 hw/arm/fsl-imx25.c                            |  10 +-
 hw/arm/fsl-imx31.c                            |   6 +-
 hw/arm/fsl-imx6.c                             |   6 +-
 hw/arm/fsl-imx6ul.c                           |   9 +-
 hw/arm/mainstone.c                            |   3 +-
 hw/arm/msf2-soc.c                             |   6 +-
 hw/arm/nrf51_soc.c                            |   2 +-
 hw/arm/omap_sx1.c                             |   6 +-
 hw/arm/palm.c                                 |   3 +-
 hw/arm/spitz.c                                |   3 +-
 hw/arm/stellaris.c                            |   3 +-
 hw/arm/stm32f205_soc.c                        |  11 +-
 hw/arm/stm32f405_soc.c                        |  12 +-
 hw/arm/tosa.c                                 |   3 +-
 hw/arm/xlnx-zynqmp.c                          |  11 +-
 hw/block/onenand.c                            |   7 +-
 hw/char/serial.c                              |   7 +-
 hw/core/platform-bus.c                        |   3 +-
 hw/display/cg3.c                              |   5 +-
 hw/display/g364fb.c                           |   3 +-
 hw/display/macfb.c                            |   4 +-
 hw/display/tcx.c                              |   5 +-
 hw/dma/i8257.c                                |   2 +-
 hw/dma/rc4030.c                               |   4 +-
 hw/i386/pc_sysfw.c                            |  29 +---
 hw/input/milkymist-softusb.c                  |  12 +-
 hw/m68k/q800.c                                |   3 +-
 hw/mips/mips_fulong2e.c                       |   3 +-
 hw/mips/mips_jazz.c                           |   6 +-
 hw/mips/mips_mipssim.c                        |   3 +-
 hw/mips/mips_r4k.c                            |   3 +-
 hw/net/dp8393x.c                              |   5 +-
 hw/net/milkymist-minimac2.c                   |   8 +-
 hw/pci-host/prep.c                            |   5 +-
 hw/ppc/mac_newworld.c                         |   3 +-
 hw/ppc/mac_oldworld.c                         |   3 +-
 hw/ppc/ppc405_boards.c                        |   6 +-
 hw/riscv/sifive_e.c                           |   9 +-
 hw/riscv/sifive_u.c                           |   2 +-
 hw/sh4/shix.c                                 |   3 +-
 hw/sparc/leon3.c                              |   3 +-
 memory.c                                      |  16 +-
 MAINTAINERS                                   |   1 +
 46 files changed, 268 insertions(+), 200 deletions(-)
 create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
 delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci

--=20
2.21.1


