Received: from eggs.gnu.org ([208.118.235.92]:43731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJH-0002yf-Iu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJD-0000vZ-OH
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTJD-0000uz-DU
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:30:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:16 +0400
Message-Id: <20190104173042.32714-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/28] machines: replace COMPAT define with a
 static array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h        |  10 +-
 hw/arm/virt.c              |  45 ++--
 hw/i386/pc_piix.c          | 474 +++++++++++++++++++++----------------
 hw/i386/pc_q35.c           |  66 +++++-
 hw/ppc/spapr.c             | 201 ++++++++--------
 hw/s390x/s390-virtio-ccw.c | 219 +++++++++--------
 6 files changed, 577 insertions(+), 438 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 362384815e..a5d8ddd68b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -289,18 +289,14 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
-#define SET_MACHINE_COMPAT(m, COMPAT) \
+#define SET_MACHINE_COMPAT(m, compat) \
     do {                              \
         int i;                        \
-        static GlobalProperty props[] =3D {       \
-            COMPAT                              \
-            { /* end of list */ }               \
-        };                                      \
         if (!m->compat_props) { \
             m->compat_props =3D g_array_new(false, false, sizeof(void *)=
); \
         } \
-        for (i =3D 0; props[i].driver !=3D NULL; i++) {    \
-            GlobalProperty *prop =3D &props[i];          \
+        for (i =3D 0; i < G_N_ELEMENTS(compat); i++) {          \
+            GlobalProperty *prop =3D &compat[i];          \
             g_array_append_val(m->compat_props, prop); \
         }                                              \
     } while (0)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c2641e56ea..6ecec1cb05 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1872,84 +1872,91 @@ static void virt_machine_4_0_options(MachineClass=
 *mc)
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
=20
-#define VIRT_COMPAT_3_1 \
+static GlobalProperty virt_compat_3_1[] =3D {
     HW_COMPAT_3_1
+};
=20
 static void virt_machine_3_1_options(MachineClass *mc)
 {
     virt_machine_4_0_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_1);
+    SET_MACHINE_COMPAT(mc, virt_compat_3_1);
 }
 DEFINE_VIRT_MACHINE(3, 1)
=20
-#define VIRT_COMPAT_3_0 \
+static GlobalProperty virt_compat_3_0[] =3D {
     HW_COMPAT_3_0
+};
=20
 static void virt_machine_3_0_options(MachineClass *mc)
 {
     virt_machine_3_1_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
+    SET_MACHINE_COMPAT(mc, virt_compat_3_0);
 }
 DEFINE_VIRT_MACHINE(3, 0)
=20
-#define VIRT_COMPAT_2_12 \
+static GlobalProperty virt_compat_2_12[] =3D {
     HW_COMPAT_2_12
+};
=20
 static void virt_machine_2_12_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_3_0_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_12);
     vmc->no_highmem_ecam =3D true;
     mc->max_cpus =3D 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
=20
-#define VIRT_COMPAT_2_11 \
+static GlobalProperty virt_compat_2_11[] =3D {
     HW_COMPAT_2_11
+};
=20
 static void virt_machine_2_11_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_12_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_11);
     vmc->smbios_old_sys_ver =3D true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
=20
-#define VIRT_COMPAT_2_10 \
+static GlobalProperty virt_compat_2_10[] =3D {
     HW_COMPAT_2_10
+};
=20
 static void virt_machine_2_10_options(MachineClass *mc)
 {
     virt_machine_2_11_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_10);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_10);
     /* before 2.11 we never faulted accesses to bad addresses */
     mc->ignore_memory_transaction_failures =3D true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
=20
-#define VIRT_COMPAT_2_9 \
+static GlobalProperty virt_compat_2_9[] =3D {
     HW_COMPAT_2_9
+};
=20
 static void virt_machine_2_9_options(MachineClass *mc)
 {
     virt_machine_2_10_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_9);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_9);
 }
 DEFINE_VIRT_MACHINE(2, 9)
=20
-#define VIRT_COMPAT_2_8 \
+static GlobalProperty virt_compat_2_8[] =3D {
     HW_COMPAT_2_8
+};
=20
 static void virt_machine_2_8_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_9_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_8);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_8);
     /* For 2.8 and earlier we falsely claimed in the DT that
      * our timers were edge-triggered, not level-triggered.
      */
@@ -1957,15 +1964,16 @@ static void virt_machine_2_8_options(MachineClass=
 *mc)
 }
 DEFINE_VIRT_MACHINE(2, 8)
=20
-#define VIRT_COMPAT_2_7 \
+static GlobalProperty virt_compat_2_7[] =3D {
     HW_COMPAT_2_7
+};
=20
 static void virt_machine_2_7_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_8_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_7);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_7);
     /* ITS was introduced with 2.8 */
     vmc->no_its =3D true;
     /* Stick with 1K pages for migration compatibility */
@@ -1973,15 +1981,16 @@ static void virt_machine_2_7_options(MachineClass=
 *mc)
 }
 DEFINE_VIRT_MACHINE(2, 7)
=20
-#define VIRT_COMPAT_2_6 \
+static GlobalProperty virt_compat_2_6[] =3D {
     HW_COMPAT_2_6
+};
=20
 static void virt_machine_2_6_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_7_options(mc);
-    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_6);
+    SET_MACHINE_COMPAT(mc, virt_compat_2_6);
     vmc->disallow_affinity_adjustment =3D true;
     /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
     vmc->no_pmu =3D true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7f1cb527b5..ac97097cac 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -438,83 +438,117 @@ static void pc_i440fx_4_0_machine_options(MachineC=
lass *m)
 DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
                       pc_i440fx_4_0_machine_options);
=20
+static GlobalProperty pc_compat_3_1[] =3D {
+    PC_COMPAT_3_1
+};
+
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
     pc_i440fx_4_0_machine_options(m);
     m->is_default =3D 0;
     m->alias =3D NULL;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
+    SET_MACHINE_COMPAT(m, pc_compat_3_1);
 }
=20
 DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
                       pc_i440fx_3_1_machine_options);
=20
+static GlobalProperty pc_compat_3_0[] =3D {
+    PC_COMPAT_3_0
+};
+
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_3_1_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
+    SET_MACHINE_COMPAT(m, pc_compat_3_0);
 }
