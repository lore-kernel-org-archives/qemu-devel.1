Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpt-0007Dj-Mh
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpp-0007q8-OL
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:53 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbpp-0007pe-GR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:49 -0500
Received: from player734.ha.ovh.net (unknown [10.109.159.68])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1E28310AB90
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:58:48 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:05 +0100
Message-Id: <20181116105729.23240-13-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 12/36] spapr: initialize VSMT before
 initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We will need to use xics_max_server_number() to create the sPAPRXive
object modeling the interrupt controller of the machine which is
created before the CPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7afd1a175bf2..50cb9f9f4a02 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
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
@@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *machi=
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
2.17.2
