Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISs-0004dV-A8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISr-0004Zj-5y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:18 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:39467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISq-0004ZH-VV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:17 -0400
Received: by mail-wm0-x233.google.com with SMTP id p11-v6so1661998wmc.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:35 +0100
Message-Id: <20180703101444.23778-12-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/20] docker: filter out linux-user builds for
 mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The recent change from TARGET_DIRS to TARGET_LIST (208ecb3e1) had the
effect of defaulting all docker builds to the current configured set
of targets. This is actually reasonable behaviour but does run into
problems if you have linux-user builds configured and you want to test
the windows cross builds. This commit fixes that by adding a
DOCKER_FILTER_TARGETS variable which is special-cased for mingw builds
so we don't pass the whole set down.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 91d9665517..1813ec0781 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -20,6 +20,9 @@ DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py
 TESTS ?= %
 IMAGES ?= %
 
+# This is used to filter targets from some docker builds
+DOCKER_FILTER_TARGETS ?=
+
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
 
@@ -108,6 +111,12 @@ $(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
 	) \
 )
 
+# Special cases
+#  mingw/windows builds cannot build linux-user
+docker-%-win32-cross: DOCKER_FILTER_TARGETS = %-linux-user
+docker-%-win64-cross: DOCKER_FILTER_TARGETS = %-linux-user
+docker-test-mingw@%: DOCKER_FILTER_TARGETS = %-linux-user
+
 docker:
 	@echo 'Build QEMU and run tests inside Docker containers'
 	@echo
@@ -174,7 +183,7 @@ docker-run: docker-qemu-src
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
+			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(filter-out $(DOCKER_FILTER_TARGETS),$(TARGET_LIST)))	\
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
@@ -195,7 +204,8 @@ docker-run: docker-qemu-src
 docker-run-%: CMD = $(shell echo '$@' | sed -e 's/docker-run-\([^@]*\)@\(.*\)/\1/')
 docker-run-%: IMAGE = $(shell echo '$@' | sed -e 's/docker-run-\([^@]*\)@\(.*\)/\2/')
 docker-run-%:
-	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE)
+	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE) DOCKER_FILTER_TARGETS=$(DOCKER_FILTER_TARGETS)
+
 
 docker-clean:
 	$(call quiet-command, $(DOCKER_SCRIPT) clean)
-- 
2.17.1
