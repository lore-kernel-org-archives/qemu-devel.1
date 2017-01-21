Received: from eggs.gnu.org ([2001:4830:134:3::10]:43727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cUrIE-00054F-0G
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cUrI9-0002db-TM
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:45:01 -0500
Received: from clearmind.me ([178.32.49.9]:60337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cUrI9-0002a4-IJ
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:44:57 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Sat, 21 Jan 2017 09:45:57 +0100
Message-Id: <20170121084600.5860-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [RFC PATCH 0/3] Preparing the build system for libtcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This series of patches introduce a set of changes, mainly to the QEMU
build system, to open the way to implementing "libtcg", i.e., using
QEMU's tiny code generator frontends as a library.

For the initial proposal, please see the related discussion:

http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg04847.html

The idea is to build a PIC version of QEMU embedding only what's
required to use the TCG frontend (typically
target/$arch/translate.c). To achieve this, some functions have been
moved out of translate.c to reduce the coupling with the other object
files.

All the configurations available on Linux and FreeBSD still build fine
(without warnings).

The last commit also introduces the libtcg/ directory and a series of
*-libtcg targets (similar to the *-{bsd,linux}-user) with the bare
minimum skeleton for the actual implementation and some dummy references
to some functions that in my previous implementation of libtcg were
required, to make sure that all the required object files are linked in.

I've verified that all the libtcg-$arch.so libraries have no pending
symbols.

This is the complete list of new targets available:

aarch64-libtcg alpha-libtcg arm-libtcg armeb-libtcg cris-libtcg i386-libtcg m68k-libtcg microblaze-libtcg microblazeel-libtcg mips-libtcg mips64-libtcg mips64el-libtcg mipsel-libtcg mipsn32-libtcg mipsn32el-libtcg or32-libtcg ppc-libtcg ppc64-libtcg ppc64abi32-libtcg ppc64le-libtcg s390x-libtcg sh4-libtcg sh4eb-libtcg sparc-libtcg sparc32plus-libtcg sparc64-libtcg unicore32-libtcg x86_64-libtcg

Bonus: to reduce the coupling among object files I've create a quick &
dirty Python script to create a Graphviz graph of the various
dependencies among the object files. Simply feed it with a set of object
files, change the name of the "entry" object file (currently anything
containing "libtcg") and it will print the .dot file:

    python graph.py *.o > graph.dot
    dot -Tsvg graph.dot > graph.svg

You can find the script here:

https://clearmind.me/downloads/graph.py

Comments are very welcome.

Alessandro Di Federico (3):
  Factor out {linux,bsd}-user/qemu.h
  *-user targets object files decoupling
  Introduce libtcg infrastructure

 Makefile                                |   7 ++
 Makefile.target                         |  40 ++++++-
 bsd-user/qemu.h                         | 193 +-------------------------------
 configure                               |  20 ++++
 crypto/Makefile.objs                    |   2 +-
 default-configs/aarch64-libtcg.mak      |   0
 default-configs/alpha-libtcg.mak        |   0
 default-configs/arm-libtcg.mak          |   0
 default-configs/armeb-libtcg.mak        |   0
 default-configs/cris-libtcg.mak         |   0
 default-configs/i386-libtcg.mak         |   0
 default-configs/m68k-libtcg.mak         |   0
 default-configs/microblaze-libtcg.mak   |   0
 default-configs/microblazeel-libtcg.mak |   0
 default-configs/mips-libtcg.mak         |   0
 default-configs/mips64-libtcg.mak       |   0
 default-configs/mips64el-libtcg.mak     |   0
 default-configs/mipsel-libtcg.mak       |   0
 default-configs/mipsn32-libtcg.mak      |   0
 default-configs/mipsn32el-libtcg.mak    |   0
 default-configs/or32-libtcg.mak         |   0
 default-configs/ppc-libtcg.mak          |   1 +
 default-configs/ppc64-libtcg.mak        |   1 +
 default-configs/ppc64abi32-libtcg.mak   |   1 +
 default-configs/ppc64le-libtcg.mak      |   1 +
 default-configs/s390x-libtcg.mak        |   0
 default-configs/sh4-libtcg.mak          |   0
 default-configs/sh4eb-libtcg.mak        |   0
 default-configs/sparc-libtcg.mak        |   0
 default-configs/sparc32plus-libtcg.mak  |   0
 default-configs/sparc64-libtcg.mak      |   0
 default-configs/unicore32-libtcg.mak    |   0
 default-configs/x86_64-libtcg.mak       |   0
 exec.c                                  |   2 +
 hw/core/Makefile.objs                   |   5 +-
 include/exec/helper-gen.h               |  12 +-
 include/exec/helper-head.h              |   8 ++
 include/exec/helper-tcg.h               |  12 +-
 libtcg/Makefile.objs                    |   1 +
 libtcg/qemu.h                           |   6 +
 libtcg/tcg.c                            |  55 +++++++++
 libtcg/tcg.h                            |   0
 linux-user/qemu.h                       | 176 +----------------------------
 qemu-user-common.h                      | 180 +++++++++++++++++++++++++++++
 target/alpha/Makefile.objs              |   9 +-
 target/arm/Makefile.objs                |  22 +++-
 target/arm/cpu.c                        | 118 +++++++++++++++++++
 target/arm/cpu.h                        |  82 ++++++++++----
 target/arm/helper.c                     |  73 +-----------
 target/arm/translate-a64.c              |  54 ---------
 target/arm/translate.c                  |  97 ++++++----------
 target/arm/translate.h                  |   7 --
 target/cris/Makefile.objs               |  10 +-
 target/i386/Makefile.objs               |  14 ++-
 target/lm32/Makefile.objs               |  12 +-
 target/m68k/Makefile.objs               |   7 +-
 target/m68k/op_helper.c                 |  23 ++++
 target/m68k/translate.c                 |  23 ----
 target/microblaze/Makefile.objs         |  10 +-
 target/mips/Makefile.objs               |  11 +-
 target/mips/op_helper.c                 |   8 --
 target/mips/translate.c                 |   8 ++
 target/moxie/Makefile.objs              |   8 +-
 target/openrisc/Makefile.objs           |  11 +-
 target/ppc/Makefile.objs                |  18 +--
 target/ppc/gdbstub.c                    |  20 ----
 target/ppc/translate.c                  |   2 +
 target/ppc/translate_init.c             |  28 +++++
 target/s390x/Makefile.objs              |  16 ++-
 target/sh4/Makefile.objs                |   8 +-
 target/sparc/Makefile.objs              |  15 ++-
 target/tilegx/Makefile.objs             |   7 +-
 target/tricore/Makefile.objs            |   7 +-
 target/unicore32/Makefile.objs          |   8 +-
 target/unicore32/helper.c               |  68 +++++++++++
 target/unicore32/translate.c            |  68 -----------
 target/xtensa/Makefile.objs             |  14 ++-
 trace/Makefile.objs                     |   2 +-
 translate-all.c                         |   4 +-
 79 files changed, 837 insertions(+), 778 deletions(-)
 create mode 100644 default-configs/aarch64-libtcg.mak
 create mode 100644 default-configs/alpha-libtcg.mak
 create mode 100644 default-configs/arm-libtcg.mak
 create mode 100644 default-configs/armeb-libtcg.mak
 create mode 100644 default-configs/cris-libtcg.mak
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
 create mode 100644 default-configs/unicore32-libtcg.mak
 create mode 100644 default-configs/x86_64-libtcg.mak
 create mode 100644 libtcg/Makefile.objs
 create mode 100644 libtcg/qemu.h
 create mode 100644 libtcg/tcg.c
 create mode 100644 libtcg/tcg.h
 create mode 100644 qemu-user-common.h

-- 
2.11.0
