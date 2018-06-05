Received: from eggs.gnu.org ([2001:4830:134:3::10]:53121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVE-0000v6-Kw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESw-0004Kj-11
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:08 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:40300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESv-0004Jv-Ks
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:45 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n5-v6so6140923wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:38 +0100
Message-Id: <20180605160541.10664-4-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/6] Makefile: Rename TARGET_DIRS to TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Fam Zheng <famz@redhat.com>

To be more accurate on its purpose and make code that looks for a certain
target out of this variable more readable.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 6d588d1f71..023b3437ec 100644
--- a/Makefile
+++ b/Makefile
@@ -62,8 +62,8 @@ seems to have been used for an in-tree build. You can fix this by running \
 endif
 endif
 
-CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
-CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
+CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_LIST)),y)
+CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_LIST)),y)
 CONFIG_XEN := $(CONFIG_XEN_BACKEND)
 CONFIG_ALL=y
 -include config-all-devices.mak
@@ -366,8 +366,8 @@ DOCS=
 endif
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
-SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
-SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
+SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
+SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_LIST))
 
 ifeq ($(SUBDIR_DEVICES_MAK),)
 config-all-devices.mak:
@@ -470,7 +470,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
+SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_LIST))
 SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
@@ -514,7 +514,7 @@ ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 romsubdir-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V="$(V)" TARGET_DIR="$*/" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
 
-ALL_SUBDIRS=$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
+ALL_SUBDIRS=$(TARGET_LIST) $(patsubst %,pc-bios/%, $(ROMS))
 
 recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
 
@@ -772,7 +772,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
-	for d in $(TARGET_DIRS); do \
+	for d in $(TARGET_LIST); do \
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
@@ -873,7 +873,7 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
-	for d in $(TARGET_DIRS); do \
+	for d in $(TARGET_LIST); do \
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
@@ -1071,9 +1071,9 @@ endif
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
index db8c9d8288..14b11130a7 100755
--- a/configure
+++ b/configure
@@ -6128,7 +6128,7 @@ qemu_version=$(head $source_path/VERSION)
 echo "VERSION=$qemu_version" >>$config_host_mak
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "TARGET_DIRS=$target_list" >> $config_host_mak
+echo "TARGET_LIST=$target_list" >> $config_host_mak
 if [ "$docs" = "yes" ] ; then
   echo "BUILD_DOCS=yes" >> $config_host_mak
 fi
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e36e..58948a67a4 100755
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
index 86f90c0cb0..9854e7794b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -858,7 +858,7 @@ endif
 
 # QTest rules
 
-TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_LIST)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
 check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
-- 
2.17.0
