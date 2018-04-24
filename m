Received: from eggs.gnu.org ([2001:4830:134:3::10]:46825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzng-0006Tr-1n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAznc-0005Fn-Jb
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAznc-0005DS-73
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id f6so1802686wmc.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:24:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:19 +0100
Message-Id: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/46] fix building of tests/tcg
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

This is starting to shape up pretty nicely. I was able to add a whole
bunch of additional architectures thanks to cross compilers in Debian
Sid which are there to support the Debian "ports". These may not be
around for ever, most "ports" are on the way out, but they will be the
last thing to drop out of the Sid repo. Maybe when Debian stops
caring (and no other distro does) maybe we should to?

However compiling big-endian targets continues to be a massive pain as
even if compilers support switching endianess with flags you are
usually let down by a partial set of headers or the linker not being
able to link against wrong-endian crt.o or libgcc files. Ultimately
any guests that are not supported by any distro are probably going to
be stuck with bare metal or hand crafted tests like in
tests/tcg/alpha.

The final patch (tests/tcg: override runners for broken tests)
suppresses a bunch of tests that fail on different guest setups. This
was to allow me to test "make check-tcg" could make it all the way
through. I'm sure some of them are bugs that need fixing so it would
be cool if maintainers could look through and see if there are any
easy wins.

Major Changes:
  - check-tcg now runs the tests (c.f build-tcg/clean-tcg)
  - clean use of quiet-command for CROSS-BUILD/RUN-TESTS and TEST
  - bunch of additional targets (alpha, hppa, m68k, sh4, sparc64, mips64)
  - review comments and tags
  - dropped fp-test and additional aarch64 tests for now

As usual detailed notes are bellow the --- in the commit messages.

Currently un-reviewed:

patch 0002/configure add test for docker availability.patch needs review
patch 0003/configure add support for cross cc FOO.patch needs review
patch 0004/configure move i386_cc to cross_cc_i386.patch needs review
patch 0005/configure allow user to specify cross cc cflags f.patch needs review
patch 0014/tests tcg multiarch enable additional linux test .patch needs review
patch 0015/tests tcg multiarch move most output to stdout.patch needs review
patch 0017/docker Add fedora i386 cross image.patch needs review
patch 0018/tests tcg enable building for i386.patch needs review
patch 0021/tests tcg i386 fix test i386 fprem.patch needs review
patch 0022/tests tcg i386 disable i386 version of test i386 .patch needs review
patch 0023/tests tcg x86_64 add Makefile.target.patch needs review
patch 0025/tests tcg i386 test i386 fix printf format.patch needs review
patch 0027/tests tcg arm fix up test arm iwmmxt test.patch needs review
patch 0028/tests tcg aarch64 add Makefile.target.patch needs review
patch 0029/tests tcg aarch64 add fcvt test cases for AArch64.patch needs review
patch 0031/tests tcg enable building for MIPS.patch needs review
patch 0032/tests tcg mips include common mips hello mips.patch needs review
patch 0035/tests tcg enable building for Alpha.patch needs review
patch 0036/tests tcg alpha add Alpha specific tests.patch needs review
patch 0037/tests tcg alpha fix warnings about write.patch needs review
patch 0038/tests tcg enable building for HPPA.patch needs review
patch 0039/tests tcg enable building for m68k.patch needs review
patch 0040/tests tcg enable building for sh4.patch needs review
patch 0041/tests tcg enable building for sparc64.patch needs review
patch 0042/tests tcg enable building for mips64.patch needs review
patch 0043/tests tcg Makefile update to be called from Makef.patch needs review
patch 0044/Makefile.target add clean guest tests targets.patch needs review
patch 0046/tests tcg override runners for broken tests UPSTR.patch needs review


Alex Bennée (41):
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
  tests/tcg/multiarch: move most output to stdout
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
  tests/tcg: move MIPS specific tests into subdir
  tests/tcg: enable building for MIPS
  tests/tcg/mips: include common mips hello-mips
  tests/tcg: enable building for s390x
  tests/tcg: enable building for ppc64
  tests/tcg: enable building for Alpha
  tests/tcg/alpha: add Alpha specific tests
  tests/tcg/alpha: fix warnings about write()
  tests/tcg: enable building for HPPA
  tests/tcg: enable building for m68k
  tests/tcg: enable building for sh4
  tests/tcg: enable building for sparc64
  tests/tcg: enable building for mips64
  tests/tcg/Makefile: update to be called from Makefile.target
  Makefile.target: add (clean-)guest-tests targets
  tests/Makefile.include: add [build|clean|check]-tcg targets
  tests/tcg: override runners for broken tests (!UPSTREAM)

