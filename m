Received: from eggs.gnu.org ([2001:4830:134:3::10]:37399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64Pc-0002Kg-FT
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64Pb-0008Re-4m
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:44 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:48324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e64Pa-0008Qq-V2
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:43 -0400
Received: by mail-pg0-x242.google.com with SMTP id v78so9203814pgb.5
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 17:46:42 -0700 (PDT)
Received: from cloudburst.twiddle.net (174-21-9-158.tukw.qwest.net.
	[174.21.9.158]) by smtp.gmail.com with ESMTPSA id
	j12sm5766728pgs.35.2017.10.21.17.46.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 21 Oct 2017 17:46:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 21 Oct 2017 17:46:21 -0700
Message-Id: <20171022004621.28372-12-richard.henderson@linaro.org>
In-Reply-To: <20171022004621.28372-1-richard.henderson@linaro.org>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Do not require the submodule, but use it if present.  Allow the
command-line to override system or git submodule either way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    | 13 +++++++++++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 66 insertions(+), 11 deletions(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index 9372742f86..beecc85bee 100644
--- a/Makefile
+++ b/Makefile
@@ -383,6 +383,19 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
 dtc/%: .git-submodule-status
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
index 26e5ce7787..2807569f9f 100755
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
