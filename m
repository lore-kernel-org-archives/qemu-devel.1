Received: from eggs.gnu.org ([2001:4830:134:3::10]:47612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB72-0007cp-S1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB6y-0005de-Pi
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:56 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:51355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eDB6y-0005aq-Iu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:52 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8F1C59C179
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:20:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Nov 2017 15:20:09 +0000
Message-Id: <20171110152017.24324-4-clg@kaod.org>
In-Reply-To: <20171110152017.24324-1-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 03/11] spapr: introduce new
 XICSFabric operations for an IRQ allocator
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

Currently, the ICSState 'ics' object of the sPAPR machine acts as the
global interrupt source handler and also as the IRQ number allocator
for the machine. Some IRQ numbers are allocated very early in the
machine initialization sequence to populate the device tree, and this
is a problem to introduce the new POWER XIVE interrupt model, as it
needs to share the IRQ numbers with the older model.

To prepare ground for XIVE, here is a set of new XICSFabric operations
to let the machine handle directly the IRQ number allocation and to
decorrelate the allocation from the interrupt source object :

    bool (*irq_test)(XICSFabric *xi, int irq);
    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
    void (*irq_free_block)(XICSFabric *xi, int irq, int num);

In these prototypes, the 'irq' parameter refers to a number in the
global IRQ number space. Indexes for arrays storing different state
informations on the interrupts, like the ICSIRQState, are usually
named 'srcno'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c        | 19 +++++++++++++++++++
 include/hw/ppc/xics.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a2dcbee07214..84d68f2fdbae 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3536,6 +3536,21 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 vcpu_id)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+static bool spapr_irq_test(XICSFabric *xi, int irq)
+{
+    return false;
+}
+
+static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
+{
+    return -1;
+}
+
+static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
+{
+    ;
+}
+
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
@@ -3630,6 +3645,10 @@ static void spapr_machine_class_init(ObjectClass *=
oc, void *data)
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
+    xic->irq_test =3D spapr_irq_test;
+    xic->irq_alloc_block =3D spapr_irq_alloc_block;
+    xic->irq_free_block =3D spapr_irq_free_block;
+
     ispc->print_info =3D spapr_pic_print_info;
     /* Force NUMA node memory size to be a multiple of
      * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 28d248abad61..30e7f2e0a7dd 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -175,6 +175,10 @@ typedef struct XICSFabricClass {
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
     ICPState *(*icp_get)(XICSFabric *xi, int server);
+    /* IRQ allocator helpers */
+    bool (*irq_test)(XICSFabric *xi, int irq);
+    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
+    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
 } XICSFabricClass;
=20
 #define XICS_IRQS_SPAPR               1024
--=20
2.13.6
