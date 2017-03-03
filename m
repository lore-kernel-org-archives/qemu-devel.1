Received: from eggs.gnu.org ([2001:4830:134:3::10]:33239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjnPA-0007tF-SB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjnP5-000110-Vq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:37:56 -0500
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:55757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cjnP5-00010S-Mh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:37:51 -0500
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 46964503BA
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 14:37:50 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  3 Mar 2017 14:37:34 +0100
Message-Id: <1488548254-456-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Also use an 'Object *' under the sPAPR machine to hold the RTC
object. Overall, these changes remove an unnecessary and implicit
dependency on SysBus.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         |   12 +++++++-----
 hw/ppc/spapr_rtc.c     |   10 +++++-----
 include/hw/ppc/spapr.h |    6 +++---
 include/hw/ppc/xics.h  |    2 +-
 4 files changed, 16 insertions(+), 14 deletions(-)

Index: qemu-dgibson-for-2.9.git/include/hw/ppc/xics.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-dgibson-for-2.9.git.orig/include/hw/ppc/xics.h
+++ qemu-dgibson-for-2.9.git/include/hw/ppc/xics.h
@@ -28,7 +28,7 @@
 #ifndef XICS_H
 #define XICS_H
=20
-#include "hw/sysbus.h"
+#include "hw/qdev.h"
=20
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
Index: qemu-dgibson-for-2.9.git/hw/ppc/spapr_rtc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-dgibson-for-2.9.git.orig/hw/ppc/spapr_rtc.c
+++ qemu-dgibson-for-2.9.git/hw/ppc/spapr_rtc.c
@@ -39,11 +39,11 @@
 typedef struct sPAPRRTCState sPAPRRTCState;
 struct sPAPRRTCState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    DeviceState parent_obj;
     int64_t ns_offset;
 };
=20
-void spapr_rtc_read(DeviceState *dev, struct tm *tm, uint32_t *ns)
+void spapr_rtc_read(Object *dev, struct tm *tm, uint32_t *ns)
 {
     sPAPRRTCState *rtc =3D SPAPR_RTC(dev);
     int64_t host_ns =3D qemu_clock_get_ns(rtc_clock);
@@ -63,7 +63,7 @@ void spapr_rtc_read(DeviceState *dev, st
     }
 }
=20
-int spapr_rtc_import_offset(DeviceState *dev, int64_t legacy_offset)
+int spapr_rtc_import_offset(Object *dev, int64_t legacy_offset)
 {
     sPAPRRTCState *rtc;
=20
@@ -155,7 +155,7 @@ static void rtas_set_time_of_day(PowerPC
=20
 static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error=
 **errp)
 {
-    spapr_rtc_read(DEVICE(obj), current_tm, NULL);
+    spapr_rtc_read(obj, current_tm, NULL);
 }
=20
 static void spapr_rtc_realize(DeviceState *dev, Error **errp)
@@ -200,7 +200,7 @@ static void spapr_rtc_class_init(ObjectC
=20
 static const TypeInfo spapr_rtc_info =3D {
     .name          =3D TYPE_SPAPR_RTC,
-    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(sPAPRRTCState),
     .class_init    =3D spapr_rtc_class_init,
 };
Index: qemu-dgibson-for-2.9.git/hw/ppc/spapr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-dgibson-for-2.9.git.orig/hw/ppc/spapr.c
+++ qemu-dgibson-for-2.9.git/hw/ppc/spapr.c
@@ -1333,13 +1333,15 @@ static void spapr_create_nvram(sPAPRMach
=20
 static void spapr_rtc_create(sPAPRMachineState *spapr)
 {
-    DeviceState *dev =3D qdev_create(NULL, TYPE_SPAPR_RTC);
+    Object *obj =3D object_new(TYPE_SPAPR_RTC);
=20
-    qdev_init_nofail(dev);
-    spapr->rtc =3D dev;
+    object_property_add_child(OBJECT(spapr), "rtc", obj, &error_fatal);
+    object_property_set_bool(obj, true, "realized", &error_fatal);
=20
-    object_property_add_alias(qdev_get_machine(), "rtc-time",
-                              OBJECT(spapr->rtc), "date", NULL);
+    spapr->rtc =3D obj;
+
+    object_property_add_alias(OBJECT(spapr), "rtc-time", spapr->rtc, "da=
te",
+                               &error_fatal);
 }
=20
 /* Returns whether we want to use VGA or not */
Index: qemu-dgibson-for-2.9.git/include/hw/ppc/spapr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-dgibson-for-2.9.git.orig/include/hw/ppc/spapr.h
+++ qemu-dgibson-for-2.9.git/include/hw/ppc/spapr.h
@@ -59,7 +59,7 @@ struct sPAPRMachineState {
     QLIST_HEAD(, sPAPRPHBState) phbs;
     struct sPAPRNVRAM *nvram;
     ICSState *ics;
-    DeviceState *rtc;
+    Object *rtc;
=20
     void *htab;
     uint32_t htab_shift;
@@ -633,8 +633,8 @@ void spapr_ccs_reset_hook(void *opaque);
 #define TYPE_SPAPR_RTC "spapr-rtc"
 #define TYPE_SPAPR_RNG "spapr-rng"
=20
-void spapr_rtc_read(DeviceState *dev, struct tm *tm, uint32_t *ns);
-int spapr_rtc_import_offset(DeviceState *dev, int64_t legacy_offset);
+void spapr_rtc_read(Object *obj, struct tm *tm, uint32_t *ns);
+int spapr_rtc_import_offset(Object *obj, int64_t legacy_offset);
=20
 int spapr_rng_populate_dt(void *fdt);
=20
