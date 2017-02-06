Received: from eggs.gnu.org ([2001:4830:134:3::10]:35335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHM-0004dR-GV
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHI-00008J-8w
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Feb 2017 12:39:25 +1100
Message-Id: <20170206013927.13693-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170206013927.13693-1-david@gibson.dropbear.id.au>
References: <20170206013927.13693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/3] Split serial-isa into its own config option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, edgar.iglesias@gmail.com, michael@walle.cc, proljc@gmail.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, veroniabahaa@gmail.com, mst@redhat.com, armbru@redhat.com, agraf@suse.de, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

At present, the core device model code for 8250-like serial ports
(serial.c) and the code for serial ports attached to ISA-style legacy IO
(serial-isa.c) are both controlled by the CONFIG_SERIAL variable.

There are lots and lots of embedded platforms that have 8250-like serial
ports but have never had anything resembling ISA legacy IO.  Therefore,
split serial-isa into its own CONFIG_SERIAL_ISA option so it can be
disabled for platforms where it's not appropriate.

For now, I enabled CONFIG_SERIAL_ISA in every default-config where
CONFIG_SERIAL is enabled, excepting microblaze, or32, and xtensa.  As best
as I can tell, those platforms never used legacy ISA, and also don't
include PCI support (which would allow connection of a PCI->ISA bridge
and/or a southbridge including legacy ISA serial ports).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/alpha-softmmu.mak       | 1 +
 default-configs/arm-softmmu.mak         | 1 +
 default-configs/i386-softmmu.mak        | 1 +
 default-configs/mips-softmmu-common.mak | 1 +
 default-configs/moxie-softmmu.mak       | 1 +
 default-configs/pci.mak                 | 1 +
 default-configs/ppc-softmmu.mak         | 1 +
 default-configs/ppc64-softmmu.mak       | 1 +
 default-configs/ppcemb-softmmu.mak      | 1 +
 default-configs/sh4-softmmu.mak         | 1 +
 default-configs/sh4eb-softmmu.mak       | 1 +
 default-configs/sparc64-softmmu.mak     | 1 +
 default-configs/x86_64-softmmu.mak      | 1 +
 hw/char/Makefile.objs                   | 3 ++-
 14 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 7f6161e..e0d75e3 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include usb.mak
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_I8254=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 6f2a180..824fa71 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,6 +6,7 @@ CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_SD=y
 CONFIG_MAX7310=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 384cefb..48b07a4 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -15,6 +15,7 @@ CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index f0676f5..7d8f5db 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -9,6 +9,7 @@ CONFIG_VGA_ISA_MM=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index 1a95476..7e22863 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -2,4 +2,5 @@
 
 CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_VGA=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index fff7ce3..d8d6548 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -27,6 +27,7 @@ CONFIG_AHCI=y
 CONFIG_ESP=y
 CONFIG_ESP_PCI=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_SERIAL_PCI=y
 CONFIG_IPACK=y
 CONFIG_WDT_IB6300ESB=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 7dd004e..09c1d45 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -46,6 +46,7 @@ CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_LIBDECNUMBER=y
 # For PReP
+CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index 9ae6563..05c8335 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -52,6 +52,7 @@ CONFIG_XICS=$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
 # For PReP
+CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_MEM_HOTPLUG=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 54acc4d..7f56004 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -5,6 +5,7 @@ include sound.mak
 include usb.mak
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_I8257=y
 CONFIG_OPENPIC=y
 CONFIG_PFLASH_CFI01=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 8e00390..546d855 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include usb.mak
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index efdd058..2d3fd49 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include usb.mak
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index c581e61..d07876a 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -5,6 +5,7 @@ include usb.mak
 CONFIG_M48T59=y
 CONFIG_PTIMER=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_PCKBD=y
 CONFIG_FDC=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 491a191..fd96345 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -15,6 +15,7 @@ CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
 CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 69a553c..6ea76fe 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -2,7 +2,8 @@ common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
 common-obj-$(CONFIG_PL011) += pl011.o
-common-obj-$(CONFIG_SERIAL) += serial.o serial-isa.o
+common-obj-$(CONFIG_SERIAL) += serial.o
+common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
 common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
 common-obj-$(CONFIG_VIRTIO) += virtio-console.o
 common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
-- 
2.9.3
