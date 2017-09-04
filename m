Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorwJ-0003g4-Sx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorwF-00041H-6B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dorwE-00040D-TQ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:19 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  4 Sep 2017 16:01:00 +0200
Message-Id: <1504533662-198084-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] vl.c: convert cpu_model to cpu type and
 set of global properties before machine_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

All machines that support user specified cpu_model either call
cpu_generic_init() or cpu_class_by_name()/CPUClass::parse_features
to parse feature string and to get CPU type to create.

Which leads to code duplication and hard-codding default CPU model
within machine_foo_init() code. Which makes it impossible to
get CPU type before machine_init() is run.

So instead of setting default CPUs models and doing parsing in
target specific machine_foo_init() in various ways, provide
a generic data driven cpu_model parsing before machine_init()
is called.

in follow up per target patches, it will allow to:
  * define default CPU type in consistent/generic manner
    per machine type and drop custom code that fallbacks
    to default if cpu_model is NULL
  * drop custom features parsing in targets and do it
    in centralized way.
  * for cases of
      cpu_generic_init(TYPE_BASE/DEFAULT_CPU, "some_cpu")
    replace it with
      cpu_create(machine->cpu_type) || cpu_create(TYPE_FOO)
    depending if CPU type is user settable or not.
    not doing useless parsing and clearly documenting where
    CPU model is user settable or fixed one.

Patch allows machine subclasses to define default CPU type
per machine class at class_init() time and if that is set
generic code will parse cpu_model into a MachineState::cpu_type
which will be used to create CPUs for that machine instance
and allows gradual per board conversion.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
Target specific changes will split into separate per target/machine
patches to make changes reviewable.

CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>

---
 include/hw/boards.h |  6 ++++++
 vl.c                | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3363dd1..b8f255a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -131,6 +131,10 @@ typedef struct {
  *    size than the target architecture's minimum. (Attempting to create
  *    such a CPU will fail.) Note that changing this is a migration
  *    compatibility break for the machine.
+ * @default_cpu_type:
+ *    specifies default CPU_TYPE, which will be used for parsing target
+ *    specific features and for creating CPUs if CPU name wasn't provided
+ *    explicitly at CLI
  */
 struct MachineClass {
     /*< private >*/
@@ -167,6 +171,7 @@ struct MachineClass {
     GArray *compat_props;
     const char *hw_version;
     ram_addr_t default_ram_size;
+    const char *default_cpu_type;
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
@@ -220,6 +225,7 @@ struct MachineState {
     char *kernel_cmdline;
     char *initrd_filename;
     const char *cpu_model;
+    const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
 };
diff --git a/vl.c b/vl.c
index 8e247cc..9ae6001 100644
--- a/vl.c
+++ b/vl.c
@@ -4630,6 +4630,16 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
+
+    /* parse features once if machine provides default cpu_type */
+    if (machine_class->default_cpu_type) {
+        current_machine->cpu_type = machine_class->default_cpu_type;
+        if (cpu_model) {
+            current_machine->cpu_type =
+                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
+        }
+    }
+
     machine_run_board_init(current_machine);
 
     realtime_init();
-- 
2.7.4
