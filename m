Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42AC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2F220730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggcWdzd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2F220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzpV-0005tI-4g
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyzor-0005Ok-BN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyzop-0006zs-0Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:08:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyzoo-0006vm-R4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580828929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRWVFL9P+j1bca0HGSb1D7My6oRLcDd2yDR/pG3kqAU=;
 b=ggcWdzd/G/n3UPekaKeomZKw9MRtJZ4a3xsAShtvj2U8q1y6oWQDeilGGvMNxKvnoFA1on
 qi7mCC69UNPINhLaErEq0JHfoXO9+mGSJjv32QLUERL9AR+Qh85buBAoruzhrk4N1RHMj6
 4Uguf7fB4O4PVGPnQaxWq8RluvXUHCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-qTptGdmdNjKfk-_glLJohA-1; Tue, 04 Feb 2020 10:08:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB22A80256B
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 15:08:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2845410027AD
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 15:08:32 +0000 (UTC)
Date: Tue, 4 Feb 2020 16:08:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/80] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200204160830.02afbd2e@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qTptGdmdNjKfk-_glLJohA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Fri, 31 Jan 2020 16:08:30 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

Paolo,

could you take a look at patches 1-7, 73,75-78 and
if series looks to be in acceptable shape, merge it via your tree

> v4:
>   - pick up new Reviewed-by-s
>   - Fix access to uninitialized pagesize/hpsize in
>     "[PATCH REPOST v3 74/80] exec: cleanup  qemu_minrampagesize()/qemu_maxrampagesize()"
>   - Make explicitly provided memory-backend work by using string property instead
>     of link so it would be possible to delay access to the backend to the time
>     when backends are initialized.
>   - added new patches to make explicit backend work nice with -m and do sanity
>     check on ram_size
>       'vl.c: move -m parsing after memory backends has been processed'
>       'vl.c: ensure that ram_size matches size of machine.memory-backend"
>     all this ram_size business needs cleanup too, but that's out of the scope
>     of this series.
>   - include m68k/q800 board into conversion
>   - drop patches that were merged through other trees
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
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v4
> 
> previous rev:
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v3
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg05299.html
> 
> Igor Mammedov (80):
>   numa: remove deprecated -mem-path fallback to anonymous RAM
>   machine: introduce memory-backend property
>   machine: alias -mem-path and -mem-prealloc into memory-foo backend
>   machine: introduce convenience MachineState::ram
>   initialize MachineState::ram in NUMA case
>   vl.c: move -m parsing after memory backends has been processed
>   vl.c: ensure that ram_size matches size of machine.memory-backend
>   alpha/dp264: use memdev for RAM
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
>   m68k/q800: use memdev for RAM
>   m68k/mcf5208: use memdev for RAM
>   m68k/next-cube: use memdev for RAM
>   mips/boston: use memdev for RAM
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
>   ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
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
>   tests/numa-test: make top level args dynamic and g_autofree(cli)
>     cleanups
>   tests:numa-test: use explicit memdev to specify node RAM
> 
>  hw/alpha/alpha_sys.h          |   2 +-
>  include/hw/boards.h           |  51 ++++++----------
>  include/hw/misc/aspeed_sdmc.h |   1 +
>  include/hw/ppc/ppc4xx.h       |   9 ++-
>  include/sysemu/hostmem.h      |  20 +++++-
>  include/sysemu/numa.h         |   1 +
>  include/sysemu/sysemu.h       |   2 -
>  backends/hostmem-file.c       |   8 ---
>  backends/hostmem-memfd.c      |   1 -
>  backends/hostmem-ram.c        |   2 -
>  backends/hostmem.c            |  53 +++++++++++-----
>  exec.c                        |  64 ++------------------
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
>  hw/arm/raspi.c                |  32 ++++------
>  hw/arm/sabrelite.c            |  23 +++----
>  hw/arm/sbsa-ref.c             |   7 +--
>  hw/arm/versatilepb.c          |   7 +--
>  hw/arm/vexpress.c             |  14 ++---
>  hw/arm/virt.c                 |   7 +--
>  hw/arm/xilinx_zynq.c          |  20 +++---
>  hw/arm/xlnx-versal-virt.c     |   7 +--
>  hw/arm/xlnx-zcu102.c          |   7 +--
>  hw/core/machine.c             |  48 +++++++++++++++
>  hw/core/null-machine.c        |   8 +--
>  hw/core/numa.c                | 101 +++++++++----------------------
>  hw/cris/axis_dev88.c          |   8 +--
>  hw/hppa/machine.c             |  10 +--
>  hw/i386/microvm.c             |  12 ++--
>  hw/i386/pc.c                  |  19 +++---
>  hw/lm32/lm32_boards.c         |  39 ++++++++----
>  hw/lm32/milkymist.c           |  21 ++++---
>  hw/m68k/an5206.c              |   5 +-
>  hw/m68k/mcf5208.c             |   5 +-
>  hw/m68k/next-cube.c           |   5 +-
>  hw/m68k/q800.c                |   6 +-
>  hw/mips/boston.c              |  11 ++--
>  hw/mips/mips_fulong2e.c       |  15 ++---
>  hw/mips/mips_jazz.c           |   7 +--
>  hw/mips/mips_malta.c          |  10 ++-
>  hw/mips/mips_mipssim.c        |   9 +--
>  hw/mips/mips_r4k.c            |  12 ++--
>  hw/misc/aspeed_sdmc.c         |  83 +++++++++++++++++++------
>  hw/ppc/e500.c                 |  17 +++---
>  hw/ppc/e500plat.c             |   1 +
>  hw/ppc/mac_newworld.c         |   6 +-
>  hw/ppc/mac_oldworld.c         |   6 +-
>  hw/ppc/mpc8544ds.c            |   1 +
>  hw/ppc/pnv.c                  |   8 +--
>  hw/ppc/ppc405_boards.c        |  48 +++++++++------
>  hw/ppc/ppc440_bamboo.c        |  12 ++--
>  hw/ppc/ppc4xx_devs.c          |  63 +++++++++----------
>  hw/ppc/prep.c                 |  15 +++--
>  hw/ppc/sam460ex.c             |   6 +-
>  hw/ppc/spapr.c                |   8 +--
>  hw/ppc/virtex_ml507.c         |  19 +++---
>  hw/s390x/s390-virtio-ccw.c    |   7 +--
>  hw/sparc/leon3.c              |   6 +-
>  hw/sparc/sun4m.c              |  74 +++++++++++-----------
>  hw/sparc64/niagara.c          |   7 +--
>  qemu-deprecated.texi          |   9 ---
>  tests/qtest/numa-test.c       | 138 ++++++++++++++++++++++--------------------
>  vl.c                          |  78 +++++++++++++++++++-----
>  79 files changed, 831 insertions(+), 801 deletions(-)
> 


