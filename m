Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI8-0004vZ-FW
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI6-0003Lj-Sk
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtI6-0003L8-Kn
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:58 -0400
Received: by mail-wm0-x241.google.com with SMTP id v131-v6so3696949wma.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:41:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:43 +0100
Message-Id: <20180621062605.941-36-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 35/57] tests/tcg/alpha: add Alpha specific
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

These tests did use their own crt.o stub however that is a little
stone age so we drop crt.S and just statically link to the cross
compilers libraries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/tcg/alpha/Makefile b/tests/tcg/alpha/Makefile
deleted file mode 100644
index 2b1f03d048..0000000000
--- a/tests/tcg/alpha/Makefile
+++ /dev/null
@@ -1,35 +0,0 @@
-CROSS=alpha-linux-gnu-
-CC=$(CROSS)gcc
-AS=$(CROSS)as
-
-SIM=../../alpha-linux-user/qemu-alpha
-
-CFLAGS=-O
-LINK=$(CC) -o $@ crt.o $< -nostdlib
-
-TESTS=test-cond test-cmov
-
-all: hello-alpha $(TESTS)
-
-hello-alpha: hello-alpha.o crt.o
-	$(LINK)
-
-test-cond: test-cond.o crt.o
-	$(LINK)
-
-test-cmov.o: test-cond.c
-	$(CC) -c $(CFLAGS) -DTEST_CMOV -o $@ $<
-
-test-cmov: test-cmov.o crt.o
-	$(LINK)
-
-test-ovf: test-ovf.o crt.o
-	$(LINK)
-
-check: $(TESTS)
-	for f in $(TESTS); do $(SIM) $$f || exit 1; done
-
-clean:
-	$(RM) *.o *~ hello-alpha $(TESTS)
-
-.PHONY: clean all check
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index bedf1b6444..a585080328 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -2,5 +2,17 @@
 #
 # Alpha specific tweaks
 
+ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
+VPATH+=$(ALPHA_SRC)
+
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf
+TESTS+=$(ALPHA_TESTS)
+
+test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
+test-cmov: test-cond.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-test-cmov: test-cmov
+
 # On Alpha Linux only supports 8k pages
 EXTRA_RUNS+=run-test-mmap-8192
diff --git a/tests/tcg/alpha/crt.s b/tests/tcg/alpha/crt.s
deleted file mode 100644
index 31af8825bc..0000000000
--- a/tests/tcg/alpha/crt.s
+++ /dev/null
@@ -1,26 +0,0 @@
-	.text
-
-	.globl _start
-	.ent _start,0
-_start:
-	.frame $15,0,$15
-	br $29,1f
-1:	ldgp $29, 0($29)
-	.prologue 0
-	ldq $27,main($29) !literal!1
-	jsr $26,($27)
-	or $0,$0,$16
-	.end _start
-
-	.globl _exit
-_exit:
-	lda $0,1
-	callsys
-
-	call_pal 0
-
-	.globl write
-write:
-	lda $0,4
-	callsys
-	ret
diff --git a/tests/tcg/alpha/hello-alpha.c b/tests/tcg/alpha/hello-alpha.c
index 79892e6522..84e43b2fc4 100644
--- a/tests/tcg/alpha/hello-alpha.c
+++ b/tests/tcg/alpha/hello-alpha.c
@@ -1,3 +1,5 @@
+#include <unistd.h>
+
 int main (void)
 {
   write (1, "hello\n", 6);
diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
index 74adffaa69..e625313b3e 100644
--- a/tests/tcg/alpha/test-cond.c
+++ b/tests/tcg/alpha/test-cond.c
@@ -1,3 +1,4 @@
+#include <unistd.h>
 
 #ifdef TEST_CMOV
 
diff --git a/tests/tcg/alpha/test-ovf.c b/tests/tcg/alpha/test-ovf.c
index 01c80e7525..17892f1e89 100644
--- a/tests/tcg/alpha/test-ovf.c
+++ b/tests/tcg/alpha/test-ovf.c
@@ -1,3 +1,5 @@
+#include <unistd.h>
+
 static long test_subqv (long a, long b)
 {
   long res;
-- 
2.17.1
