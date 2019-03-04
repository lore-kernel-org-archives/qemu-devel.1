Received: from eggs.gnu.org ([209.51.188.92]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCz-0002OZ-GJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCx-0004r3-Fi
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCt-0004Ye-Nb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:57 -0500
Received: by mail-wr1-x429.google.com with SMTP id w6so6634316wrs.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:54 +0100
Message-Id: <1551723614-1823-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/54] ppc: Express dependencies of the Mac
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
index 2433d1b..a012d2c 100644
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
index c562b69..6b4633b 100644
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
index 24e4ed9..9b5056f 100644
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
