Received: from eggs.gnu.org ([2001:4830:134:3::10]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCz6-0006Qd-Lf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCz2-0008Ah-LC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:20 -0500
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:34015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCz2-00088f-Ft
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:16 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id F092DDCAC3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:20:14 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:16 +0100
Message-Id: <1487931503-10607-18-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/24] ppc/xics: simplify spapr_dt_xics()
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

spapr_dt_xics() only needs the number of servers to build the device
tree nodes. Let's change the routine interface to reflect that.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c  | 4 ++--
 hw/ppc/spapr.c        | 2 +-
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index bc62b0ccc254..35045a20b860 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -387,10 +387,10 @@ void spapr_ics_free(ICSState *ics, int irq, int num=
)
     }
 }
=20
-void spapr_dt_xics(XICSState *xics, void *fdt, uint32_t phandle)
+void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
 {
     uint32_t interrupt_server_ranges_prop[] =3D {
-        0, cpu_to_be32(xics->nr_servers),
+        0, cpu_to_be32(nr_servers),
     };
     int node;
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fa589d5d260c..82f6cfb21ece 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -964,7 +964,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr->xics, fdt, PHANDLE_XICP);
+    spapr_dt_xics(spapr->xics->nr_servers, fdt, PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1961ee2a690f..879853cc69c2 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -201,7 +201,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp);
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
                            Error **errp);
 void spapr_ics_free(ICSState *ics, int irq, int num);
-void spapr_dt_xics(XICSState *xics, void *fdt, uint32_t phandle);
+void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
=20
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
 ICPState *xics_icp_get(XICSFabric *xi, int server);
--=20
2.7.4
