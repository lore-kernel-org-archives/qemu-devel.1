Received: from eggs.gnu.org ([2001:4830:134:3::10]:42002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNe4H-0006vZ-0N
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNe4D-0008RI-DH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:49:37 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNe4D-0008Oy-3w
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:49:33 -0400
Received: by mail-wr0-x242.google.com with SMTP id w7-v6so13366542wrn.6
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:49:31 -0700 (PDT)
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141915.6497-1-alex.bennee@linaro.org>
	<20180525141915.6497-6-alex.bennee@linaro.org>
	<e9837ab8-18d8-d552-0aca-017a2669c0e6@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e9837ab8-18d8-d552-0aca-017a2669c0e6@amsat.org>
Date: Tue, 29 May 2018 13:49:29 +0100
Message-ID: <87d0xe1vae.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 45/49] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 05/25/2018 11:19 AM, Alex Benn=C3=A9e wrote:
>> This make is now invoked from each individual target make with the
>> appropriate CC and EXTRA_CFLAGS set for each guest. It then includes
>> additional Makefile.targets from:
>>
>>   - tests/tcg/multiarch (always)
>>   - tests/tcg/$(TARGET_BASE_ARCH) (if available)
>>   - tests/tcg/$(TARGET_NAME)
>>
>> The order is important as the later Makefile's may want to suppress
>> TESTS from its base arch profile. Each included Makefile.target is
>> responsible for adding TESTS as well as defining any special build
>> instructions for individual tests.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> v2
>>   - cleaner approach to include sub makefiles
>>   - move TESTS/VPATH manipulation into sub-makefile
>>   - avoid double inclusion when TARGET_BASE_ARCH=3D=3DTARGET_NAME
>> v4
>>   - add timeout to default runner
>>   - clean-up comments about build flags
>>   - update to handle BUILD_STATIC
>>   - add MAINTAINERS entry
>> v5
>>   - support EXTRA_RUNS for run variants
>> ---
>>  MAINTAINERS        |   5 ++
>>  tests/tcg/Makefile | 179 ++++++++++++++++++---------------------------
>>  2 files changed, 76 insertions(+), 108 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ec385a15df..bfa8d0fb9c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2138,6 +2138,11 @@ W: https://travis-ci.org/qemu/qemu
>>  W: https://app.shippable.com/github/qemu/qemu
>>  W: http://patchew.org/QEMU/
>>
>> +Guest Test Compilation Support
>> +M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +F: tests/tcg/Makefile
>> +L: qemu-devel@nongnu.org
>> +
>>  Documentation
>>  -------------
>>  Build system architecture
>> diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
>> index e12395117a..8158c1f099 100644
>> --- a/tests/tcg/Makefile
>> +++ b/tests/tcg/Makefile
>> @@ -1,125 +1,88 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# TCG tests
>> +#
>> +# These are complicated by the fact we want to build them for guest
>> +# systems. This requires knowing what guests we are building and which
>> +# ones we have cross-compilers for or docker images with
>> +# cross-compilers.
>> +#
>> +# The tests themselves should be as minimal as possible as
>> +# cross-compilers don't always have a large amount of libraries
>> +# available.
>> +#
>> +# We only include the host build system for SRC_PATH and we don't
>> +# bother with the common rules.mk. We expect the following:
>> +#
>> +#   CC - the C compiler command
>> +#   EXTRA_CFLAGS - any extra CFLAGS
>> +#   BUILD_STATIC - are we building static binaries
>> +#
>> +# By default all tests are statically compiled but some host systems
>> +# may not package static libraries by default. If an external
>> +# cross-compiler can only build dynamic libraries the user might need
>> +# to make extra efforts to ensure ld.so can link at runtime when the
>> +# tests are run.
>> +#
>> +# We also accept SPEED=3Dslow to enable slower running tests
>> +#
>> +# We also expect to be in the tests build dir for the FOO-linux-user.
>> +#
>> +
>>  -include ../../config-host.mak
>> --include $(SRC_PATH)/rules.mak
>> +-include ../config-target.mak
>>
>> -$(call set-vpath, $(SRC_PATH)/tests/tcg)
>> +quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &&=
 $1, @$1))
