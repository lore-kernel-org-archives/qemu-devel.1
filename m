Received: from eggs.gnu.org ([2001:4830:134:3::10]:43588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecGuj-00074W-Dr
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecGui-0004Wo-Bv
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:35:57 -0500
Date: Thu, 18 Jan 2018 18:35:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180118203546.GF5292@localhost.localdomain>
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
	<1516296842-136976-3-git-send-email-imammedo@redhat.com>
	<33aa0c19-59ec-7063-f638-884fe2249aee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33aa0c19-59ec-7063-f638-884fe2249aee@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v2 2/5] machine: prepare machine
 'none' to gradually switch to cpu_create() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Thu, Jan 18, 2018 at 08:06:03PM +0100, Thomas Huth wrote:
> On 18.01.2018 18:33, Igor Mammedov wrote:
> > temporarily add #ifdef CPU_RESOLVING_TYPE in null-machine.c,
> > so that each target could gradually switch to cpu_create() and
> > not converted yet could continue to use cpu_init().
> > 
> > Once all targets are converted
> >    temporary ifdefs, MachineState::cpu_model and cpu_init() API
> > will be removed
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/core/null-machine.c | 13 ++++++++++++-
> >  vl.c                   |  8 +++++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > index 864832d..3cc6a49 100644
> > --- a/hw/core/null-machine.c
> > +++ b/hw/core/null-machine.c
> > @@ -23,10 +23,18 @@
> >  static void machine_none_init(MachineState *mch)
> >  {
> >      CPUState *cpu = NULL;
> > +#ifdef CPU_RESOLVING_TYPE
> > +    MachineClass *mc = MACHINE_GET_CLASS(mch);
> >  
> > -    /* Initialize CPU (if a model has been specified) */
> > +    /* Initialize CPU if cpu_type pointer is user provided
> > +     * (i.e. != to pointer tot static default cpu type string)
> 
> s/tot/to/ ?
> 
> > +     */
> > +    if (mch->cpu_type != mc->default_cpu_type) {
> > +        cpu = cpu_create(mch->cpu_type);
> > +#else
> >      if (mch->cpu_model) {
> >          cpu = cpu_init(mch->cpu_model);
> > +#endif
> >          if (!cpu) {
> >              error_report("Unable to initialize CPU");
> >              exit(1);
> > @@ -54,6 +62,9 @@ static void machine_none_machine_init(MachineClass *mc)
> >      mc->init = machine_none_init;
> >      mc->max_cpus = 1;
> >      mc->default_ram_size = 0;
> > +#ifdef CPU_RESOLVING_TYPE
> > +    mc->default_cpu_type = CPU_RESOLVING_TYPE;
> > +#endif

As mentioned in a reply to a previous series, this is making
mc->default_cpu_type lie about the default CPU type.  If vl.c is
relying on default_cpu_type to parse the CPU data, I'd like to
fix vl.c first instead of adding this hack.

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
> 
> s/fugure/figure/
> 
> > +             * user provided, make sure that if it becomes not true in future
> > +             * it won't beark silently */
> 
> s/beark/break/
> 
> > +            g_assert(
> > +                current_machine->cpu_type != machine_class->default_cpu_type);
> >          }
> >      }
> 
>  Thomas
> 
> 

-- 
Eduardo
