Received: from eggs.gnu.org ([2001:4830:134:3::10]:39858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHBls-0005ti-8L
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHBlo-0007dN-Vg
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:47:08 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHBlo-0007cs-L4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:47:04 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so119196372wmd.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:47:04 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-19-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-19-bobby.prani@gmail.com>
Date: Wed, 14 Dec 2016 15:46:01 +0000
Message-ID: <87zijysedi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/19] tests/tcg: Add and update Makefiles
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

> This commit fixes the makefiles to bring them to the desired state.
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tests/tcg/alpha/Makefile             | 38 +++++++++++++++++++----------
>  tests/tcg/arm/Makefile               | 32 +++++++++++++++----------
>  tests/tcg/cris/Makefile              | 17 +++++++++++--
>  tests/tcg/i386/Makefile              | 23 +++++++++---------
>  tests/tcg/lm32/Makefile              | 17 +++++++++++--
>  tests/tcg/mips/Makefile              | 46 ++++++++++++++++++++++++++++++++++++
>  tests/tcg/mips/mips32-dsp/Makefile   | 17 +++++++++++--
>  tests/tcg/mips/mips32-dspr2/Makefile | 17 +++++++++++--
>  tests/tcg/mips/mips64-dsp/Makefile   | 18 ++++++++++++--
>  tests/tcg/mips/mips64-dspr2/Makefile | 17 ++++++++++++-
>  tests/tcg/openrisc/Makefile          | 19 ++++++++++++---
>  tests/tcg/xtensa/Makefile            | 17 +++++++++++--
>  12 files changed, 225 insertions(+), 53 deletions(-)
>  create mode 100644 tests/tcg/mips/Makefile

I think these changes should be split and merged with each move commit.
I should be able to manually build each individual test target with each move.

