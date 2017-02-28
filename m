Received: from eggs.gnu.org ([2001:4830:134:3::10]:43803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPl-0003I6-9S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPi-0003ha-4f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:17 -0500
Received: from clearmind.me ([178.32.49.9]:49255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPh-0003gG-Qn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:14 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:14 +0100
Message-Id: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 0/7] Introducing libtcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This series of patches is a follow-up to the "Preparing the build system
for libtcg" patch set.

The first six patches' aim is to decouple and factor out some components
so that introducing libtcg can be painless and smooth. The last patch
instead introduces libtcg, along with a set of simple tests.

My main aim is to get the first six patches in mainline as soon as
possible, since rebasing when large amounts of code is moved is quite a
pain. If possible, letting the last patch in would be nice too.

The current implementation of libtcg it's not thread-safe, doesn't allow
to change the CPU, munmap memory pages and the library itself cannot be
unloaded.

Note that if libtcg is enabled in a build directory where it previously
wasn't, a `make clean` is required, since everything has to be built
with `-fPIC -fvisibility=hidden`. Maybe it's possible to have the build
system recognize this automatically (suggestions welcome).

Note also that the factoring process excluded the bsd-user targets,
which would benefit from it (mainly for mmap.c and qemu.h), but are not
in a working state, so I'm leaving them out to avoid making more
damage. Once bsd-user is back in shape in mainline I'll be happy to
include it in the factoring.

For what concerns the test suite, the s390x linux-user target seems to
be broken so I've temporarily excluded it from the test suite. Currently
I'm testing translation only on a subset of architectures (MIPS, ARM and
x86-64). It would be nice to test them all, but manually building all
the toolchains can be a pain. Is there an "official" set of toolchains
ready to use/compile?

For what concerns the PREFIX changes in tcg-common.h, they're not very
elegant. Another approach might be to prefix all the data types, data
structures and enum entries in there with LibTCG/LIBTCG_ even
internally. Opinions?

Thanks.

