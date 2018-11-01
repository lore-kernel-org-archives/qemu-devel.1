Received: from eggs.gnu.org ([2001:4830:134:3::10]:59826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAY-0005kB-0X
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAX-0003zl-1q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:61557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIAAW-0003NB-Jf
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:40 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:23:02 +0100
Message-Id: <20181101102303.16439-23-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 22/23] hw: i386: Set ACPI configuration PCI
 host pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

For both PC and Q35 machine types, we can set it at the PCI host
bridge creation time.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/pc_piix.c | 1 +
 hw/i386/pc_q35.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f5b139a3eb..f1f0de3585 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -216,6 +216,7 @@ static void pc_init1(MachineState *machine,
         no_hpet = 1;
     }
     isa_bus_irqs(isa_bus, pcms->gsi);
+    acpi_conf->pci_host = pci_host;
 
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cdde4a4beb..a8772e29a5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -188,6 +188,7 @@ static void pc_q35_init(MachineState *machine)
     qdev_init_nofail(DEVICE(q35_host));
     phb = PCI_HOST_BRIDGE(q35_host);
     host_bus = phb->bus;
+    acpi_conf->pci_host = phb;
     /* create ISA bus */
     lpc = pci_create_simple_multifunction(host_bus, PCI_DEVFN(ICH9_LPC_DEV,
                                           ICH9_LPC_FUNC), true,
-- 
2.19.1
