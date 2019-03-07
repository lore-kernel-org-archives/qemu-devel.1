Received: from eggs.gnu.org ([209.51.188.92]:44627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tua-00070H-Dh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tuZ-00027n-3Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:22:16 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:48 +0100
Message-Id: <1551968334-18982-24-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 23/29] hw/arm: Express dependencies of the
 MSF2 / EMCRAFT_SF2 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Add Kconfig dependencies for the emcraft-sf2 machine - we also
distinguish between the machine (CONFIG_EMCRAFT_SF2) and the SoC
(CONFIG_MSF2) now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  3 +--
 hw/arm/Kconfig                  | 10 +++++++++-
 hw/arm/Makefile.objs            |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9150858..a01e407 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -31,9 +31,9 @@ CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_DIGIC=y
 CONFIG_SABRELITE=y
+CONFIG_EMCRAFT_SF2=y
 
 CONFIG_VGA=y
-CONFIG_SSI_M25P80=y
 CONFIG_IMX_FEC=y
 
 CONFIG_NRF51_SOC=y
@@ -46,5 +46,4 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_MSF2=y
 CONFIG_PCI_EXPRESS_DESIGNWARE=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index cff2925..7df0bb6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -325,7 +325,6 @@ config MPS2
     select MPS2_SCC
     select PL022    # Serial port
     select PL080    # DMA controller
-    select TZ_MPC
 
 config FSL_IMX7
     bool
@@ -339,9 +338,17 @@ config FSL_IMX6UL
 config NRF51_SOC
     bool
 
+config EMCRAFT_SF2
+    bool
+    select MSF2
+    select SSI_M25P80
+
 config MSF2
     bool
+    select ARM_V7M
     select PTIMER
+    select SERIAL
+    select SSI
 
 config ZAURUS
     bool
@@ -374,6 +381,7 @@ config ARMSSE
     select IOTKIT_SECCTL
     select IOTKIT_SYSCTL
     select IOTKIT_SYSINFO
+    select TZ_MPC
     select TZ_MSC
     select TZ_PPC
 
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fadd698..eae9f6c 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
+obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
 obj-$(CONFIG_HIGHBANK) += highbank.o
 obj-$(CONFIG_INTEGRATOR) += integratorcp.o
 obj-$(CONFIG_MAINSTONE) += mainstone.o
@@ -41,7 +42,7 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MPS2) += mps2-tz.o
-obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
+obj-$(CONFIG_MSF2) += msf2-soc.o
 obj-$(CONFIG_MUSCA) += musca.o
 obj-$(CONFIG_ARMSSE) += armsse.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
-- 
1.8.3.1
