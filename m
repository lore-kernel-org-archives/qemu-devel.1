Received: from eggs.gnu.org ([2001:4830:134:3::10]:49380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecThD-00045I-5N
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecThA-0008Kp-16
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:14:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ecTh9-0008Ip-Ng
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:14:47 -0500
Date: Fri, 19 Jan 2018 11:14:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180119111439.0feb4f5a@redhat.com>
In-Reply-To: <20180118191809.GB5292@localhost.localdomain>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-21-git-send-email-imammedo@redhat.com>
	<20180118014846.GM627@localhost.localdomain>
	<20180118111035.3ab0a533@redhat.com>
	<20180118191809.GB5292@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/24] machine: drop MachineState::cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 18 Jan 2018 17:18:09 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Jan 18, 2018 at 11:10:35AM +0100, Igor Mammedov wrote:
> > On Wed, 17 Jan 2018 23:48:46 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Wed, Jan 17, 2018 at 04:43:32PM +0100, Igor Mammedov wrote:  
> > > > The last user of it was machine type 'none', which used field
> > > > to create CPU id user requested it on CLI with -cpu option.
[...]

> It looks like default_cpu_type is being overloaded for two
> different roles: 1) specifying the default CPU type; 2) finding
> the arch-specific class to be used to parse -cpu.
> 
> In the case of null-machine, these two roles conflict with each
> other.  I believe we can find other solutions instead of this
> hack that involves lying on MachineClass::default_cpu_type (and
> then having to work around the lie on machine_none_init()).
> 
> I see multiple options: adding a new MachineClass field for that
> (e.g.  resolving_cpu_type, which defaults to default_cpu_type if
> NULL); moving the CPU parsing code to arch_init.c (so it could
> use CPU_RESOLVING_TYPE or something similar); adding a optional
> MachineClass::parse_cpu_model hook.  We could even try to get rid
> of CPUClass::parse_features completely
Adding hooks just for the sake on null-machine seems to be overkill,
I'd go for arch_init.c but it won't work for linux-user, how about
exec.c as following:

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 93bd546..0185589 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -661,8 +661,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
[...]

diff --git a/exec.c b/exec.c
index d28fc0c..4543f06 100644
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
index 864832d..cde4d3e 100644
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
index a35477e..0afb3f4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4357,10 +4358,13 @@ int main(int argc, char **argv, char **envp)
         cpu_model = "any";
 #endif
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
index e42d9a7..aab8437 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -67,37 +67,6 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model)
-{
[...]
-}
-
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-{
[...]
-}
-
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
diff --git a/vl.c b/vl.c
index 2586f25..178bca3 100644
--- a/vl.c
+++ b/vl.c
@@ -4609,17 +4609,13 @@ int main(int argc, char **argv, char **envp)
     current_machine->maxram_size = maxram_size;
     current_machine->ram_slots = ram_slots;
     current_machine->boot_order = boot_order;
-    current_machine->cpu_model = cpu_model;
 
     parse_numa_opts(current_machine);
 
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
 
     machine_run_board_init(current_machine);
