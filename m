Received: from eggs.gnu.org ([2001:4830:134:3::10]:54390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eihDp-0007z7-E6
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eihDl-0006zn-GO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:54:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eihDl-0006u5-7m
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:54:09 -0500
Date: Mon, 5 Feb 2018 11:54:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180205135401.GA3300@localhost.localdomain>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
	<20180202182326.GB22556@localhost.localdomain>
	<20180205122235.03fdeaad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205122235.03fdeaad@redhat.com>
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

On Mon, Feb 05, 2018 at 12:22:35PM +0100, Igor Mammedov wrote:
> On Fri, 2 Feb 2018 16:23:26 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:
> > > As cpu_type is not a user visible string let's convert the
> > > valid_cpu_types to compare against cpu_model instead. This way we have a
> > > user friendly string to report back.
> > > 
> > > Once we have a cpu_type to cpu_model conversion this patch should be
> > > reverted and we should use cpu_type instead.
> > > 
> > > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > > ---
> > > 
> > >  hw/core/machine.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index cdc1163dc6..de5bac1c84 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
> > >      /* If the machine supports the valid_cpu_types check and the user
> > >       * specified a CPU with -cpu check here that the user CPU is supported.
> > >       */
> > > -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> > > -        ObjectClass *class = object_class_by_name(machine->cpu_type);
> > > +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> > >          int i;
> > >  
> > >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > > -            if (object_class_dynamic_cast(class,
> > > -                                          machine_class->valid_cpu_types[i])) {
> > > +            if (!strcmp(machine->cpu_model,
> > > +                        machine_class->valid_cpu_types[i])) {  
> > 
> > I would rename valid_cpu_types to valid_cpu_models to make the
> > new semantics clearer.
> > 
> > Anyway, I have bad and good news:
> > 
> > The bad news is Igor already sent patches last week that remove
> > MachineState::cpu_model, so this conflicts with his series.  Now
> > parse_cpu_model() will be the only place where the original CPU model name is
> > available, but the function needs to work on *-user too.  See:
> > "[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_model)".
> > 
> > The good news is that I think we can fix this very easily if
> > validation is done at the same place where parse_cpu_model() is
> > called.  e.g.:
> > 
> >     current_machine->cpu_type = machine_class->default_cpu_type;
> >     if (cpu_model) {
> >         current_machine->cpu_type = parse_cpu_model(cpu_model);
> > 
> >         if (machine_class->valid_cpu_models) {
> >             ObjectClass *class = object_class_by_name(machine->cpu_type);
> >             int i;
> > 
> >             for (i = 0; machine_class->valid_cpu_models[i]; i++) {
> >                 const char *valid_model = machine_class->valid_cpu_models[i];
> >                 ObjectClass *valid_class = cpu_class_by_name(machine->cpu_type, valid_model);
> >                 if (object_class_dynamic_cast(class,
> >                                               object_class_get_name(valid_class))) {
> >                      /* Valid CPU type, we're good to go */
> >                      break;
> >                 }
> >             }
> >             if (!machine_class->valid_cpu_models[i]) {
> >                 error_report("Invalid CPU model: %s", cpu_model);
> >                 error_printf("The valid CPU models are: %s",
> >                              machine_class->valid_cpu_models[0]);
> >                 for (i = 1; machine_class->valid_cpu_models[i]; i++) {
> >                     error_printf(", %s", machine_class->valid_cpu_models[i]);
> >                 }
> >                 error_printf("\n");
> >                 exit(1);
> >             }
> >         }
> >     }
> > 
> > This can be done inside main(), or moved inside
> > machine_run_board_init() if main() pass cpu_model as argument to
> > the function.
> > 
> > On either case, I think it's a good idea to do validation and
> > printing of error messages closer to the code that parses the
> > command-line options.  This way we separate parsing/validation
> > from initialization.
> I agree it's better like you suggest as at least it prevents
> ms->cpu_model creeping back into boards code.
> 
> But I still dislike (hate) an idea of new code adding non
> canonized cpu_model strings back in the boards code.
> It's just a matter of time when someone would use them
> and cpu_model parsing will creep back into boards.
> 
> It would be much better to if we add 
>    char *MachineClass::cpu_name_by_type_name(char *cpu_type)
> callback and let machines in this patchset to set it,
> something along following lines which is not much of
> refactoring and allows for gradual conversion:
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9631670..85cca84 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2885,4 +2885,6 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
>      return cpu->el_change_hook_opaque;
>  }
>  
> +char *arm_cpu_name_by_type_name(const char *typename);
> +
>  #endif
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index f936017..ae6adb7 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -46,6 +46,7 @@ static void netduino2_machine_init(MachineClass *mc)
>      mc->desc = "Netduino 2 Machine";
>      mc->init = netduino2_init;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->cpu_name_by_type_name = arm_cpu_name_by_type_name:

I really don't want to introduce a new arch-specific hook just
for that.  We should move CPU type lookup logic to common code
and make it unnecessary to write new hooks.

I agree it would be better if we had a cpu_name_by_type_name()
function, but I would like to have it implemented cleanly.

-- 
Eduardo
