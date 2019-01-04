Received: from eggs.gnu.org ([208.118.235.92]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJM-00035r-Vu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJK-0000xL-7a
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTJJ-0000wr-Vq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:17 +0400
Message-Id: <20190104173042.32714-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/28] hw: apply machine compat properties
 without touching globals
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

Similarly to accel properties, move compat properties out of globals
registration, and apply the machine compat properties during
device_post_init().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h        |  3 +-
 hw/arm/virt.c              | 27 ++++++++-----
 hw/core/machine.c          | 19 +--------
 hw/core/qdev.c             |  2 +
 hw/i386/pc_piix.c          | 81 +++++++++++++++++++++++++-------------
 hw/i386/pc_q35.c           | 33 ++++++++++------
 hw/ppc/spapr.c             | 42 +++++++++++++-------
 hw/s390x/s390-virtio-ccw.c | 33 ++++++++++------
 vl.c                       |  1 -
 9 files changed, 148 insertions(+), 93 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a5d8ddd68b..f14c38bb63 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -69,7 +69,6 @@ int machine_kvm_shadow_mem(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
-void machine_register_compat_props(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
@@ -191,7 +190,7 @@ struct MachineClass {
     const char *default_machine_opts;
     const char *default_boot_order;
     const char *default_display;
-    GArray *compat_props;
+    GPtrArray *compat_props;
     const char *hw_version;
     ram_addr_t default_ram_size;
     const char *default_cpu_type;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6ecec1cb05..275ef8bc02 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1879,7 +1879,8 @@ static GlobalProperty virt_compat_3_1[] =3D {
 static void virt_machine_3_1_options(MachineClass *mc)
 {
     virt_machine_4_0_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_3_1);
+    compat_props_add(mc->compat_props,
+                     virt_compat_3_1, G_N_ELEMENTS(virt_compat_3_1));
 }
 DEFINE_VIRT_MACHINE(3, 1)
=20
@@ -1890,7 +1891,8 @@ static GlobalProperty virt_compat_3_0[] =3D {
 static void virt_machine_3_0_options(MachineClass *mc)
 {
     virt_machine_3_1_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_3_0);
+    compat_props_add(mc->compat_props,
+                     virt_compat_3_0, G_N_ELEMENTS(virt_compat_3_0));
 }
 DEFINE_VIRT_MACHINE(3, 0)
=20
@@ -1903,7 +1905,8 @@ static void virt_machine_2_12_options(MachineClass =
*mc)
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_3_0_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_12);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_12, G_N_ELEMENTS(virt_compat_2_12));
     vmc->no_highmem_ecam =3D true;
     mc->max_cpus =3D 255;
 }
@@ -1918,7 +1921,8 @@ static void virt_machine_2_11_options(MachineClass =
*mc)
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_12_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_11);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_11, G_N_ELEMENTS(virt_compat_2_11));
     vmc->smbios_old_sys_ver =3D true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
@@ -1930,7 +1934,8 @@ static GlobalProperty virt_compat_2_10[] =3D {
 static void virt_machine_2_10_options(MachineClass *mc)
 {
     virt_machine_2_11_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_10);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_10, G_N_ELEMENTS(virt_compat_2_10));
     /* before 2.11 we never faulted accesses to bad addresses */
     mc->ignore_memory_transaction_failures =3D true;
 }
@@ -1943,7 +1948,8 @@ static GlobalProperty virt_compat_2_9[] =3D {
 static void virt_machine_2_9_options(MachineClass *mc)
 {
     virt_machine_2_10_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_9);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_9, G_N_ELEMENTS(virt_compat_2_9));
 }
 DEFINE_VIRT_MACHINE(2, 9)
=20
@@ -1956,7 +1962,8 @@ static void virt_machine_2_8_options(MachineClass *=
mc)
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_9_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_8);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_8, G_N_ELEMENTS(virt_compat_2_8));
     /* For 2.8 and earlier we falsely claimed in the DT that
      * our timers were edge-triggered, not level-triggered.
      */
