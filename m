Received: from eggs.gnu.org ([2001:4830:134:3::10]:53655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipSq-0007Na-Kc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipSl-00035l-Lh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipSl-00035W-BP
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:42:11 -0500
Date: Mon, 5 Feb 2018 20:42:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180205224205.GA3291@localhost.localdomain>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
	<20180202182326.GB22556@localhost.localdomain>
	<20180205122235.03fdeaad@redhat.com>
	<20180205135401.GA3300@localhost.localdomain>
	<20180205154202.7d1269a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205154202.7d1269a9@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Mon, Feb 05, 2018 at 03:42:02PM +0100, Igor Mammedov wrote:
> On Mon, 5 Feb 2018 11:54:01 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Feb 05, 2018 at 12:22:35PM +0100, Igor Mammedov wrote:
> > > On Fri, 2 Feb 2018 16:23:26 -0200
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:  
> > > > > As cpu_type is not a user visible string let's convert the
> > > > > valid_cpu_types to compare against cpu_model instead. This way we have a
> > > > > user friendly string to report back.
> > > > > 
> > > > > Once we have a cpu_type to cpu_model conversion this patch should be
> > > > > reverted and we should use cpu_type instead.
> > > > > 
> > > > > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > > > > ---
> > > > > 
> > > > >  hw/core/machine.c | 11 +++++------
> > > > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index cdc1163dc6..de5bac1c84 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
> > > > >      /* If the machine supports the valid_cpu_types check and the user
> > > > >       * specified a CPU with -cpu check here that the user CPU is supported.
> > > > >       */
> > > > > -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> > > > > -        ObjectClass *class = object_class_by_name(machine->cpu_type);
> > > > > +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> > > > >          int i;
> > > > >  
> > > > >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > > > > -            if (object_class_dynamic_cast(class,
> > > > > -                                          machine_class->valid_cpu_types[i])) {
> > > > > +            if (!strcmp(machine->cpu_model,
> > > > > +                        machine_class->valid_cpu_types[i])) {    
> > > > 
> > > > I would rename valid_cpu_types to valid_cpu_models to make the
> > > > new semantics clearer.
> > > > 
> > > > Anyway, I have bad and good news:
> > > > 
> > > > The bad news is Igor already sent patches last week that remove
> > > > MachineState::cpu_model, so this conflicts with his series.  Now
> > > > parse_cpu_model() will be the only place where the original CPU model name is
> > > > available, but the function needs to work on *-user too.  See:
> > > > "[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_model)".
> > > > 
> > > > The good news is that I think we can fix this very easily if
> > > > validation is done at the same place where parse_cpu_model() is
> > > > called.  e.g.:
> > > > 
> > > >     current_machine->cpu_type = machine_class->default_cpu_type;
> > > >     if (cpu_model) {
> > > >         current_machine->cpu_type = parse_cpu_model(cpu_model);
> > > > 
> > > >         if (machine_class->valid_cpu_models) {
> > > >             ObjectClass *class = object_class_by_name(machine->cpu_type);
> > > >             int i;
> > > > 
> > > >             for (i = 0; machine_class->valid_cpu_models[i]; i++) {
> > > >                 const char *valid_model = machine_class->valid_cpu_models[i];
> > > >                 ObjectClass *valid_class = cpu_class_by_name(machine->cpu_type, valid_model);
> > > >                 if (object_class_dynamic_cast(class,
> > > >                                               object_class_get_name(valid_class))) {
> > > >                      /* Valid CPU type, we're good to go */
> > > >                      break;
> > > >                 }
> > > >             }
> > > >             if (!machine_class->valid_cpu_models[i]) {
> > > >                 error_report("Invalid CPU model: %s", cpu_model);
> > > >                 error_printf("The valid CPU models are: %s",
> > > >                              machine_class->valid_cpu_models[0]);
> > > >                 for (i = 1; machine_class->valid_cpu_models[i]; i++) {
> > > >                     error_printf(", %s", machine_class->valid_cpu_models[i]);
> > > >                 }
> > > >                 error_printf("\n");
> > > >                 exit(1);
> > > >             }
> > > >         }
> > > >     }
> > > > 
> > > > This can be done inside main(), or moved inside
> > > > machine_run_board_init() if main() pass cpu_model as argument to
> > > > the function.
> > > > 
> > > > On either case, I think it's a good idea to do validation and
> > > > printing of error messages closer to the code that parses the
> > > > command-line options.  This way we separate parsing/validation
> > > > from initialization.  
> > > I agree it's better like you suggest as at least it prevents
> > > ms->cpu_model creeping back into boards code.
> > > 
> > > But I still dislike (hate) an idea of new code adding non
> > > canonized cpu_model strings back in the boards code.
> > > It's just a matter of time when someone would use them
> > > and cpu_model parsing will creep back into boards.
> > > 
> > > It would be much better to if we add 
> > >    char *MachineClass::cpu_name_by_type_name(char *cpu_type)
> > > callback and let machines in this patchset to set it,
> > > something along following lines which is not much of
> > > refactoring and allows for gradual conversion:
> > > 
> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > index 9631670..85cca84 100644
> > > --- a/target/arm/cpu.h
> > > +++ b/target/arm/cpu.h
> > > @@ -2885,4 +2885,6 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
> > >      return cpu->el_change_hook_opaque;
> > >  }
> > >  
> > > +char *arm_cpu_name_by_type_name(const char *typename);
> > > +
> > >  #endif
> > > diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> > > index f936017..ae6adb7 100644
> > > --- a/hw/arm/netduino2.c
> > > +++ b/hw/arm/netduino2.c
> > > @@ -46,6 +46,7 @@ static void netduino2_machine_init(MachineClass *mc)
> > >      mc->desc = "Netduino 2 Machine";
> > >      mc->init = netduino2_init;
> > >      mc->ignore_memory_transaction_failures = true;
> > > +    mc->cpu_name_by_type_name = arm_cpu_name_by_type_name:  
> > 
> > I really don't want to introduce a new arch-specific hook just
> > for that.  We should move CPU type lookup logic to common code
> > and make it unnecessary to write new hooks.
> unfortunately cpu_model (cpu name part) is target specific
> and it's translation to type and back is target specific mayhem.

Why can't the model<->type translation be represented as data?
We could have simple cpu_type_name_suffix + an alias table.

We have at least 4 arches that return a constant at
class_by_name.  We have at least 10 arches that simply add a
suffix to the CPU model name.  We must make them use common code
instead of requiring them to implement yet another hook[1].

In addition to the ones above, we have 3 that seem to just need
an alias table (cris, superh, alpha).  ppc can probably also use
an alias table for the ppc_cpu_class_by_pvr() stuff.  sparc just
needs whitespaces translated to '-' (sparc), which can be done
using an alias table.

In the end I couldn't find any example that can't be represented
by a suffix + alias table.


> 
> So I'd prefer having both back and forth functions together in
> one place. And common code to call them when necessary.
> 
> We could do global cpu_name_by_type_name() instead of hook,
> which I'd prefer even more but then conversion can't be done
> only for one target but rather for all targets at once.

I don't mind letting a few targets override default behavior with
a hook if really necessary, but I have a problem with requiring
all targets to implement what's basically the same boilerplate
code to add/remove a string suffix and translating aliases.


>  
> > I agree it would be better if we had a cpu_name_by_type_name()
> > function, but I would like to have it implemented cleanly.
> In some cases(targets) it can be common helper, but in other
> cases it's not so.
> My suggestion though allows to do gradual conversion and
> avoid putting cpu_model names back in board's code (which I just manged to remove).
> Once all targets converted and relevant code is isolated
> we can attempt to generalize it if it's possible or at least
> make of it global per target helper to get rid of
> temporary machine hook.
> 
> (seeing this series reposted with cpu_model names in boards code,
> it doesn't looks like author would like to implement tree-wide
> generalization first)

Well, if nobody is willing to generalize all target-specific code
right now, I don't see the harm in having cpu_model-based tables
in a few boards in the meantime (as this patch series does).  But
I do see harm in requiring all our 20 targets to implement yet
another hook and increasing the costs of cleaning up the mess
later.

---
[1] Really, this amount of duplication is insane:

static char *mips_cpu_type_name(const char *cpu_model)
{
    return g_strdup_printf(MIPS_CPU_TYPE_NAME("%s"), cpu_model);
}

static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = mips_cpu_type_name(cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    return oc;
}

static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) ||
        object_class_is_abstract(oc)) {
        return NULL;
    }
    return oc;
}

