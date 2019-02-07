Received: from eggs.gnu.org ([209.51.188.92]:57517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw0-00022U-PU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvz-0002Kn-Sa
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvz-0002KX-ME
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id c8so835994wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:03 +0100
Message-Id: <1549562254-41157-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 20/51] display: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-40-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak   | 1 -
 default-configs/sh4-softmmu.mak   | 1 -
 default-configs/sh4eb-softmmu.mak | 1 -
 hw/display/Kconfig                | 6 +++++-
 hw/i2c/Kconfig                    | 1 +
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 0dcd863..d1ee6f7 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -29,7 +29,6 @@ CONFIG_PCI_EXPRESS=y
 CONFIG_SAM460EX=y
 CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
-CONFIG_DDC=y
 CONFIG_IDE_SII3112=y
 CONFIG_AT24C=y
 CONFIG_BITBANG_I2C=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 7172c8b..ccefc10 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
-CONFIG_DDC=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 3622afc..c8edeb7 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
-CONFIG_DDC=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 5393116..6d58f93 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -38,6 +38,7 @@ config VGA_PCI
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select EDID
 
 config VGA_ISA
     bool
@@ -59,6 +60,7 @@ config BOCHS_DISPLAY
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select EDID
 
 config BLIZZARD
     bool
@@ -69,11 +71,13 @@ config FRAMEBUFFER
 config MILKYMIST_TMU2
     bool
     default y
-    depends on OPENGL && X11
+    depends on OPENGL && X11 && MILKYMIST
 
 config SM501
     bool
     select I2C
+    select DDC
+    select SERIAL
 
 config TCX
     bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 74c9328..ef1caa6 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -8,6 +8,7 @@ config SMBUS_EEPROM
 config DDC
     bool
     depends on I2C
+    select EDID
 
 config VERSATILE_I2C
     bool
-- 
1.8.3.1
