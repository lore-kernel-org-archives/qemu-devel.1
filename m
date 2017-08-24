Received: from eggs.gnu.org ([2001:4830:134:3::10]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv2x-0000YM-Qc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv2u-0007Po-L7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv2u-0007PP-C5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8FEA4A6FD
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:31:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E98268700
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:31:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:23 +0200
Message-Id: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 00/25] complete cpu QOMification
 and remove cpu_FOO_init() helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ChangeLog since v2:
  * rebase on top of rc4
  * fix latent bug in cpu_generic_init()
      [01/25] qom: cpu: fix parsed feature string length
  * drop
      [05/27] target-i386: cpu: convert  plus/minus properties to global =
properties
      [06/27] x86: extract legacy cpu  features format parser
    and replace
      [07/27] sparc: replace custom cpu  feature parsing with cpu_legacy_=
parse_featurestr()
    with new patch
      [06/25] sparc: make cpu feature parsing property
  * pick up new Reviewed/Test-bys

ChangeLog since v1:
  * rebase on top of rc3=20
  * drop MIPS CPU QOMifying patches as it's superseeded
    by another series: "[PATCH 0/8] QOMify MIPS cpu"
    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03041.html
  * new patch to hide plus/minus features handling inside of feature pars=
ing:
     "target-i386: cpu: convert plus/minus properties to global propertie=
s"
  * SPARC: make base CPU class abstract

