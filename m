Received: from eggs.gnu.org ([208.118.235.92]:54818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGd-0003FB-4w
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGO-0004O5-L0
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGO-0004B3-Bl
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:24 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:06 +0800
Message-Id: <20181227063419.12981-13-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 12/25] build: convert usb.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

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
---
 default-configs/i386-softmmu.mak |  1 -
 default-configs/usb.mak          | 11 -----------
 hw/usb/Kconfig                   | 26 ++++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 12 deletions(-)
 delete mode 100644 default-configs/usb.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 275e72f3c6..e152590d15 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -2,7 +2,6 @@
 
 CONFIG_PCI=y
 CONFIG_ISA=y
-include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
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
