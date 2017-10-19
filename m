Received: from eggs.gnu.org ([2001:4830:134:3::10]:47831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D7A-0007Kf-BD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D75-0000KJ-Od
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:47240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5D75-0000Jt-Iv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id z11so6865707pfk.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:52:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 08:51:46 -0700
Message-Id: <20171019155146.30434-10-richard.henderson@linaro.org>
In-Reply-To: <20171019155146.30434-1-richard.henderson@linaro.org>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Do not require the submodule, but use it if present.  Allow the
command-line to override system or git submodule either way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    | 13 +++++++++++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 59 +++++++++++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 64 insertions(+), 12 deletions(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index 062745f3ba..c6436e2442 100644
--- a/Makefile
+++ b/Makefile
@@ -383,6 +383,19 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
 
+# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
+# Not overriding CFLAGS leads to mis-matches between compilation modes.
+# Therefore we replicate some of the logic in the sub-makefile.
+CAP_CFLAGS = $(subst -Werror,,$(CFLAGS) $(QEMU_CFLAGS))
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
index 0000000000..a279481dbf
--- /dev/null
+++ b/capstone
@@ -0,0 +1 @@
+Subproject commit a279481dbfd54bb1e2336d771e89978cc6d43176
diff --git a/configure b/configure
index 26e5ce7787..892bfba2d2 100755
--- a/configure
+++ b/configure
@@ -375,7 +375,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt="no"
 zlib="yes"
-capstone=""
+capstone="yes"
 lzo=""
 snappy=""
 bzip2=""
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
@@ -4419,18 +4423,46 @@ fi
 ##########################################
 # capstone
 
-if test "$capstone" != no; then
-  if $pkg_config capstone; then
-    capstone=yes
+case "$capstone" in
+  yes)
+    if $pkg_config capstone; then
+      capstone=system
+    elif test -e "${source_path}/.git" ; then
+      capstone=git
+    elif test -e "${source_path}/capstone/Makefile" ; then
+      capstone=internal
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
+    capstone_internal=yes
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
@@ -6165,7 +6197,7 @@ fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
-if test "$capstone" = "yes" ; then
+if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
 fi
 
@@ -6650,6 +6682,9 @@ done # for target in $targets
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
