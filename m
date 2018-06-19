Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ50-0004fg-Sx
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4x-0007f7-Mq
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:02 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVJ4x-0007eQ-DM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:59 -0400
Received: by mail-wm0-x22b.google.com with SMTP id x6-v6so1257246wmc.3
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:01:59 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:25 +0100
Message-Id: <20180619154435.18898-47-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/56] tests/tcg: add run, diff,
 and skip helper macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>

As we aren't using the default runners for all the test cases it is
easy to miss out things like timeouts. To help with this we add some
helpers and use them so we only need to make core changes in one
place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v5
  - new for v5
v5.1
  - diff-test->diff-out
v7
  - mention $(TARGET_NAME) when skipping

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index e7dbcdb5bf..bf06415390 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -34,6 +34,15 @@
 
 quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
 
+# $1 = test name, $2 = cmd, $3 = desc
+run-test = $(call quiet-command, timeout $(TIMEOUT) $2 > $1.out,"TEST",$3)
+
+# $1 = test name, $2 = reference
+diff-out = $(call quiet-command, diff -u $1.out $2 | head -n 10,"DIFF","$1.out with $2")
+
+# $1 = test name, $2 = reason
+skip-test = @printf "  SKIPPED %s on $(TARGET_NAME) because %s\n" $1 $2
+
 # Tests we are building
 TESTS=
 
@@ -84,9 +93,7 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 RUN_TESTS+=$(EXTRA_RUNS)
 
 run-%: %
-	$(call quiet-command, \
-		timeout $(TIMEOUT) $(QEMU) $< > $<.out, \
-		"TEST", "$< on $(TARGET_NAME)")
+	$(call run-test, $<, $(QEMU) $<, "$< on $(TARGET_NAME)")
 
 .PHONY: run
 run: $(RUN_TESTS)
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 7dba32138d..08c45b8470 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -13,7 +13,5 @@ TESTS:=$(AARCH64_TESTS)
 fcvt: LDFLAGS+=-lm
 
 run-fcvt: fcvt
-	$(call quiet-command, \
-		$(QEMU) $< > fcvt.out && \
-		diff -u $(AARCH64_SRC)/fcvt.ref fcvt.out, \
-		"TEST", "$< (default) on $(TARGET_NAME)")
+	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
+	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 14b5435fc6..aa4e4e3782 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -24,10 +24,8 @@ fcvt: LDFLAGS+=-lm
 # fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
 
 run-fcvt: fcvt
-	$(call quiet-command, \
-		$(QEMU) $< > fcvt.out && \
-		diff -u $(ARM_SRC)/fcvt.ref fcvt.out, \
-		"TEST", "$< (default) on $(TARGET_NAME)")
+	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
+	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
 endif
 
 # On ARM Linux only supports 4k pages
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index cd173363ee..97b7c23cf1 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -31,7 +31,7 @@ test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386
 
 # Specialist test runners
 run-runcom: runcom pi_10.com
-	$(call quiet-command, $(QEMU) ./runcom $(I386_SRC)/pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
+	$(call run-test,$<,$(QEMU) ./runcom $(I386_SRC)/pi_10.com,"$< on $(TARGET_NAME)")
 
 ifeq ($(SPEED), slow)
 
@@ -40,13 +40,11 @@ test-i386-fprem.ref: test-i386-fprem
 
 run-test-i386-fprem: TIMEOUT=60
 run-test-i386-fprem: test-i386-fprem
-	$(call quiet-command, \
-		$(QEMU) $< > $<.out && \
-		diff -u $(I386_SRC)/$<.ref $<.out, \
-		"TEST", "$< (default) on $(TARGET_NAME)")
+	$(call run-test,test-i386-fprem, $(QEMU) $<,"$< on $(TARGET_NAME)")
+	$(call diff-out,test-i386-fprem, $(I386_SRC)/$<.ref)
 else
 run-test-i386-fprem: test-i386-fprem
-	$(call quiet-command, /bin/true, "SLOW TEST", "$< SKIPPED on $(TARGET_NAME)")
+	$(call skip-test, $<, "SLOW")
 endif
 
 # On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 90e45a881e..b77084c146 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -27,10 +27,10 @@ testthread: LDFLAGS+=-lpthread
 
 # default case (host page size)
 run-test-mmap: test-mmap
-	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", \
+	$(call run-test, test-mmap, $(QEMU) $<, \
 		"$< (default) on $(TARGET_NAME)")
 
 # additional page sizes (defined by each architecture adding to EXTRA_RUNS)
 run-test-mmap-%: test-mmap
-	$(call quiet-command, $(QEMU) -p $* $< > test-mmap-$*.out, "TEST", \
+	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
-- 
2.17.1
