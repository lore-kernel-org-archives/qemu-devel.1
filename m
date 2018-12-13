Received: from eggs.gnu.org ([2001:4830:134:3::10]:50894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICB-0003kl-1M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC6-0002BR-1M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:17 +1100
Message-Id: <20181213040126.6768-19-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/27] spapr: initialize VSMT before
 initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

We will need to use xics_max_server_number() to create the sPAPRXive
object modeling the interrupt controller of the machine which is
created before the CPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 051d080fe5..5862c6d4fa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2464,11 +2464,6 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
         boot_cores_nr =3D possible_cpus->len;
     }
=20
-    /* VSMT must be set in order to be able to compute VCPU ids, ie to
-     * call xics_max_server_number() or spapr_vcpu_id().
-     */
-    spapr_set_vsmt_mode(spapr, &error_fatal);
-
     if (smc->pre_2_10_has_unused_icps) {
         int i;
=20
@@ -2591,6 +2586,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
+    /* VSMT must be set in order to be able to compute VCPU ids, ie to
+     * call xics_max_server_number() or spapr_vcpu_id().
+     */
+    spapr_set_vsmt_mode(spapr, &error_fatal);
+
     /* Set up Interrupt Controller before we create the VCPUs */
     smc->irq->init(spapr, &error_fatal);
=20
--=20
2.19.2
