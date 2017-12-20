Received: from eggs.gnu.org ([2001:4830:134:3::10]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyH-0004a8-Hk
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyG-0007Cu-Gg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyG-0007CJ-6n
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:56 -0500
Received: by mail-wm0-x243.google.com with SMTP id f206so11068815wmf.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:31 +0100
Message-Id: <1513790098-9815-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/46] tests/boot-serial-test: Add code to allow
 to specify our own kernel or bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

QEMU only ships with some few firmware images, i.e. we can currently run
the boot-serial test only on a very limited set of machines. But writing
some characters to the default UART of a machine can often be done with
some few lines of assembly, so we add the possibility to the boot-serial
tester to use its own mini-kernels or mini-firmwares. We write such images
then into a file that we can load with the "-kernel" or "-bios" parameter
when we launch QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-3-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   |  2 ++
 tests/boot-serial-test.c | 54 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4bcc87..bbb9d89 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -297,6 +297,8 @@ gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y)
 
 check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
+check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-mips-y = tests/endianness-test$(EXESUF)
 
 check-qtest-mips64-y = tests/endianness-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index fa4183d..d997269 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -7,9 +7,10 @@
  * or later. See the COPYING file in the top-level directory.
  *
  * This test is used to check that the serial output of the firmware
- * (that we provide for some machines) contains an expected string.
- * Thus we check that the firmware still boots at least to a certain
- * point and so we know that the machine is not completely broken.
+ * (that we provide for some machines) or some small mini-kernels that
+ * we provide here contains an expected string. Thus we check that the
+ * firmware/kernel still boots at least to a certain point and so we
+ * know that the machine is not completely broken.
  */
 
 #include "qemu/osdep.h"
@@ -20,6 +21,9 @@ typedef struct testdef {
     const char *machine;    /* Name of the machine */
     const char *extra;      /* Additional parameters */
     const char *expect;     /* Expected string in the serial output */
+    size_t codesize;        /* Size of the kernel or bios data */
+    const uint8_t *kernel;  /* Set in case we use our own mini kernel */
+    const uint8_t *bios;    /* Set in case we use our own mini bios */
 } testdef_t;
 
 static testdef_t tests[] = {
@@ -72,26 +76,52 @@ done:
 static void test_machine(const void *data)
 {
     const testdef_t *test = data;
-    char tmpname[] = "/tmp/qtest-boot-serial-XXXXXX";
-    int fd;
+    char serialtmp[] = "/tmp/qtest-boot-serial-sXXXXXX";
+    char codetmp[] = "/tmp/qtest-boot-serial-cXXXXXX";
+    const char *codeparam = "";
+    const uint8_t *code = NULL;
+    int ser_fd;
 
-    fd = mkstemp(tmpname);
-    g_assert(fd != -1);
+    ser_fd = mkstemp(serialtmp);
+    g_assert(ser_fd != -1);
+
+    if (test->kernel) {
+        code = test->kernel;
+        codeparam = "-kernel";
+    } else if (test->bios) {
+        code = test->bios;
+        codeparam = "-bios";
+    }
+
+    if (code) {
+        ssize_t wlen;
+        int code_fd;
+
+        code_fd = mkstemp(codetmp);
+        g_assert(code_fd != -1);
+        wlen = write(code_fd, code, test->codesize);
+        g_assert(wlen == test->codesize);
+        close(code_fd);
+    }
 
     /*
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    global_qtest = qtest_startf("-M %s,accel=tcg:kvm "
+    global_qtest = qtest_startf("%s %s -M %s,accel=tcg:kvm "
                                 "-chardev file,id=serial0,path=%s "
                                 "-no-shutdown -serial chardev:serial0 %s",
-                                test->machine, tmpname, test->extra);
-    unlink(tmpname);
+                                codeparam, code ? codetmp : "",
+                                test->machine, serialtmp, test->extra);
+    unlink(serialtmp);
+    if (code) {
+        unlink(codetmp);
+    }
 
-    check_guest_output(test, fd);
+    check_guest_output(test, ser_fd);
     qtest_quit(global_qtest);
 
-    close(fd);
+    close(ser_fd);
 }
 
 int main(int argc, char *argv[])
-- 
1.8.3.1
