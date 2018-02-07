Received: from eggs.gnu.org ([2001:4830:134:3::10]:58520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB4-00032s-4u
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB1-0004ZX-2f
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejNB0-0004Yl-SP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18D1640FB62D
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 10:42:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  7 Feb 2018 11:40:26 +0100
Message-Id: <1518000027-274608-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
References: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/5] Use cpu_create(type) instead of
 cpu_init(cpu_model)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

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
---
v4:
  - actually remove no longer used MachineState::cpu_model field
    that I've lost somewhere during respins

  - squash in [PATCH v3 25/25] cpu: get rid of cpu_generic_init()
    as after rework/rebase cpu_generic_init() is being removed by
    this patch and only check removal was left in 25/25, which
    should be removed together with cpu_generic_init() in this patch

  - assert(!cpu_globals_initialized) in cpu_common_parse_features()
    (Eduardo Habkost <ehabkost@redhat.com>)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h    |  1 -
 include/qom/cpu.h      | 16 ++--------------
 bsd-user/main.c        |  4 +++-
 exec.c                 | 23 +++++++++++++++++++++++
 hw/core/null-machine.c |  6 +++---
 linux-user/main.c      |  8 ++++++--
 qom/cpu.c              | 47 ++++----------------------------------------=
---
 vl.c                   | 10 +++-------
 8 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index efb0a9e..16b473a 100644
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
index aff88fa..702be71 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -661,8 +661,7 @@ ObjectClass *cpu_class_by_name(const char *typename, =
const char *cpu_model);
 CPUState *cpu_create(const char *typename);
=20
 /**
- * cpu_parse_cpu_model:
- * @typename: The CPU base type or CPU type.
+ * parse_cpu_model:
  * @cpu_model: The model string including optional parameters.
  *
  * processes optional parameters and registers them as global properties
@@ -670,18 +669,7 @@ CPUState *cpu_create(const char *typename);
  * Returns: type of CPU to create or prints error and terminates process
  *          if an error occurred.
  */
