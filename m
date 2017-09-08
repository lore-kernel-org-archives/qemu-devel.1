Received: from eggs.gnu.org ([2001:4830:134:3::10]:54643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMZ-0004Mh-I2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMY-0001SX-3u
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:31 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:43402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqKMX-0001Rv-UX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:30 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E014693060
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:34:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  8 Sep 2017 16:33:44 +0200
Message-Id: <20170908143344.12960-4-clg@kaod.org>
In-Reply-To: <20170908143344.12960-1-clg@kaod.org>
References: <20170908143344.12960-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 3/3] spapr: generate a CAS reset for the
 XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When the platform and the guest agree on using the XIVE exploitation
mode for interrupts, the "interrupt-controller" node needs to reflect
the change and the device tree needs an update.

Reseting the guest after the CAS negotiation makes this change
possible, as the device tree is built at reset time. We use the
'ov5_cas' field to check which interrupt model was negotiated before
reset and populate the tree accordingly.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c       | 6 +++++-
 hw/ppc/spapr_hcall.c | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3e3ff1fbc988..be467ab61ad0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1073,7 +1073,11 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    } else {
+        /* populate device tree for XIVE */ ;
+    }
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 92f1e21358b8..ba00b8d3fdd6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1613,6 +1613,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) !=3D 0);
     }
+
+    /* We need to rebuild the device tree for XIVE, generate a reset */
+    if (!spapr->cas_reboot) {
+        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT);
+    }
+
     spapr_ovec_cleanup(ov5_updates);
=20
     if (spapr->cas_reboot) {
--=20
2.13.5
