Received: from eggs.gnu.org ([209.51.188.92]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIS-0001Ns-W8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIR-0007SZ-Ni
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:47045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIR-0005vM-FB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:47 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:58 +0800
Message-Id: <20190118112410.3010-32-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 31/43] build: convert usb.mak to Kconfig
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
 default-configs/riscv32-softmmu.mak     |  1 -
 default-configs/riscv64-softmmu.mak     |  1 -
 default-configs/sh4-softmmu.mak         |  1 -
 default-configs/sh4eb-softmmu.mak       |  1 -
 default-configs/sparc64-softmmu.mak     |  1 -
 default-configs/usb.mak                 | 11 -----------
 hw/usb/Kconfig                          | 26 +++++++++++++++++++++++++
 13 files changed, 26 insertions(+), 23 deletions(-)
 delete mode 100644 default-configs/usb.mak

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index e583177e79..b9239370a6 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for alpha-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 8734c508ee..47a974b832 100644
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
index 673ae5a7cf..615e1b528f 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,4 +1,3 @@
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index d0c1f8a613..4ccf30da63 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -2,7 +2,6 @@
 
 CONFIG_PCI=y
 CONFIG_ISA_BUS=y
-include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
 CONFIG_VMWARE_VGA=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 6d98ff94a7..338e866eaa 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,6 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-include usb.mak
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_ESP=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index c9f1446e0e..8b15d0fae1 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for ppc-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_ISA_BUS=y
 
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index d45f01bdcf..b45cd3f42e 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for riscv-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index d45f01bdcf..b45cd3f42e 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for riscv-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 8382504d11..f0d1a6d031 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for sh4-softmmu
 
-include usb.mak
 CONFIG_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index a77e1538e9..58e4c6d154 100644
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