>>
>> -QEMU=3D../../i386-linux-user/qemu-i386
>> -QEMU_X86_64=3D../../x86_64-linux-user/qemu-x86_64
>> -CC_X86_64=3D$(CC_I386) -m64
>> +# Tests we are building
>> +TESTS=3D
>>
>> -QEMU_INCLUDES +=3D -I../..
>> -CFLAGS=3D-Wall -O2 -g -fno-strict-aliasing
>> -#CFLAGS+=3D-msse2
>> +# Start with a blank slate, the build targets get to add stuff first
>> +CFLAGS=3D
>> +QEMU_CFLAGS=3D
>>  LDFLAGS=3D
>>
>> -# TODO: automatically detect ARM and MIPS compilers, and run those too
>> -
>> -# runcom maps page 0, so it requires root privileges
>> -# also, pi_10.com runs indefinitely
>> -
>> -I386_TESTS=3Dhello-i386 \
>> -	   sha1-i386 \
>> -	   test-i386 \
>> -	   test-i386-fprem \
>> -	   # runcom
>> +# The QEMU for this TARGET
>> +QEMU=3D../qemu-$(TARGET_NAME)
>> +TIMEOUT=3D15
>>
>> -# native i386 compilers sometimes are not biarch.  assume cross-compile=
rs are
>> -ifneq ($(ARCH),i386)
>> -I386_TESTS+=3Drun-test-x86_64
>> +# The order we include is important. We include multiarch, base arch
>> +# and finally arch if it's not the same as base arch.
>> +-include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
>> +ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
>>  endif
>>
>> -TESTS =3D test_path
>> -ifneq ($(call find-in-path, $(CC_I386)),)
>> -TESTS +=3D $(I386_TESTS)
>> +# Add the common build options
>> +CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing
>> +ifeq ($(BUILD_STATIC),y)
>> +LDFLAGS+=3D-static
>>  endif
>>
>> -all: $(patsubst %,run-%,$(TESTS))
>> -test: all
>> -
>> -# rules to run tests
>> -
>> -.PHONY: $(patsubst %,run-%,$(TESTS))
>> -
>> -run-%: %
>> -	-$(QEMU) ./$*
>> -
>> -run-hello-i386: hello-i386
>> -run-sha1-i386: sha1-i386
>> -
>> -run-test-i386: test-i386
>> -	./test-i386 > test-i386.ref
>> -	-$(QEMU) test-i386 > test-i386.out
>> -	@if diff -u test-i386.ref test-i386.out ; then echo "Auto Test OK"; fi
>> -
>> -run-test-i386-fprem: test-i386-fprem
>> -	./test-i386-fprem > test-i386-fprem.ref
>> -	-$(QEMU) test-i386-fprem > test-i386-fprem.out
>> -	@if diff -u test-i386-fprem.ref test-i386-fprem.out ; then echo "Auto =
Test OK"; fi
>> -
>> -run-test-x86_64: test-x86_64
>> -	./test-x86_64 > test-x86_64.ref
>> -	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
>> -	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK"=
; fi
>> -
>> +%: %.c
>> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>>
>> -run-runcom: runcom
>> -	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
>> +all: $(TESTS)
>>
>> -run-test_path: test_path
>> -	./test_path
>> +#
>> +# Test Runners
>> +#
>> +# By default we just run the test with the appropriate QEMU for the
>> +# target. More advanced tests may want to override the runner in their
>> +# specific make rules. Additional runners for the same binary should
>> +# be added to EXTRA_RUNS.
>> +#
>>
>> -# rules to compile tests
>> +RUN_TESTS=3D$(patsubst %,run-%, $(TESTS))
>> +RUN_TESTS+=3D$(EXTRA_RUNS)
>>
>> -hello-i386: hello-i386.c
>> -	$(CC_I386) -nostdlib $(CFLAGS) -static $(LDFLAGS) -o $@ $<
>> -	strip $@
>> -
>> -# i386/x86_64 emulation test (test various opcodes) */
>> -test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S \
>> -           test-i386.h test-i386-shift.h test-i386-muldiv.h
>> -	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ \
>> -              $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i38=
6-vm86.S -lm
>> -
>> -test-i386-fprem: test-i386-fprem.c
>> -	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $^
>> -
>> -test-x86_64: test-i386.c \
>> -           test-i386.h test-i386-shift.h test-i386-muldiv.h
>> -	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i3=
86.c -lm
>> -
>> -# vm86 test
>> -runcom: runcom.c
>> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
>> -
>> -# speed test
>> -sha1-i386: sha1.c
>> -	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
>> -
>> -# arm test
>> -hello-arm: hello-arm.o
>> -	arm-linux-ld -o $@ $<
>> -
>> -hello-arm.o: hello-arm.c
>> -	arm-linux-gcc -Wall -g -O2 -c -o $@ $<
>> -
>> -test-arm-iwmmxt: test-arm-iwmmxt.s
>> -	cpp < $< | arm-linux-gnu-gcc -Wall -static -march=3Diwmmxt -mabi=3Daap=
cs -x assembler - -o $@
>> -
>> -# MIPS test
>> -hello-mips: hello-mips.c
>> -	mips-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=3D32=
 -Wall -Wextra -g -O2 -o $@ $<
