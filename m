Received: from eggs.gnu.org ([2001:4830:134:3::10]:54453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoK-0007mj-Fq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoE-0008WC-GM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:12 -0400
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:43515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSoE-0008V7-9Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:06 -0400
Received: from player738.ha.ovh.net (unknown [10.109.122.87])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6B9221BA287
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:01:04 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:39 +0200
Message-Id: <20180614140043.9231-3-clg@kaod.org>
In-Reply-To: <20180614140043.9231-1-clg@kaod.org>
References: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] ppc/pnv: move the details of the ISA bus
 creation under the LPC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is a small cleanup to hide to the machine the gory details of the
creation of the ISA bus. When time comes, the 'qemu_irq_handler' should
become a LPC controller class attribute.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_lpc.h |  3 +--
 hw/ppc/pnv.c             | 15 +--------------
 hw/ppc/pnv_lpc.c         | 24 ++++++++++++++++++++----
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index fddcb1c054b3..fb4b7b83d798 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -72,7 +72,6 @@ typedef struct PnvLpcController {
     bool   primary;
 } PnvLpcController;
=20
-qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
-                                 int nirqs);
+ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type);
=20
 #endif /* _PPC_PNV_LPC_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b419d3323100..d2126ee4affc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -521,22 +521,9 @@ static void pnv_reset(void)
=20
 static ISABus *pnv_isa_create(PnvChip *chip)
 {
-    PnvLpcController *lpc =3D &chip->lpc;
-    ISABus *isa_bus;
-    qemu_irq *irqs;
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
=20
-    /* let isa_bus_new() create its own bridge on SysBus otherwise
-     * devices speficied on the command line won't find the bus and
-     * will fail to create.
-     */
-    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
-                          &error_fatal);
-
-    irqs =3D pnv_lpc_isa_irq_create(lpc, pcc->chip_type, ISA_NUM_IRQS);
-
-    isa_bus_irqs(isa_bus, irqs);
-    return isa_bus;
+    return pnv_lpc_isa_create(&chip->lpc, pcc->chip_type);
 }
=20
 static void pnv_init(MachineState *machine)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 1e70c8c19d52..7c6c012d5176 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "hw/isa/isa.h"
=20
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_lpc.h"
@@ -546,16 +547,31 @@ static void pnv_lpc_isa_irq_handler(void *opaque, i=
nt n, int level)
     }
 }
=20
-qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
-                                 int nirqs)
+ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type)
 {
+    ISABus *isa_bus;
+    qemu_irq *irqs;
+    qemu_irq_handler handler;
+
+    /* let isa_bus_new() create its own bridge on SysBus otherwise
+     * devices speficied on the command line won't find the bus and
+     * will fail to create.
+     */
+    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
+                          &error_fatal);
+
     /* Not all variants have a working serial irq decoder. If not,
      * handling of LPC interrupts becomes a platform issue (some
      * platforms have a CPLD to do it).
      */
     if (chip_type =3D=3D PNV_CHIP_POWER8NVL) {
-        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler, lpc, nirqs);
+        handler =3D pnv_lpc_isa_irq_handler;
     } else {
-        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, lpc, nir=
qs);
+        handler =3D pnv_lpc_isa_irq_handler_cpld;
     }
+
+    irqs =3D qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
+
+    isa_bus_irqs(isa_bus, irqs);
+    return isa_bus;
 }
--=20
2.13.6
