Received: from eggs.gnu.org ([2001:4830:134:3::10]:54757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jH-0008KP-8M
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jE-0007vz-O8
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:35 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jE-0007vL-F7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:32 -0400
Received: by mail-wm0-x234.google.com with SMTP id 69-v6so11741927wmf.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:10 +0100
Message-Id: <20180705160329.30386-2-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 01/20] Revert "Makefile: Rename TARGET_DIRS
 to TARGET_LIST"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This reverts commit 208ecb3e1acc8d55dab49fdf721a86d513691688. This was
causing problems by making DEF_TARGET_LIST pointless and having to
jump through hoops to build on mingw with a dully enabled config.
This includes a change to fix the per-guest TCG test probe which was
added after 208ecb3 and used TARGET_LIST.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/Makefile b/Makefile
index 7ed9cc4a21..39fd4c0546 100644
--- a/Makefile
+++ b/Makefile
@@ -60,8 +60,8 @@ seems to have been used for an in-tree build. You can fix this by running \
 endif
 endif
 
-CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_LIST)),y)
-CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_LIST)),y)
+CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
+CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
 CONFIG_XEN := $(CONFIG_XEN_BACKEND)
 CONFIG_ALL=y
 -include config-all-devices.mak
@@ -365,8 +365,8 @@ DOCS=
 endif
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
-SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
-SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_LIST))
+SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
+SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
 
 ifeq ($(SUBDIR_DEVICES_MAK),)
 config-all-devices.mak:
@@ -469,7 +469,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_LIST))
+SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
@@ -513,7 +513,7 @@ ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 romsubdir-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V="$(V)" TARGET_DIR="$*/" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
 
-ALL_SUBDIRS=$(TARGET_LIST) $(patsubst %,pc-bios/%, $(ROMS))
+ALL_SUBDIRS=$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
 
 recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
 
@@ -770,7 +770,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
-	for d in $(TARGET_LIST); do \
+	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
@@ -871,7 +871,7 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
-	for d in $(TARGET_LIST); do \
+	for d in $(TARGET_DIRS); do \
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
@@ -1066,9 +1066,9 @@ endif
 	@echo  '  ctags/TAGS      - Generate tags file for editors'
 	@echo  '  cscope          - Generate cscope index'
 	@echo  ''
-	@$(if $(TARGET_LIST), \
+	@$(if $(TARGET_DIRS), \
 		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_LIST), \
+		$(foreach t, $(TARGET_DIRS), \
 		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);) \
 		echo '')
 	@echo  'Cleaning targets:'
diff --git a/configure b/configure
index b99ebdde24..2a7796ea80 100755
--- a/configure
+++ b/configure
@@ -6212,7 +6212,7 @@ qemu_version=$(head $source_path/VERSION)
 echo "VERSION=$qemu_version" >>$config_host_mak
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "TARGET_LIST=$target_list" >> $config_host_mak
+echo "TARGET_DIRS=$target_list" >> $config_host_mak
 if [ "$docs" = "yes" ] ; then
   echo "BUILD_DOCS=yes" >> $config_host_mak
 fi
diff --git a/scripts/create_config b/scripts/create_config
index 58948a67a4..d727e5e36e 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -107,7 +107,7 @@ case $line in
     target_name=${line#*=}
     echo "#define TARGET_NAME \"$target_name\""
     ;;
- TARGET_LIST=*)
+ TARGET_DIRS=*)
     # do nothing
     ;;
  TARGET_*=y) # configuration
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1affc49ca3..0c0f9509f5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -874,7 +874,7 @@ endif
 
 # QTest rules
 
-TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_LIST)))
+TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
 check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
@@ -938,14 +938,14 @@ check-report.html: check-report.xml
 
 # Per guest TCG tests
 
-LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
+LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_DIRS))
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
 RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
 
 ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
-$(foreach PROBE_TARGET,$(TARGET_LIST), 				\
+$(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
 	$(if $(DOCKER_PREREQ), 					\
 		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
-- 
2.17.1
