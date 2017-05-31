Received: from eggs.gnu.org ([2001:4830:134:3::10]:52725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Ad-0005pA-Go
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Ac-0004cc-H2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Ac-0004bs-8N
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 323767F6A0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:00:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:45 +0400
Message-Id: <20170531135709.345-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/45] qdev: use appropriate getter/setters
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Based on underlying property type, use the appropriate getters/setters.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c      | 20 ++++++++++----------
 hw/pci-host/gpex.c        |  2 +-
 hw/pci-host/q35.c         |  2 +-
 hw/pci-host/xilinx-pcie.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ba2be1e9da..ba163e6df2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -128,7 +128,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     Object *lpc =3D ich9_lpc_find();
     Object *obj =3D NULL;
     QObject *o;
-    int64_t val;
+    uint64_t val;
=20
     pm->cpu_hp_io_base =3D 0;
     pm->pcihp_io_base =3D 0;
@@ -150,7 +150,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        if (!qnum_get_int(qobject_to_qnum(o), &val)) {
+        if (!qnum_get_uint(qobject_to_qnum(o), &val)) {
             g_assert_not_reached();
         }
         pm->s3_disabled =3D val;
@@ -160,7 +160,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        if (!qnum_get_int(qobject_to_qnum(o), &val)) {
+        if (!qnum_get_uint(qobject_to_qnum(o), &val)) {
             g_assert_not_reached();
         }
         pm->s4_disabled =3D val;
@@ -170,7 +170,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        if (!qnum_get_int(qobject_to_qnum(o), &val)) {
+        if (!qnum_get_uint(qobject_to_qnum(o), &val)) {
             g_assert_not_reached();
         }
         pm->s4_val =3D val;
@@ -538,9 +538,9 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
     if (bsel) {
-        int64_t bsel_val;
+        uint64_t bsel_val;
=20
-        if (!qnum_get_int(qobject_to_qnum(bsel), &bsel_val)) {
+        if (!qnum_get_uint(qobject_to_qnum(bsel), &bsel_val)) {
             g_assert_not_reached();
         }
=20
@@ -652,9 +652,9 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     /* If bus supports hotplug select it and notify about local events *=
/
     if (bsel) {
-        int64_t bsel_val;
+        uint64_t bsel_val;
=20
-        if (!qnum_get_int(qobject_to_qnum(bsel), &bsel_val)) {
+        if (!qnum_get_uint(qobject_to_qnum(bsel), &bsel_val)) {
             g_assert_not_reached();
         }
=20
@@ -2625,7 +2625,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
 {
     Object *pci_host;
     QObject *o;
-    int64_t val;
+    uint64_t val;
=20
     pci_host =3D acpi_get_i386_pci_host();
     g_assert(pci_host);
@@ -2641,7 +2641,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
-    if (!qnum_get_int(qobject_to_qnum(o), &val)) {
+    if (!qnum_get_uint(qobject_to_qnum(o), &val)) {
         g_assert_not_reached();
     }
     mcfg->mcfg_size =3D val;
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e2629ce70d..83084b9aab 100644
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
index c2f2af5d9a..564f6cbb14 100644
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
index a968cea2af..2c78dcfc26 100644
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
2.13.0.91.g00982b8dd
