Received: from eggs.gnu.org ([209.51.188.92]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmz-00025q-3V
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmx-0006Vc-PN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 14:53:29 +0100
Message-Id: <1548942810-22942-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1548942810-22942-1-git-send-email-thuth@redhat.com>
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] ppc: Express dependencies of the
 Sam460EX machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com

Most of the dependencies are now directly selected by the SAM460EX
switch. We can drop CONFIG_VGA_CIRRUS since this device is already
selected automatically when CONFIG_PCI_DEVICES is set.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 10 ----------
 hw/display/Kconfig              |  1 +
 hw/ppc/Kconfig                  | 10 ++++++++++
 hw/usb/Kconfig                  |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 513a8e9..5265d8a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -25,16 +25,6 @@ CONFIG_PCI_EXPRESS=y
 
 # For Sam460ex
 CONFIG_SAM460EX=y
-CONFIG_USB_EHCI_SYSBUS=y
-CONFIG_SM501=y
-CONFIG_DDC=y
-CONFIG_IDE_SII3112=y
-CONFIG_I2C=y
-CONFIG_AT24C=y
-CONFIG_BITBANG_I2C=y
-CONFIG_M41T80=y
-CONFIG_VGA_CIRRUS=y
-CONFIG_SMBUS_EEPROM=y
 
 # For Macs
 CONFIG_MAC_OLDWORLD=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index c784fe8..f8e6136 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -76,6 +76,7 @@ config MILKYMIST_TMU2
 config SM501
     bool
     depends on I2C
+    select DDC
 
 config TCX
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 2956c86..35e3704 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -27,9 +27,19 @@ config PPC440
 
 config PPC4XX
     bool
+    select BITBANG_I2C
+    select PCI
 
 config SAM460EX
     bool
+    select PFLASH_CFI01
+    select IDE_SII3112
+    select M41T80
+    select PPC440
+    select SM501
+    select SMBUS_EEPROM
+    select USB_EHCI_SYSBUS
+    select USB_OHCI
 
 config PREP
     bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index a1b7acb..871ea47 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -21,7 +21,7 @@ config USB_EHCI
 
 config USB_EHCI_SYSBUS
     bool
-    select USB
+    select USB_EHCI
 
 config USB_XHCI
     bool
-- 
1.8.3.1
