Received: from eggs.gnu.org ([2001:4830:134:3::10]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCAO-0007xr-Gz
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCAL-0007Uo-BI
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:02:44 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCAL-0007Uk-6B
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:02:41 -0400
Received: by mail-qt0-x242.google.com with SMTP id d3-v6so18932050qto.1
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 19:02:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a8e3ddaa-816d-d590-580f-94d32b5d56be@amsat.org>
Date: Sun, 10 Jun 2018 23:02:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/49] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 06/08/2018 09:32 AM, Alex Bennée wrote:
> Hi,
> 
> Not a super amount has changed since the last version but review
> comments and review tags have been added. The new patches at the end
> enable a .travis.yml run and try and make the image building part of
> check-tcg -j safe. Essentially the problem is trying to avoid
> re-building the images multiple times. The additional issue is wanting
> an upto date Debian SID image whenever we actually build an image but
> not forcing a rebuild every time.
> 
> Essentially I'd like to encode a conditional dependency when:
>   - the target image doesn't exist
>   - or the target image is out of date w.r.t. the dockerfike
> 
> I'm thinking this is going to involve some sort of extension to the
> docker.py script to feed the Makefile.
> 
> A number of the prerequisite patches have already been pulled in the
> docker fixes series however I think this series is ready to go in now.
> Unless there are any objections I'll send a pull on Monday.
> 
> Current unreviewed patches:
> 
>   patch 0017/tests tcg i386 add runner for test i386 fprem.patch needs review
>   patch 0039/docker move debian powerpc cross to sid based bui.patch needs review
>   patch 0040/tests tcg enable building for PowerPC.patch needs review
>   patch 0042/Makefile.target add clean build guest tests targe.patch needs review
>   patch 0044/tests tcg add run diff and skip helper macros.patch needs review
>   patch 0045/tests tcg override runners for broken tests.patch needs review
>   patch 0046/target sh4 Fix translator.c assertion failure for.patch needs review

Is this patch related/required to this series?
It looks it should enter via another tree.

The SH4 tests pass without it:

$ make run-tcg-tests-sh4-linux-user -j1
  ...
  RUN-TESTS for sh4
  TEST    test-mmap (default) on sh4
  TEST    sha1 on sh4
  TEST    linux-test on sh4
  TEST    testthread on sh4
  TEST    test-mmap (4096 byte pages) on sh4

