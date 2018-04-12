Received: from eggs.gnu.org ([2001:4830:134:3::10]:41745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XN6-0001qE-Ax
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XMA-0000Ty-Jt
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:14:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6XMA-0000T5-Ap
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:13:22 -0400
Date: Thu, 12 Apr 2018 16:13:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180412081311.GD24896@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-23-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180410193919.28026-23-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 22/24] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org

On Tue, 04/10 20:39, Alex Benn=E9e wrote:
> This make is now invoked from each individual target make with the
> appropriate CC and ARCH set for each guest. It includes all the
> multiarch tests by default as well as any tests from
> tests/tcg/$(ARCH).
>=20
> As there may be subtle additional requirements for building some of
> the tests it also includes tests/tcg/$(ARCH)/Makefile.target if it is
> available. This is distinct from tests/tcg/$(ARCH)/Makefile.include
> which is used by the parent make machinery to determine potential
> docker targets.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile | 185 ++++++++++++---------------------------------=
--------
>  1 file changed, 42 insertions(+), 143 deletions(-)
>=20
> diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
> index 89e3342f3d..2bba0d2a32 100644
> --- a/tests/tcg/Makefile
> +++ b/tests/tcg/Makefile
> @@ -1,156 +1,55 @@
> --include ../../config-host.mak
> --include $(SRC_PATH)/rules.mak
> +# -*- Mode: makefile -*-
> +#
> +# TCG tests
> +#
> +# These are complicated by the fact we want to build them for guest
> +# systems. This requires knowing what guests we are building and which
> +# ones we have cross-compilers for or docker images with
> +# cross-compilers.
> +#
> +# The tests themselves should be as minimal as possible as
> +# cross-compilers don't always have a large amount of libraries
> +# available.
> +#
> +# We only include the host build system for SRC_PATH and we don't
> +# bother with the common rules.mk. We expect CC to have been set for
> +# us from the parent make. We also expect to be in the tests build dir
> +# for the FOO-linux-user.
> +#
> =20
> -$(call set-vpath, $(SRC_PATH)/tests/tcg)
> +-include ../../config-host.mak
> +-include ../config-target.mak
> =20
> -QEMU=3D../../i386-linux-user/qemu-i386
> -QEMU_X86_64=3D../../x86_64-linux-user/qemu-x86_64
> -CC_X86_64=3D$(CC_I386) -m64
> +# Set search path for all sources
> +VPATH =3D $(SRC_PATH)/tests/tcg/multiarch
> +TEST_SRCS =3D $(wildcard $(SRC_PATH)/tests/tcg/multiarch/*.c)
> =20
> -QEMU_INCLUDES +=3D -I../..
> -CFLAGS=3D-Wall -O2 -g -fno-strict-aliasing
> -#CFLAGS+=3D-msse2
> -LDFLAGS=3D
> +VPATH     +=3D $(SRC_PATH)/tests/tcg/$(ARCH)
> +TEST_SRCS +=3D $(wildcard $(SRC_PATH)/tests/tcg/$(ARCH)/*.c)
> =20
> -# TODO: automatically detect ARM and MIPS compilers, and run those too
> +SRCS=3D$(notdir ${TEST_SRCS})
> +TESTS=3D$(SRCS:.c=3D)
> =20
> -# runcom maps page 0, so it requires root privileges
> -# also, pi_10.com runs indefinitely
> +# We use what ever CC we have
> +CFLAGS=3D-Wall -O0 -g -fno-strict-aliasing -static
> +QEMU_CFLAGS=3D
> +LDFLAGS=3D
> =20
> -I386_TESTS=3Dhello-i386 \
> -	   linux-test \
> -	   testthread \
> -	   sha1-i386 \
> -	   test-i386 \
> -	   test-i386-fprem \
> -	   test-mmap \
> -	   # runcom
> +# The per ARCH target makefile which might add specific compiler flags
> +# for some compilation targets.
> =20
> -# native i386 compilers sometimes are not biarch.  assume cross-compil=
ers are
> -ifneq ($(ARCH),i386)
> -I386_TESTS+=3Drun-test-x86_64
> -endif
> +EXTRA_MAKEFILE=3D$(SRC_PATH)/tests/tcg/$(ARCH)/Makefile.target
> +CHECK_INCLUDE=3D$(wildcard $(EXTRA_MAKEFILE))
> =20
> -TESTS =3D test_path
> -ifneq ($(call find-in-path, $(CC_I386)),)
> -TESTS +=3D $(I386_TESTS)
> +ifeq ($(EXTRA_MAKEFILE),$(CHECK_INCLUDE))
> +include $(EXTRA_MAKEFILE)
>  endif
> =20
> -all: $(patsubst %,run-%,$(TESTS))
> -test: all
> -
> -# rules to run tests
> -
> -.PHONY: $(patsubst %,run-%,$(TESTS))
> -
> -run-%: %
> -	-$(QEMU) ./$*
> -
> -run-hello-i386: hello-i386
> -run-linux-test: linux-test
> -run-testthread: testthread
> -run-sha1-i386: sha1-i386
> -
> -run-test-i386: test-i386
> -	./test-i386 > test-i386.ref
> -	-$(QEMU) test-i386 > test-i386.out
> -	@if diff -u test-i386.ref test-i386.out ; then echo "Auto Test OK"; f=
i
> -
> -run-test-i386-fprem: test-i386-fprem
> -	./test-i386-fprem > test-i386-fprem.ref
> -	-$(QEMU) test-i386-fprem > test-i386-fprem.out
> -	@if diff -u test-i386-fprem.ref test-i386-fprem.out ; then echo "Auto=
 Test OK"; fi
> -
> -run-test-x86_64: test-x86_64
> -	./test-x86_64 > test-x86_64.ref
> -	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
> -	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK=
"; fi
> -
> -run-test-mmap: test-mmap
> -	-$(QEMU) ./test-mmap
> -	-$(QEMU) -p 8192 ./test-mmap 8192
> -	-$(QEMU) -p 16384 ./test-mmap 16384
> -	-$(QEMU) -p 32768 ./test-mmap 32768
> -
> -run-runcom: runcom
> -	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
> -
> -run-test_path: test_path
> -	./test_path
> -
> -# rules to compile tests
> -
> -test_path: test_path.o
> -
> -test_path.o: test_path.c
> -
> -hello-i386: hello-i386.c
> -	$(CC_I386) -nostdlib $(CFLAGS) -static $(LDFLAGS) -o $@ $<
> -	strip $@
> -
> -testthread: testthread.c
> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lpthread
> -
> -# i386/x86_64 emulation test (test various opcodes) */
> -test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S \
> -           test-i386.h test-i386-shift.h test-i386-muldiv.h
> -	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ \
> -              $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i3=
86-vm86.S -lm
> -
> -test-i386-fprem: test-i386-fprem.c
> -	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $^
> -
> -test-x86_64: test-i386.c \
> -           test-i386.h test-i386-shift.h test-i386-muldiv.h
> -	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i=
386.c -lm
> -
> -# generic Linux and CPU test
> -linux-test: linux-test.c
> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
> -
> -# vm86 test
> -runcom: runcom.c
> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
> -
> -test-mmap: test-mmap.c
> -	$(CC_I386) -m32 $(CFLAGS) -Wall -O2 $(LDFLAGS) -o $@ $<
> -
> -# speed test
> -sha1-i386: sha1.c
> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
> -
> -sha1: sha1.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
> -
> -speed: sha1 sha1-i386
> -	time ./sha1
> -	time $(QEMU) ./sha1-i386
> -
> -# arm test
> -hello-arm: hello-arm.o
> -	arm-linux-ld -o $@ $<
> -
> -hello-arm.o: hello-arm.c
> -	arm-linux-gcc -Wall -g -O2 -c -o $@ $<
> -
> -test-arm-iwmmxt: test-arm-iwmmxt.s
> -	cpp < $< | arm-linux-gnu-gcc -Wall -static -march=3Diwmmxt -mabi=3Daa=
pcs -x assembler - -o $@
> -
> -# MIPS test
> -hello-mips: hello-mips.c
> -	mips-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=3D3=
2 -Wall -Wextra -g -O2 -o $@ $<
> -
> -hello-mipsel: hello-mips.c
> -	mipsel-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=3D=
32 -Wall -Wextra -g -O2 -o $@ $<
> +testthread: LDFLAGS=3D-lpthread

I'm a bit curious why only testthread is left in this file but others are=
 gone.

Fam

> =20
> -# testsuite for the CRIS port.
> -test-cris:
> -	$(MAKE) -C cris check
> +%: %.c
> +	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> =20
> -# testsuite for the LM32 port.
> -test-lm32:
> -	$(MAKE) -C lm32 check
> +all: $(TESTS)
> =20
> -clean:
> -	rm -f *~ *.o test-i386.out test-i386.ref \
> -           test-x86_64.log test-x86_64.ref qruncom $(TESTS)
> +# There is no clean target, the calling make just rm's the tests build=
 dir
> --=20
> 2.16.2
>=20
