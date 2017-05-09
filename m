Received: from eggs.gnu.org ([2001:4830:134:3::10]:45999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896y-0000MA-Ku
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896t-0004qw-Ow
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d896t-0004pi-FU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D11881240
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:39:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:55 +0300
Message-Id: <20170509173559.31598-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/17] qdev: use appropriate getter/setters type
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

Based on underlying property type, use the appropriate getters/setters.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c      | 12 ++++++------
 hw/pci-host/gpex.c        |  2 +-
 hw/pci-host/q35.c         |  2 +-
 hw/pci-host/xilinx-pcie.c |  2 +-
 target/i386/cpu.c         |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 767da5d78e..1707fae9bf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -149,21 +149,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        pm->s3_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
+        pm->s3_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
     } else {
         pm->s3_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        pm->s4_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
+        pm->s4_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
     } else {
         pm->s4_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        pm->s4_val =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
+        pm->s4_val =3D qnum_get_uint(qobject_to_qnum(o), &error_abort);
     } else {
         pm->s4_val =3D false;
     }
@@ -499,7 +499,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
     if (bsel) {
-        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
+        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel), &erro=
r_abort);
=20
         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
         notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);
@@ -609,7 +609,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     /* If bus supports hotplug select it and notify about local events *=
/
     if (bsel) {
-        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
+        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel), &erro=
r_abort);
         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
         aml_append(method,
             aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)
@@ -2590,7 +2590,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
-    mcfg->mcfg_size =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
+    mcfg->mcfg_size =3D qnum_get_uint(qobject_to_qnum(o), &error_abort);
     qobject_decref(o);
     return true;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 66055ee5cc..8d3a64008c 100644
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
index 5438be8253..3cbe8cfcea 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -173,7 +173,7 @@ static void q35_host_initfn(Object *obj)
=20
     object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
     object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
-    qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 8b71e2d950..461ed41151 100644
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e8a5b55c0..5bb8131bb8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3191,7 +3191,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error =
**errp)
                               OBJECT(cpu->apic_state), &error_abort);
     object_unref(OBJECT(cpu->apic_state));
=20
-    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
+    qdev_prop_set_int32(cpu->apic_state, "id", cpu->apic_id);
     /* TODO: convert to link<> */
     apic =3D APIC_COMMON(cpu->apic_state);
     apic->cpu =3D cpu;
--=20
2.13.0.rc1.16.gd80b50c3f
