Received: from eggs.gnu.org ([2001:4830:134:3::10]:52711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFQ6-0006Rj-SA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFQ0-000138-8E
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPz-00011a-W4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:17:00 +0800
Message-Id: <20170908091700.14867-8-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 7/7] tests: Move i386 tcg tests to check-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

Only enable the tests if i386-linux-user is a specified target in
configure, and build the test programs with "docker.py cc" command.

Also change the "diff -u" to "cmp -s" because we have really huge output
to compare.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/tcg/Makefile         | 60 -------------------------------------
 tests/tcg/Makefile.include | 74 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 61 deletions(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342f3d..4a2b069304 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -17,15 +17,6 @@ LDFLAGS=
 # runcom maps page 0, so it requires root privileges
 # also, pi_10.com runs indefinitely
 
-I386_TESTS=hello-i386 \
-	   linux-test \
-	   testthread \
-	   sha1-i386 \
-	   test-i386 \
-	   test-i386-fprem \
-	   test-mmap \
-	   # runcom
-
 # native i386 compilers sometimes are not biarch.  assume cross-compilers are
 ifneq ($(ARCH),i386)
 I386_TESTS+=run-test-x86_64
@@ -46,35 +37,11 @@ test: all
 run-%: %
 	-$(QEMU) ./$*
 
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
 run-test-x86_64: test-x86_64
 	./test-x86_64 > test-x86_64.ref
 	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
 	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK"; fi
 
-run-test-mmap: test-mmap
-	-$(QEMU) ./test-mmap
-	-$(QEMU) -p 8192 ./test-mmap 8192
-	-$(QEMU) -p 16384 ./test-mmap 16384
-	-$(QEMU) -p 32768 ./test-mmap 32768
-
-run-runcom: runcom
-	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
-
 run-test_path: test_path
 	./test_path
 
@@ -84,37 +51,10 @@ test_path: test_path.o
 
 test_path.o: test_path.c
 
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
 test-x86_64: test-i386.c \
            test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i386.c -lm
 
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
 # speed test
 sha1-i386: sha1.c
 	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index e5fea1c8c5..64f1a4a003 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -1,3 +1,75 @@
 
-check-tcg:
+TCG_I386_TESTS := \
+	hello-i386 \
+	linux-test \
+	testthread \
+	sha1-i386 \
+	test-i386 \
+	test-i386-fprem \
+	test-mmap \
+	# runcom
+
+$(addprefix tests/tcg/, $(TCG_I386_TESTS)): DOCKER_IMAGE := fedora-i386-cross
+$(addprefix tests/tcg/, $(TCG_I386_TESTS)): CFLAGS := -m32 -I/usr/lib/glib-2.0/include/ -I/usr/include/glib-2.0 -Wall -O2 -g -fno-strict-aliasing $(QEMU_INCLUDES)
+$(addprefix tests/tcg/, $(TCG_I386_TESTS)): QEMU_CFLAGS :=
+$(addprefix tests/tcg/, $(TCG_I386_TESTS)): LDFLAGS :=
+$(addprefix tests/tcg/, $(TCG_I386_TESTS)): QEMU_LDFLAGS :=
+
+check-tcg-i386: $(addprefix tcg-run-,$(TCG_I386_TESTS))
+$(addprefix tcg-run-,$(TCG_I386_TESTS)): QEMU := i386-linux-user/qemu-i386
+$(addprefix tcg-run-,$(TCG_I386_TESTS)): i386-linux-user/qemu-i386
+
+TCG_SIMPLE_TESTS := \
+	hello-i386 \
+	linux-test \
+	testthread \
+	sha1-i386
+
+$(foreach t,$(TCG_SIMPLE_TESTS), \
+	$(eval tcg-run-$t: tcg-runsimple-$t))
+
+tcg-runsimple-%: tests/tcg/%$(EXESUF)
+	-$(QEMU) $<
+
+TCG_CMP_TESTS := \
+	test-i386 \
+	test-i386-fprem
+
+$(foreach t,$(TCG_CMP_TESTS), \
+	$(eval tcg-run-$t: tcg-runcmp-$t))
+
+tcg-runcmp-%: tests/tcg/%$(EXESUF)
+	$< > $<.ref
+	-$(QEMU) $< > $<.out
+	@if cmp -s $<.ref $<.out ; then echo "Auto Test OK"; fi
+
+tcg-run-test-mmap: tests/tcg/test-mmap
+	-$(QEMU) $<
+	-$(QEMU) -p 8192 $< 8192
+	-$(QEMU) -p 16384 $< 16384
+	-$(QEMU) -p 32768 $< 32768
+
+tcg-run-runcom: tests/tcg/runcom
+	-$(QEMU) $< $(SRC_PATH)/tests/tcg/pi_10.com
+
+TCG_TESTS = $(if $(filter i386-linux-user, $(TARGET_LIST)), $(TCG_I386_TESTS))
+
+$(addprefix tests/tcg/, $(TCG_TESTS)): CXX :=
+$(addprefix tests/tcg/, $(TCG_TESTS)): CC := \
+	$(SRC_PATH)/tests/docker/docker.py cc -i qemu:$(DOCKER_IMAGE) -s $(SRC_PATH) --
+
+tests/tcg/hello-i386: LDFLAGS := -nostdlib
+
+tests/tcg/sha1-i386: tests/tcg/sha1.o
+	$(call LINK, $^)
+
+tests/tcg/test-i386: $(addprefix $(SRC_PATH)/tests/tcg/, \
+			test-i386.c test-i386-code16.S test-i386-vm86.S \
+           test-i386.h test-i386-shift.h test-i386-muldiv.h)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+              $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
+
+.PHONY: check-tcg $(patsubst %,run-%,$(TCG_TESTS))
+
+check-tcg: $(addprefix tcg-run-, $(TCG_TESTS))
 	$(MAKE) -C tests/tcg test
-- 
2.13.5
