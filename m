Received: from eggs.gnu.org ([2001:4830:134:3::10]:45454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPj-0000G4-3T
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPf-0002F3-2v
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:44 +0100
Message-Id: <1490189568-167621-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 19/23] machine: call machine init from
 wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

add machine_run_board_init() wrapper that calls machine
init for now but in follow up patches it will be used
to run generic machine code that should run before
machine init.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h | 1 +
 hw/core/machine.c   | 6 ++++++
 vl.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 40f30f1..42742d0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -32,6 +32,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 MachineClass *find_default_machine(void);
 extern MachineState *current_machine;
 
+void machine_run_board_init(MachineState *machine);
 bool machine_usb(MachineState *machine);
 bool machine_kernel_irqchip_allowed(MachineState *machine);
 bool machine_kernel_irqchip_required(MachineState *machine);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6ff0b45..d284a63 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -643,6 +643,12 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
+void machine_run_board_init(MachineState *machine)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+    machine_class->init(machine);
+}
+
 static void machine_class_finalize(ObjectClass *klass, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(klass);
diff --git a/vl.c b/vl.c
index e5c1620..2b0aed3 100644
--- a/vl.c
+++ b/vl.c
@@ -4554,7 +4554,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
-    machine_class->init(current_machine);
+    machine_run_board_init(current_machine);
 
     realtime_init();
 
-- 
2.7.4
