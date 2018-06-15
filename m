Received: from eggs.gnu.org ([2001:4830:134:3::10]:52282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugj-0002Ud-Df
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuge-0005Cf-Vr
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:13 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:39604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuge-0005Ap-Ln
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:08 -0400
Received: by mail-wm0-x22a.google.com with SMTP id p11-v6so5709527wmc.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:11 +0100
Message-Id: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 00/54] fix building of tests/tcg - last
 chance to review!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Most of the work has been trying to get make check-tcg to work
reliably under high -j's. This has led to a couple of fixes to actual
tests (see tests/tcg/multiarch: don't hard code paths/ports for
linux-test) and a lot of messing about with docker rules.

After lots of attempts of encoding various dependencies depending on
age of images and checksum checks I finally settled on the simple
expedient of disabling the building of docker images when a sub-make
is invoked from the main makefile. We still check the dockerfile
exists but we no longer rely on the caching effect of re-running the
build stage.

There is a bit of a hack for forcing NOCACHE=1 for the debian-sid
image that prevents it being re-built too often but the chances are
anytime you want to run tests against the less well supported sid
compilers you'll end up re-building. I'm happy to drop the NOCACHE
stuff if people think it's a bit too messy. It's mainly to avoid
question about build failures as the:

  || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }

in sid related dockerfiles tends to get lost in the noise.

I'm planning on sending the pull request for this next week so any
remaining review comments are most welcome. Patches currently needing
review are:

: patch 0012/tests tcg multiarch don t hard code paths ports f.patch needs review
: patch 0029/tests docker Makefile.include fix mipsel cross de.patch needs review
: patch 0048/tests add top level make dependency for docker bu.patch needs review
: patch 0049/docker docker.py don t conflate checksums for ext.patch needs review
: patch 0050/docker docker.py add check sub command.patch needs review
: patch 0051/tests Makefile call sub makes with SKIP_DOCKER_BU.patch needs review
: patch 0052/docker docker.py adding age check command.patch needs review
: patch 0053/tests docker Makefile.include only force SID to N.patch needs review

Cheers,

Alex Bennée (52):
  configure: add support for --cross-cc-FOO
  configure: move i386_cc to cross_cc_i386
  configure: allow user to specify --cross-cc-cflags-foo=
  configure: set cross_cc_FOO for host compiler
  docker: Add "cc" subcommand
  docker: extend "cc" command to accept compiler
  docker: allow "cc" command to run in user context
  docker: Makefile.include introduce DOCKER_SCRIPT
  tests/tcg: move architecture independent tests into subdir
  tests/tcg/multiarch: enable additional linux-test tests
  tests/tcg/multiarch: don't hard code paths/ports for linux-test
  tests/tcg/multiarch: move most output to stdout
  tests/tcg: move i386 specific tests into subdir
  tests/tcg: enable building for i386
  tests/tcg/i386: fix test-i386
  tests/tcg/i386: add runner for test-i386-fprem
  tests/tcg/x86_64: add Makefile.target
  tests/tcg/i386/test-i386: use modern vector_size attributes
  tests/tcg/i386/test-i386: fix printf format
  tests/tcg: move ARM specific tests into subdir
  tests/tcg: enable building for ARM
  tests/tcg/arm: fix up test-arm-iwmmxt test
  tests/tcg: enable building for AArch64
  tests/tcg/arm: add fcvt test cases for AArch32/64
  tests/tcg: move MIPS specific tests into subdir
  tests/tcg: enable building for MIPS
  tests/docker/Makefile.include: fix mipsel-cross dependancy
  tests/tcg/mips: include common mips hello-mips
  tests/tcg: enable building for s390x
  tests/tcg: enable building for ppc64
  tests/tcg: enable building for Alpha
  tests/tcg/alpha: add Alpha specific tests
  tests/tcg: enable building for HPPA
  tests/tcg: enable building for m68k
  tests/tcg: enable building for sh4
  tests/tcg: enable building for sparc64
  tests/tcg: enable building for mips64
  tests/tcg: enable building for RISCV64
  docker: move debian-powerpc-cross to sid based build
  tests/tcg: enable building for PowerPC
  tests/tcg/Makefile: update to be called from Makefile.target
  Makefile.target: add (clean-/build-)guest-tests targets
  tests/Makefile.include: add [build|clean|check]-tcg targets
  tests/tcg: add run, diff, and skip helper macros
  tests/tcg: override runners for broken tests
  tests: add top-level make dependency for docker builds
  docker: docker.py don't conflate checksums for extra_files
  docker: docker.py add check sub-command
  tests/Makefile: call sub-makes with SKIP_DOCKER_BUILD=1
  docker: docker.py adding age check command
  tests/docker/Makefile.include: only force SID to NOCACHE if old
  .travis.yml: add check-tcg test

