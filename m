Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E31C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7241C20644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7241C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqDl-0004dL-Cn
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgq4b-0002QP-Uq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgq4X-0004Mj-F6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgq4X-0004E1-6F
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:33:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E8033082207;
 Fri, 28 Jun 2019 11:54:06 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 668131A92D;
 Fri, 28 Jun 2019 11:54:04 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com
Date: Fri, 28 Jun 2019 13:53:46 +0200
Message-Id: <20190628115349.60293-2-slp@redhat.com>
In-Reply-To: <20190628115349.60293-1-slp@redhat.com>
References: <20190628115349.60293-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 28 Jun 2019 11:54:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] hw/i386: Factorize CPU routine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a combination of the following commits from
NEMU (https://github.com/intel/nemu):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit b6472ce5ce5108c7aacb0dfa3d74b3eb8f98ae85
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Fri Mar 22 10:28:31 2019 +0800

    hw: i386: Factorize CPU routines

    A few routines are now shared between pc_* and virt, including the CP=
U
    init one.
    We factorize those routines into an i386 specific file that is now us=
ed
    by all x86 machines.

    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

commit f29f3c294a889ad659dc8808728e8441e23a675c
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Mon Oct 8 15:37:17 2018 +0200

    hw: i386: Remove the pc header dependency from the cpu code

    It's only a matter of moving the compat APIC boolean to the correct
    header file (apic.h).

    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/Makefile.objs          |   1 +
 hw/i386/cpu.c                  | 174 +++++++++++++++++++++++++++++++++
 hw/i386/pc.c                   | 151 ++--------------------------
 hw/i386/pc_piix.c              |   3 +-
 hw/i386/pc_q35.c               |   3 +-
 include/hw/i386/apic.h         |   1 +
 include/hw/i386/cpu-internal.h |  32 ++++++
 7 files changed, 218 insertions(+), 147 deletions(-)
 create mode 100644 hw/i386/cpu.c
 create mode 100644 include/hw/i386/cpu-internal.h

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5d9c9efd5f..102f2b35fc 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-y +=3D multiboot.o
+obj-y +=3D cpu.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
diff --git a/hw/i386/cpu.c b/hw/i386/cpu.c
new file mode 100644
index 0000000000..e13ae61535
--- /dev/null
+++ b/hw/i386/cpu.c
@@ -0,0 +1,174 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corportation
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+#include "sysemu/cpus.h"
+#include "sysemu/qtest.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+
+#include "hw/i386/cpu-internal.h"
+#include "hw/i386/apic.h"
+#include "hw/i386/topology.h"
+
+#include "hw/acpi/pc-hotplug.h"
+
+static void cpu_new(const char *typename, int64_t apic_id, Error **errp)
+{
+    Object *cpu =3D NULL;
+    Error *local_err =3D NULL;
+
+    cpu =3D object_new(typename);
+
+    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
+    object_property_set_bool(cpu, true, "realized", &local_err);
+
+    object_unref(cpu);
+    error_propagate(errp, local_err);
+}
+
+/* Calculates initial APIC ID for a specific CPU index
+ *
+ * Currently we need to be able to calculate the APIC ID from the CPU in=
dex
+ * alone (without requiring a CPU object), as the QEMU<->Seabios interfa=
ces have
+ * no concept of "CPU index", and the NUMA tables on fw_cfg need the API=
C ID of
+ * all CPUs up to max_cpus.
+ */
+uint32_t cpu_apicid_from_index(unsigned int cpu_index, bool compat)
+{
+    uint32_t correct_id;
+    static bool warned;
+
+    correct_id =3D x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_i=
ndex);
+    if (compat) {
+        if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) {
+            error_report("APIC IDs set in compatibility mode, "
+                         "CPU topology won't match the configuration");
+            warned =3D true;
+        }
+        return cpu_index;
+    } else {
+        return correct_id;
+    }
+}
+
+CpuInstanceProperties cpu_index_to_props(MachineState *ms, unsigned cpu_=
index)
+{
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms)=
;
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+
+int64_t cpu_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+   X86CPUTopoInfo topo;
+
+   assert(idx < ms->possible_cpus->len);
+   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                            smp_cores, smp_threads, &topo);
+   return topo.pkg_id % nb_numa_nodes;
+}
+
+const CPUArchIdList *cpu_possible_cpu_arch_ids(MachineState *ms)
+{
+    int i;
+
+    if (ms->possible_cpus) {
+        /*
+         * make sure that max_cpus hasn't changed since the first use, i=
.e.
+         * -smp hasn't been parsed after it
+        */
+        assert(ms->possible_cpus->len =3D=3D max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len =3D max_cpus;
+    for (i =3D 0; i < ms->possible_cpus->len; i++) {
+        X86CPUTopoInfo topo;
+
+        ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
+        ms->possible_cpus->cpus[i].vcpus_count =3D 1;
+        ms->possible_cpus->cpus[i].arch_id =3D cpu_apicid_from_index(i, =
compat_apic_id_mode);
+        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                 smp_cores, smp_threads, &topo);
+        ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
+        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.has_core_id =3D true;
+        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
+        ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
+        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
+    }
+    return ms->possible_cpus;
+}
+
+
+void cpu_hot_add(const int64_t id, Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    int64_t apic_id =3D cpu_apicid_from_index(id, compat_apic_id_mode);
+    Error *local_err =3D NULL;
+
+    if (id < 0) {
+        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
+        return;
+    }
+
+    if (apic_id >=3D ACPI_CPU_HOTPLUG_ID_LIMIT) {
+        error_setg(errp, "Unable to add CPU: %" PRIi64
+                   ", resulting APIC ID (%" PRIi64 ") is too large",
+                   id, apic_id);
+        return;
+    }
+
+    cpu_new(ms->cpu_type, apic_id, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+uint32_t cpus_init(MachineState *ms, bool compat)
+{
+    int i;
+    uint32_t apic_id_limit;
+    const CPUArchIdList *possible_cpus;
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+
+    /* Calculates the limit to CPU APIC ID values
+     *
+     * Limit for the APIC ID value, so that all
+     * CPU APIC IDs are < ms->apic_id_limit.
+     *
+     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
+     */
+    apic_id_limit =3D cpu_apicid_from_index(max_cpus - 1, compat) + 1;
+    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
+    for (i =3D 0; i < smp_cpus; i++) {
+        cpu_new(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch=
_id,
+                &error_fatal);
+    }
+
+    return apic_id_limit;
+}
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e96360b47a..07d67a5031 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/cpu-internal.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/i386/apic.h"
@@ -914,38 +915,13 @@ bool e820_get_entry(int idx, uint32_t type, uint64_=
t *address, uint64_t *length)
 }
=20
 /* Enables contiguous-apic-ID mode, for compatibility */
-static bool compat_apic_id_mode;
+bool compat_apic_id_mode;
=20
 void enable_compat_apic_id_mode(void)
 {
     compat_apic_id_mode =3D true;
 }
=20
-/* Calculates initial APIC ID for a specific CPU index
- *
- * Currently we need to be able to calculate the APIC ID from the CPU in=
dex
- * alone (without requiring a CPU object), as the QEMU<->Seabios interfa=
ces have
- * no concept of "CPU index", and the NUMA tables on fw_cfg need the API=
C ID of
- * all CPUs up to max_cpus.
- */
-static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
-{
-    uint32_t correct_id;
-    static bool warned;
-
-    correct_id =3D x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_i=
ndex);
-    if (compat_apic_id_mode) {
-        if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) {
-            error_report("APIC IDs set in compatibility mode, "
-                         "CPU topology won't match the configuration");
-            warned =3D true;
-        }
-        return cpu_index;
-    } else {
-        return correct_id;
-    }
-}
-
 static void pc_build_smbios(PCMachineState *pcms)
 {
     uint8_t *smbios_tables, *smbios_anchor;
@@ -1516,67 +1492,6 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, =
int level)
     }
 }
