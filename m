Received: from eggs.gnu.org ([209.51.188.92]:57716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwG-0002Kr-TV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwD-0002SF-52
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:14 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwC-0002RA-JY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: by mail-wm1-x344.google.com with SMTP id q21so800837wmc.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:15 +0100
Message-Id: <1549562254-41157-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 32/51] ppc: Express dependencies of the Mac
 machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Thomas Huth <thuth@redhat.com>

This will make it for example easier if the users want to disable
one of the two machines for their builds.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak | 15 ---------------
 hw/misc/Kconfig                 |  6 ++++++
 hw/net/Kconfig                  |  1 +
 hw/pci-host/Kconfig             |  4 +++-
 hw/ppc/Kconfig                  | 15 +++++++++++++++
 5 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 066cec9..caaff60 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -35,21 +35,6 @@ CONFIG_VGA_CIRRUS=y
 CONFIG_SMBUS_EEPROM=y
 
 # For Macs
-CONFIG_ESCC=y
-CONFIG_MACIO=y
-CONFIG_MACIO_GPIO=y
-CONFIG_SUNGEM=y
-CONFIG_MOS6522=y
-CONFIG_CUDA=y
-CONFIG_ADB=y
-CONFIG_MAC_NVRAM=y
-CONFIG_MAC_DBDMA=y
-CONFIG_MAC_PMU=y
-CONFIG_HEATHROW_PIC=y
-CONFIG_GRACKLE_PCI=y
-CONFIG_UNIN_PCI=y
-CONFIG_DEC_PCI=y
-CONFIG_IDE_MACIO=y
 CONFIG_MAC_OLDWORLD=y
 CONFIG_MAC_NEWWORLD=y
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 74031cc..728c561 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -57,6 +57,12 @@ config MOS6522
 
 config MACIO
     bool
+    select CUDA
+    select ESCC
+    select IDE_MACIO
+    select MAC_DBDMA
+    select MAC_NVRAM
+    select MOS6522
 
 config IVSHMEM_DEVICE
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index dc69e55..1aa1071 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -86,6 +86,7 @@ config FTGMAC100
 
 config SUNGEM
     bool
+    depends on PCI
 
 config COLDFIRE
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index ff4080c..b39ea29 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -10,8 +10,10 @@ config GRACKLE_PCI
     bool
 
 config UNIN_PCI
-    select PCI
     bool
+    select PCI
+    select DEC_PCI
+    select OPENPIC
 
 config PPCE500_PCI
     select PCI
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 9cebf0f..fb77151 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -55,9 +55,24 @@ config RS6000_MC
 
 config MAC_OLDWORLD
     bool
+    imply PCI_DEVICES
+    imply SUNGEM
+    imply TEST_DEVICES
+    select ADB
+    select GRACKLE_PCI
+    select HEATHROW_PIC
+    select MACIO
 
 config MAC_NEWWORLD
     bool
+    imply PCI_DEVICES
+    imply SUNGEM
+    imply TEST_DEVICES
+    select ADB
+    select MACIO
+    select MACIO_GPIO
+    select MAC_PMU
+    select UNIN_PCI
 
 config E500
     bool
-- 
1.8.3.1
