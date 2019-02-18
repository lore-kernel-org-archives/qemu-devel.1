Received: from eggs.gnu.org ([209.51.188.92]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjx1-0005hE-D7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjws-0002fc-8j
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:17 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:17 +1100
Message-Id: <20190218143049.17142-12-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/43] xive: Only set source type for LSIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

MSI is the default and LSI specific code is guarded by the
xive_source_irq_is_lsi() helper. The xive_source_irq_set()
helper is a nop for MSIs.

Simplify the code by turning xive_source_irq_set() into
xive_source_irq_set_lsi() and only call it for LSIs. The
call to xive_source_irq_set(false) in spapr_xive_irq_free()
is also a nop. Just drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <154999584656.690774.18352404495120358613.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c  | 7 +++----
 include/hw/ppc/xive.h | 7 ++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a0f5ff9294..290a290e43 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -489,20 +489,19 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t=
 lisn, bool lsi)
     }
=20
     xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
-    xive_source_irq_set(xsrc, lisn, lsi);
+    if (lsi) {
+        xive_source_irq_set_lsi(xsrc, lisn);
+    }
     return true;
 }
=20
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn)
 {
-    XiveSource *xsrc =3D &xive->source;
-
     if (lisn >=3D xive->nr_irqs) {
         return false;
     }
=20
     xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
-    xive_source_irq_set(xsrc, lisn, false);
     return true;
 }
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ec3bb2aae4..13a487527b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -283,13 +283,10 @@ static inline bool xive_source_irq_is_lsi(XiveSourc=
e *xsrc, uint32_t srcno)
     return test_bit(srcno, xsrc->lsi_map);
 }
=20
-static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t srcno,
-                                       bool lsi)
+static inline void xive_source_irq_set_lsi(XiveSource *xsrc, uint32_t sr=
cno)
 {
     assert(srcno < xsrc->nr_irqs);
-    if (lsi) {
-        bitmap_set(xsrc->lsi_map, srcno, 1);
-    }
+    bitmap_set(xsrc->lsi_map, srcno, 1);
 }
=20
 void xive_source_set_irq(void *opaque, int srcno, int val);
--=20
2.20.1
