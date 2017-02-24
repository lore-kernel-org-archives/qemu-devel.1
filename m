Received: from eggs.gnu.org ([2001:4830:134:3::10]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCzF-0006YH-FD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCzB-0008NP-DS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:29 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:47112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCzB-0008MA-7S
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:25 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 447F6DCACB
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:20:24 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:18 +0100
Message-Id: <1487931503-10607-20-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/24] ppc/xics: move the ICP array under
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

This is the last step to remove the XICSState abstraction and have the
machine hold all the objects related to interrupts : ICSs and ICPs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 17 ++++++++---------
 include/hw/ppc/spapr.h |  3 +++
 include/hw/ppc/xics.h  |  2 --
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ae9a59b226c7..032c8ab008d8 100644
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
@@ -2928,8 +2928,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
server)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
=20
-    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[server]=
 :
-        NULL;
+    return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
 }
=20
 static void spapr_icp_resend(XICSFabric *xi)
@@ -2937,8 +2936,8 @@ static void spapr_icp_resend(XICSFabric *xi)
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
index 879853cc69c2..332a96b51d1c 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -80,8 +80,6 @@ struct XICSState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
-    uint32_t nr_servers;
-    ICPState *ss;
 };
=20
 #define TYPE_ICP "icp"
--=20
2.7.4
