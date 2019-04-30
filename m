Received: from eggs.gnu.org ([209.51.188.92]:54905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMyn-0005qc-Ap
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMyj-0004H6-Ih
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:15:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 30 Apr 2019 09:13:38 +0200
Message-Id: <20190430071405.16714-4-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 03/30] hw/usb/hcd-ohci: Do not use PCI
 functions with sysbus devices in ohci_die()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Cedric Le Goater <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, qemu-block@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Andrey Smirnov <andrew.smirnov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

The ohci_die() function always assumes to be running with a PCI OHCI
controller and calls the PCI-specific functions pci_set_word(). However,
this function might also get called for the sysbus OHCI devices, so it
likely fails in that case. To fix this issue, change the code now, so tha=
t
there are two implementations now, one for sysbus and one for PCI, and
use the right function via a function pointer in the OHCIState structure.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-ohci.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 81cf5ab7a5..6d3f556989 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -52,7 +52,7 @@ typedef struct OHCIPort {
     uint32_t ctrl;
 } OHCIPort;
=20
-typedef struct {
+typedef struct OHCIState {
     USBBus bus;
     qemu_irq irq;
     MemoryRegion mem;
@@ -108,6 +108,7 @@ typedef struct {
     uint32_t async_td;
     bool async_complete;
=20
+    void (*ohci_die)(struct OHCIState *ohci);
 } OHCIState;
=20
 /* Host Controller Communications Area */
@@ -302,7 +303,10 @@ struct ohci_iso_td {
=20
 #define OHCI_HRESET_FSBIR       (1 << 0)
=20
-static void ohci_die(OHCIState *ohci);
+static void ohci_die(OHCIState *ohci)
+{
+    ohci->ohci_die(ohci);
+}
=20
 /* Update IRQ levels */
 static inline void ohci_intr_update(OHCIState *ohci)
@@ -1854,13 +1858,14 @@ static USBBusOps ohci_bus_ops =3D {
=20
 static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
                           uint32_t num_ports, dma_addr_t localmem_base,
-                          char *masterbus, uint32_t firstport,
-                          AddressSpace *as, Error **errp)
+                          char *masterbus, uint32_t firstport, AddressSp=
ace *as,
+                          void (*ohci_die_fn)(struct OHCIState *), Error=
 **errp)
 {
     Error *err =3D NULL;
     int i;
=20
     ohci->as =3D as;
+    ohci->ohci_die =3D ohci_die_fn;
=20
     if (num_ports > OHCI_MAX_PORTS) {
         error_setg(errp, "OHCI num-ports=3D%u is too big (limit is %u po=
rts)",
@@ -1933,18 +1938,28 @@ typedef struct {
     uint32_t firstport;
 } OHCIPCIState;
=20
-/** A typical O/EHCI will stop operating, set itself into error state
- * (which can be queried by MMIO) and will set PERR in its config
- * space to signal that it got an error
+/**
+ * A typical OHCI will stop operating and set itself into error state
+ * (which can be queried by MMIO) to signal that it got an error.
  */
-static void ohci_die(OHCIState *ohci)
+static void ohci_sysbus_die(struct OHCIState *ohci)
 {
-    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
-
     trace_usb_ohci_die();
=20
     ohci_set_interrupt(ohci, OHCI_INTR_UE);
     ohci_bus_stop(ohci);
+}
+
+/**
+ * A typical PCI OHCI will additionally set PERR in its configspace to
+ * signal that it got an error.
+ */
+static void ohci_pci_die(struct OHCIState *ohci)
+{
+    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
+
+    ohci_sysbus_die(ohci);
+
     pci_set_word(dev->parent_obj.config + PCI_STATUS,
                  PCI_STATUS_DETECTED_PARITY);
 }
@@ -1959,7 +1974,7 @@ static void usb_ohci_realize_pci(PCIDevice *dev, Er=
ror **errp)
=20
     usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
                   ohci->masterbus, ohci->firstport,
-                  pci_get_address_space(dev), &err);
+                  pci_get_address_space(dev), ohci_pci_die, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -2023,7 +2038,7 @@ static void ohci_realize_pxa(DeviceState *dev, Erro=
r **errp)
=20
     usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
                   s->masterbus, s->firstport,
-                  &address_space_memory, &err);
+                  &address_space_memory, ohci_sysbus_die, &err);
     if (err) {
         error_propagate(errp, err);
         return;
--=20
2.21.0
