Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d897E-0000ZD-1v
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d8979-0004xt-5c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d8978-0004xd-Sd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF6783F723
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:39:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:56 +0300
Message-Id: <20170509173559.31598-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/17] acpi: fix s3/s4 disabled type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use a more specific bool type.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/ich9.c       | 24 ++++++++++++------------
 hw/acpi/piix4.c      |  8 ++++----
 hw/i386/acpi-build.c |  5 +++--
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c279bbaca..3bd8c4bcf5 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -359,9 +359,9 @@ static void ich9_pm_get_disable_s3(Object *obj, Visit=
or *v, const char *name,
                                    void *opaque, Error **errp)
 {
     ICH9LPCPMRegs *pm =3D opaque;
-    uint8_t value =3D pm->disable_s3;
+    bool value =3D pm->disable_s3;
=20
-    visit_type_uint8(v, name, &value, errp);
+    visit_type_bool(v, name, &value, errp);
 }
=20
 static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *=
name,
@@ -369,9 +369,9 @@ static void ich9_pm_set_disable_s3(Object *obj, Visit=
or *v, const char *name,
 {
     ICH9LPCPMRegs *pm =3D opaque;
     Error *local_err =3D NULL;
-    uint8_t value;
+    bool value;
=20
-    visit_type_uint8(v, name, &value, &local_err);
+    visit_type_bool(v, name, &value, &local_err);
     if (local_err) {
         goto out;
     }
@@ -384,9 +384,9 @@ static void ich9_pm_get_disable_s4(Object *obj, Visit=
or *v, const char *name,
                                    void *opaque, Error **errp)
 {
     ICH9LPCPMRegs *pm =3D opaque;
-    uint8_t value =3D pm->disable_s4;
+    bool value =3D pm->disable_s4;
=20
-    visit_type_uint8(v, name, &value, errp);
+    visit_type_bool(v, name, &value, errp);
 }
=20
 static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *=
name,
@@ -394,9 +394,9 @@ static void ich9_pm_set_disable_s4(Object *obj, Visit=
or *v, const char *name,
 {
     ICH9LPCPMRegs *pm =3D opaque;
     Error *local_err =3D NULL;
-    uint8_t value;
+    bool value;
=20
-    visit_type_uint8(v, name, &value, &local_err);
+    visit_type_bool(v, name, &value, &local_err);
     if (local_err) {
         goto out;
     }
@@ -447,8 +447,8 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm, Error **errp)
     static const uint32_t gpe0_len =3D ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled =3D true;
     pm->cpu_hotplug_legacy =3D true;
-    pm->disable_s3 =3D 0;
-    pm->disable_s4 =3D 0;
+    pm->disable_s3 =3D false;
+    pm->disable_s4 =3D false;
     pm->s4_val =3D 2;
=20
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
@@ -466,11 +466,11 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMR=
egs *pm, Error **errp)
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy,
                              NULL);
-    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
+    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "bool",
                         ich9_pm_get_disable_s3,
                         ich9_pm_set_disable_s3,
                         NULL, pm, NULL);
-    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
+    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "bool",
                         ich9_pm_get_disable_s4,
                         ich9_pm_set_disable_s4,
                         NULL, pm, NULL);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a553a7e110..74692336b5 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -83,8 +83,8 @@ typedef struct PIIX4PMState {
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_pci_hotplug;
=20
-    uint8_t disable_s3;
-    uint8_t disable_s4;
+    bool disable_s3;
+    bool disable_s4;
     uint8_t s4_val;
=20
     bool cpu_hotplug_legacy;
@@ -670,8 +670,8 @@ static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEv=
entStatusBits ev)
=20
 static Property piix4_pm_properties[] =3D {
     DEFINE_PROP_UINT32("smb_io_base", PIIX4PMState, smb_io_base, 0),
-    DEFINE_PROP_UINT8(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3=
, 0),
-    DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4=
, 0),
+    DEFINE_PROP_BOOL(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3,=
 false),
+    DEFINE_PROP_BOOL(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4,=
 false),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMStat=
e,
                      use_acpi_pci_hotplug, true),
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1707fae9bf..27ad420914 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -22,6 +22,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/types.h"
 #include "acpi-build.h"
 #include "qemu-common.h"
 #include "qemu/bitmap.h"
@@ -149,14 +150,14 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        pm->s3_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
+        pm->s3_disabled =3D qbool_get_bool(qobject_to_qbool(o));
     } else {
         pm->s3_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        pm->s4_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
+        pm->s4_disabled =3D qbool_get_bool(qobject_to_qbool(o));
     } else {
         pm->s4_disabled =3D false;
     }
--=20
2.13.0.rc1.16.gd80b50c3f