Alessandro Di Federico (7):
  Factor out linux-user/qemu.h
  Factor out *-user/mmap.c
  Move *_cpu_dump_state to translate.c
  *-user targets object files decoupling
  Isolate coprocessor parts from target/arm/helper.c
  Factor out tcg/tcg.h
  Introduce libtcg infrastructure

 Makefile                                |    9 +
 Makefile.target                         |   46 +-
 configure                               |   20 +
 crypto/Makefile.objs                    |    2 +-
 default-configs/aarch64-libtcg.mak      |    0
 default-configs/alpha-libtcg.mak        |    0
 default-configs/arm-libtcg.mak          |    0
 default-configs/armeb-libtcg.mak        |    0
 default-configs/cris-libtcg.mak         |    0
 default-configs/hppa-libtcg.mak         |    0
 default-configs/i386-libtcg.mak         |    0
 default-configs/m68k-libtcg.mak         |    0
 default-configs/microblaze-libtcg.mak   |    0
 default-configs/microblazeel-libtcg.mak |    0
 default-configs/mips-libtcg.mak         |    0
 default-configs/mips64-libtcg.mak       |    0
 default-configs/mips64el-libtcg.mak     |    0
 default-configs/mipsel-libtcg.mak       |    0
 default-configs/mipsn32-libtcg.mak      |    0
 default-configs/mipsn32el-libtcg.mak    |    0
 default-configs/nios2-libtcg.mak        |    0
 default-configs/or1k-libtcg.mak         |    0
 default-configs/or32-libtcg.mak         |    0
 default-configs/ppc-libtcg.mak          |    1 +
 default-configs/ppc64-libtcg.mak        |    1 +
 default-configs/ppc64abi32-libtcg.mak   |    1 +
 default-configs/ppc64le-libtcg.mak      |    1 +
 default-configs/s390x-libtcg.mak        |    0
 default-configs/sh4-libtcg.mak          |    0
 default-configs/sh4eb-libtcg.mak        |    0
 default-configs/sparc-libtcg.mak        |    0
 default-configs/sparc32plus-libtcg.mak  |    0
 default-configs/sparc64-libtcg.mak      |    0
 default-configs/tilegx-libtcg.mak       |    0
 default-configs/unicore32-libtcg.mak    |    0
 default-configs/x86_64-libtcg.mak       |    0
 exec.c                                  |    6 +-
 hw/core/Makefile.objs                   |    5 +-
 include/exec/helper-gen.h               |   12 +-
 include/exec/helper-head.h              |    8 +
 include/exec/helper-tcg.h               |   12 +-
 include/libtcg.h                        |  109 +
 include/qemu-common.h                   |    3 +
 include/qemu-user-common.h              |  197 ++
 include/tcg-common.h                    |  236 ++
 {tcg => include}/tcg-opc.h              |    0
 libtcg/Makefile.objs                    |    1 +
 libtcg/libtcg.c                         |  226 ++
 libtcg/qemu.h                           |    7 +
 linux-user/Makefile.objs                |    2 +-
 linux-user/qemu.h                       |  192 +-
 linux-user/mmap.c => mmap.c             |    0
 qom/cpu.c                               |    4 +-
 target/alpha/Makefile.objs              |    8 +-
 target/alpha/cpu.c                      |   44 +-
 target/alpha/helper.c                   |   73 -
 target/alpha/translate.c                |   36 +
 target/arm/Makefile.objs                |   21 +-
 target/arm/coprocessors.c               | 5814 ++++++++++++++++++++++++++++++
 target/arm/cpu.c                        |   20 +-
 target/arm/cpu.h                        |   74 +-
 target/arm/cpu64.c                      |    2 +
 target/arm/helper.c                     | 5891 +------------------------------
 target/arm/internals.h                  |    8 +
 target/arm/translate.c                  |   35 +
 target/cris/Makefile.objs               |    9 +-
 target/cris/cpu.c                       |   28 +-
 target/cris/translate.c                 |    2 +
 target/hppa/Makefile.objs               |    6 +-
 target/hppa/cpu.c                       |   10 +-
 target/hppa/helper.c                    |   25 -
 target/hppa/translate.c                 |   27 +
 target/i386/Makefile.objs               |   15 +-
 target/i386/cpu.c                       |   24 +-
 target/i386/helper.c                    |  323 --
 target/i386/translate.c                 |  325 ++
 target/lm32/Makefile.objs               |   11 +-
 target/lm32/translate.c                 |    2 +
 target/m68k/Makefile.objs               |    6 +-
 target/m68k/cpu.c                       |   73 +-
 target/m68k/cpu.h                       |   49 +
 target/m68k/helper.c                    |  110 -
 target/m68k/translate.c                 |    2 +
 target/microblaze/Makefile.objs         |    9 +-
 target/microblaze/cpu.c                 |    6 +-
 target/microblaze/translate.c           |    2 +
 target/mips/Makefile.objs               |   10 +-
 target/mips/cpu.c                       |    8 +-
 target/mips/op_helper.c                 |    8 -
 target/mips/translate.c                 |   10 +
 target/moxie/Makefile.objs              |    8 +-
 target/moxie/translate.c                |    2 +
 target/nios2/Makefile.objs              |    6 +-
 target/nios2/cpu.c                      |   17 +-
 target/nios2/translate.c                |    2 +
 target/openrisc/Makefile.objs           |   11 +-
 target/openrisc/cpu.c                   |    7 +-
 target/openrisc/translate.c             |    2 +
 target/ppc/Makefile.objs                |   19 +-
 target/ppc/gdbstub.c                    |   20 -
 target/ppc/translate.c                  |    2 +
 target/ppc/translate_init.c             |   36 +-
 target/s390x/Makefile.objs              |   16 +-
 target/s390x/cpu.c                      |   83 +-
 target/s390x/helper.c                   |   75 -
 target/s390x/translate.c                |    2 +
 target/sh4/Makefile.objs                |    7 +-
 target/sh4/cpu.c                        |   10 +-
 target/sh4/translate.c                  |    2 +
 target/sparc/Makefile.objs              |   13 +-
 target/sparc/cpu.c                      |   97 +-
 target/sparc/cpu.h                      |    2 +
 target/sparc/translate.c                |   87 +
 target/tilegx/Makefile.objs             |    6 +-
 target/tilegx/cpu.c                     |   38 +-
 target/tilegx/cpu.h                     |    3 +
 target/tilegx/translate.c               |   38 +-
 target/tricore/Makefile.objs            |    6 +-
 target/tricore/translate.c              |    2 +
 target/unicore32/Makefile.objs          |    7 +-
 target/unicore32/cpu.c                  |   11 +-
 target/unicore32/helper.c               |    5 -
 target/unicore32/translate.c            |    2 +
 target/xtensa/Makefile.objs             |   13 +-
 target/xtensa/translate.c               |    2 +
 tcg/aarch64/tcg-target.h                |    4 +-
 tcg/arm/tcg-target.h                    |    4 +-
 tcg/i386/tcg-target.h                   |    4 +-
 tcg/ia64/tcg-target.h                   |    4 +-
 tcg/mips/tcg-target.h                   |    4 +-
 tcg/ppc/tcg-target.h                    |    4 +-
 tcg/s390/tcg-target.h                   |    4 +-
 tcg/sparc/tcg-target.h                  |    4 +-
 tcg/tcg.c                               |   15 +-
 tcg/tcg.h                               |  213 +-
 tcg/tci/tcg-target.h                    |    4 +-
 tests/Makefile.include                  |    7 +-
 tests/test-libtcg.c                     |  238 ++
 trace/Makefile.objs                     |    2 +-
 translate-all.c                         |    2 +-
 140 files changed, 8198 insertions(+), 7201 deletions(-)
 create mode 100644 default-configs/aarch64-libtcg.mak
 create mode 100644 default-configs/alpha-libtcg.mak
 create mode 100644 default-configs/arm-libtcg.mak
 create mode 100644 default-configs/armeb-libtcg.mak
 create mode 100644 default-configs/cris-libtcg.mak
 create mode 100644 default-configs/hppa-libtcg.mak
 create mode 100644 default-configs/i386-libtcg.mak
 create mode 100644 default-configs/m68k-libtcg.mak
 create mode 100644 default-configs/microblaze-libtcg.mak
 create mode 100644 default-configs/microblazeel-libtcg.mak
 create mode 100644 default-configs/mips-libtcg.mak
 create mode 100644 default-configs/mips64-libtcg.mak
 create mode 100644 default-configs/mips64el-libtcg.mak
 create mode 100644 default-configs/mipsel-libtcg.mak
 create mode 100644 default-configs/mipsn32-libtcg.mak
 create mode 100644 default-configs/mipsn32el-libtcg.mak
 create mode 100644 default-configs/nios2-libtcg.mak
 create mode 100644 default-configs/or1k-libtcg.mak
 create mode 100644 default-configs/or32-libtcg.mak
 create mode 100644 default-configs/ppc-libtcg.mak
 create mode 100644 default-configs/ppc64-libtcg.mak
 create mode 100644 default-configs/ppc64abi32-libtcg.mak
 create mode 100644 default-configs/ppc64le-libtcg.mak
 create mode 100644 default-configs/s390x-libtcg.mak
 create mode 100644 default-configs/sh4-libtcg.mak
 create mode 100644 default-configs/sh4eb-libtcg.mak
 create mode 100644 default-configs/sparc-libtcg.mak
 create mode 100644 default-configs/sparc32plus-libtcg.mak
 create mode 100644 default-configs/sparc64-libtcg.mak
 create mode 100644 default-configs/tilegx-libtcg.mak
 create mode 100644 default-configs/unicore32-libtcg.mak
 create mode 100644 default-configs/x86_64-libtcg.mak
 create mode 100644 include/libtcg.h
 create mode 100644 include/qemu-user-common.h
 create mode 100644 include/tcg-common.h
 rename {tcg => include}/tcg-opc.h (100%)
 create mode 100644 libtcg/Makefile.objs
 create mode 100644 libtcg/libtcg.c
 create mode 100644 libtcg/qemu.h
 rename linux-user/mmap.c => mmap.c (100%)
 create mode 100644 target/arm/coprocessors.c
 create mode 100644 tests/test-libtcg.c

-- 
2.11.1
