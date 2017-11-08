Received: from eggs.gnu.org ([2001:4830:134:3::10]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCExI-0008Oq-V5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCExD-0004co-WC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:15:00 -0500
Received: from mail-by2nam01on0089.outbound.protection.outlook.com
	([104.47.34.89]:39809
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCExD-0004cM-IX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:14:55 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 7 Nov 2017 17:10:46 -0800
Message-ID: <e457d4e906dceea4de6c3431813a06b137c1ab9c.1510103351.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] Makefile: Capstone: Add support for
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, kraxel@redhat.com, dgilbert@redhat.com

When cross compiling QEMU for Windows we need to specify the cross
version of ranlib to avoid build errors when buildling capstone. This
patch ensures we use the same cross prefix on ranlib as other toolchain
components.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
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
