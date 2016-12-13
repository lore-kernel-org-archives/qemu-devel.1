Received: from eggs.gnu.org ([2001:4830:134:3::10]:41390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnCK-0006gc-AG
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnCF-0003pb-6D
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:32:48 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGnCE-0003p6-S8
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:32:43 -0500
Received: by mail-wm0-f47.google.com with SMTP id f82so120983672wmf.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:32:42 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-1-bobby.prani@gmail.com>
Date: Tue, 13 Dec 2016 13:31:40 +0000
Message-ID: <87bmwgt0oz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/19] Cleanup of TCG tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hello,
>
> This patch series cleans up the tcg tests in tests/tcg folder.
>
> The tests have bit-rotten and were not compiling or running. I fixed
> the Makefiles to make them compile though there are tests which do not
> pass.
>
> The motivation is to add litmus tests to each arch and have them run
> using the 'make check' target to test consistency on TCG.
>
> There are no maintainers listed for this test folder. So I am cc'ing
> people who I think might be interested.
>
> The tests are hooked to the 'tests-tcg' target. Alternatively, as
> suggested by Alex Bennee you can run a tcg tests for a particular arch
> from the build/<arch>-linux-user/tests directory as follows:
>
> $ CROSS_CC=<cross-compiler> make -f ../../tests/tcg/<arch>/Makefile

So admittedly this isn't using a cross compiler rather than a linux-user
powered docker image but I first of all had to:

  mkdir arm-linux-user/tests

And then running:

  docker run --rm -it -v /home/alex/lsrc/qemu/qemu.git/:/src --user=alex:alex -w /src/arm-linux-user/tests debian:armhf make -f ../../tests/tcg/arm/Makefile

yielded:

  ../../tests/tcg/arm/Makefile:12: /home/alex/lsrc/qemu/qemu.git/rules.mak: No such file or directory
  make: *** No rule to make target '/home/alex/lsrc/qemu/qemu.git/rules.mak'.  Stop.

Which I guess is a relative vs absolute problem. I wonder if there is a
way to make it cleaner in the event of these re-locations?

BTW running:

  docker run --rm -it -v /home/alex/lsrc/qemu/qemu.git/:/home/alex/lsrc/qemu/qemu.git/ --user=alex:alex -w /home/alex/lsrc/qemu/qemu.git/arm-linux-user/tests debian:armhf make -f ../../tests/tcg/arm/Makefile

Gives:

  cc -Wall -O2 -g -fno-strict-aliasing -nostdlib -c -o hello-arm.o /home/alex/lsrc/qemu/qemu.git/tests/tcg/arm/hello-arm.c
/tmp/ccaztzVL.s: Assembler messages:
/tmp/ccaztzVL.s:41: Error: invalid swi expression
/tmp/ccaztzVL.s:41: Error: value of 9437185 too large for field of 2 bytes at 6
/tmp/ccaztzVL.s:77: Error: invalid swi expression
/tmp/ccaztzVL.s:77: Error: value of 9437188 too large for field of 2 bytes at 30
/tmp/ccaztzVL.s:122: Error: invalid swi expression
/tmp/ccaztzVL.s:122: Error: value of 9437188 too large for field of 2 bytes at 60
/tmp/ccaztzVL.s:136: Error: invalid swi expression
/tmp/ccaztzVL.s:136: Error: value of 9437185 too large for field of 2 bytes at 68
../../tests/tcg/arm/Makefile:45: recipe for target 'hello-arm.o' failed
make: *** [hello-arm.o] Error 1


