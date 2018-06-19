Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoM-0006e0-J1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoK-0006Qr-5o
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:50 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoJ-0006Pw-Rs
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id o13-v6so1148029wmf.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:53 +0100
Message-Id: <20180619154435.18898-15-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/56] tests/tcg: move i386 specific tests into
 subdir
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

These only need to be built for i386 guests. This includes a stub
tests/tcg/i386/Makfile.target which absorbs some of what was in
tests/tcg/Makefile.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - move VPATH and TESTs setup into i386/Makefile.target
  - set CFLAGS+=-m32 for cross building
v4
  - update MAINATINERS

diff --git a/MAINTAINERS b/MAINTAINERS
index eccd81e8e7..ea298cc910 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -283,6 +283,7 @@ M: Richard Henderson <rth@twiddle.net>
 M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: target/i386/
+F: tests/tcg/i386/
 F: hw/i386/
 F: disas/i386.c
 T: git git://github.com/ehabkost/qemu.git x86-next
diff --git a/tests/tcg/README b/tests/tcg/README
index 0890044cf0..469504c4cb 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -3,45 +3,6 @@ regression testing. Tests are either multi-arch, meaning they can be
 built for all guest architectures that support linux-user executable,
 or they are architecture specific.
 
-i386
-====
-
-test-i386
----------
-
-This program executes most of the 16 bit and 32 bit x86 instructions and
-generates a text output, for comparison with the output obtained with
-a real CPU or another emulator.
-
-The Linux system call modify_ldt() is used to create x86 selectors
-to test some 16 bit addressing and 32 bit with segmentation cases.
-
-The Linux system call vm86() is used to test vm86 emulation.
-
-Various exceptions are raised to test most of the x86 user space
-exception reporting.
-
-linux-test
-----------
-
-This program tests various Linux system calls. It is used to verify
-that the system call parameters are correctly converted between target
-and host CPUs.
-
-test-i386-fprem
----------------
-
-runcom
-------
-
-test-mmap
----------
-
-sha1
-----
-
-hello-i386
-----------
 
 
 ARM
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
new file mode 100644
index 0000000000..2f27b65e2d
--- /dev/null
+++ b/tests/tcg/i386/Makefile.target
@@ -0,0 +1,30 @@
+# i386 cross compile notes
+
+I386_SRC=$(SRC_PATH)/tests/tcg/i386
+
+# Set search path for all sources
+VPATH 		+= $(I386_SRC)
+
+I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
+I386_TESTS=$(I386_SRCS:.c=)
+
+# Update TESTS
+TESTS+=$(I386_TESTS)
+
+ifneq ($(TARGET_NAME),x86_64)
+CFLAGS+=-m32
+endif
+
+#
+# hello-i386 is a barebones app
+#
+hello-i386: CFLAGS+=-ffreestanding
+hello-i386: LDFLAGS+=-nostdlib
+
+#
+# test-386 includes a couple of additional objects that need to be linked together
+#
+
+test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
diff --git a/tests/tcg/i386/README b/tests/tcg/i386/README
new file mode 100644
index 0000000000..7a0a47bf27
--- /dev/null
+++ b/tests/tcg/i386/README
@@ -0,0 +1,38 @@
+These are i386 specific guest programs
+
+test-i386
+---------
+
+This program executes most of the 16 bit and 32 bit x86 instructions and
+generates a text output, for comparison with the output obtained with
+a real CPU or another emulator.
+
+The Linux system call modify_ldt() is used to create x86 selectors
+to test some 16 bit addressing and 32 bit with segmentation cases.
+
+The Linux system call vm86() is used to test vm86 emulation.
+
+Various exceptions are raised to test most of the x86 user space
+exception reporting.
+
+linux-test
+----------
+
+This program tests various Linux system calls. It is used to verify
+that the system call parameters are correctly converted between target
+and host CPUs.
+
+test-i386-fprem
+---------------
+
+runcom
+------
+
+test-mmap
+---------
+
+sha1
+----
+
+hello-i386
+----------
diff --git a/tests/tcg/hello-i386.c b/tests/tcg/i386/hello-i386.c
similarity index 100%
rename from tests/tcg/hello-i386.c
rename to tests/tcg/i386/hello-i386.c
diff --git a/tests/tcg/pi_10.com b/tests/tcg/i386/pi_10.com
similarity index 100%
rename from tests/tcg/pi_10.com
rename to tests/tcg/i386/pi_10.com
diff --git a/tests/tcg/runcom.c b/tests/tcg/i386/runcom.c
similarity index 100%
rename from tests/tcg/runcom.c
rename to tests/tcg/i386/runcom.c
diff --git a/tests/tcg/test-i386-code16.S b/tests/tcg/i386/test-i386-code16.S
similarity index 100%
rename from tests/tcg/test-i386-code16.S
rename to tests/tcg/i386/test-i386-code16.S
diff --git a/tests/tcg/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
similarity index 100%
rename from tests/tcg/test-i386-fprem.c
rename to tests/tcg/i386/test-i386-fprem.c
diff --git a/tests/tcg/test-i386-muldiv.h b/tests/tcg/i386/test-i386-muldiv.h
similarity index 100%
rename from tests/tcg/test-i386-muldiv.h
rename to tests/tcg/i386/test-i386-muldiv.h
diff --git a/tests/tcg/test-i386-shift.h b/tests/tcg/i386/test-i386-shift.h
similarity index 100%
rename from tests/tcg/test-i386-shift.h
rename to tests/tcg/i386/test-i386-shift.h
diff --git a/tests/tcg/test-i386-ssse3.c b/tests/tcg/i386/test-i386-ssse3.c
similarity index 100%
rename from tests/tcg/test-i386-ssse3.c
rename to tests/tcg/i386/test-i386-ssse3.c
diff --git a/tests/tcg/test-i386-vm86.S b/tests/tcg/i386/test-i386-vm86.S
similarity index 100%
rename from tests/tcg/test-i386-vm86.S
rename to tests/tcg/i386/test-i386-vm86.S
diff --git a/tests/tcg/test-i386.c b/tests/tcg/i386/test-i386.c
similarity index 100%
rename from tests/tcg/test-i386.c
rename to tests/tcg/i386/test-i386.c
diff --git a/tests/tcg/test-i386.h b/tests/tcg/i386/test-i386.h
similarity index 100%
rename from tests/tcg/test-i386.h
rename to tests/tcg/i386/test-i386.h
-- 
2.17.1
