Received: from eggs.gnu.org ([2001:4830:134:3::10]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugu-0002ce-1q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugp-0005Wg-BD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:23 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:37621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugp-0005Ta-25
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:19 -0400
Received: by mail-wr0-x22e.google.com with SMTP id d8-v6so10979186wro.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:20 +0100
Message-Id: <20180615194705.28019-10-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/54] tests/tcg: move architecture
 independent tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We will want to build these for all supported guest architectures so
lets move them all into one place. We also drop test_path at this
point because it needs qemu utils and glib bits which is hard to
support for cross compiling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - move VPATH and TESTs setup into multiarch/Makefile.target
  - remove moved bits from tests/tcg/Makefile
v3
  - use LDFLAGS+= for testthread linking
v4
  - make myself MAINTAINER for tests/tcg/multiarch
v5
  - split test-mmap into run-test-mmap and run-test-mmap-%
---
 MAINTAINERS                            |   4 +
 tests/tcg/Makefile                     |  31 -----
 tests/tcg/README                       |  10 +-
 tests/tcg/multiarch/Makefile.target    |  36 ++++++
 tests/tcg/multiarch/README             |   1 +
 tests/tcg/{ => multiarch}/linux-test.c |   0
 tests/tcg/{ => multiarch}/sha1.c       |   0
 tests/tcg/{ => multiarch}/test-mmap.c  |   0
 tests/tcg/{ => multiarch}/testthread.c |   0
 tests/tcg/test_path.c                  | 157 -------------------------
 10 files changed, 45 insertions(+), 194 deletions(-)
 create mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (100%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (100%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 delete mode 100644 tests/tcg/test_path.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb5f38f9f..eccd81e8e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -303,6 +303,10 @@ F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
 
+Multiarch Linux User Tests
+M: Alex Bennée <alex.bennee@linaro.org>
+F: tests/tcg/multiarch/
+
 Guest CPU Cores (KVM):
 ----------------------
 
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342f3d..e12395117a 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -18,12 +18,9 @@ LDFLAGS=
 # also, pi_10.com runs indefinitely
 
 I386_TESTS=hello-i386 \
-	   linux-test \
-	   testthread \
 	   sha1-i386 \
 	   test-i386 \
 	   test-i386-fprem \
-	   test-mmap \
 	   # runcom
 
 # native i386 compilers sometimes are not biarch.  assume cross-compilers are
@@ -47,8 +44,6 @@ run-%: %
 	-$(QEMU) ./$*
 
 run-hello-i386: hello-i386
-run-linux-test: linux-test
-run-testthread: testthread
 run-sha1-i386: sha1-i386
 
 run-test-i386: test-i386
@@ -66,11 +61,6 @@ run-test-x86_64: test-x86_64
 	-$(QEMU_X86_64) test-x86_64 > test-x86_64.out
 	@if diff -u test-x86_64.ref test-x86_64.out ; then echo "Auto Test OK"; fi
 
-run-test-mmap: test-mmap
-	-$(QEMU) ./test-mmap
-	-$(QEMU) -p 8192 ./test-mmap 8192
-	-$(QEMU) -p 16384 ./test-mmap 16384
-	-$(QEMU) -p 32768 ./test-mmap 32768
 
 run-runcom: runcom
 	-$(QEMU) ./runcom $(SRC_PATH)/tests/pi_10.com
@@ -80,17 +70,10 @@ run-test_path: test_path
 
 # rules to compile tests
 
-test_path: test_path.o
-
-test_path.o: test_path.c
-
 hello-i386: hello-i386.c
 	$(CC_I386) -nostdlib $(CFLAGS) -static $(LDFLAGS) -o $@ $<
 	strip $@
 
-testthread: testthread.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lpthread
-
 # i386/x86_64 emulation test (test various opcodes) */
 test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S \
            test-i386.h test-i386-shift.h test-i386-muldiv.h
@@ -104,28 +87,14 @@ test-x86_64: test-i386.c \
            test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i386.c -lm
 
-# generic Linux and CPU test
-linux-test: linux-test.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
-
 # vm86 test
 runcom: runcom.c
 	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
 
-test-mmap: test-mmap.c
-	$(CC_I386) -m32 $(CFLAGS) -Wall -O2 $(LDFLAGS) -o $@ $<
-
 # speed test
 sha1-i386: sha1.c
 	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $<
 
-sha1: sha1.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
-
-speed: sha1 sha1-i386
-	time ./sha1
-	time $(QEMU) ./sha1-i386
-
 # arm test
 hello-arm: hello-arm.o
 	arm-linux-ld -o $@ $<
diff --git a/tests/tcg/README b/tests/tcg/README
index 5dcfb4852b..0890044cf0 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -1,9 +1,7 @@
-This directory contains various interesting programs for
-regression testing.
-
-The target "make test" runs the programs and, if applicable,
-runs "diff" to detect mismatches between output on the host and
-output on QEMU.
+This directory contains various interesting guest programs for
+regression testing. Tests are either multi-arch, meaning they can be
+built for all guest architectures that support linux-user executable,
+or they are architecture specific.
 
 i386
 ====
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
new file mode 100644
index 0000000000..90e45a881e
--- /dev/null
+++ b/tests/tcg/multiarch/Makefile.target
@@ -0,0 +1,36 @@
+# -*- Mode: makefile -*-
+#
+# Multiarch Tests - included from tests/tcg/Makefile.target
+#
+# These tests are plain C and built without any architecture specific code.
+#
+
+MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
+
+# Set search path for all sources
+VPATH 		+= $(MULTIARCH_SRC)
+MULTIARCH_SRCS   =$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
+MULTIARCH_TESTS  =$(MULTIARCH_SRCS:.c=)
+
+# Update TESTS
+TESTS		+=$(MULTIARCH_TESTS)
+
+#
+# The following are any additional rules needed to build things
+#
+
+testthread: LDFLAGS+=-lpthread
+
+# We define the runner for test-mmap after the individual
+# architectures have defined their supported pages sizes. If no
+# additional page sizes are defined we only run the default test.
+
+# default case (host page size)
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", \
+		"$< (default) on $(TARGET_NAME)")
+
+# additional page sizes (defined by each architecture adding to EXTRA_RUNS)
+run-test-mmap-%: test-mmap
+	$(call quiet-command, $(QEMU) -p $* $< > test-mmap-$*.out, "TEST", \
+		"$< ($* byte pages) on $(TARGET_NAME)")
diff --git a/tests/tcg/multiarch/README b/tests/tcg/multiarch/README
new file mode 100644
index 0000000000..522c9d2ea3
--- /dev/null
+++ b/tests/tcg/multiarch/README
@@ -0,0 +1 @@
+Multi-architecture linux-user tests
diff --git a/tests/tcg/linux-test.c b/tests/tcg/multiarch/linux-test.c
similarity index 100%
rename from tests/tcg/linux-test.c
rename to tests/tcg/multiarch/linux-test.c
diff --git a/tests/tcg/sha1.c b/tests/tcg/multiarch/sha1.c
similarity index 100%
rename from tests/tcg/sha1.c
rename to tests/tcg/multiarch/sha1.c
diff --git a/tests/tcg/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
similarity index 100%
rename from tests/tcg/test-mmap.c
rename to tests/tcg/multiarch/test-mmap.c
diff --git a/tests/tcg/testthread.c b/tests/tcg/multiarch/testthread.c
similarity index 100%
rename from tests/tcg/testthread.c
rename to tests/tcg/multiarch/testthread.c
diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
deleted file mode 100644
index 1c29bce263..0000000000
--- a/tests/tcg/test_path.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/* Test path override code */
-#include "config-host.h"
-#include "util/cutils.c"
-#include "util/hexdump.c"
-#include "util/iov.c"
-#include "util/path.c"
-#include "util/qemu-timer-common.c"
-#include <stdarg.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-void qemu_log(const char *fmt, ...);
-
-/* Any log message kills the test. */
-void qemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    fprintf(stderr, "FATAL: ");
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-    exit(1);
-}
-
-#define NO_CHANGE(_path)						\
-	do {								\
-	    if (strcmp(path(_path), _path) != 0) return __LINE__;	\
-	} while(0)
-
-#define CHANGE_TO(_path, _newpath)					\
-	do {								\
-	    if (strcmp(path(_path), _newpath) != 0) return __LINE__;	\
-	} while(0)
-
-static void cleanup(void)
-{
-    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE2");
-    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE3");
-    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE4");
-    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE5");
-    rmdir("/tmp/qemu-test_path/DIR1/DIR2");
-    rmdir("/tmp/qemu-test_path/DIR1/DIR3");
-    rmdir("/tmp/qemu-test_path/DIR1");
-    rmdir("/tmp/qemu-test_path");
-}
-
-static unsigned int do_test(void)
-{
-    if (mkdir("/tmp/qemu-test_path", 0700) != 0)
-	return __LINE__;
-
-    if (mkdir("/tmp/qemu-test_path/DIR1", 0700) != 0)
-	return __LINE__;
-
-    if (mkdir("/tmp/qemu-test_path/DIR1/DIR2", 0700) != 0)
-	return __LINE__;
-
-    if (mkdir("/tmp/qemu-test_path/DIR1/DIR3", 0700) != 0)
-	return __LINE__;
-
-    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE", 0600)) != 0)
-	return __LINE__;
-
-    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE2", 0600)) != 0)
-	return __LINE__;
-
-    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE3", 0600)) != 0)
-	return __LINE__;
-
-    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE4", 0600)) != 0)
-	return __LINE__;
-
-    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE5", 0600)) != 0)
-	return __LINE__;
-
-    init_paths("/tmp/qemu-test_path");
-
-    NO_CHANGE("/tmp");
-    NO_CHANGE("/tmp/");
-    NO_CHANGE("/tmp/qemu-test_path");
-    NO_CHANGE("/tmp/qemu-test_path/");
-    NO_CHANGE("/tmp/qemu-test_path/D");
-    NO_CHANGE("/tmp/qemu-test_path/DI");
-    NO_CHANGE("/tmp/qemu-test_path/DIR");
-    NO_CHANGE("/tmp/qemu-test_path/DIR1");
-    NO_CHANGE("/tmp/qemu-test_path/DIR1/");
-
-    NO_CHANGE("/D");
-    NO_CHANGE("/DI");
-    NO_CHANGE("/DIR");
-    NO_CHANGE("/DIR2");
-    NO_CHANGE("/DIR1.");
-
-    CHANGE_TO("/DIR1", "/tmp/qemu-test_path/DIR1");
-    CHANGE_TO("/DIR1/", "/tmp/qemu-test_path/DIR1");
-
-    NO_CHANGE("/DIR1/D");
-    NO_CHANGE("/DIR1/DI");
-    NO_CHANGE("/DIR1/DIR");
-    NO_CHANGE("/DIR1/DIR1");
-
-    CHANGE_TO("/DIR1/DIR2", "/tmp/qemu-test_path/DIR1/DIR2");
-    CHANGE_TO("/DIR1/DIR2/", "/tmp/qemu-test_path/DIR1/DIR2");
-
-    CHANGE_TO("/DIR1/DIR3", "/tmp/qemu-test_path/DIR1/DIR3");
-    CHANGE_TO("/DIR1/DIR3/", "/tmp/qemu-test_path/DIR1/DIR3");
-
-    NO_CHANGE("/DIR1/DIR2/F");
-    NO_CHANGE("/DIR1/DIR2/FI");
-    NO_CHANGE("/DIR1/DIR2/FIL");
-    NO_CHANGE("/DIR1/DIR2/FIL.");
-
-    CHANGE_TO("/DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/DIR2/FILE2", "/tmp/qemu-test_path/DIR1/DIR2/FILE2");
-    CHANGE_TO("/DIR1/DIR2/FILE3", "/tmp/qemu-test_path/DIR1/DIR2/FILE3");
-    CHANGE_TO("/DIR1/DIR2/FILE4", "/tmp/qemu-test_path/DIR1/DIR2/FILE4");
-    CHANGE_TO("/DIR1/DIR2/FILE5", "/tmp/qemu-test_path/DIR1/DIR2/FILE5");
-
-    NO_CHANGE("/DIR1/DIR2/FILE6");
-    NO_CHANGE("/DIR1/DIR2/FILE/X");
-
-    CHANGE_TO("/DIR1/../DIR1", "/tmp/qemu-test_path/DIR1");
-    CHANGE_TO("/DIR1/../DIR1/", "/tmp/qemu-test_path/DIR1");
-    CHANGE_TO("/../DIR1", "/tmp/qemu-test_path/DIR1");
-    CHANGE_TO("/../DIR1/", "/tmp/qemu-test_path/DIR1");
-    CHANGE_TO("/DIR1/DIR2/../DIR2", "/tmp/qemu-test_path/DIR1/DIR2");
-    CHANGE_TO("/DIR1/DIR2/../DIR2/../../DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/DIR2/../DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-
-    NO_CHANGE("/DIR1/DIR2/../DIR1");
-    NO_CHANGE("/DIR1/DIR2/../FILE");
-
-    CHANGE_TO("/./DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/././DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/./DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/././DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/DIR2/./FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/DIR1/DIR2/././FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-    CHANGE_TO("/./DIR1/./DIR2/./FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
-
-    return 0;
-}
-
-int main(int argc, char *argv[])
-{
-    int ret;
-
-    ret = do_test();
-    cleanup();
-    if (ret) {
-	fprintf(stderr, "test_path: failed on line %i\n", ret);
-	return 1;
-    }
-    return 0;
-}
-- 
2.17.1
