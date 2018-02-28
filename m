Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2fl-0004lV-DB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2fe-0001u3-Kp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:33 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 28 Feb 2018 15:23:47 +0100
Message-Id: <1519827835-239519-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
References: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/10] pc: replace pm object initialization
 with one-liner in acpi_get_pm_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org

next patch will need it before it gets to piix4/lpc branches
that initializes 'obj' now.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/i386/acpi-build.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index deb440f..b85fefe 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -128,7 +128,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
 {
     Object *piix =3D piix4_pm_find();
     Object *lpc =3D ich9_lpc_find();
-    Object *obj =3D NULL;
+    Object *obj =3D piix ? piix : lpc;
     QObject *o;
=20
     pm->force_rev1_fadt =3D false;
@@ -138,7 +138,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     if (piix) {
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible =
*/
         pm->force_rev1_fadt =3D true;
-        obj =3D piix;
         pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
         pm->pcihp_io_base =3D
             object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL)=
;
@@ -146,7 +145,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
             object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
-        obj =3D lpc;
         pm->cpu_hp_io_base =3D ICH9_CPU_HOTPLUG_IO_BASE;
     }
     assert(obj);
--=20
2.7.4
