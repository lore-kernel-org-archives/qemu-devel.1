Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGM-0000kO-LI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGI-0003c4-6i
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGH-0003Zm-R5
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B2CFB1E2E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:36 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:47:12 +0200
Message-Id: <1497016045-6009-29-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/41] acpi: use get_uint() for various acpi
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

PIIX4: piix4_pm_add_propeties() defines these with
object_property_add_uint*_ptr().

Q35: ich9_lpc_add_properties() and ich9_pm_add_properties() define them
similarly, except for ACPI_PM_PROP_GPE0_BLK().  That one's getter
ich9_pm_get_gpe0_blk() uses visit_type_uint32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-29-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/acpi-build.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d1ffce7..7c4c612 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -170,20 +170,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     qobject_decref(o);
=20
     /* Fill in mandatory properties */
-    pm->sci_int =3D object_property_get_int(obj, ACPI_PM_PROP_SCI_INT, N=
ULL);
+    pm->sci_int =3D object_property_get_uint(obj, ACPI_PM_PROP_SCI_INT, =
NULL);
=20
-    pm->acpi_enable_cmd =3D object_property_get_int(obj,
-                                                  ACPI_PM_PROP_ACPI_ENAB=
LE_CMD,
-                                                  NULL);
-    pm->acpi_disable_cmd =3D object_property_get_int(obj,
-                                                  ACPI_PM_PROP_ACPI_DISA=
BLE_CMD,
-                                                  NULL);
-    pm->io_base =3D object_property_get_int(obj, ACPI_PM_PROP_PM_IO_BASE=
,
-                                          NULL);
-    pm->gpe0_blk =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_BLK,
+    pm->acpi_enable_cmd =3D object_property_get_uint(obj,
+                                                   ACPI_PM_PROP_ACPI_ENA=
BLE_CMD,
+                                                   NULL);
+    pm->acpi_disable_cmd =3D
+        object_property_get_uint(obj,
+                                 ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                 NULL);
+    pm->io_base =3D object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BAS=
E,
                                            NULL);
-    pm->gpe0_blk_len =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_=
BLK_LEN,
-                                               NULL);
+    pm->gpe0_blk =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0_BLK=
,
+                                            NULL);
+    pm->gpe0_blk_len =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0=
_BLK_LEN,
+                                                NULL);
     pm->pcihp_bridge_en =3D
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
                                  NULL);
--=20
2.7.5
