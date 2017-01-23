Received: from eggs.gnu.org ([2001:4830:134:3::10]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo28-0003SX-Se
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo27-0006DZ-NC
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo27-0006Bs-Ej
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:19 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:36 -0200
Message-Id: <20170123232738.20796-12-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] hw/core/null-machine: Add the possibility
 to instantiate a CPU and RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Sometimes it is useful to have just a machine with CPU and RAM, without
any further hardware in it, e.g. if you just want to do some instruction
debugging for TCG with a remote GDB attached to QEMU, or run some embedded
code with the "-semihosting" QEMU parameter. qemu-system-m68k already
features a "dummy" machine, and xtensa a "sim" machine for exactly this
purpose.
All target architectures have nowadays also a "none" machine, which would
be a perfect match for this, too - but it currently does not allow to add
CPU and RAM yet. Thus let's add these possibilities in a generic way to the
"none" machine, too, so that we hopefully do not need additional "dummy"
machines in the future anymore (and maybe can also get rid of the already
existing "dummy"/"sim" machines one day).
Note that the default behaviour of the "none" machine is not changed, i.e.
no CPU and no RAM is instantiated by default. You have explicitely got to
specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
these new features.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1484743490-24721-1-git-send-email-thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/null-machine.c | 27 +++++++++++++++++++++++++--
 hw/core/Makefile.objs  |  2 +-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 0351ba7828..27c8369b57 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -13,18 +13,41 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+#include "cpu.h"
 
-static void machine_none_init(MachineState *machine)
+static void machine_none_init(MachineState *mch)
 {
+    CPUState *cpu = NULL;
+
+    /* Initialize CPU (if a model has been specified) */
+    if (mch->cpu_model) {
+        cpu = cpu_init(mch->cpu_model);
+        if (!cpu) {
+            error_report("Unable to initialize CPU");
+            exit(1);
+        }
+    }
+
+    /* RAM at address zero */
+    if (mch->ram_size) {
+        MemoryRegion *ram = g_new(MemoryRegion, 1);
+
+        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
+        memory_region_add_subregion(get_system_memory(), 0, ram);
+    }
 }
 
 static void machine_none_machine_init(MachineClass *mc)
 {
     mc->desc = "empty machine";
     mc->init = machine_none_init;
-    mc->max_cpus = 0;
+    mc->max_cpus = 1;
+    mc->default_ram_size = 0;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 833fd46897..7f8c9dc659 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -12,7 +12,6 @@ common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += register.o
@@ -20,3 +19,4 @@ common-obj-$(CONFIG_SOFTMMU) += or-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 
 obj-$(CONFIG_SOFTMMU) += generic-loader.o
+obj-$(CONFIG_SOFTMMU) += null-machine.o
-- 
2.11.0.259.g40922b1
