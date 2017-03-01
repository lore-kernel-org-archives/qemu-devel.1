Received: from eggs.gnu.org ([2001:4830:134:3::10]:46852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7x-0008FD-C4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7t-0000Ev-6Q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:59 +1100
Message-Id: <20170301044405.1792-45-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/50] ppc/xics: move the ICP array under the
 sPAPR machine
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

This is the last step to remove the XICSState abstraction and have the
machine hold all the objects related to interrupts : ICSs and ICPs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 17 ++++++++---------
 include/hw/ppc/spapr.h |  3 +++
 include/hw/ppc/xics.h  |  2 --
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8b2d21c..47eb503 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -124,15 +124,15 @@ static XICSState *try_create_xics(sPAPRMachineState=
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
         object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi), =
NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
         if (err) {
@@ -967,7 +967,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr->xics->nr_servers, fdt, PHANDLE_XICP);
+    spapr_dt_xics(spapr->nr_servers, fdt, PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2989,8 +2989,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
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
@@ -2998,8 +2997,8 @@ static void spapr_icp_resend(XICSFabric *xi)
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     int i;
=20
-    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
-        icp_resend(&spapr->xics->ss[i]);
+    for (i =3D 0; i < spapr->nr_servers; i++) {
+        icp_resend(&spapr->icps[i]);
     }
 }
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 21e506b..f5bbb04 100644
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
index f618848..50a5933 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -79,8 +79,6 @@ struct XICSState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
-    uint32_t nr_servers;
-    ICPState *ss;
 };
=20
 #define TYPE_ICP "icp"
--=20
2.9.3
