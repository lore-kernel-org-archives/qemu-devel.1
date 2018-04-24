Received: from eggs.gnu.org ([2001:4830:134:3::10]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwW-00060L-83
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwQ-0001Po-Tw
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:20 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAzwQ-0001Oa-Ix
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:14 -0400
Received: by mail-wm0-x241.google.com with SMTP id i3so1602402wmf.3
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:33:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:24:04 +0100
Message-Id: <20180424152405.10304-46-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 45/46] tests/Makefile.include: add
 [build|clean|check]-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This will ensure all linux-user targets build their guest test
programs and ensure check-tcg will run the respective tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - use -include instead of complex macro stuff
  - also include TARGET_BASE_ARCH/Makefile
v3
  - add build-tcg, make check-tcg actually run tests
---
 tests/Makefile.include     | 26 ++++++++++++++++++++++-
 tests/tcg/Makefile.include | 43 ++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d2f0458ab..310ccefdd9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -10,6 +10,7 @@ check-help:
 	@echo " $(MAKE) check-speed          Run qobject speed tests"
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
+	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-clean          Clean the tests"
 	@echo
@@ -916,6 +917,30 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
 check-report.html: check-report.xml
 	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
 
+# Per guest TCG tests
+
+LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
+BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
+CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
+RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
+
+build-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
+
+run-tcg-tests-%: build-tcg-tests-%
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" run-guest-tests,)
+
+clean-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+
+.PHONY: build-tcg
+build-tcg: $(BUILD_TCG_TARGET_RULES)
+
+.PHONY: check-tcg
+check-tcg: $(RUN_TCG_TARGET_RULES)
+
+.PHONY: clean-tcg
+clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 # Other tests
 
@@ -958,7 +983,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest check-decodetree
 check-clean:
-	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index cb8bb36026..67e89ecb67 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -8,19 +8,14 @@
 # guest compiler or calling one of our docker images to do it for us.
 #
 
-# The per ARCH makefile, if it exists holds extra information about
-# useful docker images or alternative compiler flags. Include it if it
-# exists
+# The per ARCH makefile, if it exists, holds extra information about
+# useful docker images or alternative compiler flags.
 
-ARCH_MAKEFILE=$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
-CHECK_INCLUDE=$(wildcard $(ARCH_MAKEFILE))
-
-ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
-include $(ARCH_MAKEFILE)
-endif
+-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
 
 GUEST_BUILD=
-
+TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
 # Support installed Cross Compilers
 
 ifdef CROSS_CC_GUEST
@@ -28,10 +23,10 @@ ifdef CROSS_CC_GUEST
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
 	$(call quiet-command, \
-          (mkdir -p tests && cd tests && \
-	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(CROSS_CC_GUEST)), \
-	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
-
+	   (mkdir -p tests && cd tests && \
+	    make -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
+				EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
+	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
 
 GUEST_BUILD=cross-build-guest-tests
 
@@ -54,9 +49,10 @@ DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
 .PHONY: docker-build-guest-tests
 docker-build-guest-tests: $(DOCKER_PREREQ)
 	$(call quiet-command, \
-          (mkdir -p tests && cd tests && \
-	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(DOCKER_COMPILE_CMD)), \
-	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
+	  (mkdir -p tests && cd tests && \
+	   make -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
+			       EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
+	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
 
 GUEST_BUILD=docker-build-guest-tests
 
@@ -68,9 +64,20 @@ endif
 
 ifneq ($(GUEST_BUILD),)
 guest-tests: $(GUEST_BUILD)
+
+run-guest-tests: guest-tests
+	$(call quiet-command, \
+	(cd tests && make -f $(TCG_MAKE) run), \
+	"RUN-TESTS", "for $(TARGET_NAME)")
+
 else
 guest-tests:
-	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest-tests SKIPPED")
+	$(call quiet-command, /bin/true, "CROSS-BUILD", \
+		"$(TARGET_NAME) guest-tests SKIPPED")
+
+run-guest-tests:
+	$(call quiet-command, /bin/true, "RUN-TESTS", \
+		"for $(TARGET_NAME) SKIPPED")
 endif
 
 # It doesn't mater if these don't exits
-- 
2.17.0
