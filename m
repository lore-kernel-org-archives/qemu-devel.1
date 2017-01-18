Received: from eggs.gnu.org ([2001:4830:134:3::10]:56851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnv-00022r-Au
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnr-0007Ei-4I
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtnq-0007Ds-Sb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:43 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:19 +0100
Message-Id: <1484759609-264075-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 03/13] pc: don't return cpu pointer from
 pc_new_cpu() as it's not needed anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2461d84..c0eba8a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1092,28 +1092,24 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }
 
-static X86CPU *pc_new_cpu(const char *typename, int64_t apic_id,
-                          Error **errp)
+static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 {
-    X86CPU *cpu = NULL;
+    Object *cpu = NULL;
     Error *local_err = NULL;
 
-    cpu = X86_CPU(object_new(typename));
+    cpu = object_new(typename);
 
-    object_property_set_int(OBJECT(cpu), apic_id, "apic-id", &local_err);
-    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
+    object_property_set_int(cpu, apic_id, "apic-id", &local_err);
+    object_property_set_bool(cpu, true, "realized", &local_err);
 
+    object_unref(cpu);
     if (local_err) {
         error_propagate(errp, local_err);
-        object_unref(OBJECT(cpu));
-        cpu = NULL;
     }
-    return cpu;
 }
 
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
-    X86CPU *cpu;
     ObjectClass *oc;
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     int64_t apic_id = x86_cpu_apic_id_from_index(id);
@@ -1133,12 +1129,11 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
 
     assert(pcms->possible_cpus->cpus[0].cpu); /* BSP is always present */
     oc = OBJECT_CLASS(CPU_GET_CLASS(pcms->possible_cpus->cpus[0].cpu));
-    cpu = pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
+    pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-    object_unref(OBJECT(cpu));
 }
 
 void pc_cpus_init(PCMachineState *pcms)
@@ -1148,7 +1143,6 @@ void pc_cpus_init(PCMachineState *pcms)
     ObjectClass *oc;
     const char *typename;
     gchar **model_pieces;
-    X86CPU *cpu = NULL;
     MachineState *machine = MACHINE(pcms);
 
     /* init CPUs */
@@ -1190,9 +1184,7 @@ void pc_cpus_init(PCMachineState *pcms)
         pcms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         pcms->possible_cpus->len++;
         if (i < smp_cpus) {
-            cpu = pc_new_cpu(typename, x86_cpu_apic_id_from_index(i),
-                             &error_fatal);
-            object_unref(OBJECT(cpu));
+            pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_fatal);
         }
     }
 }
-- 
2.7.4
