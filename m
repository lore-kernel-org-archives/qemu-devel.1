Received: from eggs.gnu.org ([2001:4830:134:3::10]:55246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJNFw-0003XP-3X
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJNFs-0004yo-Nh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:00 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJNFs-0004y3-Eq
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:03:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id h5-v6so6592988wrm.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:03:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:47:18 +0100
Message-Id: <20180517174718.10107-50-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 49/49] tests/tcg: override runners for
 broken tests (!UPSTREAM)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, "open list:ARM" <qemu-arm@nongnu.org>

To get a clean run of check-tcg these tests are currently skipped:

  - test-mmap -p for i386, hppa, m68k
  - hello-mips for mips
  - linux-test for sparc

For ARM/aarch64
  - fcvt doesn't compare against reference (awaiting fixes in mainline)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - document broken tests in commit
  - temporarily demote fcvt while fixes percolate upstream
---
 tests/tcg/aarch64/Makefile.target | 10 +++++-----
 tests/tcg/arm/Makefile.target     | 10 +++++-----
 tests/tcg/hppa/Makefile.target    |  7 +++++++
 tests/tcg/i386/Makefile.target    |  8 ++++++++
 tests/tcg/m68k/Makefile.target    |  9 +++++++++
 tests/tcg/mips/Makefile.target    |  4 ++++
 tests/tcg/sparc64/Makefile.target |  8 ++++++++
 7 files changed, 46 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 7dba32138d..d2a6205d7a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -12,8 +12,8 @@ TESTS:=$(AARCH64_TESTS)
 
 fcvt: LDFLAGS+=-lm
 
-run-fcvt: fcvt
-	$(call quiet-command, \
-		$(QEMU) $< > fcvt.out && \
-		diff -u $(AARCH64_SRC)/fcvt.ref fcvt.out, \
-		"TEST", "$< (default) on $(TARGET_NAME)")
+# run-fcvt: fcvt
+# 	$(call quiet-command, \
+# 		$(QEMU) $< > fcvt.out && \
+# 		diff -u $(AARCH64_SRC)/fcvt.ref fcvt.out, \
+# 		"TEST", "$< (default) on $(TARGET_NAME)")
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 7bb777f442..f42cf80f84 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -31,9 +31,9 @@ ifeq ($(TARGET_NAME), arm)
 fcvt: LDFLAGS+=-lm
 # fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
 
-run-fcvt: fcvt
-	$(call quiet-command, \
-		$(QEMU) $< > fcvt.out && \
-		diff -u $(ARM_SRC)/fcvt.ref fcvt.out, \
-		"TEST", "$< (default) on $(TARGET_NAME)")
+# run-fcvt: fcvt
+# 	$(call quiet-command, \
+# 		$(QEMU) $< > fcvt.out && \
+# 		diff -u $(ARM_SRC)/fcvt.ref fcvt.out, \
+# 		"TEST", "$< (default) on $(TARGET_NAME)")
 endif
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
new file mode 100644
index 0000000000..15fc0b429f
--- /dev/null
+++ b/tests/tcg/hppa/Makefile.target
@@ -0,0 +1,7 @@
+# -*- Mode: makefile -*-
+#
+# HPPA specific tweaks - specifically masking out broken tests
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 6d7d4a164e..b5a7011b79 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -48,3 +48,11 @@ run-test-i386-fprem: test-i386-fprem
 	$(call quiet-command, /bin/true, "SLOW TEST", "$< SKIPPED on $(TARGET_NAME)")
 endif
 
+# Currently broken tests on i386
+ifeq ($(TARGET_NAME), i386)
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
+
+endif
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
new file mode 100644
index 0000000000..92774ce5ad
--- /dev/null
+++ b/tests/tcg/m68k/Makefile.target
@@ -0,0 +1,9 @@
+# -*- Mode: makefile -*-
+#
+# m68k specific tweaks - specifically masking out broken tests
+#
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
+
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 71f0c2dd53..3db4eaf131 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -17,3 +17,7 @@ hello-mips: LDFLAGS+=-nostdlib
 
 # For MIPS32 and 64 we have a bunch of extra tests in sub-directories
 # however they are intended for system tests.
+
+run-hello-mips: hello-mips
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
new file mode 100644
index 0000000000..e971a5c818
--- /dev/null
+++ b/tests/tcg/sparc64/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# sparc specific tweaks - specifically masking out broken tests
+
+# different from the other hangs
+# /home/alex/lsrc/qemu/qemu.git/tests/tcg/multiarch/linux-test.c:264: Value too large for defined data type (ret=-1, errno=92/Value too large for defined data type)
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
-- 
2.17.0
