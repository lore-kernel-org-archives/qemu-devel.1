Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzhbW-0008Dj-3G
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzhbS-0000ri-1o
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:12:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzhbR-0000qo-Og
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:12:37 -0400
Date: Wed, 4 Oct 2017 13:12:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171004131232.32f5caae@nial.brq.redhat.com>
In-Reply-To: <CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<2a93b997d0acd369f35d68981a23ba491443daf6.1507059418.git.alistair.francis@xilinx.com>
	<20171003203654.GD4760@localhost.localdomain>
	<CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, 3 Oct 2017 14:41:17 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> On Tue, Oct 3, 2017 at 1:36 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Oct 03, 2017 at 01:05:13PM -0700, Alistair Francis wrote:  
> >> List all possible valid CPU options.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >> ---
> >>
> >>  hw/arm/xlnx-zcu102.c         | 10 ++++++++++
> >>  hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
> >>  include/hw/arm/xlnx-zynqmp.h |  1 +
> >>  3 files changed, 20 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> >> index 519a16ed98..039649e522 100644
> >> --- a/hw/arm/xlnx-zcu102.c
> >> +++ b/hw/arm/xlnx-zcu102.c
> >> @@ -98,6 +98,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
> >>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> >>                                &error_abort);
> >>
> >> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> >> +                            &error_fatal);  
> >
> > Do you have plans to support other CPU types to xlnx_zynqmp in
> > the future?  If not, I wouldn't bother adding the cpu-type
> > property and the extra boilerplate code if it's always going to
> > be set to cortex-a53.  
> 
> No, it'll always be A53.
> 
> I did think of that, but I also wanted to use the new option! I also
> think there is an advantage in sanely handling users '-cpu' option,
> before now we just ignored it, so I think it still does give a
> benefit. That'll be especially important on the Xilinx tree (sometimes
> people use our machines with a different CPU to 'benchmark' or test
> other CPUs with our CoSimulation setup). So I think it does make sense
> to keep in.
if cpu isn't user settable, one could just outright die if cpu_type
is not NULL and say that user's CLI is wrong.
(i.e. don't give users illusion that they allowed to use '-cpu')

> 
> Thanks,
> Alistair
> 
> >
> >  
> >>      object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
> >>                           "ddr-ram", &error_abort);
> >>      object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
> >> @@ -160,6 +162,10 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
> >>      arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
> >>  }
> >>
> >> +const char *xlnx_zynqmp_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a53"),
> >> +                                         NULL
> >> +                                       };
> >> +
> >>  static void xlnx_ep108_init(MachineState *machine)
> >>  {
> >>      XlnxZCU102 *s = EP108_MACHINE(machine);
> >> @@ -185,6 +191,8 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
> >>      mc->block_default_type = IF_IDE;
> >>      mc->units_per_default_bus = 1;
> >>      mc->ignore_memory_transaction_failures = true;
> >> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> >> +    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
> >>  }
> >>
> >>  static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
> >> @@ -240,6 +248,8 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
> >>      mc->block_default_type = IF_IDE;
> >>      mc->units_per_default_bus = 1;
> >>      mc->ignore_memory_transaction_failures = true;
> >> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> >> +    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
> >>  }
> >>
> >>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
> >> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> >> index 2b27daf51d..1bff099ec1 100644
> >> --- a/hw/arm/xlnx-zynqmp.c
> >> +++ b/hw/arm/xlnx-zynqmp.c
> >> @@ -133,13 +133,6 @@ static void xlnx_zynqmp_init(Object *obj)
> >>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
> >>      int i;
> >>
> >> -    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
> >> -        object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
> >> -                          "cortex-a53-" TYPE_ARM_CPU);
> >> -        object_property_add_child(obj, "apu-cpu[*]", OBJECT(&s->apu_cpu[i]),
> >> -                                  &error_abort);
> >> -    }
> >> -
> >>      object_initialize(&s->gic, sizeof(s->gic), gic_class_name());
> >>      qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
> >>
> >> @@ -187,6 +180,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> >>      qemu_irq gic_spi[GIC_NUM_SPI_INTR];
> >>      Error *err = NULL;
> >>
> >> +    /* We need to do this here to ensure the cpu_type property is set. */
> >> +    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
> >> +        object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
> >> +                          s->cpu_type);
> >> +        object_property_add_child(OBJECT(dev), "apu-cpu[*]", OBJECT(&s->apu_cpu[i]),
> >> +                                  &error_abort);
> >> +    }
> >> +
> >>      ram_size = memory_region_size(s->ddr_ram);
> >>
> >>      /* Create the DDR Memory Regions. User friendly checks should happen at
> >> @@ -425,6 +426,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> >>  }
> >>
> >>  static Property xlnx_zynqmp_props[] = {
> >> +    DEFINE_PROP_STRING("cpu-type", XlnxZynqMPState, cpu_type),
> >>      DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
> >>      DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
> >>      DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),
> >> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> >> index 6eff81a995..5afb8de11e 100644
> >> --- a/include/hw/arm/xlnx-zynqmp.h
> >> +++ b/include/hw/arm/xlnx-zynqmp.h
> >> @@ -86,6 +86,7 @@ typedef struct XlnxZynqMPState {
> >>      XlnxDPState dp;
> >>      XlnxDPDMAState dpdma;
> >>
> >> +    char *cpu_type;
> >>      char *boot_cpu;
> >>      ARMCPU *boot_cpu_ptr;
> >>
> >> --
> >> 2.11.0
> >>  
> >
> > --
> > Eduardo  
> 
