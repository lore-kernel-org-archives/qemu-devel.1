Received: from eggs.gnu.org ([2001:4830:134:3::10]:46728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7u-0008BJ-Ep
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7r-0000Cg-Ag
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:44:02 +1100
Message-Id: <20170301044405.1792-48-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 47/50] ppc/xics: move ics-simple post_load under
 the machine
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

The ICS object uses a post_load() handler which is implicitly relying
on the fact that the internal state of the ICS and ICP objects has
been restored but this is not guaranteed. So, let's move the code
under the post_load() handler of the machine where we know the objects
have been fully restored.

The icp_resend() handler of the XICSFabric QOM interface is also
removed as it is now obsolete.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 10 ----------
 hw/ppc/spapr.c        | 18 +++++++-----------
 include/hw/ppc/xics.h |  1 -
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 159cd13..ce6e8d7 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -551,15 +551,6 @@ static void ics_simple_reset(DeviceState *dev)
     }
 }
=20
-static int ics_simple_post_load(ICSState *ics, int version_id)
-{
-    XICSFabric *xi =3D ics->xics;
-    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
-
-    xic->icp_resend(xi);
-    return 0;
-}
-
 static void ics_simple_dispatch_pre_save(void *opaque)
 {
     ICSState *ics =3D opaque;
@@ -647,7 +638,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
     dc->props =3D ics_simple_properties;
     dc->vmsd =3D &vmstate_ics_simple;
     dc->reset =3D ics_simple_reset;
-    isc->post_load =3D ics_simple_post_load;
     isc->reject =3D ics_simple_reject;
     isc->resend =3D ics_simple_resend;
     isc->eoi =3D ics_simple_eoi;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6539260..76596a3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1341,6 +1341,13 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
     sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
     int err =3D 0;
=20
+    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
+        int i;
+        for (i =3D 0; i < spapr->nr_servers; i++) {
+            icp_resend(&spapr->icps[i]);
+        }
+    }
+
     /* In earlier versions, there was no separate qdev for the PAPR
      * RTC, so the RTC offset was stored directly in sPAPREnvironment.
      * So when migrating from those versions, poke the incoming offset
@@ -2981,16 +2988,6 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 server)
     return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
 }
=20
-static void spapr_icp_resend(XICSFabric *xi)
-{
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    int i;
-
-    for (i =3D 0; i < spapr->nr_servers; i++) {
-        icp_resend(&spapr->icps[i]);
-    }
-}
-
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -3040,7 +3037,6 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
-    xic->icp_resend =3D spapr_icp_resend;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 2514cfd..007ee2f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -156,7 +156,6 @@ typedef struct XICSFabricClass {
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
     ICPState *(*icp_get)(XICSFabric *xi, int server);
-    void (*icp_resend)(XICSFabric *xi);
 } XICSFabricClass;
=20
 #define XICS_IRQS_SPAPR               1024
--=20
2.9.3
