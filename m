Received: from eggs.gnu.org ([2001:4830:134:3::10]:45279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdU-0004iL-Nv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdR-0000WL-HN
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:19 +0100
Message-Id: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 00/20] linux-user: move arch
 specific parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

Some files like signal.c are really hard to read
because all architectures are mixed in the same
file.

This series moves from signal.c these parts to
the architecture dedicated directories in linux-user.
Moreover, this allows to compare easier functions
between architectures (it helps to debug problems).
Adding new functions for a new architecture will
be facilitated too.

checkpatch.pl is not happy... but I only want to
move code from a file to another. I don't want
to change the content of the parts I move.

v2:
  - only move parts from signal.c
  - link them instead of including them
  - one patch by architecture
  - add a first patch to prepare the change.

The first patch adds signal-common.h to define
what is needed by the signal.c of the architectures.
It adds a "do-nothing" signal.c in each arch
directory and the rule needed to build them
in Makefile.objs.

Then the process is simple...

for each architecture:
  - copy the arch specific code from signal.c
    to <arch>/signal.c
  - add includes (including signal-common.h)
  - export setup_rt_frame() and setup_frame()
    (remove static in <arch>/signal.c,
     add the declaration in <arch>/target_signal.h)

When the arch has 32bit and 64bit architectures,
it's a little bit more complicated:
  - ppc/ppc64: nothing special to do, all is in ppc/,
    there is no ppc64 directory,
  - arm/aarch64: one file for arm, one file for aarch64
  - i386/x86_64, sparc/sparc64, mips/mips64:
    update each target_signal.h,
    include the 32bit signal.c file into the 64bit signal.c file
    to avoid to duplicate code (and add a guard to not include
    the 32bit target_signal.h)

Laurent Vivier (20):
  linux-user: create a dummy per arch signal.c
  linux-user: move aarch64 signal.c parts to aarch64 directory
  linux-user: move arm signal.c parts to arm directory
  linux-user: move sh4 signal.c parts to sh4 directory
  linux-user: move microblaze signal.c parts to microblaze directory
  linux-user: move cris signal.c parts to cris directory
  linux-user: move nios2 signal.c parts to nios2 directory
  linux-user: move openrisc signal.c parts to openrisc directory
  linux-user: move s390x signal.c parts to s390x directory
  linux-user: move m68k signal.c parts to m68k directory
  linux-user: move alpha signal.c parts to alpha directory
  linux-user: move tilegx signal.c parts to tilegx directory
  linux-user: move riscv signal.c parts to riscv directory
  linux-user: move hppa signal.c parts to hppa directory
  linux-user: move xtensa signal.c parts to xtensa directory
  linux-user: move i386/x86_64 signal.c parts to i386 directory
  linux-user: move sparc/sparc64 signal.c parts to sparc directory
  linux-user: move mips/mips64 signal.c parts to mips directory
  linux-user: move ppc/ppc64 signal.c parts to ppc directory
  linux-user: define TARGET_ARCH_HAS_SETUP_FRAME

 linux-user/Makefile.objs              |    2 +-
 linux-user/aarch64/signal.c           |  579 +++
 linux-user/aarch64/target_signal.h    |    6 +
 linux-user/alpha/signal.c             |  280 ++
 linux-user/alpha/target_signal.h      |    6 +
 linux-user/arm/signal.c               |  772 ++++
 linux-user/arm/target_signal.h        |    7 +-
 linux-user/cris/signal.c              |  189 +
 linux-user/cris/target_signal.h       |    7 +-
 linux-user/hppa/signal.c              |  210 ++
 linux-user/hppa/target_signal.h       |    3 +
 linux-user/i386/signal.c              |  602 +++
 linux-user/i386/target_signal.h       |    6 +
 linux-user/m68k/signal.c              |  428 +++
 linux-user/m68k/target_signal.h       |    7 +-
 linux-user/microblaze/signal.c        |  248 ++
 linux-user/microblaze/target_signal.h |    7 +-
 linux-user/mips/signal.c              |  400 ++
 linux-user/mips/target_signal.h       |   10 +-
 linux-user/mips64/signal.c            |   20 +
 linux-user/mips64/target_signal.h     |    4 +-
 linux-user/nios2/signal.c             |  254 ++
 linux-user/nios2/target_signal.h      |    4 +
 linux-user/openrisc/signal.c          |  231 ++
 linux-user/openrisc/target_signal.h   |    4 +-
 linux-user/ppc/signal.c               |  689 ++++
 linux-user/ppc/target_signal.h        |    9 +-
 linux-user/riscv/signal.c             |  218 ++
 linux-user/riscv/target_signal.h      |    3 +
 linux-user/s390x/signal.c             |  327 ++
 linux-user/s390x/target_signal.h      |    7 +-
 linux-user/sh4/signal.c               |  350 ++
 linux-user/sh4/target_signal.h        |    6 +
 linux-user/signal-common.h            |   50 +
 linux-user/signal.c                   | 6654 +--------------------------------
 linux-user/sparc/signal.c             |  624 ++++
 linux-user/sparc/target_signal.h      |    7 +-
 linux-user/sparc64/signal.c           |   20 +
 linux-user/sparc64/target_signal.h    |    7 +-
 linux-user/tilegx/signal.c            |  186 +
 linux-user/tilegx/target_signal.h     |    4 +-
 linux-user/x86_64/signal.c            |   20 +
 linux-user/x86_64/target_signal.h     |    3 +
 linux-user/xtensa/signal.c            |  275 ++
 linux-user/xtensa/target_signal.h     |    3 +
 45 files changed, 7155 insertions(+), 6593 deletions(-)
 create mode 100644 linux-user/aarch64/signal.c
 create mode 100644 linux-user/alpha/signal.c
 create mode 100644 linux-user/arm/signal.c
 create mode 100644 linux-user/cris/signal.c
 create mode 100644 linux-user/hppa/signal.c
 create mode 100644 linux-user/i386/signal.c
 create mode 100644 linux-user/m68k/signal.c
 create mode 100644 linux-user/microblaze/signal.c
 create mode 100644 linux-user/mips/signal.c
 create mode 100644 linux-user/mips64/signal.c
 create mode 100644 linux-user/nios2/signal.c
 create mode 100644 linux-user/openrisc/signal.c
 create mode 100644 linux-user/ppc/signal.c
 create mode 100644 linux-user/riscv/signal.c
 create mode 100644 linux-user/s390x/signal.c
 create mode 100644 linux-user/sh4/signal.c
 create mode 100644 linux-user/signal-common.h
 create mode 100644 linux-user/sparc/signal.c
 create mode 100644 linux-user/sparc64/signal.c
 create mode 100644 linux-user/tilegx/signal.c
 create mode 100644 linux-user/x86_64/signal.c
 create mode 100644 linux-user/xtensa/signal.c

-- 
2.14.3
