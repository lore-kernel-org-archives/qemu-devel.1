Received: from eggs.gnu.org ([209.51.188.92]:45893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCa-0001ws-3O
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCY-00045J-RX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCY-00043k-IS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id j125so135317wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:38 +0100
Message-Id: <1551723614-1823-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/54] build: convert usb.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

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
index 27936dd..f0c1928 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for alpha-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 7b7c040..917b18d 100644
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
index 221c609..b7f2b43 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,4 +1,3 @@
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 075d501..54b571f 100644
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
index 556cd5c..45c599b 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,6 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-include usb.mak
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 1871185..d4807b3 100644
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
index 87da3a6..3f7fbe2 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index ce9aae9..17f07a4 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4eb-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index bf52d52..2d23b0c 100644
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
index 071e749..a1b7acb 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -5,61 +5,87 @@ config USB_UHCI
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
     select SCSI
 
 config USB_STORAGE_UAS
     bool
+    default y
+    depends on USB
     select SCSI
 
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