>
> Thanks,
> --
> Pranith
>
> Marc-André Lureau (9):
>   linux-user: fix settime old value location
>   linux-user: fix tcg/mmap test
>   check-help: add some hint to run a single test
>   tests/tcg: comment unused code
>   tests/tcg: declare some functions as static
>   linux-test: fix build
>   linux-test: fix set/getitimer returned timer check
>   Fix test-i386-fprem compilation
>   test-i386: modernize vector code v4sf
>
> Pranith Kumar (10):
>   tests/tcg: Move arm tests to arch specific folder
>   tests/tcg: Move mips test to arch specific folder
>   tests/tcg: Add tests-tcg hook in Makefile
>   tests/tcg/i386: Fix hello-i386 test
>   tests/tcg: Move i386 tests to arch specific folder
>   tests/tcg/i386: Fix test-i386 compilation
>   tests/tcg: Fix compilation of linux-test.c
>   tests/tcg: Move arch independent tests to misc directory
>   tests/tcg: Add and update Makefiles
>   tests/tcg: test-i386.c: Fix format warnings
>
>  linux-user/mmap.c                       |  27 +++---
>  linux-user/syscall.c                    |   2 +-
>  tests/Makefile.include                  |   2 +
>  tests/tcg/Makefile                      | 156 --------------------------------
>  tests/tcg/Makefile.include              |  33 +++++++
>  tests/tcg/alpha/Makefile                |  38 +++++---
>  tests/tcg/arm/Makefile                  |  51 +++++++++++
>  tests/tcg/{ => arm}/hello-arm.c         |   0
>  tests/tcg/{ => arm}/test-arm-iwmmxt.s   |   0
>  tests/tcg/cris/Makefile                 |  17 +++-
>  tests/tcg/i386/Makefile                 |  87 ++++++++++++++++++
>  tests/tcg/{ => i386}/hello-i386.c       |   9 +-
>  tests/tcg/{ => i386}/pi_10.com          | Bin
>  tests/tcg/{ => i386}/runcom.c           |   0
>  tests/tcg/{ => i386}/test-i386-code16.S |   0
>  tests/tcg/{ => i386}/test-i386-fprem.c  |  10 +-
>  tests/tcg/{ => i386}/test-i386-muldiv.h |   0
>  tests/tcg/{ => i386}/test-i386-shift.h  |   0
>  tests/tcg/{ => i386}/test-i386-ssse3.c  |   0
>  tests/tcg/{ => i386}/test-i386-vm86.S   |   0
>  tests/tcg/{ => i386}/test-i386.c        |   7 +-
>  tests/tcg/{ => i386}/test-i386.h        |   0
>  tests/tcg/lm32/Makefile                 |  17 +++-
>  tests/tcg/mips/Makefile                 |  46 ++++++++++
>  tests/tcg/{ => mips}/hello-mips.c       |   0
>  tests/tcg/mips/mips32-dsp/Makefile      |  17 +++-
>  tests/tcg/mips/mips32-dspr2/Makefile    |  17 +++-
>  tests/tcg/mips/mips64-dsp/Makefile      |  18 +++-
>  tests/tcg/mips/mips64-dspr2/Makefile    |  17 +++-
>  tests/tcg/misc/Makefile                 |  81 +++++++++++++++++
>  tests/tcg/{ => misc}/linux-test.c       |  57 +++++++-----
>  tests/tcg/{ => misc}/sha1.c             |   0
>  tests/tcg/{ => misc}/test-mmap.c        |   2 +-
>  tests/tcg/{ => misc}/test_path.c        |   0
>  tests/tcg/{ => misc}/testthread.c       |   0
>  tests/tcg/openrisc/Makefile             |  19 +++-
>  tests/tcg/xtensa/Makefile               |  17 +++-
>  37 files changed, 518 insertions(+), 229 deletions(-)
>  delete mode 100644 tests/tcg/Makefile
>  create mode 100644 tests/tcg/Makefile.include
>  create mode 100644 tests/tcg/arm/Makefile
>  rename tests/tcg/{ => arm}/hello-arm.c (100%)
>  rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)
>  create mode 100644 tests/tcg/i386/Makefile
>  rename tests/tcg/{ => i386}/hello-i386.c (72%)
>  rename tests/tcg/{ => i386}/pi_10.com (100%)
>  rename tests/tcg/{ => i386}/runcom.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
>  rename tests/tcg/{ => i386}/test-i386-fprem.c (98%)
>  rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-ssse3.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
>  rename tests/tcg/{ => i386}/test-i386.c (99%)
>  rename tests/tcg/{ => i386}/test-i386.h (100%)
>  create mode 100644 tests/tcg/mips/Makefile
>  rename tests/tcg/{ => mips}/hello-mips.c (100%)
>  create mode 100644 tests/tcg/misc/Makefile
>  rename tests/tcg/{ => misc}/linux-test.c (90%)
>  rename tests/tcg/{ => misc}/sha1.c (100%)
>  rename tests/tcg/{ => misc}/test-mmap.c (99%)
>  rename tests/tcg/{ => misc}/test_path.c (100%)
>  rename tests/tcg/{ => misc}/testthread.c (100%)


--
Alex Bennée