static ObjectClass *uc32_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(UNICORE32_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_UNICORE32_CPU) ||
                       object_class_is_abstract(oc))) {
        oc = NULL;
    }
    return oc;
}

static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU) ||
        object_class_is_abstract(oc)) {
        return NULL;
    }
    return oc;
}

static char *x86_cpu_type_name(const char *model_name)
{
    return g_strdup_printf(X86_CPU_TYPE_NAME("%s"), model_name);
}

static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    if (cpu_model == NULL) {
        return NULL;
    }

    typename = x86_cpu_type_name(cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    return oc;
}

static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;
    char **cpuname;

    cpuname = g_strsplit(cpu_model, ",", 1);
    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
    oc = object_class_by_name(typename);
    g_strfreev(cpuname);
    g_free(typename);
    if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
        object_class_is_abstract(oc)) {
        return NULL;
    }
    return oc;
}

static ObjectClass *lm32_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(LM32_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_LM32_CPU) ||
                       object_class_is_abstract(oc))) {
        oc = NULL;
    }
    return oc;
}

static ObjectClass *m68k_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(M68K_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc != NULL && (object_class_dynamic_cast(oc, TYPE_M68K_CPU) == NULL ||
                       object_class_is_abstract(oc))) {
        return NULL;
    }
    return oc;
}

static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(MOXIE_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) ||
                       object_class_is_abstract(oc))) {
        return NULL;
    }
    return oc;
}


static ObjectClass *openrisc_cpu_class_by_name(const char *cpu_model)
{
    ObjectClass *oc;
    char *typename;

    typename = g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model);
    oc = object_class_by_name(typename);
    g_free(typename);
    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU) ||
                       object_class_is_abstract(oc))) {
        return NULL;
    }
    return oc;
}


-- 
Eduardo
