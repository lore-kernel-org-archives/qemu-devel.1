Received: from eggs.gnu.org ([2001:4830:134:3::10]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMM0-00032w-FV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLw-0008K1-RO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:44 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:57243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLw-0008Jf-Kb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:40 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 87392B33D4
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:39 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:31 +0100
Message-Id: <1488205773-30436-25-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 24/26] ppc/xics: move ics-simple post_load
 under the machine
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

The ICS object uses a post_load() handler which is implicitly relying
on the fact that the internal state of the ICS and ICP objects has
been restored but this is not guaranteed. So, let's move the code
under the post_load() handler of the machine where we know the objects
have been fully restored.

The icp_resend() handler of the XICSFabric QOM interface is also
removed as it is now obsolete.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 10 ----------
 hw/ppc/spapr.c        | 18 +++++++-----------
 include/hw/ppc/xics.h |  1 -
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 159cd131420a..ce6e8d75b891 100644
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
index 1d0daef5ad3e..e097ff8de1a4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1285,6 +1285,13 @@ static int spapr_post_load(void *opaque, int versi=
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
@@ -2925,16 +2932,6 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
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
@@ -2980,7 +2977,6 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
-    xic->icp_resend =3D spapr_icp_resend;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 2514cfd86ea9..007ee2f16d16 100644
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
2.7.4
