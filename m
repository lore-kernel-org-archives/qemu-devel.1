Received: from eggs.gnu.org ([2001:4830:134:3::10]:41071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11G-0001Bt-Vr
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11C-00016t-QT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11C-00016E-Gs
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:30 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:51 +0200
Message-Id: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/28] complete cpu QOMification and remove
 cpu_FOO_init() helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

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
 * 1-2: complete QOMifying MIPS cpu and cpu models into classes
 * 4-9: complete QOMifying SPARC cpu including features into properties
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

https://github.com/imammedo/qemu.git cpu_init_def_target_cpu

https://github.com/imammedo/qemu/commits/cpu_init_def_target_cpu

PS:

Series for most targets is trivial and riskfree so it would be nice
if it's merged into 2.10 to have clean road for follow up refactoring.

MIPS/SPARC are the only targets that received 'heavy' refactoring
so I've treated them with more manual testing the rest of series if
slightly tested /make check for softmmu targets and running busybox for
the most of *-linux targets /, and not regressions were noticed.

I've CCed related maintainers on individual patches but it would be
nice if someone would ghelp out with reviewing less popular targets.=20

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
   - make cpu_model_helper will be usable at pre machine_init()
     so that commands like hotplugable-cpus could be used
     in with HMP/QMP preconfiguration interface I'm working on.
     (it's the real reason why I'm doing all of of this)

CC: Andreas F=C3=A4rber <afaerber@suse.de>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>


