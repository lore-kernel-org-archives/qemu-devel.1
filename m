Received: from eggs.gnu.org ([209.51.188.92]:57412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvv-0001wd-MQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvs-0002Dk-6z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-0002CD-Sr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:52 -0500
Received: by mail-wm1-x344.google.com with SMTP id g67so815045wmd.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:56 +0100
Message-Id: <1549562254-41157-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/51] build: convert usb.mak to Kconfig
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
Message-Id: <20190123065618.3520-33-yang.zhong@intel.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak       |  1 -
 default-configs/arm-softmmu.mak         |  2 --
 default-configs/hppa-softmmu.mak        |  1 -
 default-configs/i386-softmmu.mak        |  1 -
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/ppc-softmmu.mak         |  1 -
 default-configs/riscv32-softmmu.mak     |  1 -
 default-configs/riscv64-softmmu.mak     |  1 -
 default-configs/sh4-softmmu.mak         |  1 -
 default-configs/sh4eb-softmmu.mak       |  1 -
 default-configs/sparc64-softmmu.mak     |  1 -
 default-configs/usb.mak                 | 11 -----------
 hw/usb/Kconfig                          | 26 ++++++++++++++++++++++++++
 hw/usb/Makefile.objs                    |  2 +-
 14 files changed, 27 insertions(+), 24 deletions(-)
 delete mode 100644 default-configs/usb.mak

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index d19d920..e1017aa 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for alpha-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1ebe433..901f42a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for arm-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_VGA=y
@@ -38,7 +37,6 @@ CONFIG_DS1338=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_MICRODRIVE=y
-CONFIG_USB=y
 CONFIG_USB_MUSB=y
 CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_PLATFORM_BUS=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 85a2011..5089a94 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,4 +1,3 @@
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index db841b6..60356ed 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -3,7 +3,6 @@
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_ISA_BUS=y
-include usb.mak
 include hyperv.mak
 CONFIG_TEST_DEVICES=y
 CONFIG_VGA_ISA=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 4a48960..90a2412 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,6 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-include usb.mak
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index f1d06f4..f5df65f 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for ppc-softmmu
 
-include usb.mak
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 5501c1b..fd91efb 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for riscv-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 5501c1b..fd91efb 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for riscv-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 4c33d34..651fe1a 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 71f81da..fa3e07e 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4eb-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index cb70798..24d7389 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sparc64-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_M48T59=y
diff --git a/default-configs/usb.mak b/default-configs/usb.mak
deleted file mode 100644
index e42cfea..0000000
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
index 86ee615..e20670a 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -5,59 +5,85 @@ config USB_UHCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select USB
 
 config USB_OHCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select USB
 
 config USB_EHCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select USB
 
 config USB_EHCI_SYSBUS
     bool
+    select USB
 
 config USB_XHCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select USB
 
 config USB_XHCI_NEC
     bool
     default y if PCI_DEVICES
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
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 41be700..2b92964 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -6,7 +6,7 @@ common-obj-$(CONFIG_USB) += desc.o desc-msos.o
 common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
 common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
 common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o hcd-ehci-pci.o
-common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
+common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci.o hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
-- 
1.8.3.1