=20
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
                       pc_i440fx_3_0_machine_options);
=20
+static GlobalProperty pc_compat_2_12[] =3D {
+    PC_COMPAT_2_12
+};
+
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
+    SET_MACHINE_COMPAT(m, pc_compat_2_12);
 }
=20
 DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
                       pc_i440fx_2_12_machine_options);
=20
+static GlobalProperty pc_compat_2_11[] =3D {
+    PC_COMPAT_2_11
+};
+
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_2_12_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+    SET_MACHINE_COMPAT(m, pc_compat_2_11);
 }
=20
 DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
                       pc_i440fx_2_11_machine_options);
=20
+static GlobalProperty pc_compat_2_10[] =3D {
+    PC_COMPAT_2_10
+};
+
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
     pc_i440fx_2_11_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+    SET_MACHINE_COMPAT(m, pc_compat_2_10);
     m->auto_enable_numa_with_memhp =3D false;
 }
=20
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
                       pc_i440fx_2_10_machine_options);
=20
+static GlobalProperty pc_compat_2_9[] =3D {
+    PC_COMPAT_2_9
+};
+
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_2_10_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+    SET_MACHINE_COMPAT(m, pc_compat_2_9);
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
 }
=20
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
                       pc_i440fx_2_9_machine_options);
=20
+static GlobalProperty pc_compat_2_8[] =3D {
+    PC_COMPAT_2_8
+};
+
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
     pc_i440fx_2_9_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+    SET_MACHINE_COMPAT(m, pc_compat_2_8);
 }
=20
 DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
                       pc_i440fx_2_8_machine_options);
=20
+static GlobalProperty pc_compat_2_7[] =3D {
+    PC_COMPAT_2_7
+};
=20
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
     pc_i440fx_2_8_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
+    SET_MACHINE_COMPAT(m, pc_compat_2_7);
 }
=20
 DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
                       pc_i440fx_2_7_machine_options);
=20
+static GlobalProperty pc_compat_2_6[] =3D {
+    PC_COMPAT_2_6
+};
=20
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
 {
@@ -522,12 +556,15 @@ static void pc_i440fx_2_6_machine_options(MachineCl=
ass *m)
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
+    SET_MACHINE_COMPAT(m, pc_compat_2_6);
 }
=20
 DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
                       pc_i440fx_2_6_machine_options);
=20
+static GlobalProperty pc_compat_2_5[] =3D {
+    PC_COMPAT_2_5
+};
=20
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
 {
@@ -535,12 +572,15 @@ static void pc_i440fx_2_5_machine_options(MachineCl=
ass *m)
     pc_i440fx_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_5);
+    SET_MACHINE_COMPAT(m, pc_compat_2_5);
 }
=20
 DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
                       pc_i440fx_2_5_machine_options);
=20
+static GlobalProperty pc_compat_2_4[] =3D {
+    PC_COMPAT_2_4
+};
=20
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
 {
@@ -548,23 +588,29 @@ static void pc_i440fx_2_4_machine_options(MachineCl=
ass *m)
     pc_i440fx_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_4);
+    SET_MACHINE_COMPAT(m, pc_compat_2_4);
 }
=20
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
                       pc_i440fx_2_4_machine_options)
=20
+static GlobalProperty pc_compatp_2_3[] =3D {
+    PC_COMPAT_2_3
+};
=20
 static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version =3D "2.3.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_3);
+    SET_MACHINE_COMPAT(m, pc_compatp_2_3);
 }
=20
 DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3,
                       pc_i440fx_2_3_machine_options);
=20
+static GlobalProperty pc_compatp_2_2[] =3D {
+    PC_COMPAT_2_2
+};
=20
 static void pc_i440fx_2_2_machine_options(MachineClass *m)
 {
@@ -572,13 +618,16 @@ static void pc_i440fx_2_2_machine_options(MachineCl=
ass *m)
     pc_i440fx_2_3_machine_options(m);
     m->hw_version =3D "2.2.0";
     m->default_machine_opts =3D "firmware=3Dbios-256k.bin,suppress-vmdes=
c=3Don";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_2);
+    SET_MACHINE_COMPAT(m, pc_compatp_2_2);
     pcmc->rsdp_in_ram =3D false;
 }
=20
 DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2,
                       pc_i440fx_2_2_machine_options);
=20
+static GlobalProperty pc_compatp_2_1[] =3D {
+    PC_COMPAT_2_1
+};
=20
 static void pc_i440fx_2_1_machine_options(MachineClass *m)
 {
@@ -586,7 +635,7 @@ static void pc_i440fx_2_1_machine_options(MachineClas=
s *m)
     pc_i440fx_2_2_machine_options(m);
     m->hw_version =3D "2.1.0";
     m->default_display =3D NULL;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_1);
+    SET_MACHINE_COMPAT(m, pc_compatp_2_1);
     pcmc->smbios_uuid_encoded =3D false;
     pcmc->enforce_aligned_dimm =3D false;
 }
@@ -594,14 +643,16 @@ static void pc_i440fx_2_1_machine_options(MachineCl=
ass *m)
 DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1,
                       pc_i440fx_2_1_machine_options);
=20
-
+static GlobalProperty pc_compatp_2_0[] =3D {
+    PC_COMPAT_2_0
+};
=20
 static void pc_i440fx_2_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_2_1_machine_options(m);
     m->hw_version =3D "2.0.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_0);
