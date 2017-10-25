Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq8-0007b8-7O
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq6-00086e-S0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:20 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kq6-00085X-HY
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:18 -0400
Received: by mail-wm0-x241.google.com with SMTP id b9so1636048wmh.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:56 +0200
Message-Id: <20171025123056.3165-12-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Do not require the submodule, but use it if present.  Allow the
command-line to override system or git submodule either way.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    | 15 +++++++++++++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 68 insertions(+), 11 deletions(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index 9372742f86..33b4ce6e6e 100644
--- a/Makefile
+++ b/Makefile
@@ -383,6 +383,21 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
 dtc/%: .git-submodule-status
 	mkdir -p $@
 
+# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
+# Not overriding CFLAGS leads to mis-matches between compilation modes.
+# Therefore we replicate some of the logic in the sub-makefile.
+# Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
+# no need to annoy QEMU developers with such things.
+CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
+CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
+CAP_CFLAGS += -DCAPSTONE_HAS_ARM
+CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
+CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_X86
+
+subdir-capstone: .git-submodule-status
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/libcapstone.a)
+
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
diff --git a/.gitmodules b/.gitmodules
index 7c981a42b6..1500579638 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -37,3 +37,6 @@
 [submodule "ui/keycodemapdb"]
 	path = ui/keycodemapdb
 	url = git://git.qemu.org/keycodemapdb.git
+[submodule "capstone"]
+	path = capstone
+	url = git://git.qemu.org/capstone.git
diff --git a/capstone b/capstone
new file mode 160000
index 0000000000..22ead3e0bf
--- /dev/null
+++ b/capstone
@@ -0,0 +1 @@
+Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
diff --git a/configure b/configure
index d06ad64058..9ab10b0261 100755
--- a/configure
+++ b/configure
@@ -1299,6 +1299,10 @@ for opt do
   ;;
   --enable-capstone) capstone="yes"
   ;;
+  --enable-capstone=git) capstone="git"
+  ;;
+  --enable-capstone=system) capstone="system"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -4419,18 +4423,49 @@ fi
 ##########################################
 # capstone
 
-if test "$capstone" != no; then
-  if $pkg_config capstone; then
-    capstone=yes
+case "$capstone" in
+  "" | yes)
+    if $pkg_config capstone; then
+      capstone=system
+    elif test -e "${source_path}/.git" ; then
+      capstone=git
+    elif test -e "${source_path}/capstone/Makefile" ; then
+      capstone=internal
+    elif test -z "$capstone" ; then
+      capstone=no
+    else
+      feature_not_found "capstone" "Install capstone devel or git submodule"
+    fi
+    ;;
+
+  system)
+    if ! $pkg_config capstone; then
+      feature_not_found "capstone" "Install capstone devel"
+    fi
+    ;;
+esac
+
+case "$capstone" in
+  git | internal)
+    if test "$capstone" = git; then
+      git_submodules="${git_submodules} capstone"
+    fi
+    mkdir -p capstone
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    LIBS="\$(BUILD_DIR)/capstone/libcapstone.a $LIBS"
+    ;;
+
+  system)
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     LIBS="$($pkg_config --libs capstone) $LIBS"
-  else
-    if test "$capstone" = yes; then
-      feature_not_found capstone
-    fi
-    capstone=no
-  fi
-fi
+    ;;
+
+  no)
+    ;;
+  *)
+    error_exit "Unknown state for capstone: $capstone"
+    ;;
+esac
 
 ##########################################
 # check if we have fdatasync
@@ -6165,7 +6200,7 @@ fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
-if test "$capstone" = "yes" ; then
+if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
 fi
 
@@ -6650,6 +6685,9 @@ done # for target in $targets
 if [ "$dtc_internal" = "yes" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
+if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
+  echo "config-host.h: subdir-capstone" >> $config_host_mak
+fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
-- 
2.13.6
