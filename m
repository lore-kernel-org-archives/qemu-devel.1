Received: from eggs.gnu.org ([2001:4830:134:3::10]:45742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qV-0007nH-CQ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qU-0005cT-J6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qU-0005bp-B3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:14 -0500
Date: Thu, 21 Dec 2017 16:29:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-10-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/25] pci: Eliminate pci_find_primary_bus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: David Gibson <david@gibson.dropbear.id.au>

pci_find_primary_bus() only has one user, in pc_xen_hvm_init().  That's
inside the machine construction code, so it already has easy access to the
machine's primary PCI bus.

Get it directly, and thereby remove pci_find_primary_bus().  This removes
one of only a handful of users of the ugly pci_host_bridges global.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/pci/pci.h |  1 -
 hw/i386/pc_piix.c    |  8 ++------
 hw/pci/pci.c         | 16 ----------------
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 597ffb7..15ced96 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -467,7 +467,6 @@ void pci_for_each_bus(PCIBus *bus,
     pci_for_each_bus_depth_first(bus, NULL, fn, opaque);
 }
 
-PCIBus *pci_find_primary_bus(void);
 PCIBus *pci_device_root_bus(const PCIDevice *d);
 const char *pci_root_bus_path(PCIDevice *dev);
 PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528..2febd0e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -394,7 +394,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
 
 static void pc_xen_hvm_init(MachineState *machine)
 {
-    PCIBus *bus;
+    PCMachineState *pcms = PC_MACHINE(machine);
 
     if (!xen_enabled()) {
         error_report("xenfv machine requires the xen accelerator");
@@ -402,11 +402,7 @@ static void pc_xen_hvm_init(MachineState *machine)
     }
 
     pc_xen_hvm_init_pci(machine);
-
-    bus = pci_find_primary_bus();
-    if (bus != NULL) {
-        pci_create_simple(bus, -1, "xen-platform");
-    }
+    pci_create_simple(pcms->bus, -1, "xen-platform");
 }
 #endif
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 567be1b..e8f9fc1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -331,22 +331,6 @@ static void pci_host_bus_register(DeviceState *host)
     QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
 }
 
-PCIBus *pci_find_primary_bus(void)
-{
-    PCIBus *primary_bus = NULL;
-    PCIHostState *host;
-
-    QLIST_FOREACH(host, &pci_host_bridges, next) {
-        if (primary_bus) {
-            /* We have multiple root buses, refuse to select a primary */
-            return NULL;
-        }
-        primary_bus = host->bus;
-    }
-
-    return primary_bus;
-}
-
 PCIBus *pci_device_root_bus(const PCIDevice *d)
 {
     PCIBus *bus = pci_get_bus(d);
-- 
MST