+    SET_MACHINE_COMPAT(m, pc_compatp_2_0);
     pcmc->smbios_legacy_mode =3D true;
     pcmc->has_reserved_memory =3D false;
     /* This value depends on the actual DSDT and SSDT compiled into
@@ -627,6 +678,9 @@ static void pc_i440fx_2_0_machine_options(MachineClas=
s *m)
 DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0,
                       pc_i440fx_2_0_machine_options);
=20
+static GlobalProperty pc_compatp_1_7[] =3D {
+    PC_COMPAT_1_7
+};
=20
 static void pc_i440fx_1_7_machine_options(MachineClass *m)
 {
@@ -635,7 +689,7 @@ static void pc_i440fx_1_7_machine_options(MachineClas=
s *m)
     m->hw_version =3D "1.7.0";
     m->default_machine_opts =3D NULL;
     m->option_rom_has_mr =3D true;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_7);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_7);
     pcmc->smbios_defaults =3D false;
     pcmc->gigabyte_align =3D false;
     pcmc->legacy_acpi_table_size =3D 6414;
@@ -644,6 +698,9 @@ static void pc_i440fx_1_7_machine_options(MachineClas=
s *m)
 DEFINE_I440FX_MACHINE(v1_7, "pc-i440fx-1.7", pc_compat_1_7,
                       pc_i440fx_1_7_machine_options);
=20
+static GlobalProperty pc_compatp_1_6[] =3D {
+    PC_COMPAT_1_6
+};
=20
 static void pc_i440fx_1_6_machine_options(MachineClass *m)
 {
@@ -651,302 +708,311 @@ static void pc_i440fx_1_6_machine_options(Machine=
Class *m)
     pc_i440fx_1_7_machine_options(m);
     m->hw_version =3D "1.6.0";
     m->rom_file_has_mr =3D false;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_6);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_6);
     pcmc->has_acpi_build =3D false;
 }
=20
 DEFINE_I440FX_MACHINE(v1_6, "pc-i440fx-1.6", pc_compat_1_6,
                       pc_i440fx_1_6_machine_options);
=20
+static GlobalProperty pc_compatp_1_5[] =3D {
+    PC_COMPAT_1_5
+};
=20
 static void pc_i440fx_1_5_machine_options(MachineClass *m)
 {
     pc_i440fx_1_6_machine_options(m);
     m->hw_version =3D "1.5.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_5);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_5);
 }
=20
 DEFINE_I440FX_MACHINE(v1_5, "pc-i440fx-1.5", pc_compat_1_5,
                       pc_i440fx_1_5_machine_options);
=20
+static GlobalProperty pc_compatp_1_4[] =3D {
+    PC_COMPAT_1_4
+};
=20
 static void pc_i440fx_1_4_machine_options(MachineClass *m)
 {
     pc_i440fx_1_5_machine_options(m);
     m->hw_version =3D "1.4.0";
     m->hot_add_cpu =3D NULL;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_4);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_4);
 }
=20
 DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4,
                       pc_i440fx_1_4_machine_options);
=20
-
-#define PC_COMPAT_1_3 \
-        PC_CPU_MODEL_IDS("1.3.0") \
-        {\
-            .driver   =3D "usb-tablet",\
-            .property =3D "usb_version",\
-            .value    =3D stringify(1),\
-        },{\
-            .driver   =3D "virtio-net-pci",\
-            .property =3D "ctrl_mac_addr",\
-            .value    =3D "off",      \
-        },{ \
-            .driver   =3D "virtio-net-pci", \
-            .property =3D "mq", \
-            .value    =3D "off", \
-        }, {\
-            .driver   =3D "e1000",\
-            .property =3D "autonegotiation",\
-            .value    =3D "off",\
-        },
-
+static GlobalProperty pc_compatp_1_3[] =3D {
+    PC_CPU_MODEL_IDS("1.3.0")
+    {
+        .driver   =3D "usb-tablet",
+        .property =3D "usb_version",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "ctrl_mac_addr",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "mq",
+        .value    =3D "off",
+    }, {
+        .driver   =3D "e1000",
+        .property =3D "autonegotiation",
+        .value    =3D "off",
+    },
+};
=20
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
     pc_i440fx_1_4_machine_options(m);
     m->hw_version =3D "1.3.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_3);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_3);
 }
=20
 DEFINE_I440FX_MACHINE(v1_3, "pc-1.3", pc_compat_1_3,
                       pc_i440fx_1_3_machine_options);
=20
=20
-#define PC_COMPAT_1_2 \
-        PC_CPU_MODEL_IDS("1.2.0") \
-        {\
-            .driver   =3D "nec-usb-xhci",\
-            .property =3D "msi",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "nec-usb-xhci",\
-            .property =3D "msix",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "ivshmem",\
-            .property =3D "use64",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "qxl",\
-            .property =3D "revision",\
-            .value    =3D stringify(3),\
-        },{\
-            .driver   =3D "qxl-vga",\
-            .property =3D "revision",\
-            .value    =3D stringify(3),\
-        },{\
-            .driver   =3D "VGA",\
-            .property =3D "mmio",\
-            .value    =3D "off",\
-        },
+static GlobalProperty pc_compatp_1_2[] =3D {
+    PC_CPU_MODEL_IDS("1.2.0")
+    {
+        .driver   =3D "nec-usb-xhci",
+        .property =3D "msi",
+        .value    =3D "off",
+    },{
+        .driver   =3D "nec-usb-xhci",
+        .property =3D "msix",
+        .value    =3D "off",
+    },{
+        .driver   =3D "ivshmem",
+        .property =3D "use64",
+        .value    =3D "0",
+    },{
+        .driver   =3D "qxl",
+        .property =3D "revision",
+        .value    =3D stringify(3),
+    },{
+        .driver   =3D "qxl-vga",
+        .property =3D "revision",
+        .value    =3D stringify(3),
+    },{
+        .driver   =3D "VGA",
+        .property =3D "mmio",
+        .value    =3D "off",
+    },
+};
=20
 static void pc_i440fx_1_2_machine_options(MachineClass *m)
 {
     pc_i440fx_1_3_machine_options(m);
     m->hw_version =3D "1.2.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_2);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_2);
 }
=20
 DEFINE_I440FX_MACHINE(v1_2, "pc-1.2", pc_compat_1_2,
                       pc_i440fx_1_2_machine_options);
=20
=20
-#define PC_COMPAT_1_1 \
-        PC_CPU_MODEL_IDS("1.1.0") \
-        {\
-            .driver   =3D "virtio-scsi-pci",\
-            .property =3D "hotplug",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "virtio-scsi-pci",\
-            .property =3D "param_change",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "VGA",\
-            .property =3D "vgamem_mb",\
-            .value    =3D stringify(8),\
-        },{\
-            .driver   =3D "vmware-svga",\
-            .property =3D "vgamem_mb",\
-            .value    =3D stringify(8),\
-        },{\
-            .driver   =3D "qxl-vga",\
-            .property =3D "vgamem_mb",\
-            .value    =3D stringify(8),\
-        },{\
-            .driver   =3D "qxl",\
-            .property =3D "vgamem_mb",\
-            .value    =3D stringify(8),\
-        },{\
-            .driver   =3D "virtio-blk-pci",\
-            .property =3D "config-wce",\
-            .value    =3D "off",\
-        },
+static GlobalProperty pc_compatp_1_1[] =3D {
+    PC_CPU_MODEL_IDS("1.1.0")
+    {
+        .driver   =3D "virtio-scsi-pci",
+        .property =3D "hotplug",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-scsi-pci",
+        .property =3D "param_change",
+        .value    =3D "off",
+    },{
+        .driver   =3D "VGA",
+        .property =3D "vgamem_mb",
+        .value    =3D stringify(8),
+    },{
+        .driver   =3D "vmware-svga",
+        .property =3D "vgamem_mb",
+        .value    =3D stringify(8),
+    },{
+        .driver   =3D "qxl-vga",
+        .property =3D "vgamem_mb",
+        .value    =3D stringify(8),
+    },{
+        .driver   =3D "qxl",
+        .property =3D "vgamem_mb",
+        .value    =3D stringify(8),
+    },{
+        .driver   =3D "virtio-blk-pci",
+        .property =3D "config-wce",
+        .value    =3D "off",
+    },
+};
=20
 static void pc_i440fx_1_1_machine_options(MachineClass *m)
 {
     pc_i440fx_1_2_machine_options(m);
     m->hw_version =3D "1.1.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_1);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_1);
 }
=20
 DEFINE_I440FX_MACHINE(v1_1, "pc-1.1", pc_compat_1_2,
                       pc_i440fx_1_1_machine_options);
=20
-
-#define PC_COMPAT_1_0 \
-        PC_CPU_MODEL_IDS("1.0") \
-        {\
-            .driver   =3D TYPE_ISA_FDC,\
-            .property =3D "check_media_rate",\
-            .value    =3D "off",\
-        }, {\
-            .driver   =3D "virtio-balloon-pci",\
-            .property =3D "class",\
-            .value    =3D stringify(PCI_CLASS_MEMORY_RAM),\
-        },{\
-            .driver   =3D "apic-common",\
-            .property =3D "vapic",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D TYPE_USB_DEVICE,\
-            .property =3D "full-path",\
-            .value    =3D "no",\
-        },
+static GlobalProperty pc_compatp_1_0[] =3D {
+    PC_CPU_MODEL_IDS("1.0")
+    {
+        .driver   =3D TYPE_ISA_FDC,
+        .property =3D "check_media_rate",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-balloon-pci",
+        .property =3D "class",
+        .value    =3D stringify(PCI_CLASS_MEMORY_RAM),
+    },{
+        .driver   =3D "apic-common",
+        .property =3D "vapic",
+        .value    =3D "off",
+    },{
+        .driver   =3D TYPE_USB_DEVICE,
+        .property =3D "full-path",
+        .value    =3D "no",
+    },
+};
=20
 static void pc_i440fx_1_0_machine_options(MachineClass *m)
 {
     pc_i440fx_1_1_machine_options(m);
     m->hw_version =3D "1.0";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_1_0);
+    SET_MACHINE_COMPAT(m, pc_compatp_1_0);
 }
=20
 DEFINE_I440FX_MACHINE(v1_0, "pc-1.0", pc_compat_1_2,
                       pc_i440fx_1_0_machine_options);
=20
=20
-#define PC_COMPAT_0_15 \
-        PC_CPU_MODEL_IDS("0.15")
+static GlobalProperty pc_compatp_0_15[] =3D {
+    PC_CPU_MODEL_IDS("0.15")
+};
=20
 static void pc_i440fx_0_15_machine_options(MachineClass *m)
 {
     pc_i440fx_1_0_machine_options(m);
     m->hw_version =3D "0.15";
     m->deprecation_reason =3D "use a newer machine type instead";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_15);
+    SET_MACHINE_COMPAT(m, pc_compatp_0_15);
 }
=20
 DEFINE_I440FX_MACHINE(v0_15, "pc-0.15", pc_compat_1_2,
                       pc_i440fx_0_15_machine_options);
=20
=20
-#define PC_COMPAT_0_14 \
-        PC_CPU_MODEL_IDS("0.14") \
-        {\
-            .driver   =3D "virtio-blk-pci",\
-            .property =3D "event_idx",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "virtio-serial-pci",\
-            .property =3D "event_idx",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "virtio-net-pci",\
-            .property =3D "event_idx",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "virtio-balloon-pci",\
-            .property =3D "event_idx",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "qxl",\
-            .property =3D "revision",\
-            .value    =3D stringify(2),\
-        },{\
-            .driver   =3D "qxl-vga",\
-            .property =3D "revision",\
-            .value    =3D stringify(2),\
-        },
+static GlobalProperty pc_compatp_0_14[] =3D {
+    PC_CPU_MODEL_IDS("0.14")
+    {
+        .driver   =3D "virtio-blk-pci",
+        .property =3D "event_idx",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-serial-pci",
+        .property =3D "event_idx",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "event_idx",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-balloon-pci",
+        .property =3D "event_idx",
+        .value    =3D "off",
+    },{
+        .driver   =3D "qxl",
+        .property =3D "revision",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "qxl-vga",
+        .property =3D "revision",
+        .value    =3D stringify(2),
+    },
+};
=20
 static void pc_i440fx_0_14_machine_options(MachineClass *m)
 {
     pc_i440fx_0_15_machine_options(m);
     m->hw_version =3D "0.14";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_14);
+    SET_MACHINE_COMPAT(m, pc_compatp_0_14);
 }
=20
 DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
                       pc_i440fx_0_14_machine_options);
=20
-
-#define PC_COMPAT_0_13 \
-        PC_CPU_MODEL_IDS("0.13") \
-        {\
-            .driver   =3D TYPE_PCI_DEVICE,\
-            .property =3D "command_serr_enable",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "AC97",\
-            .property =3D "use_broken_id",\
-            .value    =3D stringify(1),\
-        },{\
-            .driver   =3D "virtio-9p-pci",\
-            .property =3D "vectors",\
-            .value    =3D stringify(0),\
-        },{\
-            .driver   =3D "VGA",\
-            .property =3D "rombar",\
-            .value    =3D stringify(0),\
-        },{\
-            .driver   =3D "vmware-svga",\
-            .property =3D "rombar",\
-            .value    =3D stringify(0),\
-        },
+static GlobalProperty pc_compatp_0_13[] =3D {
+    PC_CPU_MODEL_IDS("0.13")
+    {
+        .driver   =3D TYPE_PCI_DEVICE,
+        .property =3D "command_serr_enable",
+        .value    =3D "off",
+    },{
+        .driver   =3D "AC97",
+        .property =3D "use_broken_id",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "virtio-9p-pci",
+        .property =3D "vectors",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "VGA",
+        .property =3D "rombar",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "vmware-svga",
+        .property =3D "rombar",
+        .value    =3D stringify(0),
+    },
+};
=20
 static void pc_i440fx_0_13_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_0_14_machine_options(m);
     m->hw_version =3D "0.13";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_13);
+    SET_MACHINE_COMPAT(m, pc_compatp_0_13);
     pcmc->kvmclock_enabled =3D false;
 }
=20
 DEFINE_I440FX_MACHINE(v0_13, "pc-0.13", pc_compat_0_13,
                       pc_i440fx_0_13_machine_options);
=20
-
-#define PC_COMPAT_0_12 \
-        PC_CPU_MODEL_IDS("0.12") \
-        {\
-            .driver   =3D "virtio-serial-pci",\
-            .property =3D "max_ports",\
-            .value    =3D stringify(1),\
-        },{\
-            .driver   =3D "virtio-serial-pci",\
-            .property =3D "vectors",\
-            .value    =3D stringify(0),\
-        },{\
-            .driver   =3D "usb-mouse",\
-            .property =3D "serial",\
-            .value    =3D "1",\
-        },{\
-            .driver   =3D "usb-tablet",\
-            .property =3D "serial",\
-            .value    =3D "1",\
-        },{\
-            .driver   =3D "usb-kbd",\
-            .property =3D "serial",\
-            .value    =3D "1",\
-        },
+static GlobalProperty pc_compat_0_12[] =3D {
+    PC_CPU_MODEL_IDS("0.12")
+    {
+        .driver   =3D "virtio-serial-pci",
+        .property =3D "max_ports",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "virtio-serial-pci",
+        .property =3D "vectors",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "usb-mouse",
+        .property =3D "serial",
+        .value    =3D "1",
+    },{
+        .driver   =3D "usb-tablet",
+        .property =3D "serial",
+        .value    =3D "1",
+    },{
+        .driver   =3D "usb-kbd",
+        .property =3D "serial",
+        .value    =3D "1",
+    },
+};
=20
 static void pc_i440fx_0_12_machine_options(MachineClass *m)
 {
     pc_i440fx_0_13_machine_options(m);
     m->hw_version =3D "0.12";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_12);
+    SET_MACHINE_COMPAT(m, pc_compat_0_12);
 }
=20
 DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0a3f3f18e4..9aabae358c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -321,51 +321,71 @@ static void pc_q35_4_0_machine_options(MachineClass=
 *m)
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
=20
+static GlobalProperty pc_compat_3_1[] =3D {
+    PC_COMPAT_3_1
+};
+
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split =3D false;
     m->alias =3D NULL;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
+    SET_MACHINE_COMPAT(m, pc_compat_3_1);
 }
=20
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
                    pc_q35_3_1_machine_options);
=20
+static GlobalProperty pc_compat_3_0[] =3D {
+    PC_COMPAT_3_0
+};
+
 static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_3_1_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
+    SET_MACHINE_COMPAT(m, pc_compat_3_0);
 }
=20
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
                     pc_q35_3_0_machine_options);
=20
+static GlobalProperty pc_compat_2_12[] =3D {
+    PC_COMPAT_2_12
+};
+
 static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_3_0_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
+    SET_MACHINE_COMPAT(m, pc_compat_2_12);
 }
=20
 DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
                    pc_q35_2_12_machine_options);
=20
+static GlobalProperty pc_compat_2_11[] =3D {
+    PC_COMPAT_2_11
+};
+
 static void pc_q35_2_11_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
=20
     pc_q35_2_12_machine_options(m);
     pcmc->default_nic_model =3D "e1000";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+    SET_MACHINE_COMPAT(m, pc_compat_2_11);
 }
=20
 DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
                    pc_q35_2_11_machine_options);
=20
+static GlobalProperty pc_compat_2_10[] =3D {
+    PC_COMPAT_2_10
+};
+
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_2_11_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+    SET_MACHINE_COMPAT(m, pc_compat_2_10);
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp =3D false;
 }
@@ -373,65 +393,89 @@ static void pc_q35_2_10_machine_options(MachineClas=
s *m)
 DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
                    pc_q35_2_10_machine_options);
=20
+static GlobalProperty pc_compat_2_9[] =3D {
+    PC_COMPAT_2_9
+};
+
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_2_10_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+    SET_MACHINE_COMPAT(m, pc_compat_2_9);
 }
=20
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
                    pc_q35_2_9_machine_options);
=20
+static GlobalProperty pc_compat_2_8[] =3D {
+    PC_COMPAT_2_8
+};
+
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
     pc_q35_2_9_machine_options(m);
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+    SET_MACHINE_COMPAT(m, pc_compat_2_8);
 }
=20
 DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
                    pc_q35_2_8_machine_options);
=20
+static GlobalProperty pc_compat_2_7[] =3D {
+    PC_COMPAT_2_7
+};
+
 static void pc_q35_2_7_machine_options(MachineClass *m)
 {
     pc_q35_2_8_machine_options(m);
     m->max_cpus =3D 255;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
+    SET_MACHINE_COMPAT(m, pc_compat_2_7);
 }
=20
 DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
                    pc_q35_2_7_machine_options);
=20
+static GlobalProperty pc_compat_2_6[] =3D {
+    PC_COMPAT_2_6
+};
+
 static void pc_q35_2_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
+    SET_MACHINE_COMPAT(m, pc_compat_2_6);
 }
=20
 DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
                    pc_q35_2_6_machine_options);
=20
+static GlobalProperty pc_compat_2_5[] =3D {
+    PC_COMPAT_2_5
+};
+
 static void pc_q35_2_5_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_5);
+    SET_MACHINE_COMPAT(m, pc_compat_2_5);
 }
=20
 DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
                    pc_q35_2_5_machine_options);
=20
+static GlobalProperty pc_compat_2_4[] =3D {
+    PC_COMPAT_2_4
+};
+
 static void pc_q35_2_4_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_4);
+    SET_MACHINE_COMPAT(m, pc_compat_2_4);
 }
=20
 DEFINE_Q35_MACHINE(v2_4, "pc-q35-2.4", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 19a07c5c9d..f724a8d57a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4021,13 +4021,14 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
 /*
  * pseries-3.1
  */
