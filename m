Received: from eggs.gnu.org ([2001:4830:134:3::10]:41057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsV-0003DP-IV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsR-0002gS-1n
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:15 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:57211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnsQ-0002fk-R3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:10 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 81075FCC9F
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:15 +0200
Message-Id: <1499274819-15607-3-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 02/26] spapr: populate device tree
 depending on XIVE_EXPLOIT option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When XIVE is supported, the device tree should be populated
accordingly and the XIVE memory regions mapped to activate MMIOs.

Depending on the design we choose, we could also allocate different
ICS and ICP objects, or switch between objects. This needs to be
discussed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 27b12adc3582..0256e7a537bf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -778,6 +778,11 @@ static int spapr_dt_cas_updates(sPAPRMachineState *s=
papr, void *fdt,
         }
     }
=20
+    /* /interrupt controller */
+    if (!spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    }
+
     offset =3D fdt_path_offset(fdt, "/chosen");
     if (offset < 0) {
         offset =3D fdt_add_subnode(fdt, 0, "chosen");
@@ -801,7 +806,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *s=
papr,
=20
     size -=3D sizeof(hdr);
=20
-    /* Create sceleton */
+    /* Create skeleton */
     fdt_skel =3D g_malloc0(size);
     _FDT((fdt_create(fdt_skel, size)));
     _FDT((fdt_begin_node(fdt_skel, "")));
@@ -1069,9 +1074,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
-    /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
-
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
         error_report("couldn't setup memory nodes in fdt");
--=20
2.7.5
