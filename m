Received: from eggs.gnu.org ([2001:4830:134:3::10]:35623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s50-0004pS-Sx
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s4x-0005uv-NT
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:02 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:56716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s4x-0005uU-HM
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:59 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 476BD6379A
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:12:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:13 +0100
Message-Id: <20171029181217.9927-5-clg@kaod.org>
In-Reply-To: <20171029181217.9927-1-clg@kaod.org>
References: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/8] spapr: split the IRQ number space for LSI
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The nature of an interrupt, MSI or LSI, is stored under the flag
attribute of the ICSIRQState array. To reduce the use of this array
and consequently of the ICSState object (needed to introduce for the
new XIVE model), we choose to split the IRQ number space of the
machine in two: first the LSIs and then the MSIs.

This also has the benefit to keep the LSI IRQ numbers in a well known
range which will be useful for PHB hotplug.

For compatibility with older machines, we use the machine class flag
'pre_2_11_has_no_bitmap'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c  |  6 +++---
 hw/ppc/spapr.c        | 25 ++++++++++++++++++++++---
 include/hw/ppc/xics.h |  2 +-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index f2e20bca5b2e..e1f158302a6a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -257,7 +257,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
         }
         irq =3D irq_hint;
     } else {
-        irq =3D xic->irq_alloc_block(ics->xics, 1, 0);
+        irq =3D xic->irq_alloc_block(ics->xics, 1, 0, lsi);
         if (irq < 0) {
             error_setg(errp, "can't allocate IRQ: no IRQ left");
             return -1;
@@ -291,9 +291,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
     if (align) {
         assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
                (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D xic->irq_alloc_block(ics->xics, num, num);
+        first =3D xic->irq_alloc_block(ics->xics, num, num, lsi);
     } else {
-        first =3D xic->irq_alloc_block(ics->xics, num, 0);
+        first =3D xic->irq_alloc_block(ics->xics, num, 0, lsi);
     }
     if (first < 0) {
         error_setg(errp, "can't find a free %d-IRQ block", num);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b33eebe44906..5e42e3329ef4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1696,6 +1696,13 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
     },
 };
=20
+/*
+ * Let's provision 4 LSIs per PHBs
+ */
+#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
+                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
+#define SPAPR_MAX_LSI (SPAPR_MAX_PHBS * 4)
+
 static bool spapr_irq_map_needed(void *opaque)
 {
     sPAPRMachineState *spapr =3D opaque;
@@ -3523,8 +3530,6 @@ static void spapr_phb_placement(sPAPRMachineState *=
spapr, uint32_t index,
      * 1TiB 64-bit MMIO windows for each PHB.
      */
     const uint64_t base_buid =3D 0x800000020000000ULL;
-#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
-                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
     int i;
=20
     /* Sanity check natural alignments */
@@ -3583,18 +3588,32 @@ static bool spapr_irq_test(XICSFabric *xi, int ir=
q)
     return test_bit(srcno, spapr->irq_map);
 }
=20
-static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
+/*
+ * Split the IRQ number space of the machine in two: first the LSIs
+ * and then the MSIs. This allows us to keep the LSI IRQ numbers in a
+ * well known range which is useful for PHB hotplug.
+ */
+static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align, b=
ool lsi)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int start =3D 0;
     int srcno;
=20
+    if (!lsi && !smc->pre_2_11_has_no_bitmap) {
+        start =3D SPAPR_MAX_LSI;
+    }
+
     srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_irqs,=
 start,
                                        count, align);
     if (srcno =3D=3D spapr->nr_irqs) {
         return -1;
     }
=20
+    if (lsi && !smc->pre_2_11_has_no_bitmap && srcno >=3D SPAPR_MAX_LSI)=
 {
+        return -1;
+    }
+
     bitmap_set(spapr->irq_map, srcno, count);
     return srcno + spapr->irq_base;
 }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 30e7f2e0a7dd..c8e6637d16e4 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -177,7 +177,7 @@ typedef struct XICSFabricClass {
     ICPState *(*icp_get)(XICSFabric *xi, int server);
     /* IRQ allocator helpers */
     bool (*irq_test)(XICSFabric *xi, int irq);
-    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
+    int (*irq_alloc_block)(XICSFabric *xi, int count, int align, bool ls=
i);
     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
 } XICSFabricClass;
=20
--=20
2.13.6
