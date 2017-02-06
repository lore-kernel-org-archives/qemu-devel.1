Received: from eggs.gnu.org ([2001:4830:134:3::10]:35293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHJ-0004cY-HM
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHI-00008U-FK
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Feb 2017 12:39:26 +1100
Message-Id: <20170206013927.13693-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170206013927.13693-1-david@gibson.dropbear.id.au>
References: <20170206013927.13693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/3] Allow ISA bus to be configured out
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

Currently, the code to handle the legacy ISA bus is always included in
qemu.  However there are lots of platforms that don't include ISA legacy
devies, and quite a few that have never used ISA legacy devices at all.

This patch allows the ISA bus code to be disabled in the configuration for
platforms where it doesn't make sense.

For now, the default configs are adjusted to include ISA on all platforms
including PCI: anything with PCI can at least in principle add an i82378
PCI->ISA bridge.  Also, CONFIG_IDE_CORE which is already in pci.mak
requires ISA support.

We also explicitly enable ISA on some other non-PCI platforms which include
ISA devices: moxie, sparc and unicore32.  We may want to pare this down in
future.

The platforms that will lose ISA by default are: cris, lm32, microblazeel,
microblaze, openrisc, s390x, tricore, xtensaeb, xtensa.  As far as I can
tell none of these ever used ISA.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/moxie-softmmu.mak     | 1 +
 default-configs/pci.mak               | 2 ++
 default-configs/sparc-softmmu.mak     | 1 +
 default-configs/unicore32-softmmu.mak | 1 +
 hw/isa/Makefile.objs                  | 2 +-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index 7e22863..e00d099 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -1,5 +1,6 @@
 # Default configuration for moxie-softmmu
 
+CONFIG_ISA_BUS=y
 CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index d8d6548..60dc651 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -1,4 +1,6 @@
 CONFIG_PCI=y
+# For now, CONFIG_IDE_CORE requires ISA, so we enable it here
+CONFIG_ISA_BUS=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_USB_UHCI=y
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index ab796b3..004b0f4 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -1,5 +1,6 @@
 # Default configuration for sparc-softmmu
 
+CONFIG_ISA_BUS=y
 CONFIG_ECC=y
 CONFIG_ESP=y
 CONFIG_ESCC=y
diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index de38577..5f6c4a8 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -1,4 +1,5 @@
 # Default configuration for unicore32-softmmu
+CONFIG_ISA_BUS=y
 CONFIG_PUV3=y
 CONFIG_PTIMER=y
 CONFIG_PCKBD=y
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 9164556..fb37c55 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += isa-bus.o
+common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
-- 
2.9.3
