Received: from eggs.gnu.org ([209.51.188.92]:58820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmX-0006dY-LJ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmR-000460-B6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:53:01 +1100
Message-Id: <20190226045304.25618-48-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 47/50] hw/ppc: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

Both functions, object_initialize() and object_property_add_child() incre=
ase
the reference counter of the new object, so one of the references has to =
be
dropped afterwards to get the reference counting right. Otherwise the chi=
ld
object will not be properly cleaned up when the parent gets destroyed.
Thus let's use now object_initialize_child() instead to get the reference
counting here right.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1550748288-30598-1-git-send-email-thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c | 11 +++++------
 hw/ppc/pnv.c         | 12 ++++++------
 hw/ppc/pnv_psi.c     |  4 ++--
 hw/ppc/spapr.c       |  6 +++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 06e3c9fdbf..e0e5cb5d8e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -244,13 +244,12 @@ static void spapr_xive_instance_init(Object *obj)
 {
     sPAPRXive *xive =3D SPAPR_XIVE(obj);
=20
-    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
-    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+    object_initialize_child(obj, "source", &xive->source, sizeof(xive->s=
ource),
+                            TYPE_XIVE_SOURCE, &error_abort, NULL);
=20
-    object_initialize(&xive->end_source, sizeof(xive->end_source),
-                      TYPE_XIVE_END_SOURCE);
-    object_property_add_child(obj, "end_source", OBJECT(&xive->end_sourc=
e),
-                              NULL);
+    object_initialize_child(obj, "end_source", &xive->end_source,
+                            sizeof(xive->end_source), TYPE_XIVE_END_SOUR=
CE,
+                            &error_abort, NULL);
 }
=20
 static void spapr_xive_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index da540860a2..9e03e9c336 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,18 +736,18 @@ static void pnv_chip_power8_instance_init(Object *o=
bj)
 {
     Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
=20
-    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
-    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
+    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi)=
,
+                            TYPE_PNV_PSI, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->psi), "xics",
                                    OBJECT(qdev_get_machine()), &error_ab=
ort);
=20
-    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
-    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
+    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc)=
,
+                            TYPE_PNV_LPC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
=20
-    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
-    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
+    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ)=
,
+                            TYPE_PNV_OCC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->occ), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
 }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 8ced095063..44bc0cbf58 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -444,8 +444,8 @@ static void pnv_psi_init(Object *obj)
 {
     PnvPsi *psi =3D PNV_PSI(obj);
=20
-    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
-    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL);
+    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics)=
,
+                            TYPE_ICS_SIMPLE, &error_abort, NULL);
 }
=20
 static const uint8_t irq_to_xivr[] =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5d8b8c9e53..b6a571b6f1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1776,9 +1776,9 @@ static void spapr_create_nvram(sPAPRMachineState *s=
papr)
=20
 static void spapr_rtc_create(sPAPRMachineState *spapr)
 {
-    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC);
-    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc),
-                              &error_fatal);
+    object_initialize_child(OBJECT(spapr), "rtc",
+                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_=
RTC,
+                            &error_fatal, NULL);
     object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
                               &error_fatal);
     object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->=
rtc),
--=20
2.20.1