Igor Mammedov (28):
  mips: cpu: move mmu/fpu/mvp_init to realize time
  mips: MIPSCPU model subclasses
  mips: replace cpu_mips_init() with cpu_generic_init()
  sparc: convert cpu models to SPARC cpu subclasses
  sparc: embed sparc_def_t into CPUSPARCState
  sparc: convert cpu features to qdev properties
  sparc: move adhoc CPUSPARCState initialization to realize time
  x86: extract legacy cpu features format parser
  sparc: replace custom cpu feature parsing with
    cpu_legacy_parse_featurestr()
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

 include/qom/cpu.h                          |   6 +
 linux-user/sparc/target_syscall.h          |   2 +-
 target/alpha/cpu.h                         |   4 +-
 target/arm/cpu.h                           |   3 +-
 target/cris/cpu.h                          |   3 +-
 target/hppa/cpu.h                          |   4 +-
 target/i386/cpu.h                          |   3 +-
 target/lm32/cpu.h                          |   3 +-
 target/m68k/cpu.h                          |   3 +-
 target/microblaze/cpu.h                    |   3 +-
 target/mips/cpu-qom.h                      |   2 +
 target/mips/cpu.h                          |  63 +++++-
 target/moxie/cpu.h                         |   3 +-
 target/nios2/cpu.h                         |   3 +-
 target/openrisc/cpu.h                      |   4 +-
 target/ppc/cpu.h                           |   3 +-
 target/s390x/cpu.h                         |   3 +-
 target/sh4/cpu.h                           |   3 +-
 target/sparc/cpu-qom.h                     |   2 +
 target/sparc/cpu.h                         |  11 +-
 target/tilegx/cpu.h                        |   4 +-
 target/tricore/cpu.h                       |   4 +-
 target/unicore32/cpu.h                     |   4 +-
 target/xtensa/cpu.h                        |   4 +-
 default-configs/i386-bsd-user.mak          |   1 +
 default-configs/i386-linux-user.mak        |   1 +
 default-configs/i386-softmmu.mak           |   1 +
 default-configs/sparc-bsd-user.mak         |   1 +
 default-configs/sparc-linux-user.mak       |   1 +
 default-configs/sparc-softmmu.mak          |   1 +
 default-configs/sparc32plus-linux-user.mak |   1 +
 default-configs/sparc64-bsd-user.mak       |   1 +
 default-configs/sparc64-linux-user.mak     |   1 +
 default-configs/sparc64-softmmu.mak        |   1 +
 default-configs/x86_64-bsd-user.mak        |   1 +
 default-configs/x86_64-linux-user.mak      |   1 +
 default-configs/x86_64-softmmu.mak         |   1 +
 hw/alpha/dp264.c                           |   8 +-
 hw/arm/musicpal.c                          |   2 +-
 hw/arm/omap1.c                             |   2 +-
 hw/arm/omap2.c                             |   2 +-
 hw/arm/pxa2xx.c                            |   4 +-
 hw/arm/strongarm.c                         |   2 +-
 hw/cris/axis_dev88.c                       |   2 +-
 hw/lm32/lm32_boards.c                      |   4 +-
 hw/lm32/milkymist.c                        |   2 +-
 hw/m68k/an5206.c                           |   2 +-
 hw/m68k/mcf5208.c                          |   2 +-
 hw/mips/cps.c                              |   2 +-
 hw/mips/mips_fulong2e.c                    |   2 +-
 hw/mips/mips_jazz.c                        |   2 +-
 hw/mips/mips_malta.c                       |   2 +-
 hw/mips/mips_mipssim.c                     |   2 +-
 hw/mips/mips_r4k.c                         |   2 +-
 hw/moxie/moxiesim.c                        |   2 +-
 hw/nios2/10m50_devboard.c                  |   2 +-
 hw/openrisc/openrisc_sim.c                 |   2 +-
 hw/ppc/e500.c                              |   3 +-
 hw/ppc/mac_newworld.c                      |   3 +-
 hw/ppc/mac_oldworld.c                      |   3 +-
 hw/ppc/ppc440_bamboo.c                     |   2 +-
 hw/ppc/ppc4xx_devs.c                       |   2 +-
 hw/ppc/prep.c                              |   5 +-
 hw/ppc/virtex_ml507.c                      |   2 +-
 hw/sh4/r2d.c                               |   2 +-
 hw/sh4/shix.c                              |   2 +-
 hw/sparc/leon3.c                           |   2 +-
 hw/sparc/sun4m.c                           |   2 +-
 hw/sparc64/sparc64.c                       |   2 +-
 hw/tricore/tricore_testboard.c             |   2 +-
 hw/unicore32/puv3.c                        |   2 +-
 hw/xtensa/sim.c                            |   2 +-
 hw/xtensa/xtfpga.c                         |   2 +-
 target/alpha/cpu.c                         |  20 +-
 target/arm/helper.c                        |   5 -
 target/cris/cpu.c                          |   5 -
 target/hppa/cpu.c                          |  11 +-
 target/i386/cpu.c                          | 129 +----------
 target/lm32/helper.c                       |   5 -
 target/m68k/cpu.c                          |   2 +
 target/m68k/helper.c                       |  20 --
 target/microblaze/cpu.c                    |   6 +
 target/microblaze/translate.c              |  11 -
 target/mips/cpu.c                          |  60 +++++
 target/mips/translate.c                    |  25 ---
 target/mips/translate_init.c               |  63 +-----
 target/moxie/cpu.c                         |   5 -
 target/nios2/cpu.c                         |   9 +-
 target/openrisc/cpu.c                      |   5 -
 target/ppc/translate_init.c                |   5 -
 target/s390x/cpu.c                         |   7 +
 target/s390x/helper.c                      |  14 --
 target/sh4/cpu.c                           |   5 -
 target/sparc/cpu.c                         | 341 ++++++++++++++---------=
------
 target/sparc/int32_helper.c                |   2 +-
 target/sparc/int64_helper.c                |   2 +-
 target/sparc/ldst_helper.c                 |  14 +-
 target/sparc/mmu_helper.c                  |   2 +-
 target/sparc/translate.c                   |   2 +-
 target/sparc/win_helper.c                  |   4 +-
 target/tilegx/cpu.c                        |  11 +-
 target/tricore/helper.c                    |   5 -
 target/unicore32/helper.c                  |   5 -
 target/xtensa/cpu.c                        |   3 +
 target/xtensa/helper.c                     |  22 --
 util/Makefile.objs                         |   1 +
 util/legacy_cpu_features_parser.c          | 153 +++++++++++++
 107 files changed, 584 insertions(+), 643 deletions(-)
 create mode 100644 util/legacy_cpu_features_parser.c

--=20
2.7.4
