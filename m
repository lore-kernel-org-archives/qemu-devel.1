Received: from eggs.gnu.org ([2001:4830:134:3::10]:39085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCT-0002YW-0n
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCO-00044F-0j
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:45 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:58811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCN-00043W-Pl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:39 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.69])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2FCB21BD82E
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:50 +0200
Message-Id: <20180607155003.1580-16-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/28] spapr: initialize VSMT before
 initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We will need to use xics_max_server_number() to create the sPAPRXive
object modeling the interrupt controller of the machine which is
created before the CPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c097a7093e62..ae915a3b4803 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2423,11 +2423,6 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
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
@@ -2547,6 +2542,11 @@ static void spapr_machine_init(MachineState *machi=
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
2.13.6
