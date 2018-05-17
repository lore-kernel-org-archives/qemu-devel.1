Received: from eggs.gnu.org ([2001:4830:134:3::10]:52676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6K-0003Ce-GC
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6I-00078P-Ij
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:04 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN6I-00077t-9X
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id f6-v6so9925232wmc.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:54:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:47:15 +0100
Message-Id: <20180517174718.10107-47-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 46/49] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This make is now invoked from each individual target make with the
appropriate CC and EXTRA_CFLAGS set for each guest. It then includes
additional Makefile.targets from:

  - tests/tcg/multiarch (always)
  - tests/tcg/$(TARGET_BASE_ARCH) (if available)
  - tests/tcg/$(TARGET_NAME)

The order is important as the later Makefile's may want to suppress
TESTS from its base arch profile. Each included Makefile.target is
responsible for adding TESTS as well as defining any special build
instructions for individual tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - cleaner approach to include sub makefiles
  - move TESTS/VPATH manipulation into sub-makefile
  - avoid double inclusion when TARGET_BASE_ARCH==TARGET_NAME
v4
  - add timeout to default runner
  - clean-up comments about build flags
  - update to handle BUILD_STATIC
  - add MAINTAINERS entry
---
 MAINTAINERS        |   5 ++
 tests/tcg/Makefile | 177 ++++++++++++++++++---------------------------
 2 files changed, 74 insertions(+), 108 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee7f101890..ae569f9cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2107,6 +2107,11 @@ W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
+Guest Test Compilation Support
+M: Alex Bennée <alex.bennee@linaro.org>
+F: tests/tcg/Makefile
+L: qemu-devel@nongnu.org
+
 Documentation
 -------------
 Build system architecture
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index e12395117a..f2dcfc730a 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -1,125 +1,86 @@
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
+# bother with the common rules.mk. We expect the following:
+#
+#   CC - the C compiler command
+#   EXTRA_CFLAGS - any extra CFLAGS
+#   BUILD_STATIC - are we building static binaries
+#
+# By default all tests are statically compiled but some host systems
+# may not package static libraries by default. If an external
+# cross-compiler can only build dynamic libraries the user might need
+# to make extra efforts to ensure ld.so can link at runtime when the
+# tests are run.
+#
+# We also accept SPEED=slow to enable slower running tests
+#
+# We also expect to be in the tests build dir for the FOO-linux-user.
+#
+
 -include ../../config-host.mak
--include $(SRC_PATH)/rules.mak
+-include ../config-target.mak
 
-$(call set-vpath, $(SRC_PATH)/tests/tcg)
+quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
 
-QEMU=../../i386-linux-user/qemu-i386
-QEMU_X86_64=../../x86_64-linux-user/qemu-x86_64
-CC_X86_64=$(CC_I386) -m64
+# Tests we are building
+TESTS=
 
-QEMU_INCLUDES += -I../..
-CFLAGS=-Wall -O2 -g -fno-strict-aliasing
-#CFLAGS+=-msse2
+# Start with a blank slate, the build targets get to add stuff first
+CFLAGS=
+QEMU_CFLAGS=
 LDFLAGS=
 
-# TODO: automatically detect ARM and MIPS compilers, and run those too
-
-# runcom maps page 0, so it requires root privileges
-# also, pi_10.com runs indefinitely
-
-I386_TESTS=hello-i386 \
-	   sha1-i386 \
-	   test-i386 \
-	   test-i386-fprem \
-	   # runcom
+# The QEMU for this TARGET
+QEMU=../qemu-$(TARGET_NAME)
+TIMEOUT=15
 
-# native i386 compilers sometimes are not biarch.  assume cross-compilers are
-ifneq ($(ARCH),i386)
-I386_TESTS+=run-test-x86_64
+# The order we include is important. We include multiarch, base arch
+# and finally arch if it's not the same as base arch.
+-include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
+-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
+ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 endif
 
-TESTS = test_path
-ifneq ($(call find-in-path, $(CC_I386)),)
-TESTS += $(I386_TESTS)
+# Add the common build options
+CFLAGS+=-Wall -O0 -g -fno-strict-aliasing
+ifeq ($(BUILD_STATIC),y)
+LDFLAGS+=-static
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
+%: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-run-runcom: runcom
-	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
+all: $(TESTS)
 
-run-test_path: test_path
-	./test_path
+#
+# Test Runners
+#
+# By default we just run the test with the appropriate QEMU for the
+# target. More advanced tests may want to override the runner in their
+# specific make rules.
+#
 
-# rules to compile tests
+RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 
-hello-i386: hello-i386.c
-	$(CC_I386) -nostdlib $(CFLAGS) -static $(LDFLAGS) -o $@ $<
-	strip $@
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
-# vm86 test
-runcom: runcom.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
-
-# speed test
-sha1-i386: sha1.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
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
-
-# testsuite for the CRIS port.
-test-cris:
-	$(MAKE) -C cris check
+run-%: %
+	$(call quiet-command, \
+		timeout $(TIMEOUT) $(QEMU) $< > $<.out, \
+		"TEST", "$< on $(TARGET_NAME)")
 
-# testsuite for the LM32 port.
-test-lm32:
-	$(MAKE) -C lm32 check
+.PHONY: run
+run: $(RUN_TESTS)
 
-clean:
-	rm -f *~ *.o test-i386.out test-i386.ref \
-           test-x86_64.log test-x86_64.ref qruncom $(TESTS)
+# There is no clean target, the calling make just rm's the tests build dir
-- 
2.17.0
