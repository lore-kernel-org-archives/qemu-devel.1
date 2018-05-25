Received: from eggs.gnu.org ([2001:4830:134:3::10]:45484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeK-0005kL-0l
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeI-0003tt-BL
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:56 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDeI-0003tW-1N
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:54 -0400
Received: by mail-wr0-x241.google.com with SMTP id x9-v6so9571023wrl.13
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:24:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:12 +0100
Message-Id: <20180525141915.6497-7-alex.bennee@linaro.org>
In-Reply-To: <20180525141915.6497-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141915.6497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 46/49] Makefile.target: add
 (clean-/build-)guest-tests targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Now all the build infrastructure is in place we can build tests for
each guest that we support. That support mainly depends on having
cross compilers installed or docker setup. To keep all the logic for
that together we put the rules in tests/tcg/Makefile.include and
include it from the main Makefile.target.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - pulled Makefile.include bits from next patch
  - added qemu-$(TARGET_NAME) dependency for running tests
  - accept SPEED parameter to run slow tests
  - pass BUILD_STATIC
  - update MAINTAINERS
---
 MAINTAINERS                |  1 +
 Makefile.target            |  5 +++
 tests/tcg/Makefile.include | 88 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tests/tcg/Makefile.include

diff --git a/MAINTAINERS b/MAINTAINERS
index bfa8d0fb9c..e575bad174 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2141,6 +2141,7 @@ W: http://patchew.org/QEMU/
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 F: tests/tcg/Makefile
+F: tests/tcg/Makefile.include
 L: qemu-devel@nongnu.org
 
 Documentation
diff --git a/Makefile.target b/Makefile.target
index d0ec77a307..a30fd40257 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -36,6 +36,11 @@ endif
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
+# Makefile Tests
+ifdef CONFIG_USER_ONLY
+include $(SRC_PATH)/tests/tcg/Makefile.include
+endif
+
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
new file mode 100644
index 0000000000..fbefc8b23b
--- /dev/null
+++ b/tests/tcg/Makefile.include
@@ -0,0 +1,88 @@
+# -*- Mode: makefile -*-
+#
+# TCG tests (per-target rules)
+#
+# This Makefile fragement is included from the per-target
+# Makefile.target so will be invoked for each linux-user program we
+# build. We have two options for compiling, either using a configured
+# guest compiler or calling one of our docker images to do it for us.
+#
+
+# The per ARCH makefile, if it exists, holds extra information about
+# useful docker images or alternative compiler flags.
+
+-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+
+GUEST_BUILD=
+TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
+# Support installed Cross Compilers
+
+ifdef CROSS_CC_GUEST
+
+.PHONY: cross-build-guest-tests
+cross-build-guest-tests:
+	$(call quiet-command, \
+	   (mkdir -p tests && cd tests && \
+	    make -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
+				BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
+				EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
+	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
+
+GUEST_BUILD=cross-build-guest-tests
+
+endif
+
+# Support building with Docker
+
+ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
+ifneq ($(DOCKER_IMAGE),)
+
+# We also need the Docker make rules to depend on
+include $(SRC_PATH)/tests/docker/Makefile.include
+
+DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
+		--cc $(DOCKER_CROSS_COMPILER) \
+		-i qemu:$(DOCKER_IMAGE) \
+		-s $(SRC_PATH) -- "
+DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
+
+.PHONY: docker-build-guest-tests
+docker-build-guest-tests: $(DOCKER_PREREQ)
+	$(call quiet-command, \
+	  (mkdir -p tests && cd tests && \
+	   make -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
+			       BUILD_STATIC=y \
+			       EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
+	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
+
+GUEST_BUILD=docker-build-guest-tests
+
+endif
+endif
+
+# Final targets
+.PHONY: guest-tests
+
+ifneq ($(GUEST_BUILD),)
+guest-tests: $(GUEST_BUILD)
+
+run-guest-tests: guest-tests qemu-$(TARGET_NAME)
+	$(call quiet-command, \
+	(cd tests && make -f $(TCG_MAKE) SPEED=$(SPEED) run), \
+	"RUN-TESTS", "for $(TARGET_NAME)")
+
+else
+guest-tests:
+	$(call quiet-command, /bin/true, "CROSS-BUILD", \
+		"$(TARGET_NAME) guest-tests SKIPPED")
+
+run-guest-tests:
+	$(call quiet-command, /bin/true, "RUN-TESTS", \
+		"for $(TARGET_NAME) SKIPPED")
+endif
+
+# It doesn't mater if these don't exits
+.PHONY: clean-guest-tests
+clean-guest-tests:
+	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
-- 
2.17.0
