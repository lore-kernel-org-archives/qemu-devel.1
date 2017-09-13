Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9z-0002PY-7b
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9v-0006ZZ-6N
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsA9u-0006Z4-Ti
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF67FC058EA9
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:05:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 744F45D963
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:05:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Sep 2017 18:04:55 +0200
Message-Id: <1505318697-77161-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] vl.c: convert cpu_model to cpu type and
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
---
 include/hw/boards.h |  6 ++++++
 vl.c                | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7f044d1..6b67ada 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -125,6 +125,10 @@ typedef struct {
  *    Caller is responsible for freeing returned list.
  * @has_hotpluggable_cpus:
  *    If true, board supports CPUs creation with -device/device_add.
+ * @default_cpu_type:
+ *    specifies default CPU_TYPE, which will be used for parsing target
+ *    specific features and for creating CPUs if CPU name wasn't provided
+ *    explicitly at CLI
  * @minimum_page_bits:
  *    If non-zero, the board promises never to create a CPU with a page size
  *    smaller than this, so QEMU can use a more efficient larger page
@@ -177,6 +181,7 @@ struct MachineClass {
     GArray *compat_props;
     const char *hw_version;
     ram_addr_t default_ram_size;
+    const char *default_cpu_type;
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
@@ -231,6 +236,7 @@ struct MachineState {
     char *kernel_cmdline;
     char *initrd_filename;
     const char *cpu_model;
+    const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
 };
diff --git a/vl.c b/vl.c
index fb1f05b..034180f 100644
--- a/vl.c
+++ b/vl.c
@@ -4636,6 +4636,16 @@ int main(int argc, char **argv, char **envp)
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
