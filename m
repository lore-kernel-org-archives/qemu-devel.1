Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB494C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938072465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAo5WLwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938072465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkNZ-0005FH-8M
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkJM-0006cQ-Lv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkJK-0007jf-LC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkJK-0007jQ-GR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IG7nN06Am7OeNB5SCNLvdkS6L+pqnHmZz8vQUQtN2o8=;
 b=DAo5WLwTPMsJGTuY4CVhb9nXFz+teBtY3t0odTZDDBX+oa5jxBoCnUHr1eQGKc3PENlIRn
 9HrF1bUiuTXTvJmVew7Qm8vDyB3bOxUGMrRJM52dPuhK0KMNj3RFcBuvaduqg3AwtiJGBa
 6MAWhEhnPsdDl8hgLdRE9B1j968CPYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-LybvIuRzPRqCmEqvHYT1kQ-1; Wed, 15 Jan 2020 10:10:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5276E1011B64
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1400289AA
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/86] refactor main RAM allocation to use hostmem backend
Date: Wed, 15 Jan 2020 16:06:15 +0100
Message-Id: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LybvIuRzPRqCmEqvHYT1kQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


v2:
  - fix compile errors on mingw32 host by introducing RAM_ADDR_UFMT [11/86]
  - replace "[PATCH 43/86] hppa: drop RAM size fixup" with alternative
    patches made by Philippe (which effectively do the same thing but other
    way around)
  - ppc440: fix crash and add suggested valid RAM size in error output.
    s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/ and simplify it by removing
    not necessary nested loop
  - rebase on current master due to new conflicts


Series removes ad hoc RAM allocation API (memory_region_allocate_system_mem=
ory)
and consolidates it around hostmem backend. It allows to
 * resolve conflicts between global -mem-prealloc and hostmem's "policy" op=
tion
   fixing premature allocation before binding policy is applied
 * simplify complicated memory allocation routines which had to deal with 2=
 ways
   to allocate RAM.
 * it allows to reuse hostmem backends of a choice for main RAM without add=
ing
   extra CLI options to duplicate hostmem features.
   Recent case was -mem-shared, to enable vhost-user on targets that don't
   support hostmem backends [1] (ex: s390)
 * move RAM allocation from individual boards into generic machine code and
   provide them with prepared MemoryRegion.
 * clean up deprecated NUMA features which were tied to the old API (see pa=
tches)
    - "numa: remove deprecated -mem-path fallback to anonymous RAM"
    - "numa: remove deprecated implicit RAM distribution between nodes"
    - "forbid '-numa node,mem' for 5.0 and newer machine types"

Conversion introduces a new machine.ram-memdev property and wrapper code th=
at
aliases global -mem-path and -mem-alloc into automatically created hostmem
backend properties (provided ram-memdev was not set explicitly given by use=
r).
And then follows bulk of trivial patches that incrementally convert individ=
ual
boards to using machine.ram-memdev provided MemoryRegion.

Board conversion typically involves:
 * providing MachineClass::default_ram_size and MachineClass::default_ram_i=
d
   so generic code could create default backend if user didn't explicitly p=
rovide
   ram-memdev or -m options
 * dropping memory_region_allocate_system_memory() call
 * using convenience MachineState::ram MemoryRegion, which points to Memory=
Region
   allocated by ram-memdev
On top of that for some boards:
 * added missing ram_size checks (typically it were boards with fixed ram s=
ize)
 * ram_size fixups were replaced by checks and hard errors, forcing user to
   provide correct "-m" values instead of ignoring it and continuing runnin=
g.
  =20
After all boards are converted the old API is removed and memory allocation
routines are cleaned up.

git tree for testing:
  https://github.com/imammedo/qemu convert_main_ram_to_memdev_v2

previous rev:
  https://github.com/imammedo/qemu convert_main_ram_to_memdev_v2
  https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05409.html

