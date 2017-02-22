Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-00036H-OE
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV7-000871-Ch
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:25 +1100
Message-Id: <20170222063348.32176-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/43] ppc4xx: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc4xx_pci.c | 13 +++----------
 hw/ppc/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 683218e..dc19682 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -26,13 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
-
-#undef DEBUG
-#ifdef DEBUG
-#define DPRINTF(fmt, ...) do { printf(fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif /* DEBUG */
+#include "trace.h"
=20
 struct PCIMasterMap {
     uint32_t la;
@@ -249,8 +243,7 @@ static int ppc4xx_pci_map_irq(PCIDevice *pci_dev, int=
 irq_num)
 {
     int slot =3D pci_dev->devfn >> 3;
=20
-    DPRINTF("%s: devfn %x irq %d -> %d\n", __func__,
-            pci_dev->devfn, irq_num, slot);
+    trace_ppc4xx_pci_map_irq(pci_dev->devfn, irq_num, slot);
=20
     return slot - 1;
 }
@@ -259,7 +252,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_=
num, int level)
 {
     qemu_irq *pci_irqs =3D opaque;
=20
-    DPRINTF("%s: PCI irq %d\n", __func__, irq_num);
+    trace_ppc4xx_pci_set_irq(irq_num);
     if (irq_num < 0) {
         fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
         return;
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 6122a12..f04bb1d 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -89,3 +89,7 @@ rs6000mc_parity_read(uint32_t addr, uint32_t val) "read=
 addr=3D%x val=3D%x"
 # hw/ppc/mac_newworld.c
 mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 =
" val=3D0x%"PRIx64
 mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 "=
 val=3D0x%"PRIx64
+
+# hw/ppc/ppc4xx_pci.c
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %x irq %=
d -> %d"
+ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
--=20
2.9.3
