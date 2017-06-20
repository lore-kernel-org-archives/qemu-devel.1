Received: from eggs.gnu.org ([2001:4830:134:3::10]:45257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITG-0004Le-1y
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT9-0002DC-2N
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT8-0002Bw-Jm
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75BACC009DD2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:46 +0200
Message-Id: <1497962468-22936-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 19/41] qdev: Use appropriate getter/setters
 type
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

Based on the underlying type of the data accessed, use the appropriate
getters/setters:

* AcpiPmInfo members s3_disabled, s4_disabled are bool, member s4_val is
  an uint8_t

* Property ACPI_PCIHP_IO_PROP is defined with
  object_property_add_uint32_ptr()

* Property PCIE_HOST_MCFG_SIZE is implemented with visit_type_uint64()

* PCIDevice property "addr" is backed by PCIDevice member devfn, which
  is an int32_t

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-20-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[More verbose commit message]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/acpi-build.c      | 12 ++++++------
 hw/pci-host/gpex.c        |  2 +-
 hw/pci-host/q35.c         |  2 +-
 hw/pci-host/xilinx-pcie.c |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3eb4367..b2dc3d8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -149,21 +149,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        pm->s3_disabled =3D qnum_get_int(qobject_to_qnum(o));
+        pm->s3_disabled =3D qnum_get_uint(qobject_to_qnum(o));
     } else {
         pm->s3_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        pm->s4_disabled =3D qnum_get_int(qobject_to_qnum(o));
+        pm->s4_disabled =3D qnum_get_uint(qobject_to_qnum(o));
     } else {
         pm->s4_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        pm->s4_val =3D qnum_get_int(qobject_to_qnum(o));
+        pm->s4_val =3D qnum_get_uint(qobject_to_qnum(o));
     } else {
         pm->s4_val =3D false;
     }
@@ -528,7 +528,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
     if (bsel) {
-        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel));
+        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel));
=20
         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
         notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);
@@ -638,7 +638,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     /* If bus supports hotplug select it and notify about local events *=
/
     if (bsel) {
-        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel));
+        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel));
=20
         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
         aml_append(method,
@@ -2619,7 +2619,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
-    mcfg->mcfg_size =3D qnum_get_int(qobject_to_qnum(o));
+    mcfg->mcfg_size =3D qnum_get_uint(qobject_to_qnum(o));
     qobject_decref(o);
     return true;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e2629ce..83084b9 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -94,7 +94,7 @@ static void gpex_host_initfn(Object *obj)
=20
     object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
     object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
-    qdev_prop_set_uint32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
=20
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index c2f2af5..564f6cb 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -172,7 +172,7 @@ static void q35_host_initfn(Object *obj)
=20
     object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
     object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
-    qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index a968cea..2c78dcf 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -150,7 +150,7 @@ static void xilinx_pcie_host_init(Object *obj)
=20
     object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
     object_property_add_child(obj, "root", OBJECT(root), NULL);
-    qdev_prop_set_uint32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
=20
--=20
2.7.5
