Received: from eggs.gnu.org ([2001:4830:134:3::10]:53972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoY-0000Ya-RZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoX-0006ZU-DZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:18 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuoX-0006XY-2e
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:17 -0400
Received: by mail-wr0-x243.google.com with SMTP id l41-v6so10978394wre.7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:55:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:59 +0100
Message-Id: <20180615194705.28019-49-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 48/54] tests: add top-level make dependency
 for docker builds
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

One problem with satisfying your docker dependencies in a sub-make it
you might end up trying to satisfy the dependency multiple times. This
is especially a problem with debian-sid based cross compilers and CI
setups. We solve this by doing a docker build pass at the top level
before any sub-makes are called.

We still need to satisfy dependencies in the Makefile.target call so
people can run tests from individual target directories. We introduce
a new Makefile.probe which gets called for each PROBE_TARGET and
allows us to build up the list. It does require multiply including
config-target.mak which shouldn't cause any issues as it shouldn't
define anything that clashes with config-host.mak. However we undefine
a few key variables each time around.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - remove $(info) spam
  - just add the explicit docker dependency to each build target
  - include build-tcg-prereqs for CI tasks
---
 tests/Makefile.include   | 11 +++++++++++
 tests/tcg/Makefile.probe | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tests/tcg/Makefile.probe

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c8faa01a33..2dd0700a88 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -938,6 +938,14 @@ BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
 RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
 
+# Probe for the Docker Builds needed for each build
+DOCKER_BUILD_TARGETS:=
+$(foreach PROBE_TARGET,$(TARGET_LIST), 				\
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
+	$(if $(DOCKER_PREREQ), 					\
+		$(eval DOCKER_BUILD_TARGETS+=$(DOCKER_PREREQ))  \
+		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
+
 build-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
 
@@ -947,6 +955,9 @@ run-tcg-tests-%: build-tcg-tests-%
 clean-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
 
+.PHONY: build-tcg-prereqs
+build-tcg-prereqs: $(DOCKER_BUILD_TARGETS)
+
 .PHONY: build-tcg
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.probe
new file mode 100644
index 0000000000..15c0412657
--- /dev/null
+++ b/tests/tcg/Makefile.probe
@@ -0,0 +1,31 @@
+# -*- Mode: makefile -*-
+#
+# TCG Compiler Probe
+#
+# This Makefile fragement is included multiple times in the main make
+# script to probe for available compilers. This is used to build up a
+# selection of required docker targets before we invoke a sub-make for
+# each target.
+
+# First we need the target makefile which tells us the target architecture
+-include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
+
+# Then we load up the target architecture makefiles which tell us
+# about the compilers
+CROSS_CC_GUEST:=
+DOCKER_IMAGE:=
+DOCKER_PREREQ:=
+
+-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+
+ifndef CROSS_CC_GUEST
+ifneq ($(DOCKER_IMAGE),)
+DOCKER_PREREQ:=docker-image-$(DOCKER_IMAGE)
+endif
+endif
+
+# Clean-up
+# undefine TARGET_NAME
+# undefine TARGET_BASE_ARCH
+# undefine TARGET_ABI_DIR
-- 
2.17.1