While looking at ways to to get rid of ad-hoc cpu_model
parsing in every machine/*-user and unifying -cpu option
parsing, making it generic, I've noticed that most of
the targets have cpu_FOO_init() helper that does nothing
except of calling cpu_generic_init() and a few that do
additional ad-hoc cpu initialization outside of QOM model.

The most of the later could be easily fixed and
the 2 remaining mips/sparc targets are missing proper
conversion of cpu models to cpu subclasses and/or
cpu features to properties, with that fixed it's
possible get rid of custom cpu_FOO_init() helpers and
reuse cpu_generic_init() instead (which reduces code
size quite a bit).

That's what this series (1st part of cpu_model unification) does.
Patches:
 * 2-7: complete QOMifying SPARC cpu including features into properties
        conversion and cpu models into classes so it could use
        cpu_generic_init() to create cpus.

above patches care only about completing CPU QOMinfication and
might be not pretty or clean as they could be,
but leave cleanups and follow up code simplification is way out of scope=20
and (might|should) be done on top by respective maintainers or someone
who cares about it.

 * the rest of the patches are just replacing custom cpu_FOO_init()
   with cpu_generic_init() and sometimes dealing with target=20
   specific oddities in handling cpu name to typename conversion

git tree for testing/viewing:
https://github.com/imammedo/qemu.git cpu_init_def_target_cpu_V3
https://github.com/imammedo/qemu/commits/cpu_init_def_target_cpu_V3

Ref to v2:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg474320.html

PS:

SPARC are the only targets that received 'heavy' refactoring
so I've treated them with more manual testing the rest of series if
slightly tested /make check for softmmu targets and running busybox for
the most of *-linux targets /, and not regressions were noticed.

And now about follow up series, as end result of unificathion,
I'm looking for:

   - replacing many ad-hoc ways of specifying default cpu with
     a one generic way
   - cpu_model parsing done with common cpu_model_helper that
     will be called from 3 places: generic machine code and [linux|bsd]-u=
ser
   - cpu_model_helper returning cpu type name that
     the rest of the code will deal with
   - get rid of cpu_init() and leave only cpu_generic_init() throughout t=
he tree
   - make cpu_model_helper usable at pre machine_init() time
     so that commands like hotplugable-cpus could be used
     in with HMP/QMP preconfiguration interface I'm working on.
     (it's the real reason why I'm doing all of of this)


Igor Mammedov (25):
  qom: cpu: fix parsed feature string length
  sparc: convert cpu models to SPARC cpu subclasses
  sparc: embed sparc_def_t into CPUSPARCState
  sparc: convert cpu features to qdev properties
  sparc: move adhoc CPUSPARCState initialization to realize time
  sparc: make cpu feature parsing property based
  sparc: replace cpu_sparc_init() with cpu_generic_init()
  s390x: replace cpu_s390x_init() with cpu_generic_init()
  alpha: replace cpu_alpha_init() with cpu_generic_init()
  hppa: replace cpu_hppa_init() with cpu_generic_init()
  m68k: replace cpu_m68k_init() with cpu_generic_init()
  microblaze: replace cpu_mb_init() with cpu_generic_init()
  nios2: replace cpu_nios2_init() with cpu_generic_init()
  tilegx: replace cpu_tilegx_init() with cpu_generic_init()
  xtensa: replace cpu_xtensa_init() with cpu_generic_init()
  tricore: replace cpu_tricore_init() with cpu_generic_init()
  sh4: replace cpu_sh4_init() with cpu_generic_init()
  arm: replace cpu_arm_init() with cpu_generic_init()
  cris: replace cpu_cris_init() with cpu_generic_init()
  x86: replace cpu_x86_init() with cpu_generic_init()
  lm32: replace cpu_lm32_init() with cpu_generic_init()
  moxie: replace cpu_moxie_init() with cpu_generic_init()
  openrisc: replace cpu_openrisc_init() with cpu_generic_init()
  unicore32: replace uc32_cpu_init() with cpu_generic_init()
  ppc: replace cpu_ppc_init() with cpu_generic_init()

 linux-user/sparc/target_syscall.h |   2 +-
 target/alpha/cpu.h                |   4 +-
 target/arm/cpu.h                  |   3 +-
 target/cris/cpu.h                 |   3 +-
 target/hppa/cpu.h                 |   4 +-
 target/i386/cpu.h                 |   3 +-
 target/lm32/cpu.h                 |   3 +-
 target/m68k/cpu.h                 |   3 +-
 target/microblaze/cpu.h           |   3 +-
 target/moxie/cpu.h                |   3 +-
 target/nios2/cpu.h                |   3 +-
 target/openrisc/cpu.h             |   4 +-
 target/ppc/cpu.h                  |   3 +-
 target/s390x/cpu.h                |   3 +-
 target/sh4/cpu.h                  |   3 +-
 target/sparc/cpu-qom.h            |   2 +
 target/sparc/cpu.h                |  11 +-
 target/tilegx/cpu.h               |   4 +-
 target/tricore/cpu.h              |   4 +-
 target/unicore32/cpu.h            |   4 +-
 target/xtensa/cpu.h               |   4 +-
 hw/alpha/dp264.c                  |   8 +-
 hw/arm/musicpal.c                 |   2 +-
 hw/arm/omap1.c                    |   2 +-
 hw/arm/omap2.c                    |   2 +-
 hw/arm/pxa2xx.c                   |   4 +-
 hw/arm/strongarm.c                |   2 +-
 hw/cris/axis_dev88.c              |   2 +-
 hw/lm32/lm32_boards.c             |   4 +-
 hw/lm32/milkymist.c               |   2 +-
 hw/m68k/an5206.c                  |   2 +-
 hw/m68k/mcf5208.c                 |   2 +-
 hw/moxie/moxiesim.c               |   2 +-
 hw/nios2/10m50_devboard.c         |   2 +-
 hw/openrisc/openrisc_sim.c        |   2 +-
 hw/ppc/e500.c                     |   3 +-
 hw/ppc/mac_newworld.c             |   3 +-
 hw/ppc/mac_oldworld.c             |   3 +-
 hw/ppc/ppc440_bamboo.c            |   2 +-
 hw/ppc/ppc4xx_devs.c              |   2 +-
 hw/ppc/prep.c                     |   5 +-
 hw/ppc/virtex_ml507.c             |   2 +-
 hw/sh4/r2d.c                      |   2 +-
 hw/sh4/shix.c                     |   2 +-
 hw/sparc/leon3.c                  |   2 +-
 hw/sparc/sun4m.c                  |   2 +-
 hw/sparc64/sparc64.c              |   2 +-
 hw/tricore/tricore_testboard.c    |   2 +-
 hw/unicore32/puv3.c               |   2 +-
 hw/xtensa/sim.c                   |   2 +-
 hw/xtensa/xtfpga.c                |   2 +-
 qom/cpu.c                         |  14 +-
 target/alpha/cpu.c                |  20 +-
 target/arm/helper.c               |   5 -
 target/cris/cpu.c                 |   5 -
 target/hppa/cpu.c                 |  11 +-
 target/i386/cpu.c                 |   5 -
 target/lm32/helper.c              |   5 -
 target/m68k/cpu.c                 |   2 +
 target/m68k/helper.c              |  20 --
 target/microblaze/cpu.c           |   6 +
 target/microblaze/translate.c     |  11 --
 target/moxie/cpu.c                |   5 -
 target/nios2/cpu.c                |   9 +-
 target/openrisc/cpu.c             |   5 -
 target/ppc/translate_init.c       |   5 -
 target/s390x/cpu.c                |   7 +
 target/s390x/helper.c             |  14 --
 target/sh4/cpu.c                  |   5 -
 target/sparc/cpu.c                | 384 +++++++++++++++++++++-----------=
------
 target/sparc/int32_helper.c       |   2 +-
 target/sparc/int64_helper.c       |   2 +-
 target/sparc/ldst_helper.c        |  14 +-
 target/sparc/mmu_helper.c         |   2 +-
 target/sparc/translate.c          |   2 +-
 target/sparc/win_helper.c         |   4 +-
 target/tilegx/cpu.c               |  11 +-
 target/tricore/helper.c           |   5 -
 target/unicore32/helper.c         |   5 -
 target/xtensa/cpu.c               |   3 +
 target/xtensa/helper.c            |  22 ---
 81 files changed, 330 insertions(+), 432 deletions(-)

--=20
2.7.4