Igor Mammedov (83):
  numa: remove deprecated -mem-path fallback to anonymous RAM
  machine: introduce ram-memdev property
  machine: alias -mem-path and -mem-prealloc into memory-foo backend
  machine: introduce convenience MachineState::ram
  initialize MachineState::ram in NUMA case
  alpha:dp264: use memdev for RAM
  arm:aspeed: convert valid RAM sizes to data
  arm:aspeed: actually check RAM size
  hw:aspeed: drop warning and bogus ram_size fixup
  arm:aspeed: use memdev for RAM
  arm:collie: use memdev for RAM
  arm:cubieboard: use memdev for RAM
  arm:digic_boards: use memdev for RAM
  arm:highbank: use memdev for RAM
  arm:imx25_pdk: drop RAM size fixup
  arm:imx25_pdk: use memdev for RAM
  arm:integratorcp: use memdev for RAM
  arm:kzm: drop RAM size fixup
  arm:kzm: use memdev for RAM
  arm:mcimx6ul-evk: use memdev for RAM
  arm:mcimx7d-sabre: use memdev for RAM
  arm:mps2-tz: use memdev for RAM
  arm:mps2: use memdev for RAM
  arm:musicpal: use memdev for RAM
  arm:nseries: use memdev for RAM
  arm:omap_sx1: use memdev for RAM
  arm:palm: use memdev for RAM
  arm:raspi: use memdev for RAM
  arm:sabrelite: use memdev for RAM
  arm:sbsa-ref: use memdev for RAM
  arm:versatilepb: use memdev for RAM
  arm:vexpress: use memdev for RAM
  arm:virt: use memdev for RAM
  arm:xilinx_zynq: drop RAM size fixup
  arm:xilinx_zynq: use memdev for RAM
  arm:xlnx-versal-virt: use memdev for RAM
  arm:xlnx-zcu102: use memdev for RAM
  s390x:s390-virtio-ccw: use memdev for RAM
  null-machine: use memdev for RAM
  cris:axis_dev88: use memdev for RAM
  hppa: use memdev for RAM
  x86:microvm: use memdev for RAM
  x86:pc: use memdev for RAM
  lm32:lm32_boards: use memdev for RAM
  lm32:milkymist: use memdev for RAM
  m68k:an5206: use memdev for RAM
  m68k:mcf5208: use memdev for RAM
  m68k:next-cube: use memdev for RAM
  mips:boston-cube: use memdev for RAM
  mips:mips_fulong2e: drop RAM size fixup
  mips:mips_fulong2e: use memdev for RAM
  mips:mips_jazz: use memdev for RAM
  mips:mips_malta: use memdev for RAM
  mips:mips_mipssim: use memdev for RAM
  mips:mips_r4k: use memdev for RAM
  ppc:e500: drop RAM size fixup
  ppc:e500: use memdev for RAM
  ppc:mac_newworld: use memdev for RAM
  ppc:mac_oldworld: use memdev for RAM
  ppc:pnv: use memdev for RAM
  ppc:ppc405_boards: add RAM size checks
  ppc:ppc405_boards: use memdev for RAM
  ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
  ppc:ppc440_bamboo/sam460ex: use memdev for RAM
  ppc:prep: use memdev for RAM
  ppc:spapr: use memdev for RAM
  ppc:virtex_ml507: remove unused arguments
  ppc:virtex_ml507: use memdev for RAM
  sparc:leon3: use memdev for RAM
  sparc:sun4m: use memdev for RAM
  sparc:niagara: use memdev for RAM
  remove no longer used memory_region_allocate_system_memory()
  post conversion default_ram_id cleanup
  exec: cleanup qemu_minrampagesize()/qemu_maxrampagesize()
  exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
  make mem_path local variable
  hostmem: introduce "prealloc-threads" property
  hostmem: fix strict bind policy
  numa: forbid '-numa node,mem' for 5.0 and newer machine types
  tests:numa-test: make top level args dynamic and g_autofree(cli)
    cleanups
  tests:numa-test: use explicit memdev to specify node RAM
  numa: make exit() usage consistent
  numa: remove deprecated implicit RAM distribution between nodes