=20
-static void pc_new_cpu(const char *typename, int64_t apic_id, Error **er=
rp)
-{
-    Object *cpu =3D NULL;
-    Error *local_err =3D NULL;
-
-    cpu =3D object_new(typename);
-
-    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
-    object_property_set_bool(cpu, true, "realized", &local_err);
-
-    object_unref(cpu);
-    error_propagate(errp, local_err);
-}
-
-void pc_hot_add_cpu(const int64_t id, Error **errp)
-{
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-    int64_t apic_id =3D x86_cpu_apic_id_from_index(id);
-    Error *local_err =3D NULL;
-
-    if (id < 0) {
-        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
-        return;
-    }
-
-    if (apic_id >=3D ACPI_CPU_HOTPLUG_ID_LIMIT) {
-        error_setg(errp, "Unable to add CPU: %" PRIi64
-                   ", resulting APIC ID (%" PRIi64 ") is too large",
-                   id, apic_id);
-        return;
-    }
-
-    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
-void pc_cpus_init(PCMachineState *pcms)
-{
-    int i;
-    const CPUArchIdList *possible_cpus;
-    MachineState *ms =3D MACHINE(pcms);
-    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
-
-    /* Calculates the limit to CPU APIC ID values
-     *
-     * Limit for the APIC ID value, so that all
-     * CPU APIC IDs are < pcms->apic_id_limit.
-     *
-     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
-     */
-    pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(max_cpus - 1) + 1=
;
-    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
-    for (i =3D 0; i < smp_cpus; i++) {
-        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].a=
rch_id,
-                   &error_fatal);
-    }
-}
-
 static void pc_build_feature_control_file(PCMachineState *pcms)
 {
     MachineState *ms =3D MACHINE(pcms);
@@ -2638,60 +2553,6 @@ static void pc_machine_reset(void)
     }
 }
