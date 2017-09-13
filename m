Received: from eggs.gnu.org ([2001:4830:134:3::10]:46241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9y-0002PU-VZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9s-0006Xt-Iz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsA9s-0006X8-AI
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 655F381241
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:04:59 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE29217CC7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:04:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Sep 2017 18:04:52 +0200
Message-Id: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] generalize parsing of cpu_model
 (x86/arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changelog since v1:
 * fix merge conflicts with ignore_memory_transaction_failures
 * fix couple merge conflicts where SoC type string where replaced by typ=
e macro
 * keep plain prefix string in: strncmp(cpu_type, "pxa27", 5)
 * s/"%s" ARM_CPU_TYPE_SUFFIX/ARM_CPU_TYPE_NAME("%s")/
 * drop not needed assert
 * instead of checking error/reporting/exiting explicitly
   use error_fatal which will do all of it for us
 * squash in "cpu: rename cpu_parse_features() to cpu_parse_cpu_model()"


Issue 1:                                                                 =
       =20
Some callers call CPUClass->parse_features manually to convert           =
       =20
'-cpu cpufoo,featurestr' string to cpu type and featurestr               =
       =20
into a set of global properties and then do controlled                   =
       =20
cpu creation with setting properties and completing it with realize.     =
       =20
That's a lot of code duplication as they all are practically             =
       =20
reimplement the same parsing logic.                                      =
       =20
                                                                         =
       =20
Some use cpu_generic_init() instead which does the same parsing          =
       =20
along with creation/realizing cpu within one wrapper.                    =
       =20
                                                                         =
       =20
And some trying to switch to controlled cpu creation,                    =
       =20
implement object_new()/set properties/realize steps                      =
       =20
but forget feature parsing logic witch leads to 'bugs'                   =
       =20
commit (00909b585 hw/arm/integratorcp: Support specifying features via -c=
pu)    =20
                                                                         =
       =20
Issue 2:                                                                 =
       =20
Default cpu model selection logic is spread over  all board's            =
       =20
machine_init() fuctions but it's basicallyi hardcodes default            =
       =20
cpu model string in init function.                                       =
       =20
                                                                         =
       =20
 if (!cpu_model) {                                                       =
       =20
     cpu_model =3D "some cpu model string";                              =
         =20
 }                                                                       =
       =20
                                                                         =
       =20
and written in different ways.                                           =
       =20
it forces machine_init callbacks to parse cpu_model string               =
       =20
either by using cpu_generic_init() or by manually calling                =
       =20
cpu_class_by_name()/CPUClass::parse_features to perform                  =
       =20
name to cpu type translation.

This series moves -cpu option parsing to generic machine code            =
       =20
that removes some of code duplication and makes cpus creation            =
       =20
process more generic/simple:                                             =
              =20
                                                                         =
       =20
 * unify default (fallback) cpu type handling by replacing               =
       =20
   hardcoded cpu_model strings with cpu type directly in                 =
       =20
                                                                         =
       =20
   machine_foo_class_init() {                                            =
       =20
       MachineClass::default_cpu_type =3D BOARD_DEFAULT_CPU_TYPE         =
         =20
   }                                                                     =
       =20
                                                                         =
       =20
   which allows to generalize move cpu model parsing instead of          =
       =20
   parsing it in each board.                                             =
       =20
                                                                         =
       =20
 * make generic machine vl.c parse cpu_model into properties/cpu_type    =
       =20
   and let boards use cpu_type without any cpu_model prasing.            =
       =20
   Generic parsing will kick in only if board advertises its support     =
       =20
   by setting MachineClass::default_cpu_type to a cpu type.              =
       =20
                                                                         =
       =20
PS:                                                                      =
       =20
I intend make tree-wide conversion but as one series it's too many patche=
s,      =20
so I'm splitting out it into an intial series that implements generic    =
       =20
part and several patchsets that will do per target conversion.           =
       =20
                                                                         =
       =20
As part of initial series x86 and ARM targets conversion is included     =
       =20
to showcase generalization usage. Per target conversions are done
as 1 patch per target, it might be too much for targets that have lots
of boards (ARM) so let me know if you'd like to split it on per board
basis (then I'll respin it as separate series on top of generic patches)

github tree for testing:
https://github.com/imammedo/qemu.git default_machine_cpu_type_PC_ARM_v2


Igor Mammedov (5):
  qom: cpus: split cpu_generic_init() on feature parsing and cpu
    creation parts
  cpu: make cpu_generic_init() abort QEMU on error
  vl.c: convert cpu_model to cpu type and set of global properties
    before machine_init()
  pc: use generic cpu_model parsing
  arm: drop intermediate cpu_model -> cpu type parsing and use cpu type
    directly

 include/hw/arm/armv7m.h        |  2 +-
 include/hw/arm/aspeed_soc.h    |  2 +-
 include/hw/arm/stm32f205_soc.h |  2 +-
 include/hw/boards.h            |  6 ++++++
 include/qom/cpu.h              | 22 +++++++++++++++++++
 target/arm/cpu.h               |  3 +++
 target/i386/cpu.h              |  9 ++++++++
 bsd-user/main.c                |  4 ----
 hw/alpha/dp264.c               |  4 ----
 hw/arm/armv7m.c                | 40 +++++-----------------------------
 hw/arm/aspeed_soc.c            | 13 +++++------
 hw/arm/collie.c                | 10 +++------
 hw/arm/exynos4210.c            |  6 +-----
 hw/arm/gumstix.c               |  5 +++--
 hw/arm/highbank.c              | 10 ++++-----
 hw/arm/integratorcp.c          | 30 ++------------------------
 hw/arm/mainstone.c             |  9 ++++----
 hw/arm/mps2.c                  | 17 ++++++---------
 hw/arm/musicpal.c              | 11 ++--------
 hw/arm/netduino2.c             |  2 +-
 hw/arm/nseries.c               |  4 +++-
 hw/arm/omap1.c                 | 11 ++--------
 hw/arm/omap2.c                 |  8 ++-----
 hw/arm/omap_sx1.c              |  5 ++++-
 hw/arm/palm.c                  |  5 +++--
 hw/arm/pxa2xx.c                | 18 ++++------------
 hw/arm/realview.c              | 25 +++++----------------
 hw/arm/spitz.c                 | 12 ++++++-----
 hw/arm/stellaris.c             | 16 ++++++--------
 hw/arm/stm32f205_soc.c         |  4 ++--
 hw/arm/strongarm.c             | 15 +++----------
 hw/arm/tosa.c                  |  4 ----
 hw/arm/versatilepb.c           | 15 +++----------
 hw/arm/vexpress.c              | 32 +++++++++------------------
 hw/arm/virt.c                  | 46 ++++++++----------------------------=
---
 hw/arm/xilinx_zynq.c           | 10 ++-------
 hw/arm/z2.c                    |  9 +++-----
 hw/i386/pc.c                   | 41 +++++------------------------------
 hw/i386/pc_piix.c              |  4 +---
 hw/lm32/lm32_boards.c          |  8 -------
 hw/lm32/milkymist.c            |  4 ----
 hw/m68k/an5206.c               |  4 ----
 hw/m68k/mcf5208.c              |  4 ----
 hw/mips/cps.c                  |  4 ----
 hw/mips/mips_fulong2e.c        |  4 ----
 hw/mips/mips_jazz.c            |  4 ----
 hw/mips/mips_malta.c           |  4 ----
 hw/mips/mips_mipssim.c         |  4 ----
 hw/mips/mips_r4k.c             |  4 ----
 hw/moxie/moxiesim.c            |  4 ----
 hw/openrisc/openrisc_sim.c     |  4 ----
 hw/ppc/e500.c                  |  4 ----
 hw/ppc/mac_newworld.c          |  4 ----
 hw/ppc/mac_oldworld.c          |  4 ----
 hw/ppc/ppc440_bamboo.c         |  4 ----
 hw/ppc/ppc4xx_devs.c           |  5 -----
 hw/ppc/prep.c                  |  9 --------
 hw/ppc/virtex_ml507.c          |  4 ----
 hw/sh4/r2d.c                   |  4 ----
 hw/sh4/shix.c                  |  4 ----
 hw/sparc/leon3.c               |  4 ----
 hw/sparc/sun4m.c               |  4 ----
 hw/sparc64/sparc64.c           |  4 ----
 hw/tricore/tricore_testboard.c |  4 ----
 hw/unicore32/puv3.c            |  4 ----
 hw/xtensa/sim.c                |  5 -----
 hw/xtensa/xtfpga.c             |  5 -----
 linux-user/main.c              |  4 ----
 qom/cpu.c                      | 49 +++++++++++++++++++++++-------------=
------
 target/arm/cpu.c               |  2 +-
 target/i386/cpu.c              |  3 ---
 vl.c                           | 10 +++++++++
 72 files changed, 194 insertions(+), 489 deletions(-)

--=20
2.7.4
