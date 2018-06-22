Received: from eggs.gnu.org ([2001:4830:134:3::10]:45852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPx-0000kZ-Mh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPu-0003Uo-HR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:15 +1000
Message-Id: <20180622103528.28598-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/25] spapr: remove unused spapr_irq routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

spapr_irq_alloc_block and spapr_irq_alloc() are now deprecated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 80 +-----------------------------------------
 include/hw/ppc/spapr.h |  4 ---
 2 files changed, 1 insertion(+), 83 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b7705c3944..78186500e9 100644
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6bfdf5a2fb..8a9142244f 100644
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
--=20
2.17.1