-#define SPAPR_COMPAT_3_1                                              \
+static GlobalProperty spapr_compat_3_1[] =3D {
     HW_COMPAT_3_1
+};
=20
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     spapr_machine_4_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
+    SET_MACHINE_COMPAT(mc, spapr_compat_3_1);
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
 }
=20
@@ -4036,15 +4037,16 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
 /*
  * pseries-3.0
  */
-#define SPAPR_COMPAT_3_0                                              \
+static GlobalProperty spapr_compat_3_0[] =3D {
     HW_COMPAT_3_0
+};
=20
 static void spapr_machine_3_0_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_3_1_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
+    SET_MACHINE_COMPAT(mc, spapr_compat_3_0);
=20
     smc->legacy_irq_allocation =3D true;
     smc->irq =3D &spapr_irq_xics_legacy;
@@ -4055,25 +4057,26 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
 /*
  * pseries-2.12
  */
-#define SPAPR_COMPAT_2_12                                              \
-    HW_COMPAT_2_12                                                     \
-    {                                                                  \
-        .driver =3D TYPE_POWERPC_CPU,                                   =
 \
-        .property =3D "pre-3.0-migration",                              =
 \
-        .value    =3D "on",                                             =
 \
-    },                                                                 \
-    {                                                                  \
-        .driver =3D TYPE_SPAPR_CPU_CORE,                                =
 \
-        .property =3D "pre-3.0-migration",                              =
 \
-        .value    =3D "on",                                             =
 \
+static GlobalProperty spapr_compat_2_12[] =3D {
+    HW_COMPAT_2_12
+    {
+        .driver =3D TYPE_POWERPC_CPU,
+        .property =3D "pre-3.0-migration",
+        .value    =3D "on",
+    },
+    {
+        .driver =3D TYPE_SPAPR_CPU_CORE,
+        .property =3D "pre-3.0-migration",
+        .value    =3D "on",
     },
+};
=20
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_3_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_12);
=20
     /* We depend on kvm_enabled() to choose a default value for the
      * hpt-max-page-size capability. Of course we can't do it here
@@ -4100,8 +4103,9 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false)=
;
 /*
  * pseries-2.11
  */