@@ -1973,7 +1980,8 @@ static void virt_machine_2_7_options(MachineClass *=
mc)
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_8_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_7);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_7, G_N_ELEMENTS(virt_compat_2_7));
     /* ITS was introduced with 2.8 */
     vmc->no_its =3D true;
     /* Stick with 1K pages for migration compatibility */
@@ -1990,7 +1998,8 @@ static void virt_machine_2_6_options(MachineClass *=
mc)
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
=20
     virt_machine_2_7_options(mc);
-    SET_MACHINE_COMPAT(mc, virt_compat_2_6);
+    compat_props_add(mc->compat_props,
+                     virt_compat_2_6, G_N_ELEMENTS(virt_compat_2_6));
     vmc->disallow_affinity_adjustment =3D true;
     /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
     vmc->no_pmu =3D true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4439ea663f..bd644c976b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -647,6 +647,7 @@ static void machine_class_base_init(ObjectClass *oc, =
void *data)
         assert(g_str_has_suffix(cname, TYPE_MACHINE_SUFFIX));
         mc->name =3D g_strndup(cname,
                             strlen(cname) - strlen(TYPE_MACHINE_SUFFIX))=
;
+        mc->compat_props =3D g_ptr_array_new();
     }
 }
=20
@@ -836,24 +837,6 @@ void machine_run_board_init(MachineState *machine)
     machine_class->init(machine);
 }
=20
-void machine_register_compat_props(MachineState *machine)
-{
-    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    int i;
-    GlobalProperty *p;
-
-    if (!mc->compat_props) {
-        return;
-    }
-
-    for (i =3D 0; i < mc->compat_props->len; i++) {
-        p =3D g_array_index(mc->compat_props, GlobalProperty *, i);
-        /* Machine compat_props must never cause errors: */
-        p->errp =3D &error_abort;
-        qdev_prop_register_global(p);
-    }
-}
-
 static const TypeInfo machine_info =3D {
     .name =3D TYPE_MACHINE,
     .parent =3D TYPE_OBJECT,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 53b507164f..d510340bac 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -974,11 +974,13 @@ static void device_post_init(Object *obj)
 {
     if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
         MachineState *m =3D MACHINE(qdev_get_machine());
+        MachineClass *mc =3D MACHINE_GET_CLASS(m);
         AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
=20
         if (ac->compat_props) {
             object_apply_global_props(obj, ac->compat_props, &error_abor=
t);
         }
+        object_apply_global_props(obj, mc->compat_props, &error_abort);
     }
=20
     qdev_prop_set_globals(DEVICE(obj));
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ac97097cac..a88646a711 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -447,7 +447,8 @@ static void pc_i440fx_3_1_machine_options(MachineClas=
s *m)
     pc_i440fx_4_0_machine_options(m);
     m->is_default =3D 0;
     m->alias =3D NULL;
-    SET_MACHINE_COMPAT(m, pc_compat_3_1);
+    compat_props_add(m->compat_props,
+                     pc_compat_3_1, G_N_ELEMENTS(pc_compat_3_1));
 }
=20
 DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
@@ -460,7 +461,8 @@ static GlobalProperty pc_compat_3_0[] =3D {
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_3_1_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_3_0);
+    compat_props_add(m->compat_props,
+                     pc_compat_3_0, G_N_ELEMENTS(pc_compat_3_0));
 }
=20
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
@@ -473,7 +475,8 @@ static GlobalProperty pc_compat_2_12[] =3D {
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_12);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_12, G_N_ELEMENTS(pc_compat_2_12));
 }
=20
 DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
@@ -486,7 +489,8 @@ static GlobalProperty pc_compat_2_11[] =3D {
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_2_12_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_11);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_11, G_N_ELEMENTS(pc_compat_2_11));
 }
=20
 DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
@@ -499,7 +503,8 @@ static GlobalProperty pc_compat_2_10[] =3D {
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
     pc_i440fx_2_11_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_10);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_10, G_N_ELEMENTS(pc_compat_2_10));
     m->auto_enable_numa_with_memhp =3D false;
 }
=20
@@ -513,7 +518,8 @@ static GlobalProperty pc_compat_2_9[] =3D {
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_2_10_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_9);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_9, G_N_ELEMENTS(pc_compat_2_9));
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
 }