>   patch 0047/tests add top level make dependency for docker bu.patch needs review
>   patch 0048/tests docker prevent sub makes re building debian.patch needs review
>   patch 0049/.travis.yml add check tcg test.patch needs review
> 
> 
> Alex Bennée (46):
>   configure: add support for --cross-cc-FOO
>   configure: move i386_cc to cross_cc_i386
>   configure: allow user to specify --cross-cc-cflags-foo=
>   configure: set cross_cc_FOO for host compiler
>   docker: Add "cc" subcommand
>   docker: extend "cc" command to accept compiler
>   docker: allow "cc" command to run in user context
>   docker: Makefile.include introduce DOCKER_SCRIPT
>   tests/tcg: move architecture independent tests into subdir
>   tests/tcg/multiarch: enable additional linux-test tests
>   tests/tcg/multiarch: move most output to stdout
>   tests/tcg: move i386 specific tests into subdir
>   tests/tcg: enable building for i386
>   tests/tcg/i386: fix test-i386
>   tests/tcg/i386: add runner for test-i386-fprem
>   tests/tcg/x86_64: add Makefile.target
>   tests/tcg/i386/test-i386: use modern vector_size attributes
>   tests/tcg/i386/test-i386: fix printf format
>   tests/tcg: move ARM specific tests into subdir
>   tests/tcg: enable building for ARM
>   tests/tcg/arm: fix up test-arm-iwmmxt test
>   tests/tcg: enable building for AArch64
>   tests/tcg/arm: add fcvt test cases for AArch32/64
>   tests/tcg: move MIPS specific tests into subdir
>   tests/tcg: enable building for MIPS
>   tests/tcg/mips: include common mips hello-mips
>   tests/tcg: enable building for s390x
>   tests/tcg: enable building for ppc64
>   tests/tcg: enable building for Alpha
>   tests/tcg/alpha: add Alpha specific tests
>   tests/tcg: enable building for HPPA
>   tests/tcg: enable building for m68k
>   tests/tcg: enable building for sh4
>   tests/tcg: enable building for sparc64
>   tests/tcg: enable building for mips64
>   tests/tcg: enable building for RISCV64
>   docker: move debian-powerpc-cross to sid based build
>   tests/tcg: enable building for PowerPC
>   tests/tcg/Makefile: update to be called from Makefile.target
>   Makefile.target: add (clean-/build-)guest-tests targets
>   tests/Makefile.include: add [build|clean|check]-tcg targets
>   tests/tcg: add run, diff, and skip helper macros
>   tests/tcg: override runners for broken tests
>   tests: add top-level make dependency for docker builds
>   tests/docker: prevent sub-makes re-building debian-sid
>   .travis.yml: add check-tcg test
> 
> Fam Zheng (2):
>   tests/tcg/multiarch: Build fix for linux-test
>   tests/tcg/i386: Build fix for hello-i386
> 
> Richard Henderson (1):
>   target/sh4: Fix translator.c assertion failure for gUSA
> 
>  .travis.yml                                   |    6 +
>  MAINTAINERS                                   |   14 +
>  Makefile.target                               |    5 +
>  configure                                     |  134 +-
>  target/sh4/translate.c                        |   81 +-
>  tests/Makefile.include                        |   38 +-
>  tests/docker/Makefile.include                 |   31 +-
>  tests/docker/docker.py                        |   31 +
>  .../dockerfiles/debian-alpha-cross.docker     |   12 +
>  tests/docker/dockerfiles/debian-apt-fake.sh   |   46 -
>  .../dockerfiles/debian-hppa-cross.docker      |   12 +
>  .../dockerfiles/debian-m68k-cross.docker      |   12 +
>  .../dockerfiles/debian-mips64-cross.docker    |   12 +
>  .../dockerfiles/debian-powerpc-cross.docker   |   39 +-
>  .../dockerfiles/debian-riscv64-cross.docker   |   12 +
>  .../dockerfiles/debian-sh4-cross.docker       |   12 +
>  tests/docker/dockerfiles/debian-sid.docker    |   32 +
>  .../dockerfiles/debian-sparc64-cross.docker   |   12 +
>  tests/docker/dockerfiles/debian8.docker       |    3 -
>  tests/tcg/Makefile                            |  219 +-
>  tests/tcg/Makefile.include                    |   89 +
>  tests/tcg/Makefile.probe                      |   31 +
>  tests/tcg/README                              |   69 +-
>  tests/tcg/aarch64/Makefile.include            |    8 +
>  tests/tcg/aarch64/Makefile.target             |   17 +
>  tests/tcg/aarch64/fcvt.ref                    | 3268 +++++++++++++++++
>  tests/tcg/alpha/Makefile                      |   35 -
>  tests/tcg/alpha/Makefile.include              |    2 +
>  tests/tcg/alpha/Makefile.target               |   18 +
>  tests/tcg/alpha/crt.s                         |   26 -
>  tests/tcg/alpha/hello-alpha.c                 |    2 +
>  tests/tcg/alpha/test-cond.c                   |    1 +
>  tests/tcg/alpha/test-ovf.c                    |    2 +
>  tests/tcg/arm/Makefile.include                |    8 +
>  tests/tcg/arm/Makefile.target                 |   32 +
>  tests/tcg/arm/README                          |   11 +
>  tests/tcg/arm/fcvt.c                          |  458 +++
>  tests/tcg/arm/fcvt.ref                        | 3268 +++++++++++++++++
>  tests/tcg/{ => arm}/hello-arm.c               |    0
>  .../test-arm-iwmmxt.S}                        |    0
>  tests/tcg/hppa/Makefile.include               |    2 +
>  tests/tcg/hppa/Makefile.target                |    6 +
>  tests/tcg/i386/Makefile.include               |    9 +
>  tests/tcg/i386/Makefile.target                |   51 +
>  tests/tcg/i386/README                         |   38 +
>  tests/tcg/{ => i386}/hello-i386.c             |    1 +
>  tests/tcg/{ => i386}/pi_10.com                |  Bin
>  tests/tcg/{ => i386}/runcom.c                 |    0
>  tests/tcg/{ => i386}/test-i386-code16.S       |    0
>  tests/tcg/{ => i386}/test-i386-fprem.c        |   12 +-
>  tests/tcg/{ => i386}/test-i386-muldiv.h       |    0
>  tests/tcg/{ => i386}/test-i386-shift.h        |    0
>  tests/tcg/{ => i386}/test-i386-ssse3.c        |    0
>  tests/tcg/{ => i386}/test-i386-vm86.S         |    0
>  tests/tcg/{ => i386}/test-i386.c              |    7 +-
>  tests/tcg/{ => i386}/test-i386.h              |    0
>  tests/tcg/m68k/Makefile.include               |    2 +
>  tests/tcg/m68k/Makefile.target                |    7 +
>  tests/tcg/mips/Makefile.include               |   20 +
>  tests/tcg/mips/Makefile.target                |   22 +
>  tests/tcg/mips/README                         |    7 +
>  tests/tcg/{ => mips}/hello-mips.c             |    0
>  tests/tcg/multiarch/Makefile.target           |   36 +
>  tests/tcg/multiarch/README                    |    1 +
>  tests/tcg/{ => multiarch}/linux-test.c        |  113 +-
>  tests/tcg/{ => multiarch}/sha1.c              |    0
>  tests/tcg/{ => multiarch}/test-mmap.c         |   40 +-
>  tests/tcg/{ => multiarch}/testthread.c        |    0
>  tests/tcg/ppc/Makefile.include                |    7 +
>  tests/tcg/ppc/Makefile.target                 |   12 +
>  tests/tcg/riscv/Makefile.include              |   10 +
>  tests/tcg/s390x/Makefile.include              |    2 +
>  tests/tcg/sh4/Makefile.include                |    4 +
>  tests/tcg/sh4/Makefile.target                 |    7 +
>  tests/tcg/sparc64/Makefile.include            |    2 +
>  tests/tcg/sparc64/Makefile.target             |   11 +
>  tests/tcg/test_path.c                         |  157 -
>  tests/tcg/x86_64/Makefile.target              |   15 +
>  78 files changed, 8068 insertions(+), 641 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
>  delete mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>  create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-riscv64-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sid.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
>  create mode 100644 tests/tcg/Makefile.include
>  create mode 100644 tests/tcg/Makefile.probe
>  create mode 100644 tests/tcg/aarch64/Makefile.include
>  create mode 100644 tests/tcg/aarch64/Makefile.target
>  create mode 100644 tests/tcg/aarch64/fcvt.ref
>  delete mode 100644 tests/tcg/alpha/Makefile
>  create mode 100644 tests/tcg/alpha/Makefile.include
>  create mode 100644 tests/tcg/alpha/Makefile.target
>  delete mode 100644 tests/tcg/alpha/crt.s
>  create mode 100644 tests/tcg/arm/Makefile.include
>  create mode 100644 tests/tcg/arm/Makefile.target
>  create mode 100644 tests/tcg/arm/README
>  create mode 100644 tests/tcg/arm/fcvt.c
>  create mode 100644 tests/tcg/arm/fcvt.ref
>  rename tests/tcg/{ => arm}/hello-arm.c (100%)
>  rename tests/tcg/{test-arm-iwmmxt.s => arm/test-arm-iwmmxt.S} (100%)
>  create mode 100644 tests/tcg/hppa/Makefile.include
>  create mode 100644 tests/tcg/hppa/Makefile.target
>  create mode 100644 tests/tcg/i386/Makefile.include
>  create mode 100644 tests/tcg/i386/Makefile.target
>  create mode 100644 tests/tcg/i386/README
>  rename tests/tcg/{ => i386}/hello-i386.c (96%)
>  rename tests/tcg/{ => i386}/pi_10.com (100%)
>  rename tests/tcg/{ => i386}/runcom.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
>  rename tests/tcg/{ => i386}/test-i386-fprem.c (97%)
>  rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-ssse3.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
>  rename tests/tcg/{ => i386}/test-i386.c (99%)
>  rename tests/tcg/{ => i386}/test-i386.h (100%)
>  create mode 100644 tests/tcg/m68k/Makefile.include
>  create mode 100644 tests/tcg/m68k/Makefile.target
>  create mode 100644 tests/tcg/mips/Makefile.include
>  create mode 100644 tests/tcg/mips/Makefile.target
>  create mode 100644 tests/tcg/mips/README
>  rename tests/tcg/{ => mips}/hello-mips.c (100%)
>  create mode 100644 tests/tcg/multiarch/Makefile.target
>  create mode 100644 tests/tcg/multiarch/README
>  rename tests/tcg/{ => multiarch}/linux-test.c (86%)
>  rename tests/tcg/{ => multiarch}/sha1.c (100%)
>  rename tests/tcg/{ => multiarch}/test-mmap.c (93%)
>  rename tests/tcg/{ => multiarch}/testthread.c (100%)
>  create mode 100644 tests/tcg/ppc/Makefile.include
>  create mode 100644 tests/tcg/ppc/Makefile.target
>  create mode 100644 tests/tcg/riscv/Makefile.include
>  create mode 100644 tests/tcg/s390x/Makefile.include
>  create mode 100644 tests/tcg/sh4/Makefile.include
>  create mode 100644 tests/tcg/sh4/Makefile.target
>  create mode 100644 tests/tcg/sparc64/Makefile.include
>  create mode 100644 tests/tcg/sparc64/Makefile.target
>  delete mode 100644 tests/tcg/test_path.c
>  create mode 100644 tests/tcg/x86_64/Makefile.target
> 
