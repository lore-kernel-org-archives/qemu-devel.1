Received: from eggs.gnu.org ([2001:4830:134:3::10]:36838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2p-00063S-3N
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2m-0001ko-GS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:23 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:42569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUy2m-0001k6-AA
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:20 -0400
Received: from player688.ha.ovh.net (unknown [10.109.120.122])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D48C71911C
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 19:34:18 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 18 Jun 2018 19:34:01 +0200
Message-Id: <20180618173402.23405-3-clg@kaod.org>
In-Reply-To: <20180618173402.23405-1-clg@kaod.org>
References: <20180618173402.23405-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] spapr: remove unused spapr_irq routines
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

spapr_irq_alloc_block and spapr_irq_alloc() are now deprecated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr.h |  4 ---
 hw/ppc/spapr.c         | 80 +-------------------------------------------=
------
 2 files changed, 1 insertion(+), 83 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 15f771acc892..9decc66a1915 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -772,10 +772,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
=20
-int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
-                    Error **errp);
-int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
-                          bool align, Error **errp);
 int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
                    Error **errp);
 #define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, e=
rrp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1fa398111111..2b6d17056012 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3846,84 +3846,6 @@ int spapr_irq_find(sPAPRMachineState *spapr, int n=
um, bool align, Error **errp)
     return first + ics->offset;
 }
=20
-/*
- * Allocate the IRQ number and set the IRQ type, LSI or MSI
- */
-static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
-{
-    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
-}
-
-int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
-                    Error **errp)
-{
-    ICSState *ics =3D spapr->ics;
-    int irq;
-
-    assert(ics);
-
-    if (irq_hint) {
-        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
-            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
-            return -1;
-        }
-        irq =3D irq_hint;
-    } else {
-        irq =3D ics_find_free_block(ics, 1, 1);
-        if (irq < 0) {
-            error_setg(errp, "can't allocate IRQ: no IRQ left");
-            return -1;
-        }
-        irq +=3D ics->offset;
-    }
-
-    spapr_irq_set_lsi(spapr, irq, lsi);
-    trace_spapr_irq_alloc(irq);
-
-    return irq;
-}
-
-/*
- * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
- * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
- */
-int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
-                          bool align, Error **errp)
-{
-    ICSState *ics =3D spapr->ics;
-    int i, first =3D -1;
-
-    assert(ics);
-
-    /*
-     * MSIMesage::data is used for storing VIRQ so
-     * it has to be aligned to num to support multiple
-     * MSI vectors. MSI-X is not affected by this.
-     * The hint is used for the first IRQ, the rest should
-     * be allocated continuously.
-     */
-    if (align) {
-        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
-               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D ics_find_free_block(ics, num, num);
-    } else {
-        first =3D ics_find_free_block(ics, num, 1);
-    }
-    if (first < 0) {
-        error_setg(errp, "can't find a free %d-IRQ block", num);
-        return -1;
-    }
-
-    first +=3D ics->offset;
-    for (i =3D first; i < first + num; ++i) {
-        spapr_irq_set_lsi(spapr, i, lsi);
-    }
-
-    trace_spapr_irq_alloc_block(first, num, lsi, align);
-
-    return first;
-}
-
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
     ICSState *ics =3D spapr->ics;
@@ -3940,7 +3862,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int i=
rq, bool lsi, Error **errp)
         return -1;
     }
=20
-    spapr_irq_set_lsi(spapr, irq, lsi);
+    ics_set_irq_type(ics, irq - ics->offset, lsi);
     return 0;
 }
=20
--=20
2.13.6
