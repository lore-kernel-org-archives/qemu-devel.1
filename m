Received: from eggs.gnu.org ([2001:4830:134:3::10]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakr-0001So-J8
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakn-0007NL-Gf
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:05 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakn-0007HZ-An
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:01 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id F17221277CF
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:29 +0100
Message-Id: <20171209084338.29395-11-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/19] spapr: introduce a
 'xive_exploitation' boolean to enable XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE exploitation interrupt mode will be enabled for newer
machines and disabled for older ones. Also provide a command line
machine option to switch XIVE off on newer machines if needed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c   | 10 ++++++----
 hw/ppc/spapr.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 38e1f569ea82..bf30edc87bee 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -756,8 +756,9 @@ static const VMStateDescription vmstate_spapr_xive_iv=
e =3D {
=20
 static bool vmstate_spapr_xive_needed(void *opaque)
 {
-    /* TODO check machine XIVE support */
-    return true;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+
+    return spapr->xive_exploitation;
 }
=20
 static const VMStateDescription vmstate_spapr_xive =3D {
@@ -885,8 +886,9 @@ static const VMStateDescription vmstate_spapr_xive_nv=
t_eq =3D {
=20
 static bool vmstate_spapr_xive_nvt_needed(void *opaque)
 {
-    /* TODO check machine XIVE support */
-    return true;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+
+    return spapr->xive_exploitation;
 }
=20
 static const VMStateDescription vmstate_spapr_xive_nvt =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 306875e12320..b5b9e7f1b3b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2820,6 +2820,29 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
=20
+static bool spapr_get_xive_exploitation(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    return spapr->xive_exploitation;
+}
+
+static void spapr_set_xive_exploitation(Object *obj, bool value,
+                                            Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    if (value) {
+        /* Don't let older machines activate XIVE */
+        if (!spapr->xive_exploitation) {
+            error_setg(errp, "\"xive-exploitation\" option can not be "
+                       "switched on");
+        }
+    } else {
+        spapr->xive_exploitation =3D false;
+    }
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
@@ -2855,6 +2878,15 @@ static void spapr_machine_initfn(Object *obj)
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this=
 were"
                                     " the host's SMT mode", &error_abort=
);
+
+    spapr->xive_exploitation =3D true;
+    object_property_add_bool(obj, "xive-exploitation",
+                            spapr_get_xive_exploitation,
+                            spapr_set_xive_exploitation,
+                            NULL);
+    object_property_set_description(obj, "xive-exploitation",
+                                    "XIVE exploitation mode POWER9",
+                                    NULL);
 }
=20
 static void spapr_machine_finalizefn(Object *obj)
@@ -3890,7 +3922,10 @@ DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
=20
 static void spapr_machine_2_11_instance_options(MachineState *machine)
 {
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
+
     spapr_machine_2_12_instance_options(machine);
+    spapr->xive_exploitation =3D false;
 }
=20
 static void spapr_machine_2_11_class_options(MachineClass *mc)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 14757b805e84..1d6d2c690d7f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -127,6 +127,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
=20
     const char *icp_type;
+    bool xive_exploitation;
 };
=20
 #define H_SUCCESS         0
--=20
2.13.6
