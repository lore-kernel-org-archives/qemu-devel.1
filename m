Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CBC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9479220704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479220704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug4u-0002jy-7U
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iudjR-0004Ci-0E
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iudjO-0002He-OH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:45:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49501)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iudjO-0002Dr-ER
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:45:14 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmUDf-1jKag818tt-00iX6L; Thu, 23 Jan 2020 15:45:09 +0100
Subject: Re: [PATCH REPOST v3 00/80] refactor main RAM allocation to use
 hostmem backend
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <68ba557d-e028-211b-8472-ec6e2437e897@vivier.eu>
Date: Thu, 23 Jan 2020 15:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gzLqX3zt3neCBbELLIHJBqg3zjXU7ACE0ZDSKvVQfvuoNFBs9ci
 XwSv4q00mM/6g4/GLX1PvPtWMusnaKlBZNgt16q5pUHOAjHP8g+YJXmrCJAgzaXW/mkTtP8
 U5y3PjqdLrAa7bDjBpx+6+63Dj3Cv3cpbPIXzvZ8dbgIfchYf7Xa0l4BNaUnWnQcQA7KM/s
 YzrV69uRZnaurWFQjRzXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HklcJd7KVC4=:4UF4kxw1o8D51KdHrr20eJ
 aUX/v1M0i91IJim0IvtshbvlshUU5vVkpwPhR5RLxWE0R3D7DOxPna2Lsk1WobMcDR3MglkOC
 WsRED8DoZpq5205rcNyhQbZpmjPkC7Nczhct7ar32iByNTpAQ5qPqQNmIeOqDnTTllOaAmoWf
 VgRsjhk3fVT0VUvG76n4cyTdqeo3qB3se40rkkpwg6BB0UxnFpnQrmRMiuBfTgvpl74S+kmYn
 ++bbkjKVK4jJajBo3p4oM7/46rMfY5yIgP/z6L5h/brK/nLxkkQEZ4rocqZ5Yx0v0OId3wgVB
 6D4jdxC6nV2kPwYp4u6iHY7RXYZnEjTPzfPu3m3J+sD+zj/sSs+lHFCkHOM/nVicK2aJujKr0
 lag0R2CQmt4CvcZslXSc5UWh+OjYbj5C2gDNiK8ksQ3C5vvHdhy1gnjwQtOcip99xUFRppdrQ
 mcjbZC1PtYnd8K4vp8p31JyV/uGwcac7GOXcduyhpKLjR8/rZKnIRmIaXbuEi2iNffmX9lnUz
 fv7agHlchqDgXBCm+gAKoeNc3PjwZMIOClSxecXEv/WSl9BiJfL148z2LYuMpb+6enHLx+4Dv
 Z0NX7y6dPSdC3Lcl48xJOv/5UAimq8nGUMWGohyR9zDyJJgPW/LTu2qnqqbtOfFtEsFj2HsH2
 kDCkKaRXo0rSnWZORVCnOhV9wpn9BwuhqQ7JczbxWytcAsQ6C0vgz8xEJEYUu2LC3E9kKzgI/
 a5oZSQ26kDvh8yvVON49byHIDYi3gdG+EeV3IswfHoHh5HA704N58hgmF45csRDR0f4WoI1wu
 88LwVPPxChMhZsKCAWpDimP+9243M96kk1kG658qnXPe1tz7LIBBoaChiGkfzYCTLFHcc0N
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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