-const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del);
-
-/**
- * cpu_generic_init:
- * @typename: The CPU base type.
- * @cpu_model: The model string including optional parameters.
- *
- * Instantiates a CPU, processes optional parameters and realizes the CP=
U.
- *
- * Returns: A #CPUState or %NULL if an error occurred.
- */
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model);
+const char *parse_cpu_model(const char *cpu_model);
=20
 /**
  * cpu_has_work:
diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff..cbc683a 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -723,6 +723,7 @@ int main(int argc, char **argv)
 {
     const char *filename;
     const char *cpu_model;
+    const char *cpu_type;
     const char *log_file =3D NULL;
     const char *log_mask =3D NULL;
     struct target_pt_regs regs1, *regs =3D &regs1;
@@ -900,7 +901,8 @@ int main(int argc, char **argv)
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu =3D cpu_init(cpu_model);
+    cpu_type =3D parse_cpu_model(cpu_model);
+    cpu =3D create(cpu_type);
     env =3D cpu->env_ptr;
 #if defined(TARGET_SPARC) || defined(TARGET_PPC)
     cpu_reset(cpu);
diff --git a/exec.c b/exec.c
index 629a508..8aee230 100644
--- a/exec.c
+++ b/exec.c
@@ -817,6 +817,29 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
=20
+const char *parse_cpu_model(const char *cpu_model)
+{
+    ObjectClass *oc;
+    CPUClass *cc;
+    gchar **model_pieces;
+    const char *cpu_type;
+
+    model_pieces =3D g_strsplit(cpu_model, ",", 2);
+
+    oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    if (oc =3D=3D NULL) {
+        error_report("unable to find CPU model '%s'", model_pieces[0]);
+        g_strfreev(model_pieces);
+        exit(EXIT_FAILURE);
+    }
+
+    cpu_type =3D object_class_get_name(oc);
+    cc =3D CPU_CLASS(oc);
+    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
+    g_strfreev(model_pieces);
+    return cpu_type;
+}
+
 #if defined(CONFIG_USER_ONLY)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 864832d..cde4d3e 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -24,9 +24,9 @@ static void machine_none_init(MachineState *mch)
 {
     CPUState *cpu =3D NULL;
=20
-    /* Initialize CPU (if a model has been specified) */
-    if (mch->cpu_model) {
-        cpu =3D cpu_init(mch->cpu_model);
+    /* Initialize CPU (if user asked for it) */
+    if (mch->cpu_type) {
+        cpu =3D cpu_create(mch->cpu_type);
         if (!cpu) {
             error_report("Unable to initialize CPU");
             exit(1);
diff --git a/linux-user/main.c b/linux-user/main.c
index 7de0e02..08db4c1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -44,6 +44,7 @@ static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
 static const char *cpu_model;
+static const char *cpu_type;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
@@ -3872,7 +3873,7 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu =3D ENV_GET_CPU(env);
-    CPUState *new_cpu =3D cpu_init(cpu_model);
+    CPUState *new_cpu =3D cpu_create(cpu_type);
     CPUArchState *new_env =3D new_cpu->env_ptr;
     CPUBreakpoint *bp;
     CPUWatchpoint *wp;
@@ -4384,10 +4385,13 @@ int main(int argc, char **argv, char **envp)
         cpu_model =3D "any";
 #endif
     }
+    cpu_type =3D parse_cpu_model(cpu_model);
+
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu =3D cpu_init(cpu_model);
+
+    cpu =3D cpu_create(cpu_type);
     env =3D cpu->env_ptr;
     cpu_reset(cpu);
=20
diff --git a/qom/cpu.c b/qom/cpu.c
index e42d9a7..60292df 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -67,37 +67,6 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
=20
-const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del)
-{
-    ObjectClass *oc;
-    CPUClass *cc;
-    gchar **model_pieces;
-    const char *cpu_type;
-
-    model_pieces =3D g_strsplit(cpu_model, ",", 2);
-
-    oc =3D cpu_class_by_name(typename, model_pieces[0]);
-    if (oc =3D=3D NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type =3D object_class_get_name(oc);
-    cc =3D CPU_CLASS(oc);
-    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-    return cpu_type;
-}
-
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-{
-    /* TODO: all callers of cpu_generic_init() need to be converted to
-     * call cpu_parse_features() only once, before calling cpu_generic_i=
nit().
-     */
-    return cpu_create(cpu_parse_cpu_model(typename, cpu_model));
-}
-
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
@@ -335,23 +304,15 @@ static ObjectClass *cpu_common_class_by_name(const =
char *cpu_model)
 static void cpu_common_parse_features(const char *typename, char *featur=
es,
                                       Error **errp)
 {
-    char *featurestr; /* Single "key=3Dvalue" string being parsed */
     char *val;
     static bool cpu_globals_initialized;
+    /* Single "key=3Dvalue" string being parsed */
+    char *featurestr =3D features ? strtok(features, ",") : NULL;
=20
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
     cpu_globals_initialized =3D true;
=20
-    featurestr =3D features ? strtok(features, ",") : NULL;
-
     while (featurestr) {
         val =3D strchr(featurestr, '=3D');
         if (val) {
diff --git a/vl.c b/vl.c
index e517a8d..ade0f82 100644
--- a/vl.c
+++ b/vl.c
@@ -4594,15 +4594,11 @@ int main(int argc, char **argv, char **envp)
     current_machine->maxram_size =3D maxram_size;
     current_machine->ram_slots =3D ram_slots;
     current_machine->boot_order =3D boot_order;
-    current_machine->cpu_model =3D cpu_model;
=20
     /* parse features once if machine provides default cpu_type */
-    if (machine_class->default_cpu_type) {
-        current_machine->cpu_type =3D machine_class->default_cpu_type;
-        if (cpu_model) {
-            current_machine->cpu_type =3D
-                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu=
_model);
-        }
+    current_machine->cpu_type =3D machine_class->default_cpu_type;
+    if (cpu_model) {
+        current_machine->cpu_type =3D parse_cpu_model(cpu_model);
     }
     parse_numa_opts(current_machine);
=20
--=20
2.7.4
