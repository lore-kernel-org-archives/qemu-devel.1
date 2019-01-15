Received: from eggs.gnu.org ([209.51.188.92]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYP-0002rf-UB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPSS-0001VL-Ig
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:12:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:56326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPSS-0001A9-8v
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:12:48 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:56 +0800
Message-Id: <20190115141108.934-26-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 25/37] build: convert usb.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of including the same list of devices for each target,
let the host controllers select CONFIG_USB and make the devices
default to present whenever USB is available.

Done with the following script:
  while read i; do
     i=${i%=y}; i=${i#CONFIG_}
     sed -i -e'/^config '$i'$/!b' -en \
            -e'a\' -e'    default y\' -e'    depends on USB' \
          `grep -lw $i hw/*/Kconfig`
  done < default-configs/usb.mak

followed by adding "select USB" on the host controllers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/alpha-softmmu.mak       |  1 -
 default-configs/arm-softmmu.mak         |  2 --
 default-configs/hppa-softmmu.mak        |  1 -
 default-configs/i386-softmmu.mak        |  1 -
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/ppc-softmmu.mak         |  1 -
 default-configs/sh4-softmmu.mak         |  1 -
 default-configs/sh4eb-softmmu.mak       |  1 -
 default-configs/sparc64-softmmu.mak     |  1 -
 default-configs/usb.mak                 | 11 -----------
 hw/usb/Kconfig                          | 26 +++++++++++++++++++++++++
 11 files changed, 26 insertions(+), 21 deletions(-)
 delete mode 100644 default-configs/usb.mak

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index c71d1b7f37..ef8c9ae5ed 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for alpha-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 8c071f6224..92fc9911eb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for arm-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_VGA=y
 CONFIG_NAND=y
@@ -38,7 +37,6 @@ CONFIG_DS1338=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_MICRODRIVE=y
-CONFIG_USB=y
 CONFIG_USB_MUSB=y
 CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_PLATFORM_BUS=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 74d34c05e9..fe07c90937 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,4 +1,3 @@
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index cf49e3fae7..23dcca7a31 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -2,7 +2,6 @@
 
 CONFIG_PCI=y
 CONFIG_ISA=y
-include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 03c7a08d1a..1060374d51 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,6 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-include usb.mak
 CONFIG_ISA=y
 CONFIG_PCI=y
 CONFIG_ESP=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index c7003e4284..37040fd17a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for ppc-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 ONFIG_ISA=y
 
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 57d99fa93c..9fc09f9d6d 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 2e5909c381..c53051d0d5 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4eb-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index db393d9eb3..5507346006 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sparc64-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_M48T59=y
 CONFIG_PTIMER=y
diff --git a/default-configs/usb.mak b/default-configs/usb.mak
deleted file mode 100644
index e42cfeabbe..0000000000
--- a/default-configs/usb.mak
+++ /dev/null
@@ -1,11 +0,0 @@
-CONFIG_USB=y
-CONFIG_USB_TABLET_WACOM=y
-CONFIG_USB_STORAGE_BOT=y
-CONFIG_USB_STORAGE_UAS=y
-CONFIG_USB_STORAGE_MTP=y
-CONFIG_SCSI=y
-CONFIG_USB_SMARTCARD=y
-CONFIG_USB_AUDIO=y
-CONFIG_USB_SERIAL=y
-CONFIG_USB_NETWORK=y
-CONFIG_USB_BLUETOOTH=y
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index f23c542d27..0b8f41040e 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -5,59 +5,85 @@ config USB_UHCI
     bool
     default y
     depends on PCI
+    select USB
 
 config USB_OHCI
     bool
     default y
     depends on PCI
+    select USB
 
 config USB_EHCI
     bool
     default y
     depends on PCI
+    select USB
 
 config USB_EHCI_SYSBUS
     bool
+    select USB
 
 config USB_XHCI
     bool
     default y
     depends on PCI
+    select USB
 
 config USB_XHCI_NEC
     bool
     default y
     depends on PCI
+    select USB
 
 config USB_MUSB
     bool
+    select USB
 
 config TUSB6010
     bool
+    select USB_MUSB
 
 config USB_TABLET_WACOM
     bool
+    default y
+    depends on USB
 
 config USB_STORAGE_BOT
     bool
+    default y
+    depends on USB
 
 config USB_STORAGE_UAS
     bool
+    default y
+    depends on USB
 
 config USB_AUDIO
     bool
+    default y
+    depends on USB
 
 config USB_SERIAL
     bool
+    default y
+    depends on USB
 
 config USB_NETWORK
     bool
+    default y
+    depends on USB
 
 config USB_BLUETOOTH
     bool
+    default y
+    depends on USB
 
 config USB_SMARTCARD
     bool
+    default y
+    depends on USB
 
 config USB_STORAGE_MTP
     bool
+    default y
+    depends on USB
-- 
2.17.1
