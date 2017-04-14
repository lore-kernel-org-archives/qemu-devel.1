Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywjc-0006oc-6C
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywjX-0008Pt-Se
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:40 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 14 Apr 2017 10:37:16 +0200
Message-Id: <20170414083717.13641-4-lvivier@redhat.com>
In-Reply-To: <20170414083717.13641-1-lvivier@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] versatile: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>, Antony Pavlov <antonynpavlov@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>

cannot_destroy_with_object_finalize_yet was added by 4c315c2
("qdev: Protect device-list-properties against broken devices")
because "realview_pci" and "versatile_pci" were hanging
during "device-list-properties" cleanup (an infinite loop in
bus_unparent()).

We have this problem because the child is not removed from
the list of the PCI bus child because it has no defined parent:
qdev_set_parent_bus() set the device parent_bus pointer to bus, and
adds the device in the bus children list, but doesn't update the
device parent pointer.

To fix the problem, move all the involved parts to the realize function.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/pci-host/versatile.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 467cbb9..27fde46 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -380,20 +380,8 @@ static void pci_vpb_reset(DeviceState *d)
 
 static void pci_vpb_init(Object *obj)
 {
-    PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PCIVPBState *s = PCI_VPB(obj);
 
-    memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << 32);
-    memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL << 32);
-
-    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), "pci",
-                        &s->pci_mem_space, &s->pci_io_space,
-                        PCI_DEVFN(11, 0), TYPE_PCI_BUS);
-    h->bus = &s->pci_bus;
-
-    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
-    qdev_set_parent_bus(DEVICE(&s->pci_dev), BUS(&s->pci_bus));
-
     /* Window sizes for VersatilePB; realview_pci's init will override */
     s->mem_win_size[0] = 0x0c000000;
     s->mem_win_size[1] = 0x10000000;
@@ -403,10 +391,22 @@ static void pci_vpb_init(Object *obj)
 static void pci_vpb_realize(DeviceState *dev, Error **errp)
 {
     PCIVPBState *s = PCI_VPB(dev);
+    PCIHostState *h = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     pci_map_irq_fn mapfn;
     int i;
 
+    memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << 32);
+    memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL << 32);
+
+    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), dev, "pci",
+                        &s->pci_mem_space, &s->pci_io_space,
+                        PCI_DEVFN(11, 0), TYPE_PCI_BUS);
+    h->bus = &s->pci_bus;
+
+    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
+    qdev_set_parent_bus(DEVICE(&s->pci_dev), BUS(&s->pci_bus));
+
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
@@ -503,8 +503,6 @@ static void pci_vpb_class_init(ObjectClass *klass, void *data)
     dc->reset = pci_vpb_reset;
     dc->vmsd = &pci_vpb_vmstate;
     dc->props = pci_vpb_properties;
-    /* Reason: object_unref() hangs */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo pci_vpb_info = {
@@ -526,19 +524,10 @@ static void pci_realview_init(Object *obj)
     s->mem_win_size[2] = 0x08000000;
 }
 
-static void pci_realview_class_init(ObjectClass *class, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(class);
-
-    /* Reason: object_unref() hangs */
-    dc->cannot_destroy_with_object_finalize_yet = true;
-}
-
 static const TypeInfo pci_realview_info = {
     .name          = "realview_pci",
     .parent        = TYPE_VERSATILE_PCI,
     .instance_init = pci_realview_init,
-    .class_init    = pci_realview_class_init,
 };
 
 static void versatile_pci_register_types(void)
-- 
2.9.3
