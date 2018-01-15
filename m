Received: from eggs.gnu.org ([2001:4830:134:3::10]:36206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16m-0007nj-Q6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16g-0003Yn-EC
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:12 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 15 Jan 2018 10:30:55 +0100
Message-Id: <1516008655-31732-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1516008655-31732-1-git-send-email-thuth@redhat.com>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] default-configs/ppc-softmmu: Restructure
 the switches according to the machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Order the CONFIG switches in ppc-softmmu.mak according to the machine
classes where they are used (embedded, Mac or PReP), so that it is
easier for the users to disable a set of switches completely if they
are not needed.

For the embedded part, we now also include ppcemb-softmmu.mak instead
of duplicating all the CONFIG switches again, to make sure that the
ppc-softmmu build always contains all switches from ppcemb-softmmu (e.g.
the switch CONFIG_IDE_SII3112 from ppcemb was missing in ppc-softmmu).

While we're at it, also remove the CONFIG_IDE_CMD646 since this controller
does not seem to be used by any ppc machine in QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 59 +++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index bb225c6..460e6f4 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,26 +1,18 @@
 # Default configuration for ppc-softmmu
 
-include pci.mak
-include sound.mak
-include usb.mak
-CONFIG_PPC4XX=y
+# For embedded PPCs:
+include ppcemb-softmmu.mak
+CONFIG_E500=y
+CONFIG_ETSEC=y
+CONFIG_PLATFORM_BUS=y
+CONFIG_PPCE500_PCI=y
+CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
+
+# For Macs
+CONFIG_MAC=y
 CONFIG_ESCC=y
-CONFIG_M48T59=y
-CONFIG_SERIAL=y
-CONFIG_PARALLEL=y
-CONFIG_I8254=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
-CONFIG_I8257=y
-CONFIG_I82374=y
-CONFIG_OPENPIC=y
-CONFIG_PREP_PCI=y
-CONFIG_I82378=y
-CONFIG_PC87312=y
 CONFIG_MACIO=y
 CONFIG_SUNGEM=y
-CONFIG_PCSPK=y
-CONFIG_CS4231A=y
 CONFIG_CUDA=y
 CONFIG_ADB=y
 CONFIG_MAC_NVRAM=y
@@ -29,26 +21,23 @@ CONFIG_HEATHROW_PIC=y
 CONFIG_GRACKLE_PCI=y
 CONFIG_UNIN_PCI=y
 CONFIG_DEC_PCI=y
-CONFIG_PPCE500_PCI=y
-CONFIG_IDE_ISA=y
-CONFIG_IDE_CMD646=y
 CONFIG_IDE_MACIO=y
-CONFIG_NE2000_ISA=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_PTIMER=y
-CONFIG_I8259=y
-CONFIG_XILINX=y
-CONFIG_XILINX_ETHLITE=y
-CONFIG_PREP=y
-CONFIG_MAC=y
-CONFIG_E500=y
-CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
-CONFIG_PLATFORM_BUS=y
-CONFIG_ETSEC=y
-CONFIG_SM501=y
+
 # For PReP
+CONFIG_PREP=y
+CONFIG_PREP_PCI=y
 CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
+CONFIG_PARALLEL=y
+CONFIG_I82374=y
+CONFIG_I82378=y
+CONFIG_I8254=y
+CONFIG_FDC=y
+CONFIG_PCKBD=y
+CONFIG_NE2000_ISA=y
+CONFIG_PCSPK=y
+CONFIG_PC87312=y
+CONFIG_IDE_ISA=y
+CONFIG_CS4231A=y
-- 
1.8.3.1
