Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsAA5-0002ZO-Ii
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9v-0006Zx-Te
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsA9v-0006ZU-Kj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDD1C81E10
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:05:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42B145D963
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:05:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Sep 2017 18:04:56 +0200
Message-Id: <1505318697-77161-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] pc: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

define default CPU type in generic way in pc_machine_class_init()
and let common machine code to handle cpu_model parsing

Patch also introduces TARGET_DEFAULT_CPU_TYPE define for 2 purposes:
  * make foo_machine_class_init() look uniform on every target
  * use define in [bsd|linux]-user targets to pick default
    cpu type

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/i386/cpu.h |  9 +++++++++
 hw/i386/pc.c      | 41 +++++------------------------------------
 hw/i386/pc_piix.c |  4 +---
 target/i386/cpu.c |  3 ---
 4 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 525d35d..4035a11 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1508,6 +1508,15 @@ uint64_t cpu_get_tsc(CPUX86State *env);
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
=20
+#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
+#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
+
+#ifdef TARGET_X86_64
+#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
+#else
+#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
+#endif
+
 #define cpu_signal_handler cpu_x86_signal_handler
 #define cpu_list x86_cpu_list
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2108104..2247ac0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1107,7 +1107,6 @@ static void pc_new_cpu(const char *typename, int64_=
t apic_id, Error **errp)
=20
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
-    ObjectClass *oc;
     MachineState *ms =3D MACHINE(qdev_get_machine());
     int64_t apic_id =3D x86_cpu_apic_id_from_index(id);
     Error *local_err =3D NULL;
@@ -1124,9 +1123,7 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
         return;
     }
=20
-    assert(ms->possible_cpus->cpus[0].cpu); /* BSP is always present */
-    oc =3D OBJECT_CLASS(CPU_GET_CLASS(ms->possible_cpus->cpus[0].cpu));
-    pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
+    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1136,39 +1133,10 @@ void pc_hot_add_cpu(const int64_t id, Error **err=
p)
 void pc_cpus_init(PCMachineState *pcms)
 {
     int i;
-    CPUClass *cc;
-    ObjectClass *oc;
-    const char *typename;
-    gchar **model_pieces;
     const CPUArchIdList *possible_cpus;
-    MachineState *machine =3D MACHINE(pcms);
+    MachineState *ms =3D MACHINE(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
=20
-    /* init CPUs */
-    if (machine->cpu_model =3D=3D NULL) {
-#ifdef TARGET_X86_64
-        machine->cpu_model =3D "qemu64";
-#else
-        machine->cpu_model =3D "qemu32";
-#endif
-    }
-
-    model_pieces =3D g_strsplit(machine->cpu_model, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("Invalid/empty CPU model name");
-        exit(1);
-    }
-
-    oc =3D cpu_class_by_name(TYPE_X86_CPU, model_pieces[0]);
-    if (oc =3D=3D NULL) {
-        error_report("Unable to find CPU definition: %s", model_pieces[0=
]);
-        exit(1);
-    }
-    typename =3D object_class_get_name(oc);
-    cc =3D CPU_CLASS(oc);
-    cc->parse_features(typename, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-
     /* Calculates the limit to CPU APIC ID values
      *
      * Limit for the APIC ID value, so that all
@@ -1177,9 +1145,9 @@ void pc_cpus_init(PCMachineState *pcms)
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
      */
     pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(max_cpus - 1) + 1=
;
-    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
+    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
     for (i =3D 0; i < smp_cpus; i++) {
-        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fata=
l);
+        pc_new_cpu(ms->cpu_type, possible_cpus->cpus[i].arch_id, &error_=
fatal);
     }
 }
=20
@@ -2360,6 +2328,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     hc->unplug_request =3D pc_machine_device_unplug_request_cb;
     hc->unplug =3D pc_machine_device_unplug_cb;
     nc->nmi_monitor_handler =3D x86_nmi;
+    mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
=20
     object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
         pc_machine_get_hotplug_memory_region_size, NULL,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b03cc04..9ff79b1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -378,9 +378,6 @@ static void pc_compat_0_13(MachineState *machine)
=20
 static void pc_init_isa(MachineState *machine)
 {
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "486";
-    }
     x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
     enable_compat_apic_id_mode();
     pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVIC=
E);
@@ -1113,6 +1110,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->gigabyte_align =3D false;
     pcmc->smbios_legacy_mode =3D true;
     pcmc->has_reserved_memory =3D false;
+    m->default_cpu_type =3D X86_CPU_TYPE_NAME("486");
 }
=20
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69676e1..d0000e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -705,9 +705,6 @@ void host_vendor_fms(char *vendor, int *family, int *=
model, int *stepping)
=20
 /* CPU class name definitions: */
=20
-#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
-#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
-
 /* Return type name for a given CPU model name
  * Caller is responsible for freeing the returned string.
  */
--=20
2.7.4
