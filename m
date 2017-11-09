Received: from eggs.gnu.org ([2001:4830:134:3::10]:57046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChdr-0002W6-J7
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChdq-0000Wf-Dj
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:51 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eChdq-0000WH-6H
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:50 -0500
Received: by mail-wr0-x243.google.com with SMTP id 4so4734779wrt.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 23:52:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  9 Nov 2017 08:52:43 +0100
Message-Id: <20171109075243.4794-3-richard.henderson@linaro.org>
In-Reply-To: <20171109075243.4794-1-richard.henderson@linaro.org>
References: <20171109075243.4794-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] Makefile: Capstone: Add support for cross
 compile ranlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

When cross compiling QEMU for Windows we need to specify the cross
version of ranlib to avoid build errors when building capstone. This
patch ensures we use the same cross prefix on ranlib as other toolchain
components.

- Fedora23 mingw
- RHEL-7.2 with mingw packages from epel:

   LINK    qemu-img.exe
 build-win64/capstone/capstone.lib: error adding symbols: Archive has no
index; run ranlib to add one
 collect2: error: ld returned 1 exit status

$ x86_64-w64-mingw32-ar --version
GNU ar (GNU Binutils) 2.25

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <e457d4e906dceea4de6c3431813a06b137c1ab9c.1510103351.git.alistair.francis@xilinx.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.13.6
