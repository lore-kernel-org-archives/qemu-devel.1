Received: from eggs.gnu.org ([209.51.188.92]:51907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG0-00024X-SH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq4w-0005z4-IS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:10 +0100
Message-Id: <1550047098-1210-18-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/25] hw/arm: Express dependencies of the
 raspi machines with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

Most of the code is directly controlled by the CONFIG_RASPI switch,
so not much to add here additionally.

Note that CONFIG_SDHCI currently has a hard requirement for PCI, so
we select that switch now always there instead of depending on it.
We should split up sdhci.c into sysbus and pci parts later to get
rid of this hard requirement.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 4 +---
 hw/arm/Kconfig                  | 3 +++
 hw/sd/Kconfig                   | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b530a06..6605786 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -27,15 +27,13 @@ CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
 CONFIG_MPS2=y
+CONFIG_RASPI=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
 CONFIG_IMX_FEC=y
 
-CONFIG_FRAMEBUFFER=y
-
 CONFIG_DIGIC=y
-CONFIG_RASPI=y
 CONFIG_NRF51_SOC=y
 
 CONFIG_FSL_IMX6=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d17bd2f..bb385a5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -269,6 +269,9 @@ config ALLWINNER_A10
 
 config RASPI
     bool
+    select FRAMEBUFFER
+    select PL011 # UART
+    select SDHCI
 
 config STM32F205_SOC
     bool
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 864f535..29e359b 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -13,5 +13,5 @@ config SD
 config SDHCI
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    select PCI               # TODO: Split up sdhci.c into sysbus and pci parts
     select SD
-- 
1.8.3.1
