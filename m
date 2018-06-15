Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugt-0002cb-W7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugq-0005Zd-A8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugq-0005X2-3J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id x4-v6so10958372wro.11
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:26 +0100
Message-Id: <20180615194705.28019-16-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 15/54] tests/tcg: enable building for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

While you can construct a compile command that does work using the
x86_64 host compiler that most people use this is flakey. Different
distros handle this is different ways so we default to using a known
good i386 compiler via docker.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v3
  - add runner for runcom
v4
  - runcom pi10.com directly from SRC_DIR
v5
  - define extra test-mmap runs
---
 tests/tcg/i386/Makefile.include | 9 +++++++++
 tests/tcg/i386/Makefile.target  | 7 +++++++
 2 files changed, 16 insertions(+)
 create mode 100644 tests/tcg/i386/Makefile.include

diff --git a/tests/tcg/i386/Makefile.include b/tests/tcg/i386/Makefile.include
new file mode 100644
index 0000000000..be1c3008dd
--- /dev/null
+++ b/tests/tcg/i386/Makefile.include
@@ -0,0 +1,9 @@
+#
+# Makefile.include for all i386
+#
+# There is enough brokeness in x86_64 compilers that we don't default
+# to using the x86_64 system compiler for i386 binaries.
+#
+
+DOCKER_IMAGE=fedora-i386-cross
+DOCKER_CROSS_COMPILER=gcc
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 2f27b65e2d..8b46cc021e 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -28,3 +28,10 @@ hello-i386: LDFLAGS+=-nostdlib
 test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
+
+# Specialist test runners
+run-runcom: runcom pi_10.com
+	$(call quiet-command, $(QEMU) ./runcom $(I386_SRC)/pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
+
+# On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
+EXTRA_RUNS+=run-test-mmap-4096
-- 
2.17.1
