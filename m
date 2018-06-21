Received: from eggs.gnu.org ([2001:4830:134:3::10]:56941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtIH-00056F-6H
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtIG-0003U2-Ai
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:09 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtIG-0003Tb-4J
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:08 -0400
Received: by mail-wm0-x244.google.com with SMTP id o13-v6so3143380wmf.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:42:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:24 +0100
Message-Id: <20180621062605.941-17-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 16/57] tests/tcg: enable building for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

While you can construct a compile command that does work using the
x86_64 host compiler that most people use this is flakey. Different
distros handle this is different ways so we default to using a known
good i386 compiler via docker.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
