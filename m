Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyL-0000e5-KM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyJ-0007r9-Oc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:25 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyJ-0007q2-Gq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:23 -0400
Received: by mail-wr0-x242.google.com with SMTP id v13-v6so10979558wrp.13
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:45 +0100
Message-Id: <20180615194705.28019-35-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 34/54] tests/tcg/alpha: add Alpha specific
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

These tests did use their own crt.o stub however that is a little
stone age so we drop crt.S and just statically link to the cross
compilers libraries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4
  - drop crt.s
  - drop skipping of threadtest
  - drop write() hack, include unistd.h
v5
  - merge fixes
---
 tests/tcg/alpha/Makefile        | 35 ---------------------------------
 tests/tcg/alpha/Makefile.target | 12 +++++++++++
 tests/tcg/alpha/crt.s           | 26 ------------------------
 tests/tcg/alpha/hello-alpha.c   |  2 ++
 tests/tcg/alpha/test-cond.c     |  1 +
 tests/tcg/alpha/test-ovf.c      |  2 ++
 6 files changed, 17 insertions(+), 61 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile
 delete mode 100644 tests/tcg/alpha/crt.s

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
