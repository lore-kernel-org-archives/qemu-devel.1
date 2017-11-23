Received: from eggs.gnu.org ([2001:4830:134:3::10]:40580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrd0-0002gs-GF
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcq-0003wD-Ps
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:18 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:39273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcq-0003ti-Hc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:08 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 59DE9175B34
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:33:07 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:55 +0100
Message-Id: <20171123132955.1261-26-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/25] spapr: advertise XIVE exploitation mode
 in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We introduce a 'xive_exploitation' boolean at the machine level to
enable the XIVE interrupt mode for newer machines and to disable it on
older ones.

The XIVE interrupt mode can still be forced on the command line with a
machine option. That might be a bit dangerous. To be discussed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c   | 10 ++++++----
 hw/ppc/spapr.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++=
+-----
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b732aaf4f8ba..f7fab70cb8bb 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -736,8 +736,9 @@ static const VMStateDescription vmstate_spapr_xive_iv=
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
@@ -863,8 +864,9 @@ static const VMStateDescription vmstate_spapr_xive_ic=
p_eq =3D {
=20
 static bool vmstate_spapr_xive_icp_needed(void *opaque)
 {
-    /* TODO check machine XIVE support */
-    return true;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+
+    return spapr->xive_exploitation;
 }
=20
 static const VMStateDescription vmstate_spapr_xive_icp =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9fe3a9966b12..d3a4b1f8f6f9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -961,10 +961,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
     spapr_dt_rtas_tokens(fdt, rtas);
 }
=20
-/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU feat=
ures
- * that the guest may request and thus the valid values for bytes 24..26=
 of
- * option vector 5: */
-static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
+ * and the XIVE features that the guest may request and thus the valid
+ * values for bytes 23..26 of option vector 5: */
+static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
+                                          int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
@@ -987,7 +988,16 @@ static void spapr_dt_ov5_platform_support(void *fdt,=
 int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
+         * irqchip=3Doff for now
+         */
+        if (spapr->xive_exploitation) {
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        }
     } else {
+        if (spapr->xive_exploitation) {
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        }
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
     }
@@ -1048,7 +1058,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout=
_path));
     }
=20
-    spapr_dt_ov5_platform_support(fdt, chosen);
+    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -2441,6 +2451,11 @@ static void ppc_spapr_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
     }
=20
+    /* advertise XIVE if not disabled by the user */
+    if (spapr->xive_exploitation) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+    }
+
     /* init CPUs */
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
@@ -2840,6 +2855,21 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
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
+    spapr->xive_exploitation =3D value;
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
@@ -2875,6 +2905,15 @@ static void spapr_machine_initfn(Object *obj)
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
@@ -3956,7 +3995,10 @@ DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
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
index a25e218b34e2..c4f051f974fe 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -129,6 +129,7 @@ struct sPAPRMachineState {
=20
     const char *icp_type;
     sPAPRXive  *xive;
+    bool xive_exploitation;
 };
=20
 #define H_SUCCESS         0
--=20
2.13.6
