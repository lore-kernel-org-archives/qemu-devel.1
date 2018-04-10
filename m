Received: from eggs.gnu.org ([2001:4830:134:3::10]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z79-0000Hi-4O
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z75-0006NA-UG
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:35 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z75-0006Ma-KV
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:31 -0400
Received: by mail-wm0-x241.google.com with SMTP id x4so25391391wmh.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:04 +0100
Message-Id: <20180410193919.28026-10-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 09/24] tests/tcg: move architecture
 independent tests into subdir
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

We will want to build these for all supported guest architectures so
lets move them all into one place. We also drop test_path at this
point because it needs qemu utils and glib bits which is hard to
support for cross compiling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/README                       |  10 +--
 tests/tcg/multiarch/README             |   1 +
 tests/tcg/{ => multiarch}/linux-test.c |   0
 tests/tcg/{ => multiarch}/sha1.c       |   0
 tests/tcg/{ => multiarch}/test-mmap.c  |   0
 tests/tcg/{ => multiarch}/testthread.c |   0
 tests/tcg/test_path.c                  | 157 ---------------------------------
 7 files changed, 5 insertions(+), 163 deletions(-)
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (100%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (100%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 delete mode 100644 tests/tcg/test_path.c

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
2.16.2
