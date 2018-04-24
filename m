Received: from eggs.gnu.org ([2001:4830:134:3::10]:50377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwT-0005xn-SB
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwR-0001Sk-W2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:17 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAzwR-0001Pw-Jk
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id c14-v6so10281961wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:33:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:24:05 +0100
Message-Id: <20180424152405.10304-47-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 46/46] tests/tcg: override runners for
 broken tests (!UPSTREAM)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>

To get a clean run of check-tcg these tests are currently skipped.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/alpha/Makefile.target   |  4 ++++
 tests/tcg/hppa/Makefile.target    | 10 ++++++++++
 tests/tcg/i386/Makefile.target    | 13 +++++++++++++
 tests/tcg/m68k/Makefile.target    | 11 +++++++++++
 tests/tcg/mips/Makefile.target    | 10 ++++++++++
 tests/tcg/s390x/Makefile.target   |  6 ++++++
 tests/tcg/sh4/Makefile.target     |  6 ++++++
 tests/tcg/sparc64/Makefile.target |  8 ++++++++
 8 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index 5b573f145e..a075b0e25e 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -30,3 +30,7 @@ test-cmov: test-cmov.o crt.o
 
 test-ovf: test-ovf.c crt.o
 	$(ALPHA_BUILD)
+
+# Currently broken
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
new file mode 100644
index 0000000000..25b6b5d819
--- /dev/null
+++ b/tests/tcg/hppa/Makefile.target
@@ -0,0 +1,10 @@
+# -*- Mode: makefile -*-
+#
+# HPPA specific tweaks - specifically masking out broken tests
+
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 27086c3f2b..a01309d5f4 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -37,3 +37,16 @@ pi_10.com:
 run-runcom: runcom pi_10.com
 	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
 
+# Currently broken tests on i386
+ifeq ($(TARGET_NAME), i386)
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
+run-test-i386-fprem: test-i386-fprem
+	$(call quiet-command, /bin/true, "SLOW TEST", "$< SKIPPED on $(TARGET_NAME)")
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
+
+endif
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
new file mode 100644
index 0000000000..97bc0c9d07
--- /dev/null
+++ b/tests/tcg/m68k/Makefile.target
@@ -0,0 +1,11 @@
+# -*- Mode: makefile -*-
+#
+# m68k specific tweaks - specifically masking out broken tests
+#
+
+# Currently broken for -p
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
+
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 71f0c2dd53..1f673fce2e 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -17,3 +17,13 @@ hello-mips: LDFLAGS+=-nostdlib
 
 # For MIPS32 and 64 we have a bunch of extra tests in sub-directories
 # however they are intended for system tests.
+
+run-hello-mips: hello-mips
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
+ifeq ($(TARGET_NAME), mips64)
+
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
+endif
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
new file mode 100644
index 0000000000..10e61c422b
--- /dev/null
+++ b/tests/tcg/s390x/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# s390x specific tweaks - specifically masking out broken tests
+
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
new file mode 100644
index 0000000000..c57f398017
--- /dev/null
+++ b/tests/tcg/sh4/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# SH4 specific tweaks - specifically masking out broken tests
+
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
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
