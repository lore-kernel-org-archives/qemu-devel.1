Received: from eggs.gnu.org ([2001:4830:134:3::10]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyG-0000bQ-J4
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyE-0007ly-87
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:20 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyD-0007kf-Hk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:18 -0400
Received: by mail-wm0-x230.google.com with SMTP id r15-v6so5256866wmc.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:55 +0100
Message-Id: <20180615194705.28019-45-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 44/54] Makefile.target: add
 (clean-/build-)guest-tests targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Now all the build infrastructure is in place we can build tests for
each guest that we support. That support mainly depends on having
cross compilers installed or docker setup. To keep all the logic for
that together we put the rules in tests/tcg/Makefile.include and
include it from the main Makefile.target.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4
  - pulled Makefile.include bits from next patch
  - added qemu-$(TARGET_NAME) dependency for running tests
  - accept SPEED parameter to run slow tests
  - pass BUILD_STATIC
  - update MAINTAINERS
v6
  - bare make -> $(MAKE) for sub-makes
v7
  - fixed spelling
  - shorten CROSS-BUILD to BUILD and RUN-TESTS to RUN with additional
    info to the right.
---
 MAINTAINERS                |  1 +
 Makefile.target            |  5 +++
 tests/tcg/Makefile.include | 88 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tests/tcg/Makefile.include

diff --git a/MAINTAINERS b/MAINTAINERS
index 3795a32c27..6a8d42ab3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2153,6 +2153,7 @@ W: http://patchew.org/QEMU/
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 F: tests/tcg/Makefile
+F: tests/tcg/Makefile.include
 L: qemu-devel@nongnu.org
 
 Documentation
diff --git a/Makefile.target b/Makefile.target
index dad2cf8778..a9d8928f96 100644
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
index 0000000000..57470b2a2c
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
+	    $(MAKE) -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
+			BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
+			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
+	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
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
+	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
+			BUILD_STATIC=y \
+			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
+	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
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
+	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=$(SPEED) run), \
+	"RUN", "tests for $(TARGET_NAME)")
+
+else
+guest-tests:
+	$(call quiet-command, /bin/true, "BUILD", \
+		"$(TARGET_NAME) guest-tests SKIPPED")
+
+run-guest-tests:
+	$(call quiet-command, /bin/true, "RUN", \
+		"tests for $(TARGET_NAME) SKIPPED")
+endif
+
+# It doesn't matter if these don't exits
+.PHONY: clean-guest-tests
+clean-guest-tests:
+	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
-- 
2.17.1
