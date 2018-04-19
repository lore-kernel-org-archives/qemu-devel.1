Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vm-0008Nd-7m
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vi-0008O9-9b
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:54 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:34627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vi-0008NY-3V
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:50 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.25])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8EDEB1B221C
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:48 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:07 +0200
Message-Id: <20180419124331.3915-12-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/35] spapr: introduce a
 'xive_exploitation' option to enable XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Also provide a 'both' option to activate both interrupt mode: XIVE
exploitation and legacy (XICS).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Changes since v2 :

 - changed the option to a string : "both|off|on"
 - option is not enabled by default anymore. To be discussed.

 hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a81570e7c8b1..b459c0076792 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2907,6 +2907,39 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
=20
+static char *spapr_get_xive_exploitation(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    switch (spapr->xive_exploitation) {
+    case 0x80:
+        return g_strdup("both");
+    case 0x40:
+        return g_strdup("on");
+    case 0x0:
+        return g_strdup("off");
+    }
+    g_assert_not_reached();
+}
+
+static void spapr_set_xive_exploitation(Object *obj, const char *value,
+                                        Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    /* TODO: Don't let older machines activate XIVE */
+
+    if (strcmp(value, "both") =3D=3D 0) {
+        spapr->xive_exploitation =3D 0x80;
+    } else if (strcmp(value, "on") =3D=3D 0) {
+        spapr->xive_exploitation =3D 0x40;
+    } else if (strcmp(value, "off") =3D=3D 0) {
+        spapr->xive_exploitation =3D 0;
+    } else {
+        error_setg(errp, "Bad value for \"xive-exploitation\" property")=
;
+    }
+}
+
 static void spapr_instance_init(Object *obj)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
@@ -2944,6 +2977,14 @@ static void spapr_instance_init(Object *obj)
                                     " the host's SMT mode", &error_abort=
);
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
+    spapr->xive_exploitation =3D false;
+    object_property_add_str(obj, "xive-exploitation",
+                            spapr_get_xive_exploitation,
+                            spapr_set_xive_exploitation,
+                            NULL);
+    object_property_set_description(obj, "xive-exploitation",
+                                    "XIVE exploitation mode POWER9",
+                                    NULL);
 }
=20
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d60b7c6d7a8b..3f8980310492 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -165,6 +165,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
=20
     const char *icp_type;
+    uint8_t xive_exploitation;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
--=20
2.13.6