>
> diff --git a/tests/tcg/alpha/Makefile b/tests/tcg/alpha/Makefile
> index 2b1f03d..e20315f 100644
> --- a/tests/tcg/alpha/Makefile
> +++ b/tests/tcg/alpha/Makefile
> @@ -1,33 +1,47 @@
> -CROSS=alpha-linux-gnu-
> -CC=$(CROSS)gcc
> -AS=$(CROSS)as
> +# -*- Mode: makefile -*-
> +#
> +# Alpha linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/alpha-linux-user/tests directory
> +#
>
> -SIM=../../alpha-linux-user/qemu-alpha
> +BUILD_DIR?=$(CURDIR)
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
>
> -CFLAGS=-O
> -LINK=$(CC) -o $@ crt.o $< -nostdlib
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/alpha)
> +
> +QEMU=$(BUILD_DIR)/alpha-linux-user/qemu-alpha
> +
> +# Compiler set-up, default to system compiler if not set
> +CROSS_CC?=$(CC)
> +
> +CFLAGS=-Wall -O2 -g -fno-strict-aliasing -static
> +LDFLAGS=-nostdlib
>
>  TESTS=test-cond test-cmov
>
>  all: hello-alpha $(TESTS)
>
>  hello-alpha: hello-alpha.o crt.o
> -	$(LINK)
> +	$(CROSS_CC) -o $@ crt.o $< $(LDFLAGS)
>
>  test-cond: test-cond.o crt.o
> -	$(LINK)
> +	$(CROSS_CC) -o $@ crt.o $< $(LDFLAGS)
>
>  test-cmov.o: test-cond.c
> -	$(CC) -c $(CFLAGS) -DTEST_CMOV -o $@ $<
> +	$(CROSS_CC) -c $(CFLAGS) -DTEST_CMOV -o $@ $<
>
>  test-cmov: test-cmov.o crt.o
> -	$(LINK)
> +	$(CROSS_CC) -o $@ crt.o $< $(LDFLAGS)
>
>  test-ovf: test-ovf.o crt.o
> -	$(LINK)
> +	$(CROSS_CC) -o $@ crt.o $< $(LDFLAGS)
>
>  check: $(TESTS)
> -	for f in $(TESTS); do $(SIM) $$f || exit 1; done
> +	for f in $(TESTS); do $(QEMU) $$f || exit 1; done
>
>  clean:
>  	$(RM) *.o *~ hello-alpha $(TESTS)
> diff --git a/tests/tcg/arm/Makefile b/tests/tcg/arm/Makefile
> index c2ae491..a7c8953 100644
> --- a/tests/tcg/arm/Makefile
> +++ b/tests/tcg/arm/Makefile
> @@ -1,20 +1,26 @@
> -BUILD_DIR?=$(CURDIR)
> -SRC_PATH=../../../
> -include $(BUILD_DIR)/config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# Arm linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/arm-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
>  include $(SRC_PATH)/rules.mak
>
>  $(call set-vpath, $(SRC_PATH)/tests/tcg/arm)
>
>  QEMU=$(BUILD_DIR)/arm-linux-user/qemu-arm
>
> -QEMU_INCLUDES += -I$(BUILD_DIR)
> -CFLAGS=-Wall -O2 -g -fno-strict-aliasing
> -LDFLAGS=
> -
> -# TODO: automatically detect ARM and MIPS compilers, and run those too
> +# Compiler set-up, default to system compiler if not set
> +CROSS_CC?=$(CC)
>
> -# runcom maps page 0, so it requires root privileges
> -# also, pi_10.com runs indefinitely
> +QEMU_INCLUDES += -I$(BUILD_DIR)
> +CFLAGS=-Wall -O2 -g -fno-strict-aliasing -nostdlib
> +LDFLAGS=-nostdlib
>
>  TESTS=hello-arm arm-iwmmxt
>
> @@ -33,13 +39,13 @@ run-arm-iwmmxt: arm-iwmmxt
>
>  # arm test
>  hello-arm: hello-arm.o
> -	arm-linux-gnueabi-ld -o $@ $<
> +	$(CROSS_CC) $(LDFLAGS) -o $@ $<
>
>  hello-arm.o: hello-arm.c
> -	arm-linux-gnueabi-gcc -Wall -g -O2 -c -o $@ $<
> +	$(CROSS_CC) $(CFLAGS) -c -o $@ $<
>
>  arm-iwmmxt: test-arm-iwmmxt.s
> -	cpp < $< | arm-linux-gnueabi-gcc -Wall -static -march=iwmmxt -mabi=aapcs -x assembler - -o $@
> +	cpp < $< | $(CROSS_CC) -Wall -static -march=iwmmxt -mabi=aapcs -x assembler - -o $@
>
>  clean:
>  	rm -f *~ *.o $(TESTS)
> diff --git a/tests/tcg/cris/Makefile b/tests/tcg/cris/Makefile
> index 6b3dba4..009c3f4 100644
> --- a/tests/tcg/cris/Makefile
> +++ b/tests/tcg/cris/Makefile
> @@ -1,7 +1,20 @@
> --include ../../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# Cris linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/cris-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/arm)
>
>  CROSS=crisv32-axis-linux-gnu-
> -SIM=../../../cris-linux-user/qemu-cris -L ./
> +SIM=$(BUILD_DIR)/cris-linux-user/qemu-cris -L ./
>  SIMG=cris-axis-linux-gnu-run --sysroot=./
>
>  CC      = $(CROSS)gcc
> diff --git a/tests/tcg/i386/Makefile b/tests/tcg/i386/Makefile
> index 97c1a97..55a45ad 100644
> --- a/tests/tcg/i386/Makefile
> +++ b/tests/tcg/i386/Makefile
> @@ -1,6 +1,14 @@
> -BUILD_DIR=../../../build/
> -SRC_PATH=../../../
> -include $(BUILD_DIR)/config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# i386 linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/i386-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
>  include $(SRC_PATH)/rules.mak
>
>  $(call set-vpath, $(SRC_PATH)/tests/tcg/i386)
> @@ -14,14 +22,8 @@ CFLAGS=-Wall -O2 -g -fno-strict-aliasing
>  #CFLAGS+=-msse2
>  LDFLAGS=
>
> -# TODO: automatically detect ARM and MIPS compilers, and run those too
> -
> -# runcom maps page 0, so it requires root privileges
> -# also, pi_10.com runs indefinitely
> -
>  I386_TESTS=hello-i386 \
>  	   test-i386-fprem
> -	   # runcom
>
>  # native i386 compilers sometimes are not biarch.  assume cross-compilers are
>  ifneq ($(ARCH),i386)
> @@ -57,9 +59,6 @@ run-test-x86_64: test-x86_64
>  	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
>  	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK"; fi
>
> -run-runcom: runcom
> -	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
> -
>  # rules to compile tests
>
>  hello-i386: hello-i386.c
> diff --git a/tests/tcg/lm32/Makefile b/tests/tcg/lm32/Makefile
> index 57e7363..ad5d9a7 100644
> --- a/tests/tcg/lm32/Makefile
> +++ b/tests/tcg/lm32/Makefile
> @@ -1,8 +1,21 @@
> --include ../../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# lm32 linux-system TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/lm32-softmmu/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/lm32)
>
>  CROSS=lm32-elf-
>
> -SIM = qemu-system-lm32
> +QEMU=$(BUILD_DIR)/lm32-softmmu/qemu-system-lm32
>  SIMFLAGS = -M lm32-evr -nographic -semihosting -net none -kernel
>
>  CC      = $(CROSS)gcc
> diff --git a/tests/tcg/mips/Makefile b/tests/tcg/mips/Makefile
> new file mode 100644
> index 0000000..a56d6c8
> --- /dev/null
> +++ b/tests/tcg/mips/Makefile
> @@ -0,0 +1,46 @@
> +# -*- Mode: makefile -*-
> +#
> +# mips linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/mips-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/mips)
> +
> +QEMU=$(BUILD_DIR)/mips-linux-user/qemu-mips
> +
> +# Compiler set-up, default to system compiler if not set
> +CROSS_CC?=$(CC)
> +
> +CFLAGS=-Wall -O2 -g -fno-strict-aliasing
> +LDFLAGS=
> +
> +TESTS=hello-mips
> +
> +all: $(patsubst %,run-%,$(TESTS))

