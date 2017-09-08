Received: from eggs.gnu.org ([2001:4830:134:3::10]:52471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPc-0005yW-1H
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPX-0000NQ-4z
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPW-0000Mm-Sy
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:54 +0800
Message-Id: <20170908091700.14867-2-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/7] Makefile: Rename TARGET_DIRS to
 TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

To be more accurate on its purpose and make code that looks for a certain
target out of this variable more readable.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile               | 20 ++++++++++----------
 configure              |  2 +-
 scripts/create_config  |  2 +-
 tests/Makefile.include |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 337a1f6f9b..c1e35b1fd0 100644
--- a/Makefile
+++ b/Makefile
@@ -24,8 +24,8 @@ seems to have been used for an in-tree build. You can fix this by running \
 endif
 endif
 
-CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
-CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
+CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_LIST)),y)
+CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_LIST)),y)
 CONFIG_XEN := $(CONFIG_XEN_BACKEND)
 CONFIG_ALL=y
 -include config-all-devices.mak
@@ -217,8 +217,8 @@ DOCS=
 endif
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory) BUILD_DIR=$(BUILD_DIR)
-SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
-SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
+SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
+SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_LIST))
 
 ifeq ($(SUBDIR_DEVICES_MAK),)
 config-all-devices.mak:
@@ -314,7 +314,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
+SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_LIST))
 SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
@@ -352,7 +352,7 @@ ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 romsubdir-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V="$(V)" TARGET_DIR="$*/" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
 
-ALL_SUBDIRS=$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
+ALL_SUBDIRS=$(TARGET_LIST) $(patsubst %,pc-bios/%, $(ROMS))
 
 recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
 
@@ -537,7 +537,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-	for d in $(TARGET_DIRS); do \
+	for d in $(TARGET_LIST); do \
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
@@ -638,7 +638,7 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
-	for d in $(TARGET_DIRS); do \
+	for d in $(TARGET_LIST); do \
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
@@ -832,9 +832,9 @@ help:
 	@echo  '  ctags/TAGS      - Generate tags file for editors'
 	@echo  '  cscope          - Generate cscope index'
 	@echo  ''
-	@$(if $(TARGET_DIRS), \
+	@$(if $(TARGET_LIST), \
 		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_DIRS), \
+		$(foreach t, $(TARGET_LIST), \
 		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);) \
 		echo '')
 	@echo  'Cleaning targets:'
diff --git a/configure b/configure
index a541aadebc..36a2fa1f23 100755
--- a/configure
+++ b/configure
@@ -5587,7 +5587,7 @@ qemu_version=$(head $source_path/VERSION)
 echo "VERSION=$qemu_version" >>$config_host_mak
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "TARGET_DIRS=$target_list" >> $config_host_mak
+echo "TARGET_LIST=$target_list" >> $config_host_mak
 if [ "$docs" = "yes" ] ; then
   echo "BUILD_DOCS=yes" >> $config_host_mak
 fi
diff --git a/scripts/create_config b/scripts/create_config
index e6929dd61e..3612f8154f 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -107,7 +107,7 @@ case $line in
     target_name=${line#*=}
     echo "#define TARGET_NAME \"$target_name\""
     ;;
- TARGET_DIRS=*)
+ TARGET_LIST=*)
     # do nothing
     ;;
  TARGET_*=y) # configuration
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..debaf845db 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -820,7 +820,7 @@ endif
 
 # QTest rules
 
-TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_LIST)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
 check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
-- 
2.13.5