-#define SPAPR_COMPAT_2_11                                              \
+static GlobalProperty spapr_compat_2_11[] =3D {
     HW_COMPAT_2_11
+};
=20
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
@@ -4109,7 +4113,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
=20
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_11);
 }
=20
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
@@ -4117,13 +4121,14 @@ DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
 /*
  * pseries-2.10
  */
-#define SPAPR_COMPAT_2_10                                              \
+static GlobalProperty spapr_compat_2_10[] =3D {
     HW_COMPAT_2_10
+};
=20
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
     spapr_machine_2_11_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_10);
 }
=20
 DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
@@ -4131,20 +4136,21 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
 /*
  * pseries-2.9
  */
-#define SPAPR_COMPAT_2_9                                               \
-    HW_COMPAT_2_9                                                      \
-    {                                                                  \
-        .driver =3D TYPE_POWERPC_CPU,                                   =
 \
-        .property =3D "pre-2.10-migration",                             =
 \
-        .value    =3D "on",                                             =
 \
-    },                                                                 \
+static GlobalProperty spapr_compat_2_9[] =3D {
+    HW_COMPAT_2_9
+    {
+        .driver =3D TYPE_POWERPC_CPU,
+        .property =3D "pre-2.10-migration",
+        .value    =3D "on",
+    },
+};
=20
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_2_10_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_9);
     mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
