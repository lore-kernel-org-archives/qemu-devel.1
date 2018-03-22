Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Em-0004Xz-O5
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Ej-00048u-JG
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:08 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ez8Ej-00048F-1y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:05 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 22 Mar 2018 22:58:28 +0100
Message-Id: <20180322215833.7713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 0/5] linux-user: move arch specific
 parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Some files like signal.c are really hard to read
because all architectures are mixed in the same
file.

This series moves from signal.c these parts to
the architecture dedicated directories in linux-user.
Moerover, this allows to compare easier functions
between architectures (it helps to debug problems).
Adding new functions for a new architecture will
be facilitated too.

As we are doing that for signal.c, we can also
do that for main.c, for the cpu loop part
and the cpu loop prologue too.

checkpatch.pl is not happy... but I only want to
move code from a file to another. I don't want
to change the content of the parts I move.

Laurent Vivier (5):
  linux-user: cleanup signal.c
  linux-user: remove unneeded #ifdef in signal.c
  linux-user: define TARGET_ARCH_HAS_SETUP_FRAME
  linux-user: cleanup cpu_loop()
  linux-user: cleanup main()

 linux-user/aarch64/cpu_loop.inc.c    |    1 +
 linux-user/aarch64/prologue.inc.c    |   21 +
 linux-user/aarch64/signal.inc.c      |  557 +++
 linux-user/alpha/cpu_loop.inc.c      |  191 +
 linux-user/alpha/prologue.inc.c      |    9 +
 linux-user/alpha/signal.inc.c        |  259 ++
 linux-user/arm/cpu_loop.inc.c        |  488 +++
 linux-user/arm/prologue.inc.c        |   23 +
 linux-user/arm/signal.inc.c          |  750 ++++
 linux-user/cris/cpu_loop.inc.c       |   67 +
 linux-user/cris/prologue.inc.c       |   19 +
 linux-user/cris/signal.inc.c         |  167 +
 linux-user/hppa/cpu_loop.inc.c       |  178 +
 linux-user/hppa/prologue.inc.c       |    8 +
 linux-user/hppa/signal.inc.c         |  188 +
 linux-user/i386/cpu_loop.inc.c       |  229 ++
 linux-user/i386/prologue.inc.c       |  113 +
 linux-user/i386/signal.inc.c         |  580 +++
 linux-user/m68k/cpu_loop.inc.c       |  115 +
 linux-user/m68k/prologue.inc.c       |   26 +
 linux-user/m68k/signal.inc.c         |  407 +++
 linux-user/main.c                    | 4318 +---------------------
 linux-user/microblaze/cpu_loop.inc.c |  116 +
 linux-user/microblaze/prologue.inc.c |   35 +
 linux-user/microblaze/signal.inc.c   |  227 ++
 linux-user/mips/cpu_loop.inc.c       |  695 ++++
 linux-user/mips/prologue.inc.c       |   25 +
 linux-user/mips/signal.inc.c         |  379 ++
 linux-user/mips64/cpu_loop.inc.c     |    1 +
 linux-user/mips64/prologue.inc.c     |    1 +
 linux-user/mips64/signal.inc.c       |    1 +
 linux-user/nios2/cpu_loop.inc.c      |   98 +
 linux-user/nios2/prologue.inc.c      |   29 +
 linux-user/nios2/signal.inc.c        |  232 ++
 linux-user/openrisc/cpu_loop.inc.c   |   81 +
 linux-user/openrisc/prologue.inc.c   |    9 +
 linux-user/openrisc/signal.inc.c     |  209 ++
 linux-user/ppc/cpu_loop.inc.c        |  538 +++
 linux-user/ppc/prologue.inc.c        |   16 +
 linux-user/ppc/signal.inc.c          |  668 ++++
 linux-user/riscv/cpu_loop.inc.c      |   89 +
 linux-user/riscv/prologue.inc.c      |    4 +
 linux-user/riscv/signal.inc.c        |  196 +
 linux-user/s390x/cpu_loop.inc.c      |  132 +
 linux-user/s390x/prologue.inc.c      |    8 +
 linux-user/s390x/signal.inc.c        |  306 ++
 linux-user/sh4/cpu_loop.inc.c        |   78 +
 linux-user/sh4/prologue.inc.c        |    8 +
 linux-user/sh4/signal.inc.c          |  328 ++
 linux-user/signal.c                  | 6623 +---------------------------------
 linux-user/sparc/cpu_loop.inc.c      |  271 ++
 linux-user/sparc/prologue.inc.c      |   10 +
 linux-user/sparc/signal.inc.c        |  602 +++
 linux-user/sparc64/cpu_loop.inc.c    |    1 +
 linux-user/sparc64/prologue.inc.c    |    1 +
 linux-user/sparc64/signal.inc.c      |    1 +
 linux-user/tilegx/cpu_loop.inc.c     |  251 ++
 linux-user/tilegx/prologue.inc.c     |   10 +
 linux-user/tilegx/signal.inc.c       |  163 +
 linux-user/x86_64/cpu_loop.inc.c     |    1 +
 linux-user/x86_64/prologue.inc.c     |    1 +
 linux-user/x86_64/signal.inc.c       |    1 +
 linux-user/xtensa/cpu_loop.inc.c     |  231 ++
 linux-user/xtensa/prologue.inc.c     |    8 +
 linux-user/xtensa/signal.inc.c       |  253 ++
 65 files changed, 10776 insertions(+), 10875 deletions(-)
 create mode 100644 linux-user/aarch64/cpu_loop.inc.c
 create mode 100644 linux-user/aarch64/prologue.inc.c
 create mode 100644 linux-user/aarch64/signal.inc.c
 create mode 100644 linux-user/alpha/cpu_loop.inc.c
 create mode 100644 linux-user/alpha/prologue.inc.c
 create mode 100644 linux-user/alpha/signal.inc.c
 create mode 100644 linux-user/arm/cpu_loop.inc.c
 create mode 100644 linux-user/arm/prologue.inc.c
 create mode 100644 linux-user/arm/signal.inc.c
 create mode 100644 linux-user/cris/cpu_loop.inc.c
 create mode 100644 linux-user/cris/prologue.inc.c
 create mode 100644 linux-user/cris/signal.inc.c
 create mode 100644 linux-user/hppa/cpu_loop.inc.c
 create mode 100644 linux-user/hppa/prologue.inc.c
 create mode 100644 linux-user/hppa/signal.inc.c
 create mode 100644 linux-user/i386/cpu_loop.inc.c
 create mode 100644 linux-user/i386/prologue.inc.c
 create mode 100644 linux-user/i386/signal.inc.c
 create mode 100644 linux-user/m68k/cpu_loop.inc.c
 create mode 100644 linux-user/m68k/prologue.inc.c
 create mode 100644 linux-user/m68k/signal.inc.c
 create mode 100644 linux-user/microblaze/cpu_loop.inc.c
 create mode 100644 linux-user/microblaze/prologue.inc.c
 create mode 100644 linux-user/microblaze/signal.inc.c
 create mode 100644 linux-user/mips/cpu_loop.inc.c
 create mode 100644 linux-user/mips/prologue.inc.c
 create mode 100644 linux-user/mips/signal.inc.c
 create mode 100644 linux-user/mips64/cpu_loop.inc.c
 create mode 100644 linux-user/mips64/prologue.inc.c
 create mode 100644 linux-user/mips64/signal.inc.c
 create mode 100644 linux-user/nios2/cpu_loop.inc.c
 create mode 100644 linux-user/nios2/prologue.inc.c
 create mode 100644 linux-user/nios2/signal.inc.c
 create mode 100644 linux-user/openrisc/cpu_loop.inc.c
 create mode 100644 linux-user/openrisc/prologue.inc.c
 create mode 100644 linux-user/openrisc/signal.inc.c
 create mode 100644 linux-user/ppc/cpu_loop.inc.c
 create mode 100644 linux-user/ppc/prologue.inc.c
 create mode 100644 linux-user/ppc/signal.inc.c
 create mode 100644 linux-user/riscv/cpu_loop.inc.c
 create mode 100644 linux-user/riscv/prologue.inc.c
 create mode 100644 linux-user/riscv/signal.inc.c
 create mode 100644 linux-user/s390x/cpu_loop.inc.c
 create mode 100644 linux-user/s390x/prologue.inc.c
 create mode 100644 linux-user/s390x/signal.inc.c
 create mode 100644 linux-user/sh4/cpu_loop.inc.c
 create mode 100644 linux-user/sh4/prologue.inc.c
 create mode 100644 linux-user/sh4/signal.inc.c
 create mode 100644 linux-user/sparc/cpu_loop.inc.c
 create mode 100644 linux-user/sparc/prologue.inc.c
 create mode 100644 linux-user/sparc/signal.inc.c
 create mode 100644 linux-user/sparc64/cpu_loop.inc.c
 create mode 100644 linux-user/sparc64/prologue.inc.c
 create mode 100644 linux-user/sparc64/signal.inc.c
 create mode 100644 linux-user/tilegx/cpu_loop.inc.c
 create mode 100644 linux-user/tilegx/prologue.inc.c
 create mode 100644 linux-user/tilegx/signal.inc.c
 create mode 100644 linux-user/x86_64/cpu_loop.inc.c
 create mode 100644 linux-user/x86_64/prologue.inc.c
 create mode 100644 linux-user/x86_64/signal.inc.c
 create mode 100644 linux-user/xtensa/cpu_loop.inc.c
 create mode 100644 linux-user/xtensa/prologue.inc.c
 create mode 100644 linux-user/xtensa/signal.inc.c

-- 
2.14.3
