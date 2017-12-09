Received: from eggs.gnu.org ([2001:4830:134:3::10]:46071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalZ-000299-KT
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalY-0008IM-Nv
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:49 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:46536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNalY-0008Hj-Ho
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:48 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 760181277DB
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:47 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:37 +0100
Message-Id: <20171209084338.29395-19-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/19] spapr: add support to dump XIVE
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Modify the InterruptStatsProvider output to reflect the interrupt mode
currently in use by the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4d7a3d64e51e..867c9d759f3b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3873,10 +3873,18 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+            spapr_xive_nvt_pic_print_info(SPAPR_XIVE_NVT(cpu->intc), mon=
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
