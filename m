Received: from eggs.gnu.org ([2001:4830:134:3::10]:58746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCS3t-0004Qe-GA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCS3q-0002MC-7M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:14:41 -0500
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com
	([104.47.38.52]:21963
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCS3p-0002Lk-VI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:14:38 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 07:10:32 -0800
Message-ID: <14c2a46a082a9e34d6cbd3aba0fb47e353850d0d.1510153659.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/1] Makefile: Capstone: Add support for
 cross compile ranlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, kraxel@redhat.com, dgilbert@redhat.com, f4bug@amsat.org

When cross compiling QEMU for Windows we need to specify the cross
version of ranlib to avoid build errors when building capstone. This
patch ensures we use the same cross prefix on ranlib as other toolchain
components.

This patch fixes this build error when building on RHEL (or Fedora) with
MinGW:
/scratch/jenkins_tmp/workspace/QEMU-BuildAll/label/ssw_rhel7/target/windows/build-windows/capstone/capstone.lib:
error adding symbols: Archive has no index; run ranlib to add one
collect2: error: ld returned 1 exit status
make: *** [qemu-io.exe] Error 1

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---

 Makefile  | 2 +-
 configure | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0496c5057a..814f6820d9 100644
--- a/Makefile
+++ b/Makefile
@@ -405,7 +405,7 @@ CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 subdir-capstone: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
 
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
diff --git a/configure b/configure
index a6055c0710..0e856bbc04 100755
--- a/configure
+++ b/configure
@@ -482,6 +482,7 @@ ccas="${CCAS-$cc}"
 cpp="${CPP-$cc -E}"
 objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
+ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
 strip="${STRIP-${cross_prefix}strip}"
 windres="${WINDRES-${cross_prefix}windres}"
@@ -6288,6 +6289,7 @@ echo "CCAS=$ccas" >> $config_host_mak
 echo "CPP=$cpp" >> $config_host_mak
 echo "OBJCOPY=$objcopy" >> $config_host_mak
 echo "LD=$ld" >> $config_host_mak
+echo "RANLIB=$ranlib" >> $config_host_mak
 echo "NM=$nm" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
@@ -6782,6 +6784,7 @@ for rom in seabios vgabios ; do
     echo "OBJCOPY=objcopy" >> $config_mak
     echo "IASL=$iasl" >> $config_mak
     echo "LD=$ld" >> $config_mak
+    echo "RANLIB=$ranlib" >> $config_mak
 done
 
 # set up tests data directory
-- 
2.11.0