We need new run targets for the tests - certainly a default make
shouldn't run the test.

> +test: all
> +
> +# rules to run tests
> +
> +run-%: %
> +	$(QEMU) ./$*
> +
> +#.PHONY: $(patsubst %,run-%,$(TESTS))
> +
> +run-hello-mips: hello-mips
> +
> +# mips test
> +hello-mips: hello-mips.o
> +	$(CROSS_CC) -o $@ $<
> +
> +hello-mips.o: hello-mips.c
> +	$(CROSS_CC) -Wall -g -O2 -c -o $@ $<
> +
> +clean:
> +	rm -f *~ *.o $(TESTS)
> diff --git a/tests/tcg/mips/mips32-dsp/Makefile b/tests/tcg/mips/mips32-dsp/Makefile
> index c3a0a00..996b9a0 100644
> --- a/tests/tcg/mips/mips32-dsp/Makefile
> +++ b/tests/tcg/mips/mips32-dsp/Makefile
> @@ -1,8 +1,21 @@
> --include ../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# mipsel linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/mipsel-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/mips/mips32-dsp)
>
>  CROSS=mips64el-unknown-linux-gnu-
>
> -SIM=qemu-mipsel
> +SIM=$(BUILD_DIR)/mipsel-linux-user/qemu-mipsel
>  SIM_FLAGS=-cpu 74Kf
>
>  CC      = $(CROSS)gcc
> diff --git a/tests/tcg/mips/mips32-dspr2/Makefile b/tests/tcg/mips/mips32-dspr2/Makefile
> index ed19581..e99f2bc 100644
> --- a/tests/tcg/mips/mips32-dspr2/Makefile
> +++ b/tests/tcg/mips/mips32-dspr2/Makefile
> @@ -1,8 +1,21 @@
> --include ../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# mipsel linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/mipsel-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/mips/mips32-dsp)
>
>  CROSS=mips64el-unknown-linux-gnu-
>
> -SIM=qemu-mipsel
> +SIM=$(BUILD_DIR)/mipsel-linux-user/qemu-mipsel
>  SIM_FLAGS=-cpu 74Kf
>
>  CC      = $(CROSS)gcc
> diff --git a/tests/tcg/mips/mips64-dsp/Makefile b/tests/tcg/mips/mips64-dsp/Makefile
> index b2ac6b3..4ee3bbb 100644
> --- a/tests/tcg/mips/mips64-dsp/Makefile
> +++ b/tests/tcg/mips/mips64-dsp/Makefile
> @@ -1,7 +1,21 @@
> +# -*- Mode: makefile -*-
> +#
> +# mips64el linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/mips64el-linux-user/tests directory
> +#
>
> -CROSS_COMPILE	?= mips64el-unknown-linux-gnu-
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
>
> -SIM = qemu-system-mips64el
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/mips/mips64-dsp)
> +
> +CROSS=mips64el-unknown-linux-gnu-
> +
> +SIM=$(BUILD_DIR)/mipsel-linux-user/qemu-mips64el
>  SIMFLAGS = -nographic -cpu mips64dspr2 -kernel
>
>  AS      = $(CROSS_COMPILE)as
> diff --git a/tests/tcg/mips/mips64-dspr2/Makefile b/tests/tcg/mips/mips64-dspr2/Makefile
> index ba44bb9..8510d8c 100644
> --- a/tests/tcg/mips/mips64-dspr2/Makefile
> +++ b/tests/tcg/mips/mips64-dspr2/Makefile
> @@ -1,6 +1,21 @@
> +# -*- Mode: makefile -*-
> +#
> +# mips64el linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/mips64el-linux-user/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/mips/mips64-dsp)
> +
>  CROSS_COMPILE	?= mips64el-unknown-linux-gnu-
>
> -SIM = qemu-system-mips64el
> +SIM=$(BUILD_DIR)/mipsel-linux-user/qemu-mips64el
>  SIMFLAGS = -nographic -cpu mips64dspr2 -kernel
>
>  AS      = $(CROSS_COMPILE)as
> diff --git a/tests/tcg/openrisc/Makefile b/tests/tcg/openrisc/Makefile
> index 7e65888..071aaab 100644
> --- a/tests/tcg/openrisc/Makefile
> +++ b/tests/tcg/openrisc/Makefile
> @@ -1,8 +1,21 @@
> --include ../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# openrisc linux-user TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/or32-linux-user/tests directory
> +#
>
> -CROSS = or32-linux-
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/openrisc)
>
> -SIM = qemu-or32
> +SIM=$(BUILD_DIR)/or32-linux-user/qemu-mips
> +
> +CROSS = or32-linux-
>
>  CC = $(CROSS)gcc
>
> diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
> index 522a63e..e3269ed 100644
> --- a/tests/tcg/xtensa/Makefile
> +++ b/tests/tcg/xtensa/Makefile
> @@ -1,10 +1,23 @@
> --include ../../../config-host.mak
> +# -*- Mode: makefile -*-
> +#
> +# xtensa linux TCG tests
> +#
> +# The Make is expected to be called in the
> +# ${BUILD_DIR}/xtensa-softmmu/tests directory
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/xtensa)
>
>  CORE=dc232b
>  CROSS=xtensa-$(CORE)-elf-
>
>  ifndef XT
> -SIM = ../../../xtensa-softmmu/qemu-system-xtensa
> +SIM = $(BUILD_DIR)/xtensa-softmmu/qemu-system-xtensa
>  SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting $(EXTFLAGS) -kernel
>  SIMDEBUG = -s -S
>  else


--
Alex Bennée
