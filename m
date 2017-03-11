Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzg-00027t-SV
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzf-0002Yj-Om
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzf-0002Y8-GB
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:35 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:44 +0400
Message-Id: <20170311132256.22951-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/21] qdev: use appropriate type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c      | 15 ++++++++-------
 hw/pci-host/gpex.c        |  2 +-
 hw/pci-host/q35.c         |  2 +-
 hw/pci-host/xilinx-pcie.c |  2 +-
 target/i386/cpu.c         |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108577..76bff18e3f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -58,6 +58,7 @@
 #include "hw/acpi/aml-build.h"
=20
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
@@ -150,21 +151,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        pm->s3_disabled =3D qint_get_int(qobject_to_qint(o));
+        pm->s3_disabled =3D quint_get_uint(qobject_to_quint(o));
     } else {
         pm->s3_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        pm->s4_disabled =3D qint_get_int(qobject_to_qint(o));
+        pm->s4_disabled =3D quint_get_uint(qobject_to_quint(o));
     } else {
         pm->s4_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        pm->s4_val =3D qint_get_int(qobject_to_qint(o));
+        pm->s4_val =3D quint_get_uint(qobject_to_quint(o));
     } else {
         pm->s4_val =3D false;
     }
@@ -500,7 +501,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
     if (bsel) {
-        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
+        uint64_t bsel_val =3D quint_get_uint(qobject_to_quint(bsel));
=20
         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
         notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);
@@ -610,7 +611,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     /* If bus supports hotplug select it and notify about local events *=
/
     if (bsel) {
-        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
+        uint64_t bsel_val =3D quint_get_uint(qobject_to_quint(bsel));
         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
         aml_append(method,
             aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)
@@ -2586,12 +2587,12 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     if (!o) {
         return false;
     }
-    mcfg->mcfg_base =3D qint_get_int(qobject_to_qint(o));
+    mcfg->mcfg_base =3D quint_get_uint(qobject_to_quint(o));
     qobject_decref(o);
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
-    mcfg->mcfg_size =3D qint_get_int(qobject_to_qint(o));
+    mcfg->mcfg_size =3D quint_get_uint(qobject_to_quint(o));
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
index fba92125ab..54f859bc8d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3176,7 +3176,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error =
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
2.12.0.191.gc5d8de91d