@@ -4155,18 +4161,19 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
 /*
  * pseries-2.8
  */
-#define SPAPR_COMPAT_2_8                                        \
-    HW_COMPAT_2_8                                               \
-    {                                                           \
-        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,                 \
-        .property =3D "pcie-extended-configuration-space",        \
-        .value    =3D "off",                                      \
+static GlobalProperty spapr_compat_2_8[] =3D {
+    HW_COMPAT_2_8
+    {
+        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "pcie-extended-configuration-space",
+        .value    =3D "off",
     },
+};
=20
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     spapr_machine_2_9_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_8);
     mc->numa_mem_align_shift =3D 23;
 }
=20
@@ -4175,28 +4182,29 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
 /*
  * pseries-2.7
  */
-#define SPAPR_COMPAT_2_7                            \
-    HW_COMPAT_2_7                                   \
-    {                                               \
-        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,     \
-        .property =3D "mem_win_size",                 \
-        .value    =3D stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),\
-    },                                              \
-    {                                               \
-        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,     \
-        .property =3D "mem64_win_size",               \
-        .value    =3D "0",                            \
-    },                                              \
-    {                                               \
-        .driver =3D TYPE_POWERPC_CPU,                 \
-        .property =3D "pre-2.8-migration",            \
-        .value    =3D "on",                           \
-    },                                              \
-    {                                               \
-        .driver =3D TYPE_SPAPR_PCI_HOST_BRIDGE,       \
-        .property =3D "pre-2.8-migration",            \
-        .value    =3D "on",                           \
+static GlobalProperty spapr_compat_2_7[] =3D {
+    HW_COMPAT_2_7
+    {
+        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "mem_win_size",
+        .value    =3D stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),
+    },
+    {
+        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "mem64_win_size",
+        .value    =3D "0",
+    },
+    {
+        .driver =3D TYPE_POWERPC_CPU,
+        .property =3D "pre-2.8-migration",
+        .value    =3D "on",
     },
+    {
+        .driver =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "pre-2.8-migration",
+        .value    =3D "on",
+    },
+};
=20
 static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
                               uint64_t *buid, hwaddr *pio,
