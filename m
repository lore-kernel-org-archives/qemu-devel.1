Received: from eggs.gnu.org ([2001:4830:134:3::10]:46748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7u-0008Bp-MJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7r-0000Cx-EP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:57 +1100
Message-Id: <20170301044405.1792-43-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/50] ppc/xics: simplify spapr_dt_xics()
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

spapr_dt_xics() only needs the number of servers to build the device
tree nodes. Let's change the routine interface to reflect that.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c  | 4 ++--
 hw/ppc/spapr.c        | 2 +-
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index bc62b0c..35045a2 100644
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
index f9289c6..7ad932f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -966,7 +966,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
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
index c57e80e..f618848 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -202,7 +202,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
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
2.9.3
