Received: from eggs.gnu.org ([2001:4830:134:3::10]:42648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5f-0005xU-MS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5Z-00024O-2W
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:11 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:41107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5Y-00023X-M1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:04 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v24-v6so14329201wra.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:18 +0100
Message-Id: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the second revision of my attempt to revive the tests/tcg
directory. You can find the first iteration here:

  https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01361.html

Changes:

I've slightly re-jigged the Makefile inclusion to make
tests/tcg/Makefile very simple. All the TESTS are added by the various
sub-makes. I've also included
tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target so common base
architectures can include tests. See MIPS for an example.

Missing Targets:

We still have quite a bit of test code that is not built. These are:

  * tests/tcg/mips/mip[32|64]-dsp[r]

  A bunch of system tests. Also we have no mips64 BE support.

  * tests/tcg/alpha

  Need a cross-compiler

  * tests/tcg/cris

  Needs a cross-compiler

  * tests/tcg/lm32

  Needs a cross-compiler

  * tests/tcg/openrisc

  Needs a cross-compiler

  * tests/tcg/xtensa

  Needs a cross-compiler


We should be able to build basic multiarch tests for a bunch of
additional linux-user targets. A bunch of our LE target compilers
should be able to build BE but I ran into troubles of an incomplete
glibc-dev assuming it's not needed. Apparently a newlib based
cross-compiler would fix this as it has both LE and BE headers
available.

I did start playing with crosstool-ng and Linaro's own ABE scripts but
realised this could end up a massive time sync. What would be really
helpful is if the respective maintainers could encode their EXACT
STEPS for building their cross compilers into some docker recipes.

Missing Cross Compilers:

  aarch64_be alpha armeb cris hppa m68k microblaze microblazeel mips64
  mipsn32 mipsn32el nios2 or1k ppc ppc64abi32 riscv32 riscv64 sh4
  sh4eb sparc sparc32plus sparc64 tilegx xtensa xtensaeb

Finally the end of the series has me adding Emilio's fp-test to the
per-target builds. Unfortunately although some osdep.h and softfloat.c
fiddling allows us to build in most cases I still can't build for
example an i386 fp-test on an x86_64 host using the cross compiler as
it triggers incompatibilities with config-host.h - in this case Int128
support. Currently I just hackily disable fp-test for non-64 bit
platforms.

While the later patches in the series are a bit of a WIP the earlier
patches are certainly deserving of review. Currently the un-reviewed
patches are:

  patch 0001/docker add probe command for configure.patch needs review
  patch 0002/configure add test for docker availability.patch needs review
  patch 0003/configure add support for cross cc FOO.patch needs review
  patch 0004/configure move i386_cc to cross_cc_i386.patch needs review
  patch 0005/configure allow user to specify cross cc cflags f.patch needs review
  patch 0006/configure set cross_cc_FOO for host compiler.patch needs review
  patch 0009/docker extend cc command to accept compiler.patch needs review
  patch 0014/tests tcg multiarch enable additional linux test .patch needs review
  patch 0016/docker Add fedora i386 cross image.patch needs review
  patch 0017/tests tcg enable building for i386.patch needs review
  patch 0020/tests tcg i386 fix test i386 fprem.patch needs review
  patch 0021/tests tcg i386 disable i386 version of test i386 .patch needs review
  patch 0022/tests tcg x86_64 add Makefile.target.patch needs review
  patch 0023/tests tcg i386 test i386 use modern vector_size a.patch needs review
  patch 0024/tests tcg i386 test i386 fix printf format.patch needs review
  patch 0026/tests tcg arm fix up test arm iwmmxt test.patch needs review
  patch 0027/tests tcg aarch64 add Makefile.target.patch needs review
  patch 0028/tests tcg aarch64 add fcvt test cases for AArch64.patch needs review
  patch 0029/tests tcg aarch64 userspace system register test.patch needs review
  patch 0031/tests tcg enable building for MIPS.patch needs review
  patch 0032/tests tcg mips include common mips hello mips.patch needs review
  patch 0035/tests tcg Makefile update to be called from Makef.patch needs review
  patch 0036/Makefile.target add clean guest tests targets.patch needs review
  patch 0038/osdep disable glib compat.h include with QEMU_NO_.patch needs review
  patch 0039/softfloat do not include glib headers.patch needs review
  patch 0040/tests add fp test a floating point test suite.patch needs review
  patch 0041/tests tcg multiarch add fp test into multiarch se.patch needs review

I've merged a few patches but I've kept the review tags so far. As
usual there are comments bellow the --- for any changes.


Alex Bennée (35):
  configure: add test for docker availability
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
  tests/tcg: move i386 specific tests into subdir
  tests/tcg: enable building for i386
  tests/tcg/i386: fix test-i386
  tests/tcg/i386: fix test-i386-fprem
  tests/tcg/i386: disable i386 version of test-i386-ssse
  tests/tcg/x86_64: add Makefile.target
  tests/tcg/i386/test-i386: use modern vector_size attributes
  tests/tcg/i386/test-i386: fix printf format
  tests/tcg: move ARM specific tests into subdir
  tests/tcg/arm: fix up test-arm-iwmmxt test
  tests/tcg/aarch64: add Makefile.target
  tests/tcg/aarch64: add fcvt test cases for AArch64
  tests/tcg/aarch64: userspace system register test
  tests/tcg: move MIPS specific tests into subdir
  tests/tcg: enable building for MIPS
  tests/tcg/mips: include common mips hello-mips
  tests/tcg: enable building for s390x
  tests/tcg: enable building for ppc64
  tests/tcg/Makefile: update to be called from Makefile.target
  Makefile.target: add (clean-)guest-tests targets
  tests/Makefile.include: add (clean-)check-tcg targets
  tests/tcg/multiarch: add fp-test into multiarch set
  tests/tcg: disable fp-test for 32 bit (HACK!)
  tests: fp-test add fcvt support (!INCOMPLETE WIP)

Emilio G. Cota (3):
  osdep: disable glib-compat.h include with QEMU_NO_GLIB
  softfloat: do not include glib headers
  tests: add fp-test, a floating point test suite

Fam Zheng (4):
  Makefile: Rename TARGET_DIRS to TARGET_LIST
  tests/tcg/multiarch: Build fix for linux-test
  docker: Add fedora-i386-cross image
  tests/tcg/i386: Build fix for hello-i386

Peter Maydell (1):
  docker: add "probe" command for configure

 Makefile                                      |   20 +-
 Makefile.target                               |    5 +
 configure                                     |  111 +-
 fpu/softfloat.c                               |    4 +
 include/qemu/osdep.h                          |    2 +
 scripts/create_config                         |    2 +-
 tests/Makefile.include                        |   24 +-
 tests/docker/Makefile.include                 |   10 +-
 tests/docker/docker.py                        |   49 +
 .../dockerfiles/fedora-i386-cross.docker      |   14 +
 tests/fp/.gitignore                           |    3 +
 tests/fp/Makefile                             |   34 +
 tests/fp/fp-test.c                            | 1582 +++++++++++++++++
 tests/fp/qemu/regression-tests.fptest         |    7 +
 tests/tcg/Makefile                            |  184 +-
 tests/tcg/Makefile.include                    |   76 +
 tests/tcg/README                              |   69 +-
 tests/tcg/aarch64/Makefile.target             |   13 +
 tests/tcg/aarch64/fcvt.c                      |  260 +++
 tests/tcg/aarch64/fcvt.out                    | 1305 ++++++++++++++
 tests/tcg/aarch64/sysregs.c                   |   14 +
 tests/tcg/arm/Makefile.target                 |   20 +
 tests/tcg/arm/README                          |   11 +
 tests/tcg/{ => arm}/hello-arm.c               |    0
 .../test-arm-iwmmxt.S}                        |    0
 tests/tcg/i386/Makefile.include               |    9 +
 tests/tcg/i386/Makefile.target                |   30 +
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
 tests/tcg/mips/Makefile.include               |   17 +
 tests/tcg/mips/Makefile.target                |   19 +
 tests/tcg/mips/README                         |    7 +
 tests/tcg/{ => mips}/hello-mips.c             |    0
 tests/tcg/multiarch/Makefile.target           |   50 +
 tests/tcg/multiarch/README                    |    1 +
 tests/tcg/{ => multiarch}/linux-test.c        |   82 +-
 tests/tcg/{ => multiarch}/sha1.c              |    0
 tests/tcg/{ => multiarch}/test-mmap.c         |    0
 tests/tcg/{ => multiarch}/testthread.c        |    0
 tests/tcg/ppc64le/Makefile.include            |    2 +
 tests/tcg/s390x/Makefile.include              |    2 +
 tests/tcg/test_path.c                         |  157 --
 tests/tcg/x86_64/Makefile.target              |   15 +
 53 files changed, 3814 insertions(+), 454 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
 create mode 100644 tests/fp/.gitignore
 create mode 100644 tests/fp/Makefile
 create mode 100644 tests/fp/fp-test.c
 create mode 100644 tests/fp/qemu/regression-tests.fptest
 create mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/fcvt.c
 create mode 100644 tests/tcg/aarch64/fcvt.out
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{test-arm-iwmmxt.s => arm/test-arm-iwmmxt.S} (100%)
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
 create mode 100644 tests/tcg/mips/Makefile.include
 create mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/README
 rename tests/tcg/{ => mips}/hello-mips.c (100%)
 create mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (89%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (100%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 create mode 100644 tests/tcg/ppc64le/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/test_path.c
 create mode 100644 tests/tcg/x86_64/Makefile.target

-- 
2.17.0
