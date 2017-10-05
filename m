Received: from eggs.gnu.org ([2001:4830:134:3::10]:52406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yf-0007Bt-LJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06YZ-0008Ek-IF
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06YZ-0008Dd-9z
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:19 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:34 +0200
Message-Id: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/40] generalize parsing of cpu_model (part
 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Changelog:
 v2:
    - replace "qom: add helper type_init_from_array()" with 3 new patches
      * qom: update doc comment for type_register[_static]()             =
             =20
      * qom: introduce type_register_static_array()                      =
             =20
      * qom: add helper macro DEFINE_TYPES()
    - s/type_init_from_array/DEFINE_TYPES/ across series in
        "FOO: cleanup cpu type name composition" patches
    - re-add lost DEFINE_CRIS_CPU_TYPE() in
        "cris: cleanup cpu type name composition"
    - improve commit message in
        "sh4: shix: use generic cpu_model parsing"
    - drop  NULL-initialization in
        "sh4: simplify superh_cpu_class_by_name()"
    - pick up Reviewed/Acked-bys from v1
        I took a liberty to keep all of them because of
        s/type_init_from_array/DEFINE_TYPES/ renaming in reviewed
        "FOO: cleanup cpu type name composition" patches was trivial
        and it passed tests locally so works as expected.

this series is continuation of effort to remove boards dependency on
cpu_model parsing and generalizing default cpu type handling.
For background story look at merged:=20

  [PATCH v2 0/5] generalize parsing of cpu_model (x86/arm)
  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03564.html

thisi series mostly consist of 3 types of patches:
 1: unifying cpu type name composing by introdicing=20
        FOO_CPU_TYPE_NAME() macro across targets
 2: replacing simple static(and needlessly dynamic) cpu type registration=
s
    with common pattern where typinfo is put into array which
    is used to batch register cpu types with new helper DEFINE_TYPES()
 3: main patches that generalize cpu_model parsing for boards

I'm releasing independent subset that takes care of all
targets/boards except null-machine, ppc and *-user targets
(as they are still work in progress and PPC part is big
enough to deserve its own series)

I've tried to test all converted boards but there were a lot
so I've might have missed some.

git tree for testing:
  https://github.com/imammedo/qemu/branches cpu_init_removal_part2_v2

For reference v1:
  https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00036.html

PS:
 rebased on top of ehabkost/machine-next tree to avoid resolve conflicts =
with
 queued "qom/cpu: move cpu_model null check to  cpu_class_by_name()"

CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Igor Mammedov (40):
  qom: update doc comment for type_register[_static]()
  qom: introduce type_register_static_array()
  qom: add helper macro DEFINE_TYPES()
  alpha: cleanup cpu type name composition
  alpha: use generic cpu_model parsing
  cris: cleanup cpu type name composition
  cris: use generic cpu_model parsing
  lm32: cleanup cpu type name composition
  lm32: milkymist: use generic cpu_model parsing
  lm32: lm32_boards: use generic cpu_model parsing
  m68k: cleanup cpu type name composition
  m68k: an5206: use generic cpu_model parsing
  m68k: mcf5208: use generic cpu_model parsing
  moxie: fix qemu-system-moxie failing to start with CLI "-cpu
    MoxieLite"
  moxie: cleanup cpu type name composition
  moxie: use generic cpu_model parsing
  openrisc: cleanup cpu type name composition
  openrisc: use generic cpu_model parsing
  sh4: r2d: use generic cpu_model parsing
  sh4: shix: use generic cpu_model parsing
  sh4: cleanup cpu type name composition
  sh4: simplify superh_cpu_class_by_name()
  sh4: remove SuperHCPUClass::name field
  xtensa: cleanup cpu type name composition
  xtensa: sim: use generic cpu_model parsing
  xtensa: lx60/lx200/ml605/kc705: use generic cpu_model parsing
  unicore32: cleanup cpu type name composition
  unicore32: use generic cpu_model parsing
  tricore: cleanup cpu type name composition
  tricore: use generic cpu_model parsing
  sparc: cleanup cpu type name composition
  sparc: sun4u/sun4v/niagara: use generic cpu_model parsing
  sparc: sparc: use generic cpu_model parsing
  sparc: leon3: use generic cpu_model parsing
  mips: use object_new() instead of gnew()+object_initialize()
  mips: malta/boston: replace cpu_model with cpu_type
  mips: fulong2e: replace cpu_model with cpu_type
  mips: Magnum/Acer Pica 61: replace cpu_model with cpu_type
  mips: mipssim: replace cpu_model with cpu_type
  mips: r4k: replace cpu_model with cpu_type

 include/hw/mips/cps.h          |   2 +-
 include/hw/sparc/sparc64.h     |   3 +-
 include/qom/object.h           |  50 ++++++++++++++++++-
 target/alpha/cpu.h             |   3 ++
 target/cris/cpu.h              |   3 ++
 target/lm32/cpu.h              |   3 ++
 target/m68k/cpu.h              |   3 ++
 target/mips/cpu.h              |   8 ++-
 target/moxie/cpu.h             |   3 ++
 target/openrisc/cpu.h          |   3 ++
 target/sh4/cpu-qom.h           |   8 ++-
 target/sh4/cpu.h               |   3 ++
 target/sparc/cpu.h             |   3 ++
 target/tricore/cpu.h           |   2 +
 target/unicore32/cpu.h         |   3 ++
 target/xtensa/cpu.h            |   4 ++
 hw/alpha/dp264.c               |   4 +-
 hw/cris/axis_dev88.c           |   7 +--
 hw/lm32/lm32_boards.c          |  14 ++----
 hw/lm32/milkymist.c            |   7 +--
 hw/m68k/an5206.c               |   7 +--
 hw/m68k/mcf5208.c              |   7 +--
 hw/mips/boston.c               |  14 +++---
 hw/mips/cps.c                  |   4 +-
 hw/mips/mips_fulong2e.c        |   7 +--
 hw/mips/mips_jazz.c            |   8 ++-
 hw/mips/mips_malta.c           |  36 ++++++--------
 hw/mips/mips_mipssim.c         |  15 +++---
 hw/mips/mips_r4k.c             |  16 +++---
 hw/moxie/moxiesim.c            |   7 +--
 hw/openrisc/openrisc_sim.c     |   8 +--
 hw/sh4/r2d.c                   |   8 +--
 hw/sh4/shix.c                  |   7 +--
 hw/sparc/leon3.c               |   8 +--
 hw/sparc/sun4m.c               |  29 +++++------
 hw/sparc64/niagara.c           |   4 +-
 hw/sparc64/sparc64.c           |   8 +--
 hw/sparc64/sun4u.c             |   8 ++-
 hw/tricore/tricore_testboard.c |   6 +--
 hw/unicore32/puv3.c            |   8 +--
 hw/xtensa/sim.c                |   8 +--
 hw/xtensa/xtfpga.c             |  11 ++---
 qom/object.c                   |   9 ++++
 target/alpha/cpu.c             | 107 +++++++++++++----------------------=
------
 target/cris/cpu.c              |  81 +++++++++++--------------------
 target/lm32/cpu.c              |  74 +++++++++-------------------
 target/m68k/cpu.c              |  75 +++++++++++------------------
 target/mips/cpu.c              |   2 +-
 target/mips/translate.c        |  20 +++-----
 target/mips/translate_init.c   |  12 -----
 target/moxie/cpu.c             |  61 +++++++++--------------
 target/openrisc/cpu.c          |  69 +++++++++-----------------
 target/sh4/cpu.c               | 107 +++++++++++++++--------------------=
------
 target/sparc/cpu.c             |   2 +-
 target/tricore/cpu.c           |  68 ++++++++------------------
 target/unicore32/cpu.c         |  61 ++++++++---------------
 target/xtensa/cpu.c            |   2 +-
 target/xtensa/helper.c         |   2 +-
 58 files changed, 442 insertions(+), 680 deletions(-)

--=20
2.7.4
