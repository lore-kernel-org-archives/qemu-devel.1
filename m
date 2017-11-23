Received: from eggs.gnu.org ([2001:4830:134:3::10]:40361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcr-0002Ys-6h
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcl-0003is-FL
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:09 -0500
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcl-0003hX-9L
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:03 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3198E175B24
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:33:02 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:54 +0100
Message-Id: <20171123132955.1261-25-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/25] spapr: add support to dump XIVE
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Modify the InterruptStatsProvider output to reflect the interrupt mode
currently in use by the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b7389dbdf5ca..9fe3a9966b12 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3785,10 +3785,18 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+            spapr_xive_icp_pic_print_info(SPAPR_XIVE_ICP(cpu->intc), mon=
);
+        } else {
+            icp_pic_print_info(ICP(cpu->intc), mon);
+        }
     }
=20
-    ics_pic_print_info(spapr->ics, mon);
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_pic_print_info(spapr->xive, mon);
+    } else {
+        ics_pic_print_info(spapr->ics, mon);
+    }
 }
=20
 int spapr_vcpu_id(PowerPCCPU *cpu)
--=20
2.13.6
