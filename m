Received: from eggs.gnu.org ([2001:4830:134:3::10]:57411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fB3aq-0000D2-66
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fB3am-0004fN-VM
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:27:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 24 Apr 2018 21:26:15 +0200
Message-Id: <20180424192635.6027-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.13 v4 00/20] linux-user: move arch
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
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

v4:
  - rebase on 2.12 and add R-b
  - report changes introduced by
      aac8f55633 linux-user/signal.c: Put AArch64 frame record in the right place
      bb3ba35f20 linux-user: check that all of AArch64 SVE extended sigframe is writable

v3:
  - rebase and add R-b (except on PATCH 20/20]
  - expand tabs
  - move declarations of functions to signal-common.h
  - fix comment in handle_pending_signal()
  - report changes introduced by
      5de154e82f linux-user: define TARGET_ARCH_HAS_KA_RESTORER
      20ef667060 target/xtensa: fix flush_window_regs
      95a29a4e3e linux-user: fix alpha signal emulation
      7f0f4208b3 linux-user/signal.c: Ensure AArch64 signal frame isn't too small

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
 linux-user/aarch64/signal.c           |  586 +++
 linux-user/aarch64/target_signal.h    |    1 +
 linux-user/alpha/signal.c             |  280 ++
 linux-user/alpha/target_signal.h      |    1 +
 linux-user/arm/signal.c               |  772 ++++
 linux-user/arm/target_signal.h        |    2 +-
 linux-user/cris/signal.c              |  189 +
 linux-user/cris/target_signal.h       |    2 +-
 linux-user/hppa/signal.c              |  210 ++
 linux-user/hppa/target_signal.h       |    1 -
 linux-user/i386/signal.c              |  602 +++
 linux-user/i386/target_signal.h       |    1 +
 linux-user/m68k/signal.c              |  428 +++
 linux-user/m68k/target_signal.h       |    2 +-
 linux-user/microblaze/signal.c        |  248 ++
 linux-user/microblaze/target_signal.h |    2 +-
 linux-user/mips/signal.c              |  400 ++
 linux-user/mips/target_signal.h       |    5 +-
 linux-user/mips64/signal.c            |   20 +
 linux-user/mips64/target_signal.h     |    2 -
 linux-user/nios2/signal.c             |  254 ++
 linux-user/nios2/target_signal.h      |    1 -
 linux-user/openrisc/signal.c          |  231 ++
 linux-user/openrisc/target_signal.h   |    2 -
 linux-user/ppc/signal.c               |  689 ++++
 linux-user/ppc/target_signal.h        |    4 +-
 linux-user/riscv/signal.c             |  218 ++
 linux-user/riscv/target_signal.h      |    1 -
 linux-user/s390x/signal.c             |  327 ++
 linux-user/s390x/target_signal.h      |    2 +-
 linux-user/sh4/signal.c               |  350 ++
 linux-user/sh4/target_signal.h        |    2 +-
 linux-user/signal-common.h            |   57 +
 linux-user/signal.c                   | 6652 +--------------------------------
 linux-user/sparc/signal.c             |  624 ++++
 linux-user/sparc/target_signal.h      |    2 +-
 linux-user/sparc64/signal.c           |   20 +
 linux-user/sparc64/target_signal.h    |    2 +-
 linux-user/tilegx/signal.c            |  186 +
 linux-user/tilegx/target_signal.h     |    2 -
 linux-user/x86_64/signal.c            |   20 +
 linux-user/x86_64/target_signal.h     |    1 -
 linux-user/xtensa/signal.c            |  268 ++
 linux-user/xtensa/target_signal.h     |    1 -
 45 files changed, 7071 insertions(+), 6601 deletions(-)
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
