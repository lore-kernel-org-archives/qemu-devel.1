Received: from eggs.gnu.org ([2001:4830:134:3::10]:55077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu0-0004vb-1X
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpty-0007l7-QU
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpty-0007hT-6i
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:22 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:12 +0100
Message-Id: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Series is finishing work on generalizing cpu_model parsing
and limiting parts that deal with inconsistent cpu_model
naming to "-cpu" CLI option processing in vl.c/*-user.main.c
and FOO_cpu_class_by_name() callbacks.

It introduces TARGET_DEFAULT_CPU_TYPE which must be defined
by each target and is used setting default cpu type for
linux/bsd-user targets and as anchor point to pick cpu class
that provides target specific FOO_cpu_class_by_name()
callback for cpu_parse_cpu_model() in null-machine.c
which is compiled for all targets that have system
mode emulation.

After TARGET_DEFAULT_CPU_TYPE is provided by each target,
patches 20-21/24 switch null-machine.c and *-user.main.c
to use TARGET_DEFAULT_CPU_TYPE and using
   cpu_parse_cpu_model()/cpu_create()
instead of
   cpu_init()/cpu_generic_init()
so nor more users of later remains and boards/targets deal
only with cpu types (in similar/consistent manner).

Finishing patches 22-24/24 remove not used anymore
  cpu_init()/cpu_generic_init()
API so cpu_model won't be introduced back in boards code
in the future (23/24 removes cpu_generic_init user that
managed to slip in this merge window).=20

CC: Laurent Vivier <laurent@vivier.eu>

Igor Mammedov (24):
  arm: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  alpha: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  cris: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  lm32: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  m68k: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  microblaze: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  mips: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  moxie: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  nios2: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  openrisc: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  ppc: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  s390x: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  sh4: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  sparc: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  tricore: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  unicore32: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  xtensa: cpu: rename XTENSA_DEFAULT_CPU_TYPE to TARGET_DEFAULT_CPU_TYPE
  hppa: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  tilegx: cpu: add TARGET_DEFAULT_CPU_TYPE macro
  machine: drop MachineState::cpu_model
  linux/bsd-user: drop cpu_init() and use cpu_create() instead
  cpu: get rid of unused cpu_init() defines
  nios2: 10m50_devboard: replace cpu_model with cpu_type
  cpu: get rid of cpu_generic_init()

 include/hw/boards.h       |  1 -
 include/qom/cpu.h         | 11 ----------
 target/alpha/cpu.h        |  3 +--
 target/arm/cpu.h          |  3 +--
 target/cris/cpu.h         |  3 +--
 target/hppa/cpu.h         |  2 +-
 target/i386/cpu.h         |  2 --
 target/lm32/cpu.h         |  3 +--
 target/m68k/cpu.h         |  3 +--
 target/microblaze/cpu.h   |  2 +-
 target/mips/cpu.h         |  8 ++++++--
 target/moxie/cpu.h        |  3 +--
 target/nios2/cpu.h        |  2 +-
 target/openrisc/cpu.h     |  3 +--
 target/ppc/cpu.h          |  8 ++++++--
 target/s390x/cpu.h        |  3 +--
 target/sh4/cpu.h          |  3 +--
 target/sparc/cpu.h        | 10 +++++----
 target/tilegx/cpu.h       |  2 +-
 target/tricore/cpu.h      |  3 +--
 target/unicore32/cpu.h    |  3 +--
 target/xtensa/cpu.h       |  4 +---
 bsd-user/main.c           | 26 ++++--------------------
 hw/core/null-machine.c    | 10 ++++++---
 hw/nios2/10m50_devboard.c |  2 +-
 hw/xtensa/sim.c           |  2 +-
 hw/xtensa/xtfpga.c        |  8 ++++----
 linux-user/main.c         | 52 +++++------------------------------------=
------
 qom/cpu.c                 | 25 ++---------------------
 vl.c                      |  8 +++++++-
 30 files changed, 65 insertions(+), 153 deletions(-)

--=20
2.7.4