@@ -4254,7 +4262,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
     spapr_machine_2_8_class_options(mc);
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power7_v2.3");
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff";
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_7);
     smc->phb_placement =3D phb_placement_2_7;
 }
=20
@@ -4263,19 +4271,20 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
 /*
  * pseries-2.6
  */
-#define SPAPR_COMPAT_2_6 \
-    HW_COMPAT_2_6 \
-    { \
-        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,\
-        .property =3D "ddw",\
-        .value    =3D stringify(off),\
+static GlobalProperty spapr_compat_2_6[] =3D {
+    HW_COMPAT_2_6
+    {
+        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "ddw",
+        .value    =3D stringify(off),
     },
+};
=20
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     spapr_machine_2_7_class_options(mc);
     mc->has_hotpluggable_cpus =3D false;
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_6);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_6);
 }
=20
 DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
@@ -4283,13 +4292,14 @@ DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
 /*
  * pseries-2.5
  */
-#define SPAPR_COMPAT_2_5 \
-    HW_COMPAT_2_5 \
-    { \
-        .driver   =3D "spapr-vlan", \
-        .property =3D "use-rx-buffer-pools", \
-        .value    =3D "off", \
+static GlobalProperty spapr_compat_2_5[] =3D {
+    HW_COMPAT_2_5
+    {
+        .driver   =3D "spapr-vlan",
+        .property =3D "use-rx-buffer-pools",
+        .value    =3D "off",
     },
+};
=20
 static void spapr_machine_2_5_class_options(MachineClass *mc)
 {
@@ -4297,7 +4307,7 @@ static void spapr_machine_2_5_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_6_class_options(mc);
     smc->use_ohci_by_default =3D true;
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_5);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_5);
 }
=20
 DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
@@ -4305,8 +4315,9 @@ DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
 /*
  * pseries-2.4
  */
-#define SPAPR_COMPAT_2_4 \
-        HW_COMPAT_2_4
+static GlobalProperty spapr_compat_2_4[] =3D {
+    HW_COMPAT_2_4
+};
=20
 static void spapr_machine_2_4_class_options(MachineClass *mc)
 {
@@ -4314,7 +4325,7 @@ static void spapr_machine_2_4_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_5_class_options(mc);
     smc->dr_lmb_enabled =3D false;
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_4);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_4);
 }
=20
 DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
@@ -4322,37 +4333,38 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 /*
  * pseries-2.3
  */
-#define SPAPR_COMPAT_2_3 \
-        HW_COMPAT_2_3 \
-        {\
-            .driver   =3D "spapr-pci-host-bridge",\
-            .property =3D "dynamic-reconfiguration",\
-            .value    =3D "off",\
-        },
+static GlobalProperty spapr_compat_2_3[] =3D {
+    HW_COMPAT_2_3
+    {
+        .driver   =3D "spapr-pci-host-bridge",
+        .property =3D "dynamic-reconfiguration",
+        .value    =3D "off",
+    },
+};
=20
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     spapr_machine_2_4_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_3);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_3);
 }
 DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
=20
 /*
  * pseries-2.2
  */
-
-#define SPAPR_COMPAT_2_2 \
-        HW_COMPAT_2_2 \
-        {\
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,\
-            .property =3D "mem_win_size",\
-            .value    =3D "0x20000000",\
-        },
+static GlobalProperty spapr_compat_2_2[] =3D {
+    HW_COMPAT_2_2
+    {
+        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
+        .property =3D "mem_win_size",
+        .value    =3D "0x20000000",
+    },
+};
=20
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     spapr_machine_2_3_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_2);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_2);
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff,suppress-v=
mdesc=3Don";
 }
 DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
@@ -4360,13 +4372,14 @@ DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
 /*
  * pseries-2.1
  */
