Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drlpx-00029I-Lz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drlps-0006Jm-Jz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:06:49 -0400
Date: Tue, 12 Sep 2017 16:06:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912160629.7731bdbe@nial.brq.redhat.com>
In-Reply-To: <20170912125322.GW7570@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
	<20170912141159.22c63bce@nial.brq.redhat.com>
	<20170912125322.GW7570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] arm: drop intermadiate cpu_model ->
 cpu type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, 12 Sep 2017 09:53:22 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Sep 12, 2017 at 02:11:59PM +0200, Igor Mammedov wrote:
> > On Tue, 5 Sep 2017 18:31:52 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Mon, Sep 04, 2017 at 04:01:02PM +0200, Igor Mammedov wrote:  
> > > > there are 2 use cases to deal with:
> > > >   1: fixed CPU models per board/soc
> > > >   2: boards with user configurable cpu_model and fallback to
> > > >      default cpu_model if user hasn't specified one explicitly
> > > > 
> > > > For the 1st
> > > >   drop intermediate cpu_model parsing and use const cpu type
> > > >   directly, which replaces:
> > > >      typename = object_class_get_name(
> > > >            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> > > >      object_new(typename)
> > > >   with
> > > >      object_new(FOO_CPU_TYPE_NAME)
> > > >   or
> > > >      cpu_generic_init(BASE_CPU_TYPE, "my cpu model")
> > > >   with
> > > >      cpu_create(FOO_CPU_TYPE_NAME)
> > > > 
> > > > as result 1st use case doesn't have to invoke not necessary
> > > > translation and not needed code is removed.
> > > > 
> > > > For the 2nd
> > > >  1: set default cpu type with MachineClass::default_cpu_type and
> > > >  2: use generic cpu_model parsing that done before machine_init()
> > > >     is run and:
> > > >     2.1: drop custom cpu_model parsing where pattern is:
> > > >        typename = object_class_get_name(
> > > >            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> > > >        [parse_features(typename, cpu_model, &err) ]
> > > > 
> > > >     2.2: or replace cpu_generic_init() which does what
> > > >          2.1 does + create_cpu(typename) with just
> > > >          create_cpu(machine->cpu_type)
> > > > as result cpu_name -> cpu_type translation is done using
> > > > generic machine code one including parsing optional features
> > > > if supported/present (removes a bunch of duplicated cpu_model
> > > > parsing code) and default cpu type is defined in an uniform way
> > > > within machine_class_init callbacks instead of adhoc places
> > > > in boadr's machine_init code.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---  
> > [...]
> >   
> > > > @@ -285,20 +259,16 @@ static void armv7m_reset(void *opaque)
> > > >     Returns the ARMv7M device.  */
> > > >  
> > > >  DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
> > > > -                      const char *kernel_filename, const char *cpu_model)
> > > > +                      const char *kernel_filename, const char *cpu_type)
> > > >  {
> > > >      DeviceState *armv7m;
> > > >  
> > > > -    if (cpu_model == NULL) {
> > > > -        cpu_model = "cortex-m3";
> > > > -    }
> > > > -    
> > > 
> > > I was going to suggest doing the default_cpu_type stuff in a
> > > separate patch, but it might require touching those lines twice.
> > > So I guess this is OK.  
> > I've have tried it, but yes it's more changes and there is also
> > chicken/egg problem, cleanest way I've stopped at is to get rid of
> > cpu_model fallback + cpu_generic_init() in one go.  
> 
> OK
> 
> > 
> >    
> > > >      armv7m = qdev_create(NULL, "armv7m");
> > > >      qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
> > > > -    qdev_prop_set_string(armv7m, "cpu-model", cpu_model);
> > > > +    qdev_prop_set_string(armv7m, "cpu-type", cpu_type);
> > > >      object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory()),
> > > >                                       "memory", &error_abort);
> > > > -    /* This will exit with an error if the user passed us a bad cpu_model */
> > > > +    /* This will exit with an error if the user passed us a bad cpu_type */
> > > >      qdev_init_nofail(armv7m);
> > > >  
> > > >      armv7m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);  
> > [...]
> >   
> > > > diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> > > > index 20e60f1..0d7190a 100644
> > > > --- a/hw/arm/highbank.c
> > > > +++ b/hw/arm/highbank.c
> > > > @@ -219,7 +219,6 @@ enum cxmachines {
> > > >  static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
> > > >  {
> > > >      ram_addr_t ram_size = machine->ram_size;
> > > > -    const char *cpu_model = machine->cpu_model;
> > > >      const char *kernel_filename = machine->kernel_filename;
> > > >      const char *kernel_cmdline = machine->kernel_cmdline;
> > > >      const char *initrd_filename = machine->initrd_filename;
> > > > @@ -236,19 +235,20 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
> > > >  
> > > >      switch (machine_id) {
> > > >      case CALXEDA_HIGHBANK:
> > > > -        cpu_model = "cortex-a9";
> > > > +        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> > > >          break;
> > > >      case CALXEDA_MIDWAY:
> > > > -        cpu_model = "cortex-a15";
> > > > +        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> > > >          break;
> > > > +    default:
> > > > +        assert(0);
> > > >      }    
> > > 
> > > Why not delete this switch statement completely and set
> > > default_cpu_type at midway_class_init() and
> > > highbank_class_init()?  
> > it would allow '-cpu foo' to take effect which isn't what current code does,
> > as series doesn't add valid_cpus[] check at the same time.  
> 
> Oh, I see.
> 
> 
> > 
> > So here we do pretty much strait-forward conversion from cpu_model
> > to cpu_type and nothing else.  
> 
> OK.
> 
> >   
> > > 
> > >   
> > > >  
> > > >      for (n = 0; n < smp_cpus; n++) {
> > > > -        ObjectClass *oc = cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
> > > >          Object *cpuobj;
> > > >          ARMCPU *cpu;
> > > >  
> > > > -        cpuobj = object_new(object_class_get_name(oc));
> > > > +        cpuobj = object_new(machine->cpu_type);
> > > >          cpu = ARM_CPU(cpuobj);
> > > >  
> > > >          object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_SMC,  
> > [...]
> >   
> > > > diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> > > > index c16657d..79b317a 100644
> > > > --- a/hw/arm/pxa2xx.c
> > > > +++ b/hw/arm/pxa2xx.c
> > > > @@ -2052,21 +2052,19 @@ static void pxa2xx_reset(void *opaque, int line, int level)
> > > >  
> > > >  /* Initialise a PXA270 integrated chip (ARM based core).  */
> > > >  PXA2xxState *pxa270_init(MemoryRegion *address_space,
> > > > -                         unsigned int sdram_size, const char *revision)
> > > > +                         unsigned int sdram_size, const char *cpu_type)
> > > >  {
> > > >      PXA2xxState *s;
> > > >      int i;
> > > >      DriveInfo *dinfo;
> > > >      s = g_new0(PXA2xxState, 1);
> > > >  
> > > > -    if (revision && strncmp(revision, "pxa27", 5)) {
> > > > +    if (strncmp(cpu_type, ARM_CPU_TYPE_NAME("pxa27"), 5)) {    
> > > 
> > > Why are you using ARM_CPU_TYPE_NAME here, if you are only
> > > checking if cpu_type starts with "pxa27"?  
> > mainly to show that we are dealing with types here,
> > I can leave plain "pxa27" if you prefer.  
> 
> Considering that we're dealing with a strncmp() hack that needs
> ARM_CPU_TYPE_NAME to work in a very specific way, I would prefer
> to leave the actual argument to strncmp() explicitly visible,
> until we implement another solution.
> 
> > 
> >   
> > > I suggest adding a TODO here noting that we implement this using
> > > either a TYPE_ARM_PXA27 subclass (so we can use
> > > object_class_dynamic_cast()), or a ARMCPUClass field to identify
> > > if the CPU is pxa27.  
> > dynamic cast would be nice, but ("pxa27", 5) cover a range of cpu types
> > starting with this prefix, to use cast class structure should be reorganized
> > to make all pxa27 based cpus have a common pxa27 ancestor.
> > Or just use more verbose complete list of valid_cpus[]
> > 
> > It's out of scope of this patch including TODO comment,
> > all boards should be audited anyways to make proper use of valid_cpus[]
> > and adding not related TODO comments here doesn't seem right.  
> 
> True, now we have the plan of adding valid_cpus[], and this would
> affect lots of other boards.  I won't mind if you prefer to not
> add the TODO comment on this series.
> 
> > 
> >   
> > > >          fprintf(stderr, "Machine requires a PXA27x processor.\n");
> > > >          exit(1);
> > > >      }    
> > > 
> > > This would be another use case for a generic CPU model validation
> > > mechanism in MachineClass.  
> > yep, just applied to a range of cpus instead of typical leaf class.
> > 
> > [...]
> >   
> > > > diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> > > > index c1145dd..3d1a231 100644
> > > > --- a/hw/arm/strongarm.c
> > > > +++ b/hw/arm/strongarm.c
> > > > @@ -1581,23 +1581,19 @@ static const TypeInfo strongarm_ssp_info = {
> > > >  
> > > >  /* Main CPU functions */
> > > >  StrongARMState *sa1110_init(MemoryRegion *sysmem,
> > > > -                            unsigned int sdram_size, const char *rev)
> > > > +                            unsigned int sdram_size, const char *cpu_type)
> > > >  {
> > > >      StrongARMState *s;
> > > >      int i;
> > > >  
> > > >      s = g_new0(StrongARMState, 1);
> > > >  
> > > > -    if (!rev) {
> > > > -        rev = "sa1110-b5";
> > > > -    }
> > > > -
> > > > -    if (strncmp(rev, "sa1110", 6)) {
> > > > +    if (strncmp(cpu_type, "sa1110", 6)) {
> > > >          error_report("Machine requires a SA1110 processor.");
> > > >          exit(1);    
> > > 
> > > Same suggestion as on pxa270_init(): adding a TODO here noting
> > > that we implement this using either object_class_dynamic_cast(),
> > > or a ARMCPUClass field to identify if the CPU is sa1110.  
> > same as pxa27, it's a case of range of cpus,
> > TODO is orthogonal to patch topic, so I'd prefer not to add it here.  
> 
> OK
> 
> >   
> > > 
> > >   
> > > >      }
> > > >  
> > > > -    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
> > > > +    s->cpu = ARM_CPU(cpu_create(cpu_type));
> > > >  
> > > >      memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdram",
> > > >                                           sdram_size);
> > > > diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> > > > index 8b757ff..75631f6 100644
> > > > --- a/hw/arm/tosa.c
> > > > +++ b/hw/arm/tosa.c
> > > > @@ -219,7 +219,6 @@ static struct arm_boot_info tosa_binfo = {
> > > >  
> > > >  static void tosa_init(MachineState *machine)
> > > >  {
> > > > -    const char *cpu_model = machine->cpu_model;
> > > >      const char *kernel_filename = machine->kernel_filename;
> > > >      const char *kernel_cmdline = machine->kernel_cmdline;
> > > >      const char *initrd_filename = machine->initrd_filename;
> > > > @@ -229,9 +228,6 @@ static void tosa_init(MachineState *machine)
> > > >      TC6393xbState *tmio;
> > > >      DeviceState *scp0, *scp1;
> > > >  
> > > > -    if (!cpu_model)
> > > > -        cpu_model = "pxa255";
> > > > -    
> > > 
> > > Don't we need to set mc->default_cpu_type at
> > > tosapda_machine_init() to replace this?  
> > board doesn't actually take user input and above remove code does nothing,
> > look into pxa255_init() where it uses hardcoded cpu model
> >   cpu_generic_init(TYPE_ARM_CPU, "pxa255")
> > 
> > another user connex_init() of pxa255_init() were already cleaned up
> > or didn't have junk to begin with  
> 
> You are right, I didn't notice cpu_model was an unused variable.
> 
> >   
> > > >      mpu = pxa255_init(address_space_mem, tosa_binfo.ram_size);
> > > >  
> > > >      memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);  
> > [...]
> >   
> > > > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > > > index 05c038b..feeeeb2 100644
> > > > --- a/target/arm/cpu.c
> > > > +++ b/target/arm/cpu.c
> > > > @@ -867,7 +867,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
> > > >      }
> > > >  
> > > >      cpuname = g_strsplit(cpu_model, ",", 1);
> > > > -    typename = g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
> > > > +    typename = g_strdup_printf("%s" ARM_CPU_TYPE_SUFFIX, cpuname[0]);    
> > > 
> > > What about doing the same we do in x86 and s390:
> > > 
> > >    g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);  
> > sure
> >   
> 
> I think this and the strncmp() line are the only suggestions that
> I'm still keeping.  But they shouldn't block the series, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Thanks!

I'll do fixups and squash 3/6 into 1/6 as suggested and respin.
