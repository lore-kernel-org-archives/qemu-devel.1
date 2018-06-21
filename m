Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtIH-00055n-1R
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtIF-0003TR-EY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:09 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtIF-0003Sp-7e
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id z6-v6so1926506wma.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:42:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:58 +0100
Message-Id: <20180621062605.941-51-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 50/57] tests: add top-level make dependency
 for docker builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5c401874e8..da647324a2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -938,6 +938,14 @@ BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
 RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
 
+ifeq ($(HAVE_USER_DOCKER),y)
+# Probe for the Docker Builds needed for each build
+$(foreach PROBE_TARGET,$(TARGET_LIST), 				\
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
+	$(if $(DOCKER_PREREQ), 					\
+		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
+endif
+
 build-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
 
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
