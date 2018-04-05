Received: from eggs.gnu.org ([2001:4830:134:3::10]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQL-0001XW-Hd
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQH-0000sH-5m
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:14:27 +1000
Message-Id: <20180405021437.16761-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180405021437.16761-1-david@gibson.dropbear.id.au>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.13 03/13] target/ppc: Pass cpu instead of
 env to ppc_create_page_sizes_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

As a rule we prefer to pass PowerPCCPU instead of CPUPPCState, and this
change will make some things simpler later on.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/fdt.c         | 5 +++--
 hw/ppc/pnv.c         | 4 ++--
 hw/ppc/spapr.c       | 4 ++--
 include/hw/ppc/fdt.h | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
index 2ffc5866e4..2721603ffa 100644
--- a/hw/ppc/fdt.c
+++ b/hw/ppc/fdt.c
@@ -13,9 +13,10 @@
 #include "hw/ppc/fdt.h"
=20
 #if defined(TARGET_PPC64)
-size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
-                                     size_t maxsize)
+size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
+                                  size_t maxsize)
 {
+    CPUPPCState *env =3D &cpu->env;
     size_t maxcells =3D maxsize / sizeof(uint32_t);
     int i, j, count;
     uint32_t *p =3D prop;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 98ee3c607a..5a79b24828 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -209,8 +209,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
     }
=20
-    page_sizes_prop_size =3D ppc_create_page_sizes_prop(env, page_sizes_=
prop,
-                                                  sizeof(page_sizes_prop=
));
+    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_sizes_=
prop,
+                                                      sizeof(page_sizes_=
prop));
     if (page_sizes_prop_size) {
         _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
                            page_sizes_prop, page_sizes_prop_size)));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e764f999c5..14c31f82fa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -581,8 +581,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
     }
=20
-    page_sizes_prop_size =3D ppc_create_page_sizes_prop(env, page_sizes_=
prop,
-                                                  sizeof(page_sizes_prop=
));
+    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_sizes_=
prop,
+                                                      sizeof(page_sizes_=
prop));
     if (page_sizes_prop_size) {
         _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
                           page_sizes_prop, page_sizes_prop_size)));
diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index bd5b0a8c3d..a8cd85069f 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -23,7 +23,7 @@
         }                                                          \
     } while (0)
=20
-size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
+size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
                                   size_t maxsize);
=20
 #endif /* PPC_FDT_H */
--=20
2.14.3
