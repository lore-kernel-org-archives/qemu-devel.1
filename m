Received: from eggs.gnu.org ([2001:4830:134:3::10]:44085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFi-000315-6s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFh-0003Hy-3r
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:46 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwwFg-0003HW-VY
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:45 -0400
Received: by mail-pg0-x22f.google.com with SMTP id 7so6503514pgd.13
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 13:14:27 -0700
Message-Id: <20170926201427.2833-10-richard.henderson@linaro.org>
In-Reply-To: <20170926201427.2833-1-richard.henderson@linaro.org>
References: <20170926201427.2833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org

Do not require the submodule, but use it if present (in preference
even to a system copy).  This will allow us to easily use capstone
in older systems for which a package is not available, and also
easily track bug fixes from upstream.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile    |  4 ++++
 .gitmodules |  3 +++
 capstone    |  1 +
 configure   | 12 +++++++++++-
 4 files changed, 19 insertions(+), 1 deletion(-)
 create mode 160000 capstone

diff --git a/Makefile b/Makefile
index 2be61fcf1c..4723a65e9c 100644
--- a/Makefile
+++ b/Makefile
@@ -335,6 +335,10 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
 
+# ??? Overriding CFLAGS causes us to lose defines added in the sub-makefile.
+subdir-capstone:
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/libcapstone.a)
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
index 62d172d88a..b0c30992ff 100755
--- a/configure
+++ b/configure
@@ -4378,7 +4378,14 @@ fi
 # capstone
 
 if test "$capstone" != no; then
-  if $pkg_config capstone; then
+  if test -d ${source_path}/capstone ; then
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
@@ -6577,6 +6584,9 @@ done # for target in $targets
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