Fam Zheng (4):
  Makefile: Rename TARGET_DIRS to TARGET_LIST
  tests/tcg/multiarch: Build fix for linux-test
  docker: Add fedora-i386-cross image
  tests/tcg/i386: Build fix for hello-i386

Peter Maydell (1):
  docker: add "probe" command for configure

 Makefile                                      |   20 +-
 Makefile.target                               |    5 +
 configure                                     |  136 +-
 scripts/create_config                         |    2 +-
 tests/Makefile.include                        |   28 +-
 tests/docker/Makefile.include                 |   16 +-
 tests/docker/docker.py                        |   49 +
 .../dockerfiles/debian-alpha-cross.docker     |   12 +
 .../dockerfiles/debian-cross-build.docker     |   36 +
 .../dockerfiles/debian-hppa-cross.docker      |   12 +
 .../dockerfiles/debian-m68k-cross.docker      |   12 +
 .../dockerfiles/debian-mips64-cross.docker    |   12 +
 .../dockerfiles/debian-sh4-cross.docker       |   12 +
 tests/docker/dockerfiles/debian-sid.docker    |   23 +
 .../dockerfiles/debian-sparc64-cross.docker   |   12 +
 .../dockerfiles/fedora-i386-cross.docker      |   14 +
 tests/tcg/Makefile                            |  193 +--
 tests/tcg/Makefile.include                    |   86 ++
 tests/tcg/README                              |   69 +-
 tests/tcg/aarch64/Makefile.target             |   13 +
 tests/tcg/aarch64/fcvt.c                      |  260 ++++
 tests/tcg/aarch64/fcvt.out                    | 1305 +++++++++++++++++
 tests/tcg/alpha/Makefile                      |   35 -
 tests/tcg/alpha/Makefile.include              |    2 +
 tests/tcg/alpha/Makefile.target               |   36 +
 tests/tcg/alpha/{crt.s => crt.S}              |    0
 tests/tcg/alpha/hello-alpha.c                 |    2 +
 tests/tcg/alpha/test-cond.c                   |    1 +
 tests/tcg/alpha/test-ovf.c                    |    2 +
 tests/tcg/arm/Makefile.target                 |   20 +
 tests/tcg/arm/README                          |   11 +
 tests/tcg/{ => arm}/hello-arm.c               |    0
 .../test-arm-iwmmxt.S}                        |    0
 tests/tcg/hppa/Makefile.include               |    2 +
 tests/tcg/hppa/Makefile.target                |   10 +
 tests/tcg/i386/Makefile.include               |    9 +
 tests/tcg/i386/Makefile.target                |   52 +
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
 tests/tcg/m68k/Makefile.target                |   11 +
 tests/tcg/mips/Makefile.include               |   20 +
 tests/tcg/mips/Makefile.target                |   29 +
 tests/tcg/mips/README                         |    7 +
 tests/tcg/{ => mips}/hello-mips.c             |    0
 tests/tcg/multiarch/Makefile.target           |   29 +
 tests/tcg/multiarch/README                    |    1 +
 tests/tcg/{ => multiarch}/linux-test.c        |   93 +-
 tests/tcg/{ => multiarch}/sha1.c              |    0
 tests/tcg/{ => multiarch}/test-mmap.c         |   38 +-
 tests/tcg/{ => multiarch}/testthread.c        |    0
 tests/tcg/ppc64le/Makefile.include            |    2 +
 tests/tcg/s390x/Makefile.include              |    2 +
 tests/tcg/s390x/Makefile.target               |    6 +
 tests/tcg/sh4/Makefile.include                |    4 +
 tests/tcg/sh4/Makefile.target                 |    6 +
 tests/tcg/sparc64/Makefile.include            |    2 +
 tests/tcg/sparc64/Makefile.target             |    8 +
 tests/tcg/test_path.c                         |  157 --
 tests/tcg/x86_64/Makefile.target              |   15 +
 70 files changed, 2495 insertions(+), 504 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-cross-build.docker
 create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sid.docker
 create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
 create mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/fcvt.c
 create mode 100644 tests/tcg/aarch64/fcvt.out
 delete mode 100644 tests/tcg/alpha/Makefile
 create mode 100644 tests/tcg/alpha/Makefile.include
 create mode 100644 tests/tcg/alpha/Makefile.target
 rename tests/tcg/alpha/{crt.s => crt.S} (100%)
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
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
 rename tests/tcg/{ => multiarch}/linux-test.c (87%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (94%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 create mode 100644 tests/tcg/ppc64le/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/sh4/Makefile.include
 create mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/sparc64/Makefile.target
 delete mode 100644 tests/tcg/test_path.c
 create mode 100644 tests/tcg/x86_64/Makefile.target

-- 
2.17.0