-#define SPAPR_COMPAT_2_1 \
-        HW_COMPAT_2_1
+static GlobalProperty spapr_compat_2_1[] =3D {
+    HW_COMPAT_2_1
+};
=20
 static void spapr_machine_2_1_class_options(MachineClass *mc)
 {
     spapr_machine_2_2_class_options(mc);
-    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_1);
+    SET_MACHINE_COMPAT(mc, spapr_compat_2_1);
 }
 DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fd9d0b0542..882a9796cf 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -651,99 +651,110 @@ bool css_migration_enabled(void)
     }                                                                   =
      \
     type_init(ccw_machine_register_##suffix)
=20
-#define CCW_COMPAT_3_1 \
-        HW_COMPAT_3_1
-
-#define CCW_COMPAT_3_0 \
-        HW_COMPAT_3_0
-
-#define CCW_COMPAT_2_12 \
-        HW_COMPAT_2_12
-
-#define CCW_COMPAT_2_11 \
-        HW_COMPAT_2_11 \
-        {\
-            .driver   =3D TYPE_SCLP_EVENT_FACILITY,\
-            .property =3D "allow_all_mask_sizes",\
-            .value    =3D "off",\
-        },
-
-#define CCW_COMPAT_2_10 \
-        HW_COMPAT_2_10
-
-#define CCW_COMPAT_2_9 \
-        HW_COMPAT_2_9 \
-        {\
-            .driver   =3D TYPE_S390_STATTRIB,\
-            .property =3D "migration-enabled",\
-            .value    =3D "off",\
-        },
-
-#define CCW_COMPAT_2_8 \
-        HW_COMPAT_2_8 \
-        {\
-            .driver   =3D TYPE_S390_FLIC_COMMON,\
-            .property =3D "adapter_routes_max_batch",\
-            .value    =3D "64",\
-        },
-
-#define CCW_COMPAT_2_7 \
-        HW_COMPAT_2_7
-
-#define CCW_COMPAT_2_6 \
-        HW_COMPAT_2_6 \
-        {\
-            .driver   =3D TYPE_S390_IPL,\
-            .property =3D "iplbext_migration",\
-            .value    =3D "off",\
-        }, {\
-            .driver   =3D TYPE_VIRTUAL_CSS_BRIDGE,\
-            .property =3D "css_dev_path",\
-            .value    =3D "off",\
-        },
-
-#define CCW_COMPAT_2_5 \
-        HW_COMPAT_2_5
-
-#define CCW_COMPAT_2_4 \
-        HW_COMPAT_2_4 \
-        {\
-            .driver   =3D TYPE_S390_SKEYS,\
-            .property =3D "migration-enabled",\
-            .value    =3D "off",\
-        },{\
-            .driver   =3D "virtio-blk-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-balloon-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-serial-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-9p-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-rng-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-net-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "virtio-scsi-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },{\
-            .driver   =3D "vhost-scsi-ccw",\
-            .property =3D "max_revision",\
-            .value    =3D "0",\
-        },
+static GlobalProperty ccw_compat_3_1[] =3D {
+    HW_COMPAT_3_1
+};
+
+static GlobalProperty ccw_compat_3_0[] =3D {
+    HW_COMPAT_3_0
+};
+
+static GlobalProperty ccw_compat_2_12[] =3D {
+    HW_COMPAT_2_12
+};
+
+static GlobalProperty ccw_compat_2_11[] =3D {
+    HW_COMPAT_2_11
+    {
+        .driver   =3D TYPE_SCLP_EVENT_FACILITY,
+        .property =3D "allow_all_mask_sizes",
+        .value    =3D "off",
+    },
+};
+
+static GlobalProperty ccw_compat_2_10[] =3D {
+    HW_COMPAT_2_10
+};
+
+static GlobalProperty ccw_compat_2_9[] =3D {
+    HW_COMPAT_2_9
+    {
+        .driver   =3D TYPE_S390_STATTRIB,
+        .property =3D "migration-enabled",
+        .value    =3D "off",
+    },
+};
+
+static GlobalProperty ccw_compat_2_8[] =3D {
+    HW_COMPAT_2_8
+    {
+        .driver   =3D TYPE_S390_FLIC_COMMON,
+        .property =3D "adapter_routes_max_batch",
+        .value    =3D "64",
+    },
+};
+
+static GlobalProperty ccw_compat_2_7[] =3D {
+    HW_COMPAT_2_7
+};
+
+static GlobalProperty ccw_compat_2_6[] =3D {
+    HW_COMPAT_2_6
+    {
+        .driver   =3D TYPE_S390_IPL,
+        .property =3D "iplbext_migration",
+        .value    =3D "off",
+    }, {
+        .driver   =3D TYPE_VIRTUAL_CSS_BRIDGE,
+        .property =3D "css_dev_path",
+        .value    =3D "off",
+    },
+};
+
+static GlobalProperty ccw_compat_2_5[] =3D {
+    HW_COMPAT_2_5
+};
+
+static GlobalProperty ccw_compat_2_4[] =3D {
+    HW_COMPAT_2_4
+    {
+        .driver   =3D TYPE_S390_SKEYS,
+        .property =3D "migration-enabled",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-blk-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-balloon-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-serial-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-9p-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-rng-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-net-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "virtio-scsi-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },{
+        .driver   =3D "vhost-scsi-ccw",
+        .property =3D "max_revision",
+        .value    =3D "0",
+    },
+};
=20
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
@@ -762,7 +773,7 @@ static void ccw_machine_3_1_instance_options(MachineS=
tate *machine)
 static void ccw_machine_3_1_class_options(MachineClass *mc)
 {
     ccw_machine_4_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_1);
+    SET_MACHINE_COMPAT(mc, ccw_compat_3_1);
 }
 DEFINE_CCW_MACHINE(3_1, "3.1", false);
=20
@@ -777,7 +788,7 @@ static void ccw_machine_3_0_class_options(MachineClas=
s *mc)
=20
     s390mc->hpage_1m_allowed =3D false;
     ccw_machine_3_1_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_0);
+    SET_MACHINE_COMPAT(mc, ccw_compat_3_0);
 }
 DEFINE_CCW_MACHINE(3_0, "3.0", false);
=20
@@ -791,7 +802,7 @@ static void ccw_machine_2_12_instance_options(Machine=
State *machine)
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
     ccw_machine_3_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_12);
 }
 DEFINE_CCW_MACHINE(2_12, "2.12", false);
=20
@@ -807,7 +818,7 @@ static void ccw_machine_2_11_instance_options(Machine=
State *machine)
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
     ccw_machine_2_12_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_11);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_11);
 }
 DEFINE_CCW_MACHINE(2_11, "2.11", false);
=20
@@ -819,7 +830,7 @@ static void ccw_machine_2_10_instance_options(Machine=
State *machine)
 static void ccw_machine_2_10_class_options(MachineClass *mc)
 {
     ccw_machine_2_11_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_10);
 }
 DEFINE_CCW_MACHINE(2_10, "2.10", false);
=20
@@ -838,7 +849,7 @@ static void ccw_machine_2_9_class_options(MachineClas=
s *mc)
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
=20
     ccw_machine_2_10_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_9);
     s390mc->css_migration_enabled =3D false;
 }
 DEFINE_CCW_MACHINE(2_9, "2.9", false);
@@ -851,7 +862,7 @@ static void ccw_machine_2_8_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
     ccw_machine_2_9_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_8);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_8);
 }
 DEFINE_CCW_MACHINE(2_8, "2.8", false);
=20
@@ -866,7 +877,7 @@ static void ccw_machine_2_7_class_options(MachineClas=
s *mc)
=20
     s390mc->cpu_model_allowed =3D false;
     ccw_machine_2_8_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_7);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_7);
 }
 DEFINE_CCW_MACHINE(2_7, "2.7", false);
=20
@@ -881,7 +892,7 @@ static void ccw_machine_2_6_class_options(MachineClas=
s *mc)
=20
     s390mc->ri_allowed =3D false;
     ccw_machine_2_7_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_6);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_6);
 }
 DEFINE_CCW_MACHINE(2_6, "2.6", false);
=20
@@ -893,7 +904,7 @@ static void ccw_machine_2_5_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_5_class_options(MachineClass *mc)
 {
     ccw_machine_2_6_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_5);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_5);
 }
 DEFINE_CCW_MACHINE(2_5, "2.5", false);
=20
@@ -905,7 +916,7 @@ static void ccw_machine_2_4_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_4_class_options(MachineClass *mc)
 {
     ccw_machine_2_5_class_options(mc);
-    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_4);
+    SET_MACHINE_COMPAT(mc, ccw_compat_2_4);
 }
 DEFINE_CCW_MACHINE(2_4, "2.4", false);
=20
--=20
2.20.1.2.gb21ebb671b
