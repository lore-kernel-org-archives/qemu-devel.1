Received: from eggs.gnu.org ([209.51.188.92]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjws-0005XA-54
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwo-0002dp-SN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:11 +1100
Message-Id: <20190218143049.17142-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/43] spapr_pci: Fix interrupt leak in
 rtas_ibm_change_msi() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Now that IRQ allocation has been split in two (first allocate IRQ numbers=
,
then claim them), if the claiming fails, we must release the IRQs.

Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 41d81f4a85..c3fb0ac884 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     for (i =3D 0; i < req_num; i++) {
         spapr_irq_claim(spapr, irq + i, false, &err);
         if (err) {
+            if (i) {
+                spapr_irq_free(spapr, irq, i);
+            }
+            if (!smc->legacy_irq_allocation) {
+                spapr_irq_msi_free(spapr, irq, req_num);
+            }
             error_reportf_err(err, "Can't allocate MSIs for device %x: "=
,
                               config_addr);
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
--=20
2.20.1
