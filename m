Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Nz1-0007To-Jg
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Nyx-0007hn-1H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:27:47 -0400
Date: Fri, 6 Oct 2017 10:27:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006102738.06b23f3f@nial.brq.redhat.com>
In-Reply-To: <20171006030256.GF3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-5-git-send-email-imammedo@redhat.com>
	<20171006030256.GF3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/23] ppc: mpc8544ds/e500plat: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

On Fri, 6 Oct 2017 14:02:56 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 05, 2017 at 06:24:31PM +0200, Igor Mammedov wrote:
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Do you want me to queue the ppc patches here, or do you already have a
> plan for that?
Id didn't want to distract others with only PPC related code so
I've posted this series separately for you to merge it via PPC tree


> 
> > ---
> >  hw/ppc/e500.c      | 8 +-------
> >  hw/ppc/e500plat.c  | 1 +
> >  hw/ppc/mpc8544ds.c | 2 ++
> >  3 files changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > index db0e49a..9178e70 100644
> > --- a/hw/ppc/e500.c
> > +++ b/hw/ppc/e500.c
> > @@ -803,11 +803,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
> >      SysBusDevice *s;
> >      PPCE500CCSRState *ccsr;
> >  
> > -    /* Setup CPUs */
> > -    if (machine->cpu_model == NULL) {
> > -        machine->cpu_model = "e500v2_v30";
> > -    }
> > -
> >      irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
> >      irqs[0] = g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
> >      for (i = 0; i < smp_cpus; i++) {
> > @@ -815,8 +810,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
> >          CPUState *cs;
> >          qemu_irq *input;
> >  
> > -        cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> > -                                           machine->cpu_model));
> > +        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> >          env = &cpu->env;
> >          cs = CPU(cpu);
> >  
> > diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> > index 94b4545..e59e80f 100644
> > --- a/hw/ppc/e500plat.c
> > +++ b/hw/ppc/e500plat.c
> > @@ -64,6 +64,7 @@ static void e500plat_machine_init(MachineClass *mc)
> >      mc->init = e500plat_init;
> >      mc->max_cpus = 32;
> >      mc->has_dynamic_sysbus = true;
> > +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
> >  }
> >  
> >  DEFINE_MACHINE("ppce500", e500plat_machine_init)
> > diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> > index 27b8289..1717953 100644
> > --- a/hw/ppc/mpc8544ds.c
> > +++ b/hw/ppc/mpc8544ds.c
> > @@ -16,6 +16,7 @@
> >  #include "sysemu/device_tree.h"
> >  #include "hw/ppc/openpic.h"
> >  #include "qemu/error-report.h"
> > +#include "cpu.h"
> >  
> >  static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
> >  {
> > @@ -55,6 +56,7 @@ static void ppce500_machine_init(MachineClass *mc)
> >      mc->desc = "mpc8544ds";
> >      mc->init = mpc8544ds_init;
> >      mc->max_cpus = 15;
> > +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
> >  }
> >  
> >  DEFINE_MACHINE("mpc8544ds", ppce500_machine_init)  
> 
