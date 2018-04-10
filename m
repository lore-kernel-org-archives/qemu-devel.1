Received: from eggs.gnu.org ([2001:4830:134:3::10]:49753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC6-0004x7-9b
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC4-0001C8-52
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:42 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5zC3-0001Aw-PL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:40 -0400
Received: by mail-wm0-x241.google.com with SMTP id t67so28651197wmt.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:44:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:17 +0100
Message-Id: <20180410193919.28026-23-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 22/24] tests/tcg/Makefile: update to be
 called from Makefile.target
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

This make is now invoked from each individual target make with the
appropriate CC and ARCH set for each guest. It includes all the
multiarch tests by default as well as any tests from
tests/tcg/$(ARCH).

As there may be subtle additional requirements for building some of
the tests it also includes tests/tcg/$(ARCH)/Makefile.target if it is
available. This is distinct from tests/tcg/$(ARCH)/Makefile.include
which is used by the parent make machinery to determine potential
docker targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile | 185 ++++++++++++-----------------------------------------
 1 file changed, 42 insertions(+), 143 deletions(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342f3d..2bba0d2a32 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -1,156 +1,55 @@
--include ../../config-host.mak
--include $(SRC_PATH)/rules.mak
+# -*- Mode: makefile -*-
+#
+# TCG tests
+#
+# These are complicated by the fact we want to build them for guest
+# systems. This requires knowing what guests we are building and which
+# ones we have cross-compilers for or docker images with
+# cross-compilers.
+#
+# The tests themselves should be as minimal as possible as
+# cross-compilers don't always have a large amount of libraries
+# available.
+#
+# We only include the host build system for SRC_PATH and we don't
+# bother with the common rules.mk. We expect CC to have been set for
+# us from the parent make. We also expect to be in the tests build dir
+# for the FOO-linux-user.
+#
 
-$(call set-vpath, $(SRC_PATH)/tests/tcg)
+-include ../../config-host.mak
+-include ../config-target.mak
 
-QEMU=../../i386-linux-user/qemu-i386
-QEMU_X86_64=../../x86_64-linux-user/qemu-x86_64
-CC_X86_64=$(CC_I386) -m64
+# Set search path for all sources
+VPATH = $(SRC_PATH)/tests/tcg/multiarch
+TEST_SRCS = $(wildcard $(SRC_PATH)/tests/tcg/multiarch/*.c)
 
-QEMU_INCLUDES += -I../..
-CFLAGS=-Wall -O2 -g -fno-strict-aliasing
-#CFLAGS+=-msse2
-LDFLAGS=
+VPATH     += $(SRC_PATH)/tests/tcg/$(ARCH)
+TEST_SRCS += $(wildcard $(SRC_PATH)/tests/tcg/$(ARCH)/*.c)
 
-# TODO: automatically detect ARM and MIPS compilers, and run those too
+SRCS=$(notdir ${TEST_SRCS})
+TESTS=$(SRCS:.c=)
 
-# runcom maps page 0, so it requires root privileges
-# also, pi_10.com runs indefinitely
+# We use what ever CC we have
+CFLAGS=-Wall -O0 -g -fno-strict-aliasing -static
+QEMU_CFLAGS=
+LDFLAGS=
 
-I386_TESTS=hello-i386 \
-	   linux-test \
-	   testthread \
-	   sha1-i386 \
-	   test-i386 \
-	   test-i386-fprem \
-	   test-mmap \
-	   # runcom
+# The per ARCH target makefile which might add specific compiler flags
+# for some compilation targets.
 
-# native i386 compilers sometimes are not biarch.  assume cross-compilers are
-ifneq ($(ARCH),i386)
-I386_TESTS+=run-test-x86_64
-endif
+EXTRA_MAKEFILE=$(SRC_PATH)/tests/tcg/$(ARCH)/Makefile.target
+CHECK_INCLUDE=$(wildcard $(EXTRA_MAKEFILE))
 
-TESTS = test_path
-ifneq ($(call find-in-path, $(CC_I386)),)
-TESTS += $(I386_TESTS)
+ifeq ($(EXTRA_MAKEFILE),$(CHECK_INCLUDE))
+include $(EXTRA_MAKEFILE)
 endif
 
-all: $(patsubst %,run-%,$(TESTS))
-test: all
-
-# rules to run tests
-
-.PHONY: $(patsubst %,run-%,$(TESTS))
-
-run-%: %
-	-$(QEMU) ./$*
-
-run-hello-i386: hello-i386
-run-linux-test: linux-test
-run-testthread: testthread
-run-sha1-i386: sha1-i386
-
-run-test-i386: test-i386
-	./test-i386 > test-i386.ref
-	-$(QEMU) test-i386 > test-i386.out
-	@if diff -u test-i386.ref test-i386.out ; then echo "Auto Test OK"; fi
-
-run-test-i386-fprem: test-i386-fprem
-	./test-i386-fprem > test-i386-fprem.ref
-	-$(QEMU) test-i386-fprem > test-i386-fprem.out
-	@if diff -u test-i386-fprem.ref test-i386-fprem.out ; then echo "Auto Test OK"; fi
-
-run-test-x86_64: test-x86_64
-	./test-x86_64 > test-x86_64.ref
-	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
-	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK"; fi
-
-run-test-mmap: test-mmap
-	-$(QEMU) ./test-mmap
-	-$(QEMU) -p 8192 ./test-mmap 8192
-	-$(QEMU) -p 16384 ./test-mmap 16384
-	-$(QEMU) -p 32768 ./test-mmap 32768
-
-run-runcom: runcom
-	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
-
-run-test_path: test_path
-	./test_path
-
-# rules to compile tests
-
-test_path: test_path.o
-
-test_path.o: test_path.c
-
-hello-i386: hello-i386.c
-	$(CC_I386) -nostdlib $(CFLAGS) -static $(LDFLAGS) -o $@ $<
-	strip $@
-
-testthread: testthread.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lpthread
-
-# i386/x86_64 emulation test (test various opcodes) */
-test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S \
-           test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ \
-              $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
-
-test-i386-fprem: test-i386-fprem.c
-	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $^
-
-test-x86_64: test-i386.c \
-           test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i386.c -lm
-
-# generic Linux and CPU test
-linux-test: linux-test.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
-
-# vm86 test
-runcom: runcom.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
-
-test-mmap: test-mmap.c
-	$(CC_I386) -m32 $(CFLAGS) -Wall -O2 $(LDFLAGS) -o $@ $<
-
-# speed test
-sha1-i386: sha1.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
-
-sha1: sha1.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
-
-speed: sha1 sha1-i386
-	time ./sha1
-	time $(QEMU) ./sha1-i386
-
-# arm test
-hello-arm: hello-arm.o
-	arm-linux-ld -o $@ $<
-
-hello-arm.o: hello-arm.c
-	arm-linux-gcc -Wall -g -O2 -c -o $@ $<
-
-test-arm-iwmmxt: test-arm-iwmmxt.s
-	cpp < $< | arm-linux-gnu-gcc -Wall -static -march=iwmmxt -mabi=aapcs -x assembler - -o $@
-
-# MIPS test
-hello-mips: hello-mips.c
-	mips-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=32 -Wall -Wextra -g -O2 -o $@ $<
-
-hello-mipsel: hello-mips.c
-	mipsel-linux-gnu-gcc -nostdlib -static -mno-abicalls -fno-PIC -mabi=32 -Wall -Wextra -g -O2 -o $@ $<
+testthread: LDFLAGS=-lpthread
 
-# testsuite for the CRIS port.
-test-cris:
-	$(MAKE) -C cris check
+%: %.c
+	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-# testsuite for the LM32 port.
-test-lm32:
-	$(MAKE) -C lm32 check
+all: $(TESTS)
 
-clean:
-	rm -f *~ *.o test-i386.out test-i386.ref \
-           test-x86_64.log test-x86_64.ref qruncom $(TESTS)
+# There is no clean target, the calling make just rm's the tests build dir
-- 
2.16.2
