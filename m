Received: from eggs.gnu.org ([2001:4830:134:3::10]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7r-00086g-0e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7o-00008h-1P
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:48 +1100
Message-Id: <20170301044405.1792-34-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/50] ppc/xics: use the QOM interface to resend
 irqs
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

Also change the ICPState 'xics' backlink to be a XICSFabric, this
removes the need of using qdev_get_machine() to get the QOM interface
in some of the routines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 20 +++++++++++---------
 hw/ppc/spapr.c        |  3 ++-
 include/hw/ppc/xics.h |  3 ++-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e3dbe63..23e45a8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -231,14 +231,14 @@ static void icp_check_ipi(ICPState *ss)
=20
 static void icp_resend(ICPState *ss)
 {
-    ICSState *ics;
+    XICSFabric *xi =3D ss->xics;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
=20
     if (ss->mfrr < CPPR(ss)) {
         icp_check_ipi(ss);
     }
-    QLIST_FOREACH(ics, &ss->xics->ics, list) {
-        ics_resend(ics);
-    }
+
+    xic->ics_resend(xi);
 }
=20
 void icp_set_cppr(ICPState *ss, uint8_t cppr)
@@ -299,6 +299,8 @@ uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
=20
 void icp_eoi(ICPState *ss, uint32_t xirr)
 {
+    XICSFabric *xi =3D ss->xics;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
     ICSState *ics;
     uint32_t irq;
=20
@@ -306,10 +308,10 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
     ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
     trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
     irq =3D xirr & XISR_MASK;
-    QLIST_FOREACH(ics, &ss->xics->ics, list) {
-        if (ics_valid_irq(ics, irq)) {
-            ics_eoi(ics, irq);
-        }
+
+    ics =3D xic->ics_get(xi, irq);
+    if (ics) {
+        ics_eoi(ics, irq);
     }
     if (!XISR(ss)) {
         icp_resend(ss);
@@ -401,7 +403,7 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
         return;
     }
=20
-    icp->xics =3D XICS_COMMON(obj);
+    icp->xics =3D XICS_FABRIC(obj);
 }
=20
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c6cef04..a4e4b86 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -100,6 +100,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
                                   const char *type_icp, int nr_servers,
                                   int nr_irqs, Error **errp)
 {
+    XICSFabric *xi =3D XICS_FABRIC(spapr);
     Error *err =3D NULL, *local_err =3D NULL;
     XICSState *xics;
     ICSState *ics =3D NULL;
@@ -131,7 +132,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
=20
         object_initialize(icp, sizeof(*icp), type_icp);
         object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
-        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
+        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi), =
NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
         if (err) {
             goto error;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 094756d..b880715 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -69,6 +69,7 @@ typedef struct ICPState ICPState;
 typedef struct ICSStateClass ICSStateClass;
 typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
+typedef struct XICSFabric XICSFabric;
=20
 struct XICSStateClass {
     DeviceClass parent_class;
@@ -115,7 +116,7 @@ struct ICPState {
     qemu_irq output;
     bool cap_irq_xics_enabled;
=20
-    XICSState *xics;
+    XICSFabric *xics;
 };
=20
 #define TYPE_ICS_BASE "ics-base"
--=20
2.9.3
