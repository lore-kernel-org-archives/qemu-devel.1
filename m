Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB06A-0005Fx-Og
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB064-0000cB-Uk
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:18 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fB064-0000bn-Is
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:12 -0400
Received: by mail-wm0-x241.google.com with SMTP id a8so1933016wmg.5
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:43:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:55 +0100
Message-Id: <20180424152405.10304-37-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 36/46] tests/tcg/alpha: add Alpha specific
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

These tests are a little strange as they use their own crt.o stub
instead of the system supplied one. We also disable the multiarch
testthread test as that requires a dynamically linked build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/alpha/Makefile         | 35 --------------------------------
 tests/tcg/alpha/Makefile.target  | 32 +++++++++++++++++++++++++++++
 tests/tcg/alpha/{crt.s => crt.S} |  0
 3 files changed, 32 insertions(+), 35 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile
 create mode 100644 tests/tcg/alpha/Makefile.target
 rename tests/tcg/alpha/{crt.s => crt.S} (100%)

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
new file mode 100644
index 0000000000..5b573f145e
--- /dev/null
+++ b/tests/tcg/alpha/Makefile.target
@@ -0,0 +1,32 @@
+# -*- Mode: makefile -*-
+#
+# Alpha specific tweaks
+
+ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
+VPATH+=$(ALPHA_SRC)
+
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf
+TESTS+=$(ALPHA_TESTS)
+
+# Our own minimal crt.o, bypassing gcc's version
+crt.o: CFLAGS+=-ffreestanding
+crt.o: crt.S
+	$(CC) $(CFLAGS) -c $< -o $@
+
+# Alternative build, linking against local crt.o
+ALPHA_BUILD=$(CC) -o $@ crt.o $< -nostdlib
+
+hello-alpha: hello-alpha.c crt.o
+	$(ALPHA_BUILD)
+
+test-cond: test-cond.c crt.o
+	$(ALPHA_BUILD)
+
+test-cmov.o: test-cond.c
+	$(CC) $(CFLAGS) -DTEST_CMOV -c $< -o $@
+
+test-cmov: test-cmov.o crt.o
+	$(ALPHA_BUILD)
+
+test-ovf: test-ovf.c crt.o
+	$(ALPHA_BUILD)
diff --git a/tests/tcg/alpha/crt.s b/tests/tcg/alpha/crt.S
similarity index 100%
rename from tests/tcg/alpha/crt.s
rename to tests/tcg/alpha/crt.S
-- 
2.17.0