>> -
>> -hello-mipsel: hello-mips.c
>> -	mipsel-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=3D=
32 -Wall -Wextra -g -O2 -o $@ $<
>> -
>> -# testsuite for the CRIS port.
>> -test-cris:
>> -	$(MAKE) -C cris check
>> +run-%: %
>> +	$(call quiet-command, \
>> +		timeout $(TIMEOUT) $(QEMU) $< > $<.out, \
>> +		"TEST", "$< on $(TARGET_NAME)")
>
> Should we use --preserve-status here?
>
> I'm getting Error 124:
>
>        If the command times out, and  --preserve-status  is  not  set,
>        then  exit with status 124.  Otherwise, exit with the status of
>        COMMAND.  If no signal is specified, send the TERM signal  upon
>        timeout.  The TERM signal kills any process that does not block
>        or catch that signal.  It may be necessary to use the KILL  (9)
>        signal,  since  this signal cannot be caught, in which case the
>        exit status is 128+9 rather than 124.

I guess it only really matters if the test cases are going to catch and
handle TERM signals. Currently I think any non-zero response is enough
to exit make.

>
> $ make -j1 run-tcg-tests-i386-linux-user
> [...]
>   RUN-TESTS for i386
>   TEST    test-mmap (default) on i386
>   TEST    sha1 on i386
>   TEST    linux-test on i386
>   TEST    testthread on i386
>   TEST    test-i386 on i386
>   TEST    hello-i386 on i386
>   SKIPPED test-i386-fprem because SLOW
>   TEST    runcom on i386
> make[2]: *** [/src/qemu/tests/tcg/i386/Makefile.target:34: run-runcom]
> Error 124
> make[1]: *** [/src/qemu/tests/tcg/Makefile.include:71: run-guest-tests]
> Error 2
> make: *** [/src/qemu/tests/Makefile.include:931:
> run-tcg-tests-i386-linux-user] Error 2
>
>>
>> -# testsuite for the LM32 port.
>> -test-lm32:
>> -	$(MAKE) -C lm32 check
>> +.PHONY: run
>> +run: $(RUN_TESTS)
>>
>> -clean:
>> -	rm -f *~ *.o test-i386.out test-i386.ref \
>> -           test-x86_64.log test-x86_64.ref qruncom $(TESTS)
>> +# There is no clean target, the calling make just rm's the tests build =
dir
>>


--
Alex Benn=C3=A9e
