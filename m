Received: from eggs.gnu.org ([2001:4830:134:3::10]:40595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMG-00073R-KQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMF-00041o-GP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:16 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:18:57 +1100
Message-Id: <20180315041903.10046-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/9] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The global hack for creating SCSI devices has recently been removed,
but this apparently broke SCSI devices on some boards that were not
ready for this change yet. For the 40p machine you now get:

$ ppc64-softmmu/qemu-system-ppc64 -M 40p -cdrom x.iso
qemu-system-ppc64: -cdrom x.iso: machine type does not support if=scsi,bus=0,unit=2

Fix it by providing a lsi53c810_create() function that takes care
of calling scsi_bus_legacy_handle_cmdline() after creating the
corresponding SCSI controller.

Fixes: 1454509726719e0933c800fad00d6999752688ea
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c        | 2 +-
 hw/scsi/lsi53c895a.c | 7 +++++++
 include/hw/pci/pci.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 096d4d4cfb..3361509a85 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -788,7 +788,7 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
         qdev_init_nofail(dev);
 
-        pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810");
+        lsi53c810_create(pci_bus, PCI_DEVFN(1, 0));
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
         pci_vga_init(pci_bus);
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f3d4c4d230..160657f4b9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2279,3 +2279,10 @@ void lsi53c895a_create(PCIBus *bus)
 
     scsi_bus_legacy_handle_cmdline(&s->bus);
 }
+
+void lsi53c810_create(PCIBus *bus, int devfn)
+{
+    LSIState *s = LSI53C895A(pci_create_simple(bus, devfn, "lsi53c810"));
+
+    scsi_bus_legacy_handle_cmdline(&s->bus);
+}
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d8c18c7fa4..e255941b5a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -708,6 +708,7 @@ PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
 void lsi53c895a_create(PCIBus *bus);
+void lsi53c810_create(PCIBus *bus, int devfn);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
-- 
2.14.3
