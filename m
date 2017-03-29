Received: from eggs.gnu.org ([2001:4830:134:3::10]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVE-00025u-69
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVB-0000Ad-7a
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJVA-0000AN-VX
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBF8A7F3EB
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:45 -0300
Message-Id: <20170329194148.19015-7-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 6/9] Explicitly cast the *_GET_CLASS() value
 when we break the rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

object_get_class() and *_GET_CLASS() macros are going to be
changed to return const pointers because the class structs are
supposed to be initialized at class_init and not be changed
later.

However, there are a few places the code still break the
(proposed) rules, and change class data outside class_init. On
those cases, add an explicit cast to the *_GET_CLASS() return
value.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/bus.c        | 2 +-
 hw/mips/mips_jazz.c  | 2 +-
 hw/xen/xen_backend.c | 2 +-
 target/s390x/cpu.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24486..9233f8723b 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -90,7 +90,7 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
         bus->name = g_strdup_printf("%s.%d", bus->parent->id, bus_id);
     } else {
         /* no id -> use lowercase bus type plus global bus-id for bus name */
-        bc = BUS_GET_CLASS(bus);
+        bc = (BusClass *)BUS_GET_CLASS(bus);
         bus_id = bc->automatic_ids++;
         bus->name = g_strdup_printf("%s.%d", typename, bus_id);
         for (i = 0; bus->name[i]; i++) {
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 1cef581878..0407d998f1 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -166,7 +166,7 @@ static void mips_jazz_init(MachineState *machine,
      * CPU, which raise an exception.
      * Handle that case by hijacking the do_unassigned_access method on
      * the CPU, and do not raise exceptions for data access. */
-    cc = CPU_GET_CLASS(cpu);
+    cc = (CPUClass *)CPU_GET_CLASS(cpu);
     real_do_unassigned_access = cc->do_unassigned_access;
     cc->do_unassigned_access = mips_jazz_do_unassigned_access;
 
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6e530681f4..541ebb226c 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -553,7 +553,7 @@ err:
 static void xen_set_dynamic_sysbus(void)
 {
     Object *machine = qdev_get_machine();
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MachineClass *mc = (MachineClass *)MACHINE_GET_CLASS(machine);
 
     mc->has_dynamic_sysbus = true;
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 066dcd17df..07eb8b745f 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -174,7 +174,7 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
+    S390CPUClass *scc = (S390CPUClass *)S390_CPU_GET_CLASS(dev);
     S390CPU *cpu = S390_CPU(dev);
     CPUS390XState *env = &cpu->env;
     Error *err = NULL;
-- 
2.11.0.259.g40922b1
