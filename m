Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eierH-0005It-9q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eierD-0004Gc-Qy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eierD-0004Fq-Ht
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:43 -0500
Date: Mon, 5 Feb 2018 12:22:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180205122235.03fdeaad@redhat.com>
In-Reply-To: <20180202182326.GB22556@localhost.localdomain>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
	<20180202182326.GB22556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Fri, 2 Feb 2018 16:23:26 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:
> > As cpu_type is not a user visible string let's convert the
> > valid_cpu_types to compare against cpu_model instead. This way we have a
> > user friendly string to report back.
> > 
> > Once we have a cpu_type to cpu_model conversion this patch should be
> > reverted and we should use cpu_type instead.
> > 
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > ---
> > 
> >  hw/core/machine.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index cdc1163dc6..de5bac1c84 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
> >      /* If the machine supports the valid_cpu_types check and the user
> >       * specified a CPU with -cpu check here that the user CPU is supported.
> >       */
> > -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> > -        ObjectClass *class = object_class_by_name(machine->cpu_type);
> > +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> >          int i;
> >  
> >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > -            if (object_class_dynamic_cast(class,
> > -                                          machine_class->valid_cpu_types[i])) {
> > +            if (!strcmp(machine->cpu_model,
> > +                        machine_class->valid_cpu_types[i])) {  
> 
> I would rename valid_cpu_types to valid_cpu_models to make the
> new semantics clearer.
> 
> Anyway, I have bad and good news:
> 
> The bad news is Igor already sent patches last week that remove
> MachineState::cpu_model, so this conflicts with his series.  Now
> parse_cpu_model() will be the only place where the original CPU model name is
> available, but the function needs to work on *-user too.  See:
> "[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_model)".
> 
> The good news is that I think we can fix this very easily if
> validation is done at the same place where parse_cpu_model() is
> called.  e.g.:
> 
>     current_machine->cpu_type = machine_class->default_cpu_type;
>     if (cpu_model) {
>         current_machine->cpu_type = parse_cpu_model(cpu_model);
> 
>         if (machine_class->valid_cpu_models) {
>             ObjectClass *class = object_class_by_name(machine->cpu_type);
>             int i;
> 
>             for (i = 0; machine_class->valid_cpu_models[i]; i++) {
>                 const char *valid_model = machine_class->valid_cpu_models[i];
>                 ObjectClass *valid_class = cpu_class_by_name(machine->cpu_type, valid_model);
>                 if (object_class_dynamic_cast(class,
>                                               object_class_get_name(valid_class))) {
>                      /* Valid CPU type, we're good to go */
>                      break;
>                 }
>             }
>             if (!machine_class->valid_cpu_models[i]) {
>                 error_report("Invalid CPU model: %s", cpu_model);
>                 error_printf("The valid CPU models are: %s",
>                              machine_class->valid_cpu_models[0]);
>                 for (i = 1; machine_class->valid_cpu_models[i]; i++) {
>                     error_printf(", %s", machine_class->valid_cpu_models[i]);
>                 }
>                 error_printf("\n");
>                 exit(1);
>             }
>         }
>     }
> 
> This can be done inside main(), or moved inside
> machine_run_board_init() if main() pass cpu_model as argument to
> the function.
> 
> On either case, I think it's a good idea to do validation and
> printing of error messages closer to the code that parses the
> command-line options.  This way we separate parsing/validation
> from initialization.
I agree it's better like you suggest as at least it prevents
ms->cpu_model creeping back into boards code.

But I still dislike (hate) an idea of new code adding non
canonized cpu_model strings back in the boards code.
It's just a matter of time when someone would use them
and cpu_model parsing will creep back into boards.

It would be much better to if we add 
   char *MachineClass::cpu_name_by_type_name(char *cpu_type)
callback and let machines in this patchset to set it,
something along following lines which is not much of
refactoring and allows for gradual conversion:

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9631670..85cca84 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2885,4 +2885,6 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
     return cpu->el_change_hook_opaque;
 }
 
+char *arm_cpu_name_by_type_name(const char *typename);
+
 #endif
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017..ae6adb7 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -46,6 +46,7 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->desc = "Netduino 2 Machine";
     mc->init = netduino2_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->cpu_name_by_type_name = arm_cpu_name_by_type_name:
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cc1856c..dacc3cc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -928,6 +928,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     acc->parent_realize(dev, errp);
 }
 
+char *arm_cpu_name_by_type_name(const char *typename)
+{
+    return g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU));
+}
+
 static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c83c901..e27b7f0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5373,7 +5373,7 @@ static void arm_cpu_list_entry(gpointer data, gpointer user_data)
     char *name;
 
     typename = object_class_get_name(oc);
-    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU));
+    name = arm_cpu_name_by_type_name(typename);
     (*s->cpu_fprintf)(s->file, "  %s\n",
                       name);
     g_free(name);
@@ -5410,8 +5410,7 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 
     typename = object_class_get_name(oc);
     info = g_malloc0(sizeof(*info));
-    info->name = g_strndup(typename,
-                           strlen(typename) - strlen("-" TYPE_ARM_CPU));
+    info->name = arm_cpu_name_by_type_name(typename);
     info->q_typename = g_strdup(typename);
 
     entry = g_malloc0(sizeof(*entry));
diff --git a/vl.c b/vl.c
index c10b0f4..fda1cb2 100644
--- a/vl.c
+++ b/vl.c
@@ -4646,6 +4646,11 @@ int main(int argc, char **argv, char **envp)
         if (cpu_model) {
             current_machine->cpu_type =
                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
+
+            if !is_valid_cpu(current_machine->cpu_type)
+                print("valid cpu types: ")
+                for_each_valid_type
+                    print(machine_class->cpu_name_by_type_name())
         }
     }