=20
-static CpuInstanceProperties
-pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
-{
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
-    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms)=
;
-
-    assert(cpu_index < possible_cpus->len);
-    return possible_cpus->cpus[cpu_index].props;
-}
-
-static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int id=
x)
-{
-   X86CPUTopoInfo topo;
-
-   assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            smp_cores, smp_threads, &topo);
-   return topo.pkg_id % nb_numa_nodes;
-}
-
-static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
-{
-    int i;
-
-    if (ms->possible_cpus) {
-        /*
-         * make sure that max_cpus hasn't changed since the first use, i=
.e.
-         * -smp hasn't been parsed after it
-        */
-        assert(ms->possible_cpus->len =3D=3D max_cpus);
-        return ms->possible_cpus;
-    }
-
-    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
-                                  sizeof(CPUArchId) * max_cpus);
-    ms->possible_cpus->len =3D max_cpus;
-    for (i =3D 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
-
-        ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
-        ms->possible_cpus->cpus[i].vcpus_count =3D 1;
-        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 smp_cores, smp_threads, &topo);
-        ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
-        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
-        ms->possible_cpus->cpus[i].props.has_core_id =3D true;
-        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
-        ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
-        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
-    }
-    return ms->possible_cpus;
-}
-
 static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     /* cpu index isn't used */
@@ -2732,13 +2593,13 @@ static void pc_machine_class_init(ObjectClass *oc=
, void *data)
     pcmc->pvh_enabled =3D true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotplug_handler;
-    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
-    mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
-    mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props =3D cpu_index_to_props;
+    mc->get_default_cpu_node_id =3D cpu_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids =3D cpu_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp =3D true;
     mc->has_hotpluggable_cpus =3D true;
     mc->default_boot_order =3D "cad";
-    mc->hot_add_cpu =3D pc_hot_add_cpu;
+    mc->hot_add_cpu =3D cpu_hot_add;
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 255;
     mc->reset =3D pc_machine_reset;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..1e240004dd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/cpu-internal.h"
 #include "hw/i386/apic.h"
 #include "hw/display/ramfb.h"
 #include "hw/firmware/smbios.h"
@@ -150,7 +151,7 @@ static void pc_init1(MachineState *machine,
         }
     }
=20
-    pc_cpus_init(pcms);
+    pcms->apic_id_limit =3D cpus_init(machine, compat_apic_id_mode);
=20
     if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 57232aed6b..308cd04a13 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -43,6 +43,7 @@
 #include "hw/pci-host/q35.h"
 #include "exec/address-spaces.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/cpu-internal.h"
 #include "hw/i386/ich9.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
@@ -180,7 +181,7 @@ static void pc_q35_init(MachineState *machine)
         xen_hvm_init(pcms, &ram_memory);
     }
=20
-    pc_cpus_init(pcms);
+    pcms->apic_id_limit =3D cpus_init(machine, compat_apic_id_mode);
=20
     kvmclock_create();
=20
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index da1d2fe155..f72be753b8 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -23,5 +23,6 @@ int apic_get_highest_priority_irr(DeviceState *dev);
=20
 /* pc.c */
 DeviceState *cpu_get_current_apic(void);
+extern bool compat_apic_id_mode;
=20
 #endif
diff --git a/include/hw/i386/cpu-internal.h b/include/hw/i386/cpu-interna=
l.h
new file mode 100644
index 0000000000..48a5253aa9
--- /dev/null
+++ b/include/hw/i386/cpu-internal.h
@@ -0,0 +1,32 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corportation
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_I386_CPU_H
+#define QEMU_I386_CPU_H
+
+#include "hw/boards.h"
+
+uint32_t cpu_apicid_from_index(unsigned int cpu_index, bool compat);
+
+CpuInstanceProperties cpu_index_to_props(MachineState *ms, unsigned cpu_=
index);
+int64_t cpu_get_default_cpu_node_id(const MachineState *ms, int idx);
+const CPUArchIdList *cpu_possible_cpu_arch_ids(MachineState *ms);
+
+void cpu_hot_add(const int64_t id, Error **errp);
+uint32_t cpus_init(MachineState *ms, bool compat);
+
+#endif
--=20
2.21.0