Fam Zheng (2):
  tests/tcg/multiarch: Build fix for linux-test
  tests/tcg/i386: Build fix for hello-i386

 .travis.yml                                   |    8 +
 MAINTAINERS                                   |   14 +
 Makefile.target                               |    5 +
 configure                                     |  134 +-
 tests/Makefile.include                        |   41 +-
 tests/docker/Makefile.include                 |   47 +-
 tests/docker/docker.py                        |   91 +-
 .../dockerfiles/debian-alpha-cross.docker     |   12 +
 tests/docker/dockerfiles/debian-apt-fake.sh   |   46 -
 .../dockerfiles/debian-hppa-cross.docker      |   12 +
 .../dockerfiles/debian-m68k-cross.docker      |   12 +
 .../dockerfiles/debian-mips64-cross.docker    |   12 +
 .../dockerfiles/debian-powerpc-cross.docker   |   39 +-
 .../dockerfiles/debian-riscv64-cross.docker   |   12 +
 .../dockerfiles/debian-sh4-cross.docker       |   12 +
 tests/docker/dockerfiles/debian-sid.docker    |   32 +
 .../dockerfiles/debian-sparc64-cross.docker   |   12 +
 tests/docker/dockerfiles/debian8.docker       |    3 -
 tests/tcg/Makefile                            |  219 +-
 tests/tcg/Makefile.include                    |   88 +
 tests/tcg/Makefile.probe                      |   31 +
 tests/tcg/README                              |   69 +-
 tests/tcg/aarch64/Makefile.include            |    8 +
 tests/tcg/aarch64/Makefile.target             |   17 +
 tests/tcg/aarch64/fcvt.ref                    | 3268 +++++++++++++++++
 tests/tcg/alpha/Makefile                      |   35 -
 tests/tcg/alpha/Makefile.include              |    2 +
 tests/tcg/alpha/Makefile.target               |   18 +
 tests/tcg/alpha/crt.s                         |   26 -
 tests/tcg/alpha/hello-alpha.c                 |    2 +
 tests/tcg/alpha/test-cond.c                   |    1 +
 tests/tcg/alpha/test-ovf.c                    |    2 +
 tests/tcg/arm/Makefile.include                |    8 +
 tests/tcg/arm/Makefile.target                 |   32 +
 tests/tcg/arm/README                          |   11 +
 tests/tcg/arm/fcvt.c                          |  458 +++
 tests/tcg/arm/fcvt.ref                        | 3268 +++++++++++++++++
 tests/tcg/{ => arm}/hello-arm.c               |    0
 .../test-arm-iwmmxt.S}                        |    0
 tests/tcg/hppa/Makefile.include               |    2 +
 tests/tcg/hppa/Makefile.target                |    6 +
 tests/tcg/i386/Makefile.include               |    9 +
 tests/tcg/i386/Makefile.target                |   51 +
 tests/tcg/i386/README                         |   38 +
 tests/tcg/{ => i386}/hello-i386.c             |    1 +
 tests/tcg/{ => i386}/pi_10.com                |  Bin
 tests/tcg/{ => i386}/runcom.c                 |    0
 tests/tcg/{ => i386}/test-i386-code16.S       |    0
 tests/tcg/{ => i386}/test-i386-fprem.c        |   12 +-
 tests/tcg/{ => i386}/test-i386-muldiv.h       |    0
 tests/tcg/{ => i386}/test-i386-shift.h        |    0
 tests/tcg/{ => i386}/test-i386-ssse3.c        |    0
 tests/tcg/{ => i386}/test-i386-vm86.S         |    0
 tests/tcg/{ => i386}/test-i386.c              |    7 +-
 tests/tcg/{ => i386}/test-i386.h              |    0
 tests/tcg/m68k/Makefile.include               |    2 +
 tests/tcg/m68k/Makefile.target                |    7 +
 tests/tcg/mips/Makefile.include               |   20 +
 tests/tcg/mips/Makefile.target                |   22 +
 tests/tcg/mips/README                         |    7 +
 tests/tcg/{ => mips}/hello-mips.c             |    0
 tests/tcg/multiarch/Makefile.target           |   36 +
 tests/tcg/multiarch/README                    |    1 +
 tests/tcg/{ => multiarch}/linux-test.c        |  148 +-
 tests/tcg/{ => multiarch}/sha1.c              |    0
 tests/tcg/{ => multiarch}/test-mmap.c         |   40 +-
 tests/tcg/{ => multiarch}/testthread.c        |    0
 tests/tcg/ppc/Makefile.include                |    7 +
 tests/tcg/ppc/Makefile.target                 |   12 +
 tests/tcg/riscv/Makefile.include              |   10 +
 tests/tcg/s390x/Makefile.include              |    2 +
 tests/tcg/sh4/Makefile.include                |    4 +
 tests/tcg/sh4/Makefile.target                 |    7 +
 tests/tcg/sparc64/Makefile.include            |    2 +
 tests/tcg/sparc64/Makefile.target             |   11 +
 tests/tcg/test_path.c                         |  157 -
 tests/tcg/x86_64/Makefile.target              |   15 +
 77 files changed, 8118 insertions(+), 625 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 delete mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-riscv64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sid.docker
 create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
 create mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/Makefile.probe
 create mode 100644 tests/tcg/aarch64/Makefile.include
 create mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/fcvt.ref
 delete mode 100644 tests/tcg/alpha/Makefile
 create mode 100644 tests/tcg/alpha/Makefile.include
 create mode 100644 tests/tcg/alpha/Makefile.target
 delete mode 100644 tests/tcg/alpha/crt.s
 create mode 100644 tests/tcg/arm/Makefile.include
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 create mode 100644 tests/tcg/arm/fcvt.c
 create mode 100644 tests/tcg/arm/fcvt.ref
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{test-arm-iwmmxt.s => arm/test-arm-iwmmxt.S} (100%)
 create mode 100644 tests/tcg/hppa/Makefile.include
 create mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/i386/Makefile.include
 create mode 100644 tests/tcg/i386/Makefile.target
 create mode 100644 tests/tcg/i386/README
 rename tests/tcg/{ => i386}/hello-i386.c (96%)
 rename tests/tcg/{ => i386}/pi_10.com (100%)
 rename tests/tcg/{ => i386}/runcom.c (100%)
 rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
 rename tests/tcg/{ => i386}/test-i386-fprem.c (97%)
 rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
 rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
 rename tests/tcg/{ => i386}/test-i386-ssse3.c (100%)
 rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
 rename tests/tcg/{ => i386}/test-i386.c (99%)
 rename tests/tcg/{ => i386}/test-i386.h (100%)
 create mode 100644 tests/tcg/m68k/Makefile.include
 create mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/mips/Makefile.include
 create mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/README
 rename tests/tcg/{ => mips}/hello-mips.c (100%)
 create mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (82%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (93%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 create mode 100644 tests/tcg/ppc/Makefile.include
 create mode 100644 tests/tcg/ppc/Makefile.target
 create mode 100644 tests/tcg/riscv/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.include
 create mode 100644 tests/tcg/sh4/Makefile.include
 create mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/sparc64/Makefile.target
 delete mode 100644 tests/tcg/test_path.c
 create mode 100644 tests/tcg/x86_64/Makefile.target

-- 
2.17.1