=20
@@ -527,7 +533,8 @@ static GlobalProperty pc_compat_2_8[] =3D {
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
     pc_i440fx_2_9_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_8);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_8, G_N_ELEMENTS(pc_compat_2_8));
 }
=20
 DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
@@ -540,7 +547,8 @@ static GlobalProperty pc_compat_2_7[] =3D {
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
     pc_i440fx_2_8_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_7);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_7, G_N_ELEMENTS(pc_compat_2_7));
 }
=20
 DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
@@ -556,7 +564,8 @@ static void pc_i440fx_2_6_machine_options(MachineClas=
s *m)
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    SET_MACHINE_COMPAT(m, pc_compat_2_6);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_6, G_N_ELEMENTS(pc_compat_2_6));
 }
=20
 DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
@@ -572,7 +581,8 @@ static void pc_i440fx_2_5_machine_options(MachineClas=
s *m)
     pc_i440fx_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    SET_MACHINE_COMPAT(m, pc_compat_2_5);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_5, G_N_ELEMENTS(pc_compat_2_5));
 }
=20
 DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
@@ -588,7 +598,8 @@ static void pc_i440fx_2_4_machine_options(MachineClas=
s *m)
     pc_i440fx_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    SET_MACHINE_COMPAT(m, pc_compat_2_4);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_4, G_N_ELEMENTS(pc_compat_2_4));
 }
=20
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
@@ -602,7 +613,8 @@ static void pc_i440fx_2_3_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version =3D "2.3.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_2_3);
+    compat_props_add(m->compat_props,
+                     pc_compatp_2_3, G_N_ELEMENTS(pc_compatp_2_3));
 }
=20
 DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3,
@@ -618,7 +630,8 @@ static void pc_i440fx_2_2_machine_options(MachineClas=
s *m)
     pc_i440fx_2_3_machine_options(m);
     m->hw_version =3D "2.2.0";
     m->default_machine_opts =3D "firmware=3Dbios-256k.bin,suppress-vmdes=
c=3Don";
-    SET_MACHINE_COMPAT(m, pc_compatp_2_2);
+    compat_props_add(m->compat_props,
+                     pc_compatp_2_2, G_N_ELEMENTS(pc_compatp_2_2));
     pcmc->rsdp_in_ram =3D false;
 }
=20
@@ -635,7 +648,8 @@ static void pc_i440fx_2_1_machine_options(MachineClas=
s *m)
     pc_i440fx_2_2_machine_options(m);
     m->hw_version =3D "2.1.0";
     m->default_display =3D NULL;
-    SET_MACHINE_COMPAT(m, pc_compatp_2_1);
+    compat_props_add(m->compat_props,
+                     pc_compatp_2_1, G_N_ELEMENTS(pc_compatp_2_1));
     pcmc->smbios_uuid_encoded =3D false;
     pcmc->enforce_aligned_dimm =3D false;
 }