Philippe Mathieu-Daud=C3=A9 (3):
  hw/hppa/machine: Correctly check the firmware is in PDC range
  hw/hppa/machine: Restrict the total memory size to 3GB
  hw/hppa/machine: Map the PDC memory region with higher priority

 hw/alpha/alpha_sys.h          |   2 +-
 include/exec/cpu-common.h     |   2 +
 include/hw/boards.h           |  51 ++++----------
 include/hw/misc/aspeed_sdmc.h |   2 +
 include/hw/ppc/ppc4xx.h       |   9 ++-
 include/sysemu/hostmem.h      |  20 +++++-
 include/sysemu/numa.h         |   5 +-
 include/sysemu/sysemu.h       |   2 -
 backends/hostmem-file.c       |   8 ---
 backends/hostmem-memfd.c      |   1 -
 backends/hostmem-ram.c        |   2 -
 backends/hostmem.c            |  53 ++++++++++----
 exec.c                        |  66 ++---------------
 hw/alpha/dp264.c              |   2 +-
 hw/alpha/typhoon.c            |   8 +--
 hw/arm/aspeed.c               |  13 +---
 hw/arm/collie.c               |  15 ++--
 hw/arm/cubieboard.c           |  25 +++----
 hw/arm/digic_boards.c         |  35 +++++----
 hw/arm/highbank.c             |  10 ++-
 hw/arm/imx25_pdk.c            |  13 ++--
 hw/arm/integratorcp.c         |   9 ++-
 hw/arm/kzm.c                  |  13 ++--
 hw/arm/mcimx6ul-evk.c         |  25 +++----
 hw/arm/mcimx7d-sabre.c        |  25 +++----
 hw/arm/mps2-tz.c              |  13 ++--
 hw/arm/mps2.c                 |  13 ++--
 hw/arm/musicpal.c             |  16 +++--
 hw/arm/nseries.c              |  31 ++++----
 hw/arm/omap_sx1.c             |  18 +++--
 hw/arm/palm.c                 |  18 +++--
 hw/arm/raspi.c                |  32 +++------
 hw/arm/sabrelite.c            |  23 +++---
 hw/arm/sbsa-ref.c             |   7 +-
 hw/arm/versatilepb.c          |   7 +-
 hw/arm/vexpress.c             |  14 ++--
 hw/arm/virt.c                 |   9 ++-
 hw/arm/xilinx_zynq.c          |  20 +++---
 hw/arm/xlnx-versal-virt.c     |   7 +-
 hw/arm/xlnx-zcu102.c          |   7 +-
 hw/core/machine.c             |  37 ++++++++--
 hw/core/null-machine.c        |   7 +-
 hw/core/numa.c                | 160 +++++++++-----------------------------=
----
 hw/cris/axis_dev88.c          |   8 +--
 hw/hppa/machine.c             |  18 ++---
 hw/i386/microvm.c             |  12 ++--
 hw/i386/pc.c                  |  20 +++---
 hw/i386/pc_piix.c             |   2 +-
 hw/i386/pc_q35.c              |   2 +-
 hw/lm32/lm32_boards.c         |  36 ++++++----
 hw/lm32/milkymist.c           |  19 +++--
 hw/m68k/an5206.c              |   5 +-
 hw/m68k/mcf5208.c             |   5 +-
 hw/m68k/next-cube.c           |   5 +-
 hw/mips/boston.c              |  11 ++-
 hw/mips/mips_fulong2e.c       |  15 ++--
 hw/mips/mips_jazz.c           |   7 +-
 hw/mips/mips_malta.c          |  10 ++-
 hw/mips/mips_mipssim.c        |   9 +--
 hw/mips/mips_r4k.c            |  12 ++--
 hw/misc/aspeed_sdmc.c         | 112 +++++++++++------------------
 hw/ppc/e500.c                 |  17 +++--
 hw/ppc/e500plat.c             |   1 +
 hw/ppc/mac_newworld.c         |   6 +-
 hw/ppc/mac_oldworld.c         |   6 +-
 hw/ppc/mpc8544ds.c            |   1 +
 hw/ppc/pnv.c                  |   8 +--
 hw/ppc/ppc405_boards.c        |  45 +++++++-----
 hw/ppc/ppc440_bamboo.c        |  12 ++--
 hw/ppc/ppc4xx_devs.c          |  59 ++++++++--------
 hw/ppc/prep.c                 |  15 ++--
 hw/ppc/sam460ex.c             |   6 +-
 hw/ppc/spapr.c                |  17 ++---
 hw/ppc/virtex_ml507.c         |  18 ++---
 hw/s390x/s390-virtio-ccw.c    |   7 +-
 hw/sparc/leon3.c              |   6 +-
 hw/sparc/sun4m.c              |  73 ++++++++++---------
 hw/sparc64/niagara.c          |   7 +-
 qemu-deprecated.texi          |  33 ---------
 qemu-options.hx               |  20 +++---
 tests/qtest/numa-test.c       |  90 ++++++++++++++----------
 vl.c                          |  37 +++++++++-
 82 files changed, 727 insertions(+), 920 deletions(-)

--=20
2.7.4


