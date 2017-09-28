Received: from eggs.gnu.org ([2001:4830:134:3::10]:55413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc56-0004vQ-C4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc52-0004Ot-CP
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:36 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:46058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxc52-0004OZ-5s
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:32 -0400
Received: by mail-pg0-x236.google.com with SMTP id 188so1258341pgb.2
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:54:32 -0700 (PDT)
Received: from bigtime.twiddle.net ([70.35.39.2])
	by smtp.gmail.com with ESMTPSA id
	e133sm3062332pfh.177.2017.09.28.09.54.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 28 Sep 2017 09:54:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Sep 2017 09:54:14 -0700
Message-Id: <20170928165414.7339-10-richard.henderson@linaro.org>
In-Reply-To: <20170928165414.7339-1-richard.henderson@linaro.org>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Do not require the submodule, but use it if present (in preference
even to a system copy).  This will allow us to easily use capstone
in older systems for which a package is not available, and also
easily track bug fixes from upstream.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    | 13 +++++++++++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 12 +++++++++++-
 4 files changed, 28 insertions(+), 1 deletion(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index cee6e28659..7ff366f6ca 100644
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,19 @@ subdir-dtc:dtc/libfdt dtc/tests
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
+subdir-capstone:
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/libcapstone.a)
+
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
diff --git a/.gitmodules b/.gitmodules
index 84c54cdc49..bcb80d701a 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -34,3 +34,6 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = git://git.qemu.org/QemuMacDrivers.git
+[submodule "capstone"]
+	path = capstone
+	url = https://github.com/aquynh/capstone.git
diff --git a/capstone b/capstone
new file mode 160000
index 0000000000..a279481dbf
--- /dev/null
+++ b/capstone
@@ -0,0 +1 @@
+Subproject commit a279481dbfd54bb1e2336d771e89978cc6d43176
diff --git a/configure b/configure
index 3777db91b6..a6cf0a5a15 100755
--- a/configure
+++ b/configure
@@ -4380,7 +4380,14 @@ fi
 # capstone
 
 if test "$capstone" != no; then
-  if $pkg_config capstone; then
+  if test -f ${source_path}/capstone/Makefile ; then
+    # have submodule capstone - use it
+    capstone=yes
+    capstone_internal=yes
+    mkdir -p capstone
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    LIBS="\$(BUILD_DIR)/capstone/libcapstone.a $LIBS"
+  elif $pkg_config capstone; then
     capstone=yes
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     LIBS="$($pkg_config --libs capstone) $LIBS"
@@ -6596,6 +6603,9 @@ done # for target in $targets
 if [ "$dtc_internal" = "yes" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
+if [ "$capstone_internal" = "yes" ]; then
+  echo "config-host.h: subdir-capstone" >> $config_host_mak
+fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
-- 
2.13.5
