Received: from eggs.gnu.org ([2001:4830:134:3::10]:57375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec79o-0004DJ-W8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec79k-0006af-0X
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:10:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ec79j-0006Zx-Ny
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:10:47 -0500
Date: Thu, 18 Jan 2018 11:10:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180118111035.3ab0a533@redhat.com>
In-Reply-To: <20180118014846.GM627@localhost.localdomain>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-21-git-send-email-imammedo@redhat.com>
	<20180118014846.GM627@localhost.localdomain>
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

On Wed, 17 Jan 2018 23:48:46 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jan 17, 2018 at 04:43:32PM +0100, Igor Mammedov wrote:
> > The last user of it was machine type 'none', which used field
> > to create CPU id user requested it on CLI with -cpu option.
> > 
> > We could compare pointers of MachineState::cpu_type and
> > MachineClass::default_cpu_type to check for the same condition,
> > and drop cpu_model concept completly from machine/boards code
> > So that no one would try to reuse obsolete field and only
> > place to deal with cpu model would be vl.c and
> > foo_cpu_class_by_name() callbacks.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > CC: Marcel Apfelbaum <marcel@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  include/hw/boards.h    |  1 -
> >  hw/core/null-machine.c | 10 +++++++---
> >  vl.c                   |  8 +++++++-
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 156b16f..decd0ec 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -246,7 +246,6 @@ struct MachineState {
> >      char *kernel_filename;
> >      char *kernel_cmdline;
> >      char *initrd_filename;
> > -    const char *cpu_model;
> >      const char *cpu_type;
> >      AccelState *accelerator;
> >      CPUArchIdList *possible_cpus;
> > diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > index 864832d..c2e466c 100644
> > --- a/hw/core/null-machine.c
> > +++ b/hw/core/null-machine.c
> > @@ -23,10 +23,13 @@
> >  static void machine_none_init(MachineState *mch)
> >  {
> >      CPUState *cpu = NULL;
> > +    MachineClass *mc = MACHINE_GET_CLASS(mch);
> >  
> > -    /* Initialize CPU (if a model has been specified) */
> > -    if (mch->cpu_model) {
> > -        cpu = cpu_init(mch->cpu_model);
> > +    /* Initialize CPU if cpu_type pointer is user provided
> > +     * (i.e. != to pointer tot static default cpu type string)
> > +     */
> > +    if (mch->cpu_type != mc->default_cpu_type) {
> > +        cpu = cpu_create(mch->cpu_type);  
> 
> This is a big assumption about the code that sets mch->cpu_type.
> A simple g_strdup(machine_class->default_cpu_type) would break
> this silently (as it won't trigger the assert() below).
Yes, it's a bit of a hack to figure out is user has requested
cpu type explicitly. But so far there isn't need to do
   g_strdup(machine_class->default_cpu_type)
when copying default in vl.c and guarding against it
looks like overkill currently.

Cleaner way would be to make cpu_type property, add new property
API to set/check flags and use that here, there are other places
that would benefit from such API as well.
But it looks beyond scope of this series, so I used simple
hackish way to make it work with current code.

I can amend comment here:
    /* Initialize CPU if cpu_type pointer is user provided
     * (i.e. != to pointer to static default cpu type string)
     * MachineClass::default_cpu_type must be assigned to
     * MachineState::cpu_type directly for this to work.
     * TODO:
     *   - make cpu_type a property
     *   - add API to add/check user_set flag to property
     *   - use new API to check if property was user set
     */

> 
> 
> >          if (!cpu) {
> >              error_report("Unable to initialize CPU");
> >              exit(1);
> > @@ -54,6 +57,7 @@ static void machine_none_machine_init(MachineClass *mc)
> >      mc->init = machine_none_init;
> >      mc->max_cpus = 1;
> >      mc->default_ram_size = 0;
> > +    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;  
> 
> Why do you need this?  Isn't it simpler to just leave
> default_cpu_type=NULL here?
vl.c "-cpu" parsing depends on default_cpu_type being set
 ...
 if (machine_class->default_cpu_type) {
   ...
 }
when we get rid of requirement for proxy type in
 cpu_parse_cpu_model()
we can drop this ugliness in null-machine.

I'm doing it dirty way to prevent cpu_model resurgence
in boards code as it happened with nios2, even though
I've tried to monitor list for such patches.
 
> >  }
> >  
> >  DEFINE_MACHINE("none", machine_none_machine_init)
> > diff --git a/vl.c b/vl.c
> > index 2586f25..8aa0131 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4609,7 +4609,6 @@ int main(int argc, char **argv, char **envp)
> >      current_machine->maxram_size = maxram_size;
> >      current_machine->ram_slots = ram_slots;
> >      current_machine->boot_order = boot_order;
> > -    current_machine->cpu_model = cpu_model;
> >  
> >      parse_numa_opts(current_machine);
> >  
> > @@ -4619,6 +4618,13 @@ int main(int argc, char **argv, char **envp)
> >          if (cpu_model) {
> >              current_machine->cpu_type =
> >                  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
> > +
> > +            /* machine 'none' depends on default cpu type pointer not being
> > +             * equal to resolved type name pointer to fugure out if type was
> > +             * user provided, make sure that if it becomes not true in future
> > +             * it won't beark silently */
> > +            g_assert(
> > +                current_machine->cpu_type != machine_class->default_cpu_type);
> >          }
> >      }
> >  
> > -- 
> > 2.7.4
> >   
> 
