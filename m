Received: from eggs.gnu.org ([2001:4830:134:3::10]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXOu-0007iV-Sv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXOq-0001Bk-Pl
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewXOq-0001B6-FO
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 15 Mar 2018 15:14:18 -0300
Message-Id: <20180315181420.8694-6-ehabkost@redhat.com>
In-Reply-To: <20180315181420.8694-1-ehabkost@redhat.com>
References: <20180315181420.8694-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 5/7] Use cpu_create(type) instead of
 cpu_init(cpu_model)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

With all targets defining CPU_RESOLVING_TYPE, refactor
cpu_parse_cpu_model(type, cpu_model) to parse_cpu_model(cpu_model)
so that callers won't have to know internal resolving cpu
type. Place it in exec.c so it could be called from both
target independed vl.c and *-user/main.c.

That allows us to stop abusing cpu type from
  MachineClass::default_cpu_type
as resolver class in vl.c which were confusing part of
cpu_parse_cpu_model().

Also with new parse_cpu_model(), the last users of cpu_init()
in null-machine.c and bsd/linux-user targets could be switched
to cpu_create() API and cpu_init() API will be removed by
follow up patch.

With no longer users left remove MachineState::cpu_model field,
new code should use MachineState::cpu_type instead and
leave cpu_model parsing to generic code in vl.c.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1518000027-274608-5-git-send-email-imammedo@redhat.com>
[ehabkost: Fix bsd-user build error]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h    |  1 -
 include/qom/cpu.h      | 16 ++--------------
 bsd-user/main.c        |  4 +++-
 exec.c                 | 23 +++++++++++++++++++++++
 hw/core/null-machine.c |  6 +++---
 linux-user/main.c      |  8 ++++++--
 qom/cpu.c              | 47 ++++-------------------------------------------
 vl.c                   | 10 +++-------
 8 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index efb0a9edfd..16b473a4f4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -251,7 +251,6 @@ struct MachineState {
     char *kernel_filename;
     char *kernel_cmdline;
     char *initrd_filename;
-    const char *cpu_model;
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc6d4956a8..14e45c4282 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -662,8 +662,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
 CPUState *cpu_create(const char *typename);
 
 /**
- * cpu_parse_cpu_model:
- * @typename: The CPU base type or CPU type.
+ * parse_cpu_model:
  * @cpu_model: The model string including optional parameters.
  *
  * processes optional parameters and registers them as global properties
@@ -671,18 +670,7 @@ CPUState *cpu_create(const char *typename);
  * Returns: type of CPU to create or prints error and terminates process
  *          if an error occurred.
  */
-const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model);
-
-/**
- * cpu_generic_init:
- * @typename: The CPU base type.
- * @cpu_model: The model string including optional parameters.
- *
- * Instantiates a CPU, processes optional parameters and realizes the CPU.
- *
- * Returns: A #CPUState or %NULL if an error occurred.
- */
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model);
+const char *parse_cpu_model(const char *cpu_model);
 
 /**
  * cpu_has_work:
diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff8c5..984d0ff3bd 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -723,6 +723,7 @@ int main(int argc, char **argv)
 {
     const char *filename;
     const char *cpu_model;
+    const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     struct target_pt_regs regs1, *regs = &regs1;
@@ -900,7 +901,8 @@ int main(int argc, char **argv)
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu = cpu_init(cpu_model);
+    cpu_type = parse_cpu_model(cpu_model);
+    cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
 #if defined(TARGET_SPARC) || defined(TARGET_PPC)
     cpu_reset(cpu);
diff --git a/exec.c b/exec.c
index a9181e6417..bc643fc50f 100644
--- a/exec.c
+++ b/exec.c
@@ -817,6 +817,29 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
 
+const char *parse_cpu_model(const char *cpu_model)
+{
+    ObjectClass *oc;
+    CPUClass *cc;
+    gchar **model_pieces;
+    const char *cpu_type;
+
+    model_pieces = g_strsplit(cpu_model, ",", 2);
+
+    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    if (oc == NULL) {
+        error_report("unable to find CPU model '%s'", model_pieces[0]);
+        g_strfreev(model_pieces);
+        exit(EXIT_FAILURE);
+    }
+
+    cpu_type = object_class_get_name(oc);
+    cc = CPU_CLASS(oc);
+    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
+    g_strfreev(model_pieces);
+    return cpu_type;
+}
+
 #if defined(CONFIG_USER_ONLY)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 864832db34..cde4d3eb57 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -24,9 +24,9 @@ static void machine_none_init(MachineState *mch)
 {
     CPUState *cpu = NULL;
 
-    /* Initialize CPU (if a model has been specified) */
-    if (mch->cpu_model) {
-        cpu = cpu_init(mch->cpu_model);
+    /* Initialize CPU (if user asked for it) */
+    if (mch->cpu_type) {
+        cpu = cpu_create(mch->cpu_type);
         if (!cpu) {
             error_report("Unable to initialize CPU");
             exit(1);
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc79b0..89b24d43a5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -45,6 +45,7 @@ static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
 static const char *cpu_model;
+static const char *cpu_type;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
@@ -3967,7 +3968,7 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    CPUState *new_cpu = cpu_init(cpu_model);
+    CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = new_cpu->env_ptr;
     CPUBreakpoint *bp;
     CPUWatchpoint *wp;
@@ -4450,10 +4451,13 @@ int main(int argc, char **argv, char **envp)
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
+    cpu_type = parse_cpu_model(cpu_model);
+
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu = cpu_init(cpu_model);
+
+    cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
 
diff --git a/qom/cpu.c b/qom/cpu.c
index e42d9a7f9e..60292dfde9 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -67,37 +67,6 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model)
-{
-    ObjectClass *oc;
-    CPUClass *cc;
-    gchar **model_pieces;
-    const char *cpu_type;
-
-    model_pieces = g_strsplit(cpu_model, ",", 2);
-
-    oc = cpu_class_by_name(typename, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-    return cpu_type;
-}
-
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-{
-    /* TODO: all callers of cpu_generic_init() need to be converted to
-     * call cpu_parse_features() only once, before calling cpu_generic_init().
-     */
-    return cpu_create(cpu_parse_cpu_model(typename, cpu_model));
-}
-
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -335,23 +304,15 @@ static ObjectClass *cpu_common_class_by_name(const char *cpu_model)
 static void cpu_common_parse_features(const char *typename, char *features,
                                       Error **errp)
 {
-    char *featurestr; /* Single "key=value" string being parsed */
     char *val;
     static bool cpu_globals_initialized;
+    /* Single "key=value" string being parsed */
+    char *featurestr = features ? strtok(features, ",") : NULL;
 
-    /* TODO: all callers of ->parse_features() need to be changed to
-     * call it only once, so we can remove this check (or change it
-     * to assert(!cpu_globals_initialized).
-     * Current callers of ->parse_features() are:
-     * - cpu_generic_init()
-     */
-    if (cpu_globals_initialized) {
-        return;
-    }
+    /* should be called only once, catch invalid users */
+    assert(!cpu_globals_initialized);
     cpu_globals_initialized = true;
 
-    featurestr = features ? strtok(features, ",") : NULL;
-
     while (featurestr) {
         val = strchr(featurestr, '=');
         if (val) {
diff --git a/vl.c b/vl.c
index 3ef04ce991..61c2f19365 100644
--- a/vl.c
+++ b/vl.c
@@ -4582,15 +4582,11 @@ int main(int argc, char **argv, char **envp)
     current_machine->maxram_size = maxram_size;
     current_machine->ram_slots = ram_slots;
     current_machine->boot_order = boot_order;
-    current_machine->cpu_model = cpu_model;
 
     /* parse features once if machine provides default cpu_type */
-    if (machine_class->default_cpu_type) {
-        current_machine->cpu_type = machine_class->default_cpu_type;
-        if (cpu_model) {
-            current_machine->cpu_type =
-                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
-        }
+    current_machine->cpu_type = machine_class->default_cpu_type;
+    if (cpu_model) {
+        current_machine->cpu_type = parse_cpu_model(cpu_model);
     }
     parse_numa_opts(current_machine);
 
-- 
2.14.3
