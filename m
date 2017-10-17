Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4TwN-0004L4-Vl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4TwM-0005wx-Tx
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:37:59 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:46979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4TwM-0005vK-O3
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:37:58 -0400
Received: by mail-pf0-x232.google.com with SMTP id p87so1615909pfj.3
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 08:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 17 Oct 2017 08:37:42 -0700
Message-Id: <20171017153742.10026-10-richard.henderson@linaro.org>
In-Reply-To: <20171017153742.10026-1-richard.henderson@linaro.org>
References: <20171017153742.10026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Do not require the submodule, but use it if present (in preference
even to a system copy).  This will allow us to easily use capstone
in older systems for which a package is not available, and also
easily track bug fixes from upstream.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    | 13 +++++++++++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 13 ++++++++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index 90f91e54eb..ca5eb489b0 100644
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
index 11e3078936..5a305c0a69 100755
--- a/configure
+++ b/configure
@@ -4412,7 +4412,15 @@ fi
 # capstone
 
 if test "$capstone" != no; then
-  if $pkg_config capstone; then
+  # have GIT checkout, so activate capstone submodule
+  if test -e "${source_path}/.git" ; then
+    git_submodules="${git_submodules} capstone"
+    capstone=yes
+    capstone_internal=yes
+    mkdir -p capstone
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    LIBS="\$(BUILD_DIR)/capstone/libcapstone.a $LIBS"
+  elif $pkg_config capstone; then
     capstone=yes
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     LIBS="$($pkg_config --libs capstone) $LIBS"
@@ -6642,6 +6650,9 @@ done # for target in $targets
 if [ "$dtc_internal" = "yes" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
+if [ "$capstone_internal" = "yes" ]; then
+  echo "config-host.h: subdir-capstone" >> $config_host_mak
+fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
-- 
2.13.6
