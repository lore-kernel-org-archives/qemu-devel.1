Received: from eggs.gnu.org ([2001:4830:134:3::10]:57889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wc-0000rf-7f
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wY-0000Wc-Bp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:46 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:38597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wY-0000W8-4H
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:42 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.111])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B30EBD38DF
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:40 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:16 +0200
Message-Id: <20180419124331.3915-21-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 20/35] spapr: add support to dump XIVE
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Modify the InterruptStatsProvider output to reflect the interrupt mode
currently in use by the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0c59816bf3d6..e3567543e6e6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4015,10 +4015,18 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+            xive_nvt_pic_print_info(XIVE_NVT(cpu->intc), mon);
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
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
--=20
2.13.6
