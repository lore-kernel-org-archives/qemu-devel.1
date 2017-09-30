Received: from eggs.gnu.org ([2001:4830:134:3::10]:49923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyDgD-0003Bi-4P
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyDgA-0003ub-07
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:03:25 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dyDg9-0003tU-Ph
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:03:21 -0400
Received: by mail-pf0-x243.google.com with SMTP id i23so1244181pfi.2
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 02:03:21 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Sat, 30 Sep 2017 02:02:40 -0700
Message-Id: <20170930090240.23729-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] tests/tcg: add write tests for nbyte = 0
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhuoweizhang@yahoo.com, laurent@vivier.eu, peter.maydell@linaro.com, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
List-ID: <qemu-devel.nongnu.org>

rename linux-test so we can get both (32 and 64 bit) versions in a multilib
x86 host.

published as an RFC since the include options that were needed to fix the
build will most likely conflict with scripts/clean-includes

`make check` is unaffected by this new test (which fails in x86_64) and the
rule to automatically run it against qemu-user and diff has been left out
in purpose, not to affect any user of the remaining surrounding tests, but
discussion on how to get tests/tcg back in shape, or if linux-user should
be tested somewhere else is also encouraged

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 include/qemu/cutils.h     |  2 ++
 include/qemu/fprintf-fn.h |  2 ++
 tests/tcg/Makefile        | 11 +++++++----
 tests/tcg/linux-test.c    |  9 ++++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index f0878eaafa..2219942fe0 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_CUTILS_H
 #define QEMU_CUTILS_H
 
+#include <stdbool.h>
+
 #include "qemu/fprintf-fn.h"
 
 /**
diff --git a/include/qemu/fprintf-fn.h b/include/qemu/fprintf-fn.h
index 9068a960b3..80361d87bf 100644
--- a/include/qemu/fprintf-fn.h
+++ b/include/qemu/fprintf-fn.h
@@ -8,6 +8,8 @@
 #ifndef QEMU_FPRINTF_FN_H
 #define QEMU_FPRINTF_FN_H
 
+#include "compiler.h"
+
 typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342f3d..0931ffa6c0 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -18,7 +18,7 @@ LDFLAGS=
 # also, pi_10.com runs indefinitely
 
 I386_TESTS=hello-i386 \
-	   linux-test \
+	   linux-test-i386 \
 	   testthread \
 	   sha1-i386 \
 	   test-i386 \
@@ -47,7 +47,7 @@ run-%: %
 	-$(QEMU) ./$*
 
 run-hello-i386: hello-i386
-run-linux-test: linux-test
+run-linux-test-i386: linux-test-i386
 run-testthread: testthread
 run-sha1-i386: sha1-i386
 
@@ -105,8 +105,11 @@ test-x86_64: test-i386.c \
 	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $(<D)/test-i386.c -lm
 
 # generic Linux and CPU test
-linux-test: linux-test.c
-	$(CC_I386) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
+linux-test-i386: linux-test.c
+	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
+
+linux-test-x86_64: linux-test.c
+	$(CC_X86_64) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
 
 # vm86 test
 runcom: runcom.c
diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
index 5070d31446..dd0a93996f 100644
--- a/tests/tcg/linux-test.c
+++ b/tests/tcg/linux-test.c
@@ -39,6 +39,7 @@
 #include <dirent.h>
 #include <setjmp.h>
 #include <sys/shm.h>
+#include <sys/resource.h>
 #include "qemu/cutils.h"
 
 #define TESTPATH "/tmp/linux-test.tmp"
@@ -107,6 +108,12 @@ void test_file(void)
     len = chk_error(write(fd, buf, FILE_BUF_SIZE / 2));
     if (len != (FILE_BUF_SIZE / 2))
         error("write");
+    len = chk_error(write(fd, buf, 0));
+    if (len != 0)
+        error("write 0 size");
+    len = chk_error(write(fd, NULL, 0));
+    if (len != 0)
+	error("write NULL buf");
     vecs[0].iov_base = buf + (FILE_BUF_SIZE / 2);
     vecs[0].iov_len = 16;
     vecs[1].iov_base = buf + (FILE_BUF_SIZE / 2) + 16;
@@ -533,7 +540,7 @@ int main(int argc, char **argv)
     test_time();
     test_socket();
     //    test_clone();
-    test_signal();
+    //test_signal();
     test_shm();
     return 0;
 }
-- 
2.14.2
