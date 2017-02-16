Received: from eggs.gnu.org ([2001:4830:134:3::10]:39858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRl-0002pR-0R
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRf-00063N-5Z
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:09 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:44025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMRe-00062z-Uw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:03 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id BFCDD241FB
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:50:01 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:40 +0100
Message-Id: <1487252865-12064-18-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/22] ppc/xics: move the ICP array under
 the sPAPR machine
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 17 ++++++++---------
 include/hw/ppc/spapr.h |  3 +++
 include/hw/ppc/xics.h  |  2 --
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 445d9a6ddad4..6b35b48f818a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -123,15 +123,15 @@ static XICSState *try_create_xics(sPAPRMachineState=
 *spapr,
         goto error;
     }
=20
-    xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
-    xics->nr_servers =3D nr_servers;
+    spapr->icps =3D g_malloc0(nr_servers * sizeof(ICPState));
+    spapr->nr_servers =3D nr_servers;
=20
     for (i =3D 0; i < nr_servers; i++) {
-        ICPState *icp =3D &xics->ss[i];
+        ICPState *icp =3D &spapr->icps[i];
=20
         object_initialize(icp, sizeof(*icp), type_icp);
         qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
-        object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
+        object_property_add_child(OBJECT(spapr), "icp[*]", OBJECT(icp), =
NULL);
         object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
         if (err) {
@@ -965,7 +965,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr->xics->nr_servers, fdt, PHANDLE_XICP);
+    spapr_dt_xics(spapr->nr_servers, fdt, PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2920,8 +2920,7 @@ static ICPState *spapr_icp_get(XICSInterface *xi, i=
nt server)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
=20
-    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[server]=
 :
-        NULL;
+    return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
 }
=20
 static void spapr_icp_resend(XICSInterface *xi)
@@ -2929,8 +2928,8 @@ static void spapr_icp_resend(XICSInterface *xi)
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     int i;
=20
-    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
-        icp_resend(xi, &spapr->xics->ss[i]);
+    for (i =3D 0; i < spapr->nr_servers; i++) {
+        icp_resend(xi, &spapr->icps[i]);
     }
 }
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 21e506b13cfa..f5bbb040f941 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -95,6 +95,9 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
+
+    uint32_t nr_servers;
+    ICPState *icps;
 };
=20
 #define H_SUCCESS         0
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e320a4c91bb1..726492c948db 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -80,8 +80,6 @@ struct XICSState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
-    uint32_t nr_servers;
-    ICPState *ss;
 };
=20
 #define TYPE_ICP "icp"
--=20
2.7.4
