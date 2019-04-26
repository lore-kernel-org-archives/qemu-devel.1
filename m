Received: from eggs.gnu.org ([209.51.188.92]:60475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065U-2D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00059Y-3S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:19 +1000
Message-Id: <20190426060627.18153-29-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/36] spapr_pci: Get rid of duplicate code for
 node name creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
introduced to "make it easier to relate the guest and qemu views of memor=
y
to each other", hence its name.

Use it when creating the PHB node to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d6d0a7115c..f005854dec 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2176,7 +2176,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
                           uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
-    gchar *nodename;
     uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
     struct {
         uint32_t hi;
@@ -2227,9 +2226,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
     Error *errp =3D NULL;
=20
     /* Start populating the FDT */
-    nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
-    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
     if (node_offset) {
         *node_offset =3D bus_off;
     }
--=20
2.20.1