@@ -652,7 +666,8 @@ static void pc_i440fx_2_0_machine_options(MachineClas=
s *m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_2_1_machine_options(m);
     m->hw_version =3D "2.0.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_2_0);
+    compat_props_add(m->compat_props,
+                     pc_compatp_2_0, G_N_ELEMENTS(pc_compatp_2_0));
     pcmc->smbios_legacy_mode =3D true;
     pcmc->has_reserved_memory =3D false;
     /* This value depends on the actual DSDT and SSDT compiled into
@@ -689,7 +704,8 @@ static void pc_i440fx_1_7_machine_options(MachineClas=
s *m)
     m->hw_version =3D "1.7.0";
     m->default_machine_opts =3D NULL;
     m->option_rom_has_mr =3D true;
-    SET_MACHINE_COMPAT(m, pc_compatp_1_7);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_7, G_N_ELEMENTS(pc_compatp_1_7));
     pcmc->smbios_defaults =3D false;
     pcmc->gigabyte_align =3D false;
     pcmc->legacy_acpi_table_size =3D 6414;
@@ -708,7 +724,8 @@ static void pc_i440fx_1_6_machine_options(MachineClas=
s *m)
     pc_i440fx_1_7_machine_options(m);
     m->hw_version =3D "1.6.0";
     m->rom_file_has_mr =3D false;
-    SET_MACHINE_COMPAT(m, pc_compatp_1_6);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_6, G_N_ELEMENTS(pc_compatp_1_6));
     pcmc->has_acpi_build =3D false;
 }
=20
@@ -723,7 +740,8 @@ static void pc_i440fx_1_5_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_1_6_machine_options(m);
     m->hw_version =3D "1.5.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_1_5);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_5, G_N_ELEMENTS(pc_compatp_1_5));
 }
=20
 DEFINE_I440FX_MACHINE(v1_5, "pc-i440fx-1.5", pc_compat_1_5,
@@ -738,7 +756,8 @@ static void pc_i440fx_1_4_machine_options(MachineClas=
s *m)
     pc_i440fx_1_5_machine_options(m);
     m->hw_version =3D "1.4.0";
     m->hot_add_cpu =3D NULL;
-    SET_MACHINE_COMPAT(m, pc_compatp_1_4);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_4, G_N_ELEMENTS(pc_compatp_1_4));
 }
=20
 DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4,
@@ -769,7 +788,8 @@ static void pc_i440fx_1_3_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_1_4_machine_options(m);
     m->hw_version =3D "1.3.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_1_3);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_3, G_N_ELEMENTS(pc_compatp_1_3));
 }
=20
 DEFINE_I440FX_MACHINE(v1_3, "pc-1.3", pc_compat_1_3,
@@ -809,7 +829,8 @@ static void pc_i440fx_1_2_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_1_3_machine_options(m);
     m->hw_version =3D "1.2.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_1_2);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_2, G_N_ELEMENTS(pc_compatp_1_2));
 }
=20
 DEFINE_I440FX_MACHINE(v1_2, "pc-1.2", pc_compat_1_2,
@@ -853,7 +874,8 @@ static void pc_i440fx_1_1_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_1_2_machine_options(m);
     m->hw_version =3D "1.1.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_1_1);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_1, G_N_ELEMENTS(pc_compatp_1_1));
 }
=20
 DEFINE_I440FX_MACHINE(v1_1, "pc-1.1", pc_compat_1_2,
@@ -884,7 +906,8 @@ static void pc_i440fx_1_0_machine_options(MachineClas=
s *m)
 {
     pc_i440fx_1_1_machine_options(m);
     m->hw_version =3D "1.0";
-    SET_MACHINE_COMPAT(m, pc_compatp_1_0);
+    compat_props_add(m->compat_props,
+                     pc_compatp_1_0, G_N_ELEMENTS(pc_compatp_1_0));
 }
=20
 DEFINE_I440FX_MACHINE(v1_0, "pc-1.0", pc_compat_1_2,
@@ -900,7 +923,8 @@ static void pc_i440fx_0_15_machine_options(MachineCla=
ss *m)
     pc_i440fx_1_0_machine_options(m);
     m->hw_version =3D "0.15";
     m->deprecation_reason =3D "use a newer machine type instead";
-    SET_MACHINE_COMPAT(m, pc_compatp_0_15);
+    compat_props_add(m->compat_props,
+                     pc_compatp_0_15, G_N_ELEMENTS(pc_compatp_0_15));
 }
=20
 DEFINE_I440FX_MACHINE(v0_15, "pc-0.15", pc_compat_1_2,
@@ -940,7 +964,8 @@ static void pc_i440fx_0_14_machine_options(MachineCla=
ss *m)
 {
     pc_i440fx_0_15_machine_options(m);
     m->hw_version =3D "0.14";
-    SET_MACHINE_COMPAT(m, pc_compatp_0_14);
+    compat_props_add(m->compat_props,
+                     pc_compatp_0_14, G_N_ELEMENTS(pc_compatp_0_14));
 }
=20
 DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
@@ -976,7 +1001,8 @@ static void pc_i440fx_0_13_machine_options(MachineCl=
ass *m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_0_14_machine_options(m);
     m->hw_version =3D "0.13";
-    SET_MACHINE_COMPAT(m, pc_compatp_0_13);
+    compat_props_add(m->compat_props,
+                     pc_compatp_0_13, G_N_ELEMENTS(pc_compatp_0_13));
     pcmc->kvmclock_enabled =3D false;
 }
=20
@@ -1012,7 +1038,8 @@ static void pc_i440fx_0_12_machine_options(MachineC=
lass *m)
 {
     pc_i440fx_0_13_machine_options(m);
     m->hw_version =3D "0.12";
-    SET_MACHINE_COMPAT(m, pc_compat_0_12);
+    compat_props_add(m->compat_props,
+                     pc_compat_0_12, G_N_ELEMENTS(pc_compat_0_12));
 }
=20
 DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9aabae358c..4ae6718b74 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,7 +330,8 @@ static void pc_q35_3_1_machine_options(MachineClass *=
m)
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split =3D false;
     m->alias =3D NULL;
-    SET_MACHINE_COMPAT(m, pc_compat_3_1);
+    compat_props_add(m->compat_props,
+                     pc_compat_3_1, G_N_ELEMENTS(pc_compat_3_1));
 }
=20
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
@@ -343,7 +344,8 @@ static GlobalProperty pc_compat_3_0[] =3D {
 static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_3_1_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_3_0);
+    compat_props_add(m->compat_props,
+                     pc_compat_3_0, G_N_ELEMENTS(pc_compat_3_0));
 }
=20
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
@@ -356,7 +358,8 @@ static GlobalProperty pc_compat_2_12[] =3D {
 static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_3_0_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_12);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_12, G_N_ELEMENTS(pc_compat_2_12));
 }
=20
 DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
@@ -372,7 +375,8 @@ static void pc_q35_2_11_machine_options(MachineClass =
*m)
=20
     pc_q35_2_12_machine_options(m);
     pcmc->default_nic_model =3D "e1000";
-    SET_MACHINE_COMPAT(m, pc_compat_2_11);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_11, G_N_ELEMENTS(pc_compat_2_11));
 }
=20
 DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
@@ -385,7 +389,8 @@ static GlobalProperty pc_compat_2_10[] =3D {
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_2_11_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_10);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_10, G_N_ELEMENTS(pc_compat_2_10));
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp =3D false;
 }
@@ -400,7 +405,8 @@ static GlobalProperty pc_compat_2_9[] =3D {
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_2_10_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_9);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_9, G_N_ELEMENTS(pc_compat_2_9));
 }
=20
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
@@ -413,7 +419,8 @@ static GlobalProperty pc_compat_2_8[] =3D {
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
     pc_q35_2_9_machine_options(m);
-    SET_MACHINE_COMPAT(m, pc_compat_2_8);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_8, G_N_ELEMENTS(pc_compat_2_8));
 }
=20
 DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
@@ -427,7 +434,8 @@ static void pc_q35_2_7_machine_options(MachineClass *=
m)
 {
     pc_q35_2_8_machine_options(m);
     m->max_cpus =3D 255;
-    SET_MACHINE_COMPAT(m, pc_compat_2_7);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_7, G_N_ELEMENTS(pc_compat_2_7));
 }
=20
 DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
@@ -443,7 +451,8 @@ static void pc_q35_2_6_machine_options(MachineClass *=
m)
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    SET_MACHINE_COMPAT(m, pc_compat_2_6);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_6, G_N_ELEMENTS(pc_compat_2_6));
 }
=20
 DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
@@ -459,7 +468,8 @@ static void pc_q35_2_5_machine_options(MachineClass *=
m)
     pc_q35_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    SET_MACHINE_COMPAT(m, pc_compat_2_5);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_5, G_N_ELEMENTS(pc_compat_2_5));
 }
=20
 DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
@@ -475,7 +485,8 @@ static void pc_q35_2_4_machine_options(MachineClass *=
m)
     pc_q35_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    SET_MACHINE_COMPAT(m, pc_compat_2_4);
+    compat_props_add(m->compat_props,
+                     pc_compat_2_4, G_N_ELEMENTS(pc_compat_2_4));
 }
=20
 DEFINE_Q35_MACHINE(v2_4, "pc-q35-2.4", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f724a8d57a..f27aa5a09f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4028,7 +4028,8 @@ static GlobalProperty spapr_compat_3_1[] =3D {
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     spapr_machine_4_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_3_1);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_3_1, G_N_ELEMENTS(spapr_compat_3_1));
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
 }
=20
@@ -4046,7 +4047,8 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_3_1_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_3_0);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_3_0, G_N_ELEMENTS(spapr_compat_3_0));
=20
     smc->legacy_irq_allocation =3D true;
     smc->irq =3D &spapr_irq_xics_legacy;
@@ -4076,7 +4078,8 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_3_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_12);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_12, G_N_ELEMENTS(spapr_compat_2_12))=
;
=20
     /* We depend on kvm_enabled() to choose a default value for the
      * hpt-max-page-size capability. Of course we can't do it here
@@ -4113,7 +4116,8 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
=20
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_11);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_11, G_N_ELEMENTS(spapr_compat_2_11))=
;
 }
=20
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
@@ -4128,7 +4132,8 @@ static GlobalProperty spapr_compat_2_10[] =3D {
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
     spapr_machine_2_11_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_10);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_10, G_N_ELEMENTS(spapr_compat_2_10))=
;
 }
=20
 DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
@@ -4150,7 +4155,8 @@ static void spapr_machine_2_9_class_options(Machine=
Class *mc)
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_2_10_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_9);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_9, G_N_ELEMENTS(spapr_compat_2_9));
     mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
@@ -4173,7 +4179,8 @@ static GlobalProperty spapr_compat_2_8[] =3D {
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     spapr_machine_2_9_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_8);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_8, G_N_ELEMENTS(spapr_compat_2_8));
     mc->numa_mem_align_shift =3D 23;
 }
=20
@@ -4262,7 +4269,8 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
     spapr_machine_2_8_class_options(mc);
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power7_v2.3");
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff";
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_7);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_7, G_N_ELEMENTS(spapr_compat_2_7));
     smc->phb_placement =3D phb_placement_2_7;
 }
=20
@@ -4284,7 +4292,8 @@ static void spapr_machine_2_6_class_options(Machine=
Class *mc)
 {
     spapr_machine_2_7_class_options(mc);
     mc->has_hotpluggable_cpus =3D false;
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_6);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_6, G_N_ELEMENTS(spapr_compat_2_6));
 }
=20
 DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
@@ -4307,7 +4316,8 @@ static void spapr_machine_2_5_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_6_class_options(mc);
     smc->use_ohci_by_default =3D true;
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_5);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_5, G_N_ELEMENTS(spapr_compat_2_5));
 }
=20
 DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
@@ -4325,7 +4335,8 @@ static void spapr_machine_2_4_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_5_class_options(mc);
     smc->dr_lmb_enabled =3D false;
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_4);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_4, G_N_ELEMENTS(spapr_compat_2_4));
 }
=20
 DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
@@ -4345,7 +4356,8 @@ static GlobalProperty spapr_compat_2_3[] =3D {
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     spapr_machine_2_4_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_3);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_3, G_N_ELEMENTS(spapr_compat_2_3));
 }
 DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
=20
@@ -4364,7 +4376,8 @@ static GlobalProperty spapr_compat_2_2[] =3D {
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     spapr_machine_2_3_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_2);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_2, G_N_ELEMENTS(spapr_compat_2_2));
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff,suppress-v=
mdesc=3Don";
 }
 DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
@@ -4379,7 +4392,8 @@ static GlobalProperty spapr_compat_2_1[] =3D {
 static void spapr_machine_2_1_class_options(MachineClass *mc)
 {
     spapr_machine_2_2_class_options(mc);
-    SET_MACHINE_COMPAT(mc, spapr_compat_2_1);
+    compat_props_add(mc->compat_props,
+                     spapr_compat_2_1, G_N_ELEMENTS(spapr_compat_2_1));
 }
 DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 882a9796cf..f2faea585e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -773,7 +773,8 @@ static void ccw_machine_3_1_instance_options(MachineS=
tate *machine)
 static void ccw_machine_3_1_class_options(MachineClass *mc)
 {
     ccw_machine_4_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_3_1);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_3_1, G_N_ELEMENTS(ccw_compat_3_1));
 }
 DEFINE_CCW_MACHINE(3_1, "3.1", false);
=20
@@ -788,7 +789,8 @@ static void ccw_machine_3_0_class_options(MachineClas=
s *mc)
=20
     s390mc->hpage_1m_allowed =3D false;
     ccw_machine_3_1_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_3_0);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_3_0, G_N_ELEMENTS(ccw_compat_3_0));
 }
 DEFINE_CCW_MACHINE(3_0, "3.0", false);
=20
@@ -802,7 +804,8 @@ static void ccw_machine_2_12_instance_options(Machine=
State *machine)
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
     ccw_machine_3_0_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_12);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_12, G_N_ELEMENTS(ccw_compat_2_12));
 }
 DEFINE_CCW_MACHINE(2_12, "2.12", false);
=20
@@ -818,7 +821,8 @@ static void ccw_machine_2_11_instance_options(Machine=
State *machine)
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
     ccw_machine_2_12_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_11);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_11, G_N_ELEMENTS(ccw_compat_2_11));
 }
 DEFINE_CCW_MACHINE(2_11, "2.11", false);
=20
@@ -830,7 +834,8 @@ static void ccw_machine_2_10_instance_options(Machine=
State *machine)
 static void ccw_machine_2_10_class_options(MachineClass *mc)
 {
     ccw_machine_2_11_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_10);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_10, G_N_ELEMENTS(ccw_compat_2_10));
 }
 DEFINE_CCW_MACHINE(2_10, "2.10", false);
=20
@@ -849,7 +854,8 @@ static void ccw_machine_2_9_class_options(MachineClas=
s *mc)
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
=20
     ccw_machine_2_10_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_9);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_9, G_N_ELEMENTS(ccw_compat_2_9));
     s390mc->css_migration_enabled =3D false;
 }
 DEFINE_CCW_MACHINE(2_9, "2.9", false);
@@ -862,7 +868,8 @@ static void ccw_machine_2_8_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
     ccw_machine_2_9_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_8);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_8, G_N_ELEMENTS(ccw_compat_2_8));
 }
 DEFINE_CCW_MACHINE(2_8, "2.8", false);
=20
@@ -877,7 +884,8 @@ static void ccw_machine_2_7_class_options(MachineClas=
s *mc)
=20
     s390mc->cpu_model_allowed =3D false;
     ccw_machine_2_8_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_7);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_7, G_N_ELEMENTS(ccw_compat_2_7));
 }
 DEFINE_CCW_MACHINE(2_7, "2.7", false);
=20
@@ -892,7 +900,8 @@ static void ccw_machine_2_6_class_options(MachineClas=
s *mc)
=20
     s390mc->ri_allowed =3D false;
     ccw_machine_2_7_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_6);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_6, G_N_ELEMENTS(ccw_compat_2_6));
 }
 DEFINE_CCW_MACHINE(2_6, "2.6", false);
=20
@@ -904,7 +913,8 @@ static void ccw_machine_2_5_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_5_class_options(MachineClass *mc)
 {
     ccw_machine_2_6_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_5);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_5, G_N_ELEMENTS(ccw_compat_2_5));
 }
 DEFINE_CCW_MACHINE(2_5, "2.5", false);
=20
@@ -916,7 +926,8 @@ static void ccw_machine_2_4_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_4_class_options(MachineClass *mc)
 {
     ccw_machine_2_5_class_options(mc);
-    SET_MACHINE_COMPAT(mc, ccw_compat_2_4);
+    compat_props_add(mc->compat_props,
+                     ccw_compat_2_4, G_N_ELEMENTS(ccw_compat_2_4));
 }
 DEFINE_CCW_MACHINE(2_4, "2.4", false);
=20
diff --git a/vl.c b/vl.c
index f2a20f8148..7baa7a8968 100644
--- a/vl.c
+++ b/vl.c
@@ -2997,7 +2997,6 @@ static void user_register_global_props(void)
  */
 static void register_global_properties(MachineState *ms)
 {
-    machine_register_compat_props(ms);
     user_register_global_props();
 }
=20
--=20
2.20.1.2.gb21ebb671b
