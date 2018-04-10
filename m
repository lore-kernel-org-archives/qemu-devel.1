Received: from eggs.gnu.org ([2001:4830:134:3::10]:46509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z6z-000058-Aj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z6w-0006EX-5j
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:25 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z6v-0006Dp-RM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:22 -0400
Received: by mail-wr0-x236.google.com with SMTP id o3so1625787wri.2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:38:55 +0100
Message-Id: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/24] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

We've talked about fixing this up for a long time and there have been
several RFC patches sent attempting to do that. This is yet another
RFC but hopefully shows a way forward which can build on our docker
support but also allow users to specify their own guest cross
compilers.

So far I've built arm, aarch64, ppc64 and s390x but adding support for
additional guests is simple, especially if we already have a docker
cross compile setup.

I've weeded out any tests that linked with QEMU (testpath) and reduced
the expectations of any tests/tcg test to just having access to libc.
This is the lowest common denominator for anything that can reasonably
be called a cross compiler.

The tests are all aimed at linux-user targets. We could probably come
up with something for building bare-metal softmmu tests but I suspect
that might be better served by using a different mechanism to import
existing tests into our build (e.g. kvm-unit-tests).

Let's breakdown the series:

configure:

As we need make magic we move the detection of docker and cross
compilers into configure. If any cross compiler is detected for a
given target we set CROSS_CC_GUEST in each config-target.mak. A
functioning cross compiler takes precedence over the docker fallback.
I think this makes sense for individual target sub-maintainers as they
likely already have a cross compile setup.

For docker we only set HAVE_USER_DOCKER in config-host.mak if the user
can run docker without sudo. We still need match up a docker image and
compiler once we build. This is handled by
tests/tcg/$(ARCH)/Makefile.include.

docker:

I've extended Fam's original patches to allow a bit more flexibility
for the "cc" command. I'm not overly wedded to using the docker.py
wrapper, we could just construct the command directly in Make if we
wanted to.

tests/tcg:

The top of the tree has been cleared out and everything moved into
sub-directories. There is a new multiarch sub-directory which is built
for every linux-user guest that has compiler support. Additional tests
are then included from tests/tcg/$(ARCH)/*.c or manually
added/modified by tests/tcg/$(ARCH)/Makefile.target.

Makefile:

As we are building tests/tcg for each target so Makefile.target now
invokes a sub-make with tests/tcg/Makefile while in the appropriate
build directory $(ARCH)-linux-user/tests/. The check-tcg and clean-tcg
targets unroll into all the configured FOO-linux-user targets and will
build the tests if cross compilation is available, otherwise the build
is skipped without failing the make.

Running tests:

Currently this is done manually from the build directory:

  ./qemu-arm tests/hello-arm

However once we have everything converted it shouldn't be too hard to
plumb into the normal make check sequence.

So what do people think? Is this a viable way to go forward?

Alex Bennée (20):
  configure: add test for docker availability
  configure: add support for --cross-cc-FOO
  configure: move i386_cc to cross_cc_i386
  docker: extend "cc" command to accept compiler
  docker: allow "cc" command to run in user context
  docker: Makefile.include introduce DOCKER_SCRIPT
  tests/tcg: move architecture independent tests into subdir
  tests/tcg: move i386 specific tests into subdir
  tests/tcg/i386: move test-i386-sse.c to tests/tcg/x86_64/test-sse.c
  tests/tcg/i386: fix test-i386
  tests/tcg/i368: fix hello-i386
  tests/tcg/i386: fix test-i386-fprem
  tests/tcg: move ARM specific tests into subdir
  tests/tcg/arm: fix hello-arm
  tests/tcg: move MIPS specific tests into subdir
  tests/tcg: enable building for s390x
  tests/tcg: enable building for ppc64
  tests/tcg/Makefile: update to be called from Makefile.target
  Makefile.target: add (clean-)guest-tests targets
  tests/Makefile.include: add (clean-)check-tcg targets

Fam Zheng (4):
  Makefile: Rename TARGET_DIRS to TARGET_LIST
  docker: Add "cc" subcommand
  tests/tcg/multiarch: Build fix for linux-test
  tests/tcg/i386: Build fix for hello-i386

 Makefile                                           |  20 +--
 Makefile.target                                    |   5 +
 configure                                          |  92 +++++++++-
 scripts/create_config                              |   2 +-
 tests/Makefile.include                             |  21 ++-
 tests/docker/Makefile.include                      |  10 +-
 tests/docker/docker.py                             |  40 +++++
 tests/tcg/Makefile                                 | 185 +++++----------------
 tests/tcg/Makefile.include                         |  79 +++++++++
 tests/tcg/README                                   |  69 +-------
 tests/tcg/arm/Makefile.target                      |   6 +
 tests/tcg/arm/README                               |  11 ++
 tests/tcg/{ => arm}/hello-arm.c                    |   0
 tests/tcg/{ => arm}/test-arm-iwmmxt.s              |   0
 tests/tcg/i386/Makefile.target                     |  35 ++++
 tests/tcg/i386/README                              |  38 +++++
 tests/tcg/{ => i386}/hello-i386.c                  |   1 +
 tests/tcg/{ => i386}/pi_10.com                     | Bin
 tests/tcg/{ => i386}/runcom.c                      |   0
 tests/tcg/{ => i386}/test-i386-code16.S            |   0
 tests/tcg/{ => i386}/test-i386-fprem.c             |   9 +-
 tests/tcg/{ => i386}/test-i386-muldiv.h            |   0
 tests/tcg/{ => i386}/test-i386-shift.h             |   0
 tests/tcg/{ => i386}/test-i386-vm86.S              |   0
 tests/tcg/{ => i386}/test-i386.c                   |   1 -
 tests/tcg/{ => i386}/test-i386.h                   |   0
 tests/tcg/mips/README                              |   7 +
 tests/tcg/{ => mips}/hello-mips.c                  |   0
 tests/tcg/multiarch/README                         |   1 +
 tests/tcg/{ => multiarch}/linux-test.c             |  68 +++-----
 tests/tcg/{ => multiarch}/sha1.c                   |   0
 tests/tcg/{ => multiarch}/test-mmap.c              |   0
 tests/tcg/{ => multiarch}/testthread.c             |   0
 tests/tcg/ppc64/Makefile.include                   |   2 +
 tests/tcg/s390x/Makefile.include                   |   2 +
 tests/tcg/test_path.c                              | 157 -----------------
 tests/tcg/{test-i386-ssse3.c => x86_64/test-sse.c} |   6 +-
 37 files changed, 424 insertions(+), 443 deletions(-)
 create mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)
 create mode 100644 tests/tcg/i386/Makefile.target
 create mode 100644 tests/tcg/i386/README
 rename tests/tcg/{ => i386}/hello-i386.c (96%)
 rename tests/tcg/{ => i386}/pi_10.com (100%)
 rename tests/tcg/{ => i386}/runcom.c (100%)
 rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
 rename tests/tcg/{ => i386}/test-i386-fprem.c (98%)
 rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
 rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
 rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
 rename tests/tcg/{ => i386}/test-i386.c (99%)
 rename tests/tcg/{ => i386}/test-i386.h (100%)
 create mode 100644 tests/tcg/mips/README
 rename tests/tcg/{ => mips}/hello-mips.c (100%)
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (91%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (100%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 create mode 100644 tests/tcg/ppc64/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/test_path.c
 rename tests/tcg/{test-i386-ssse3.c => x86_64/test-sse.c} (93%)

-- 
2.16.2