Le 23/01/2020 à 12:37, Igor Mammedov a écrit :
> 
> v3:
>   - due to libvirt not being ready, postpone till 5.1
>      * [PATCH v2 82/86] numa: forbid '-numa node,  mem' for 5.0 and newer machine types
>      and depended
>        [PATCH v2 86/86] numa: remove deprecated implicit RAM distribution  between nodes
>   - drop as not related "[PATCH v2 85/86] numa: make exit() usage consistent"
>   - drop "[PATCH v2 76/86] post conversion default_ram_id cleanup"
>     so that default memory-backedend won't be created for boards that do not care
>     about -m. Which makes -m optin feature. We should decide  what do in  case
>     board doesn't use -m (but that's out of scope of this series)
>   - use object_register_sugar_prop() instead of hacking compat props directly
>   - simplified/reworked aspeed patches
>   - s/RAM_ADDR_FMT/size_to_str()/
>   - rename 'ram-memdev' property to 'memory-backend'
>   - minor fixes to numa-test
>   - fixes for issues noticed during review of
>        [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
> 
> v2:
>   - fix compile errors on mingw32 host by introducing RAM_ADDR_UFMT [11/86]
>   - replace "[PATCH 43/86] hppa: drop RAM size fixup" with alternative
>     patches made by Philippe (which effectively do the same thing but other
>     way around)
>   - ppc440: fix crash and add suggested valid RAM size in error output.
>     s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/ and simplify it by removing
>     not necessary nested loop
>   - rebase on current master due to new conflicts
> 
> 
> Series removes ad hoc RAM allocation API (memory_region_allocate_system_memory)
> and consolidates it around hostmem backend. It allows to
>  * resolve conflicts between global -mem-prealloc and hostmem's "policy" option
>    fixing premature allocation before binding policy is applied
>  * simplify complicated memory allocation routines which had to deal with 2 ways
>    to allocate RAM.
>  * it allows to reuse hostmem backends of a choice for main RAM without adding
>    extra CLI options to duplicate hostmem features.
>    Recent case was -mem-shared, to enable vhost-user on targets that don't
>    support hostmem backends [1] (ex: s390)
>  * move RAM allocation from individual boards into generic machine code and
>    provide them with prepared MemoryRegion.
>  * clean up deprecated NUMA features which were tied to the old API (see patches)
>     - "numa: remove deprecated -mem-path fallback to anonymous RAM"
>     - (POSTPONED, waiting on libvirt side) "forbid '-numa node,mem' for 5.0 and newer machine types"
>     - (POSTPONED) "numa: remove deprecated implicit RAM distribution between nodes"
> 
> Conversion introduces a new machine.memory-backend property and wrapper code that
> aliases global -mem-path and -mem-alloc into automatically created hostmem
> backend properties (provided memory-backend was not set explicitly given by user).
> And then follows bulk of trivial patches that incrementally convert individual
> boards to using machine.memory-backend provided MemoryRegion.
> 
> Board conversion typically involves:
>  * providing MachineClass::default_ram_size and MachineClass::default_ram_id
>    so generic code could create default backend if user didn't explicitly provide
>    memory-backend or -m options
>  * dropping memory_region_allocate_system_memory() call
>  * using convenience MachineState::ram MemoryRegion, which points to MemoryRegion
>    allocated by ram-memdev
> On top of that for some boards:
>  * added missing ram_size checks (typically it were boards with fixed ram size)
>  * ram_size fixups were replaced by checks and hard errors, forcing user to
>    provide correct "-m" values instead of ignoring it and continuing running.
> 
> After all boards are converted the old API is removed and memory allocation
> routines are cleaned up.
> 
> git tree for testing:
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v3
> 
> previous rev:
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v2
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02960.html
> 
> 
> Igor Mammedov (77):
>   numa: remove deprecated -mem-path fallback to anonymous RAM
>   machine: introduce memory-backend property
>   machine: alias -mem-path and -mem-prealloc into memory-foo backend
>   machine: introduce convenience MachineState::ram
>   initialize MachineState::ram in NUMA case
>   alpha:dp264: use memdev for RAM
>   arm/aspeed: actually check RAM size
>   arm/aspeed: use memdev for RAM
>   arm/collie: use memdev for RAM
>   arm/cubieboard: use memdev for RAM
>   arm/digic_boards: use memdev for RAM
>   arm/highbank: use memdev for RAM
>   arm/imx25_pdk: drop RAM size fixup
>   arm/imx25_pdk: use memdev for RAM
>   arm/integratorcp: use memdev for RAM
>   arm/kzm: drop RAM size fixup
>   arm/kzm: use memdev for RAM
>   arm/mcimx6ul-evk: use memdev for RAM
>   arm/mcimx7d-sabre: use memdev for RAM
>   arm/mps2-tz: use memdev for RAM
>   arm/mps2: use memdev for RAM
>   arm/musicpal: use memdev for RAM
>   arm/nseries: use memdev for RAM
>   arm/omap_sx1: use memdev for RAM
>   arm/palm: use memdev for RAM
>   arm/raspi: use memdev for RAM
>   arm/sabrelite: use memdev for RAM
>   arm/sbsa-ref: use memdev for RAM
>   arm/versatilepb: use memdev for RAM
>   arm/vexpress: use memdev for RAM
>   arm/virt: use memdev for RAM
>   arm/xilinx_zynq: drop RAM size fixup
>   arm/xilinx_zynq: use memdev for RAM
>   arm/xlnx-versal-virt: use memdev for RAM
>   arm/xlnx-zcu102: use memdev for RAM
>   s390x/s390-virtio-ccw: use memdev for RAM
>   null-machine: use memdev for RAM
>   cris/axis_dev88: use memdev for RAM
>   hppa: use memdev for RAM
>   x86/microvm: use memdev for RAM
>   x86/pc: use memdev for RAM
>   lm32/lm32_boards: use memdev for RAM
>   lm32/milkymist: use memdev for RAM
>   m68k/an5206: use memdev for RAM
>   m68k/mcf5208: use memdev for RAM
>   m68k/next-cube: use memdev for RAM
>   mips/boston-cube: use memdev for RAM
>   mips/mips_fulong2e: drop RAM size fixup
>   mips/mips_fulong2e: use memdev for RAM
>   mips/mips_jazz: use memdev for RAM
>   mips/mips_malta: use memdev for RAM
>   mips/mips_mipssim: use memdev for RAM
>   mips/mips_r4k: use memdev for RAM
>   ppc/e500: drop RAM size fixup
>   ppc/e500: use memdev for RAM
>   ppc/mac_newworld: use memdev for RAM
>   ppc/mac_oldworld: use memdev for RAM
>   ppc/pnv: use memdev for RAM
>   ppc/ppc405_boards: add RAM size checks
>   ppc/ppc405_boards: use memdev for RAM
>   ppc/{ppc440_bamboo,sam460ex}: drop RAM size fixup
>   ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
>   ppc/prep: use memdev for RAM
>   ppc/spapr: use memdev for RAM
>   ppc/virtex_ml507: remove unused arguments
>   ppc/virtex_ml507: use memdev for RAM
>   sparc/leon3: use memdev for RAM
>   sparc/sun4m: use memdev for RAM
>   sparc/niagara: use memdev for RAM
>   remove no longer used memory_region_allocate_system_memory()
>   exec: cleanup qemu_minrampagesize()/qemu_maxrampagesize()
>   exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
>   make mem_path local variable
>   hostmem: introduce "prealloc-threads" property
>   hostmem: fix strict bind policy
>   tests:numa-test: make top level args dynamic and g_autofree(cli)
>     cleanups
>   tests:numa-test: use explicit memdev to specify node RAM
> 
> Philippe Mathieu-Daudé (3):
>   hw/hppa/machine: Correctly check the firmware is in PDC range
>   hw/hppa/machine: Restrict the total memory size to 3GB
>   hw/hppa/machine: Map the PDC memory region with higher priority
> 
>  hw/alpha/alpha_sys.h          |   2 +-
>  include/hw/boards.h           |  48 +++++----------
>  include/hw/misc/aspeed_sdmc.h |   1 +
>  include/hw/ppc/ppc4xx.h       |   9 ++-
>  include/sysemu/hostmem.h      |  20 +++++-
>  include/sysemu/numa.h         |   1 +
>  include/sysemu/sysemu.h       |   2 -
>  backends/hostmem-file.c       |   8 ---
>  backends/hostmem-memfd.c      |   1 -
>  backends/hostmem-ram.c        |   2 -
>  backends/hostmem.c            |  53 +++++++++++-----
>  exec.c                        |  66 +++-----------------
>  hw/alpha/dp264.c              |   3 +-
>  hw/alpha/typhoon.c            |   8 +--
>  hw/arm/aspeed.c               |  18 +++---
>  hw/arm/collie.c               |  17 ++++--
>  hw/arm/cubieboard.c           |  25 +++-----
>  hw/arm/digic_boards.c         |  40 ++++++------
>  hw/arm/highbank.c             |  10 ++-
>  hw/arm/imx25_pdk.c            |  13 ++--
>  hw/arm/integratorcp.c         |   9 ++-
>  hw/arm/kzm.c                  |  18 +++---
>  hw/arm/mcimx6ul-evk.c         |  25 +++-----
>  hw/arm/mcimx7d-sabre.c        |  25 +++-----
>  hw/arm/mps2-tz.c              |  15 +++--
>  hw/arm/mps2.c                 |  15 +++--
>  hw/arm/musicpal.c             |  18 ++++--
>  hw/arm/nseries.c              |  32 ++++++----
>  hw/arm/omap_sx1.c             |  20 ++++--
>  hw/arm/palm.c                 |  20 ++++--
>  hw/arm/raspi.c                |  34 ++++-------
>  hw/arm/sabrelite.c            |  23 +++----
>  hw/arm/sbsa-ref.c             |   7 +--
>  hw/arm/versatilepb.c          |   7 +--
>  hw/arm/vexpress.c             |  14 ++---
>  hw/arm/virt.c                 |   7 +--
>  hw/arm/xilinx_zynq.c          |  20 +++---
>  hw/arm/xlnx-versal-virt.c     |   7 +--
>  hw/arm/xlnx-zcu102.c          |   7 +--
>  hw/core/machine.c             |  30 +++++++++
>  hw/core/null-machine.c        |   8 +--
>  hw/core/numa.c                | 101 +++++++++----------------------
>  hw/cris/axis_dev88.c          |   8 +--
>  hw/hppa/machine.c             |  19 +++---
>  hw/i386/microvm.c             |  12 ++--
>  hw/i386/pc.c                  |  19 +++---
>  hw/lm32/lm32_boards.c         |  39 ++++++++----
>  hw/lm32/milkymist.c           |  21 ++++---
>  hw/m68k/an5206.c              |   5 +-
>  hw/m68k/mcf5208.c             |   5 +-
>  hw/m68k/next-cube.c           |   5 +-

Could you add hw/m68k/q800.c ?

Thanks,
Laurent


