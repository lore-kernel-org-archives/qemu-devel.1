Received: from eggs.gnu.org ([209.51.188.92]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCXI-0005tZ-5p
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCXA-0004GQ-Ii
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:01:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCX6-0002Nr-H5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:01:10 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:18 +0800
Message-Id: <20190123065618.3520-45-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 44/44] Makefile: only support defconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

add CONFIG_VHOST_USER and CONFIG_LINUX in Kconfig.host, the
current Makefile only support defconfig because of randconfig
does not work.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Kconfig.host     |  6 ++++++
 Makefile         | 16 ++++++++--------
 hw/block/Kconfig |  2 ++
 hw/scsi/Kconfig  |  2 ++
 hw/tpm/Kconfig   |  2 ++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Kconfig.host b/Kconfig.host
index d7f503d0ca..3772627a3a 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -16,3 +16,9 @@ config TPM
 
 config XEN
     bool
+
+config VHOST_USER
+    bool
+
+config LINUX
+    bool
diff --git a/Makefile b/Makefile
index 97c6453415..b8f1e71977 100644
--- a/Makefile
+++ b/Makefile
@@ -312,6 +312,9 @@ endif
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
 SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
+SUBDIR_TARGET_MAK=$(patsubst %, %/config-target.mak, $(TARGET_DIRS))
+
+-include $(SUBDIR_TARGET_MAK)
 
 ifeq ($(SUBDIR_DEVICES_MAK),)
 config-all-devices.mak:
@@ -332,16 +335,13 @@ MINIKCONF_ARGS = \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_TPM=$(CONFIG_TPM) \
     CONFIG_XEN=$(CONFIG_XEN) \
-    CONFIG_OPENGL=$(CONFIG_OPENGL)
-
-MINIKCONF = $(SHELL) $(SRC_PATH)/scripts/minikconf.sh
+    CONFIG_OPENGL=$(CONFIG_OPENGL) \
+    CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
+    CONFIG_LINUX=$(CONFIG_LINUX)
 
-.PHONY: allyesconfig allnoconfig defconfig randconfig
-allyesconfig allnoconfig defconfig randconfig:
-	rm */config-devices.mak config-all-devices.mak
-	$(MAKE) MINIKCONF="$(MINIKCONF) --$<" config-all-devices.mak
+MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py --defconfig
 
-%/config-devices.mak: default-configs/%-softmmu.mak Kconfig.host hw/Kconfig
+%/config-devices.mak: default-configs/%.mak Kconfig.host $(SRC_PATH)/hw/Kconfig
 	$(call quiet-command, \
             $(MINIKCONF) $@ $*-config-devices.mak.d $^ $(MINIKCONF_ARGS) > $@.tmp, "  GEN   $@.tmp")
 	$(call quiet-command, if test -f $@; then \
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 771967ad9f..b2f1de9eca 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -33,3 +33,5 @@ config VIRTIO_BLK
 
 config VHOST_USER_BLK
     bool
+    default y
+    depends on VHOST_USER && LINUX
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 22281213ba..e5d5bcaa5c 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -48,3 +48,5 @@ config VIRTIO_SCSI
 
 config VHOST_USER_SCSI
     bool
+    default y
+    depends on VHOST_USER && LINUX
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 28acdb745e..6d383b7209 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -13,6 +13,8 @@ config TPM_CRB
 
 config TPM_PASSTHROUGH
     bool
+    depends on TPM
 
 config TPM_EMULATOR
     bool
+    depends on TPM
-- 
2.17.1
