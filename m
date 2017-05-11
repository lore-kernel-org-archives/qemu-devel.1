Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcY-0002n0-Ty
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcY-0007zc-17
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcX-0007zV-RU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:36 -0300
Message-Id: <20170511191843.13784-23-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 22/29] machine: call machine init from wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

add machine_run_board_init() wrapper that calls machine
init for now but in follow up patches it will be used
to run generic machine code that should run before
machine init.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1494415802-227633-15-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h | 1 +
 hw/core/machine.c   | 6 ++++++
 vl.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 4e14ff060e..76ce0219ff 100644
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
index 420c8c4d16..64e2a4ff2c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -678,6 +678,12 @@ bool machine_mem_merge(MachineState *machine)
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
index 5cd0c17ba0..3d8c140011 100644
--- a/vl.c
+++ b/vl.c
@@ -4559,7 +4559,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
-    machine_class->init(current_machine);
+    machine_run_board_init(current_machine);
 
     realtime_init();
 
-- 
2.11.0.259.g40922b1
