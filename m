Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwlFR-0005zc-Gc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwlFN-0004k9-Eu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:29:45 -0400
Date: Tue, 26 Sep 2017 10:29:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170926102936.1a099080@nial.brq.redhat.com>
In-Reply-To: <20170926091928.50e115ff@bahia.lan>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170926025739.GF12504@umbus> <20170926091928.50e115ff@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Tue, 26 Sep 2017 09:19:28 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 26 Sep 2017 12:57:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote:  
> > > The CPU core abstraction belongs to the machine code. This also gets
> > > rid of some code duplication.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > 
> > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> > > but this is already handled by the following cleanup patch:    
> > 
> > I don't really see what the advantage of this is.  As others have
> > pointed out it leads to the host type being registered very late,
> > which could cause problems.
> >   
> 
> Well, the goal was to consolidate the code to register sPAPRCPUCore types in
> the spapr code, instead of open-coding it in spapr_cpu_core.c and kvm.c... 
> 
> But now I realize that delaying the registration even more is a bad idea. And,
> the other way round, registering a static type earlier as asked by Igor would
> require all parent types to be already registered, which seems to be impossible
> to guarantee with the current code.
so I'll leave this code as is for now as as it's a bit of topic
wrt my work on cpu_model removal (or I'll try not to touch it until I have to)

> Maybe we could at least have kvm_ppc_register_host_cpu_type() to call a
> function in spapr_cpu_core.c instead of duplicating the registration code ?
Is it possible for other boards (non core based) to use host CPU?

but for simplicity sake I'd lave it where it's now.

BTW I have an additional question:
what PPC boards are supposed to support KVM/host cpu?

(especially taking in account that aliases get patched to it as well,
which I very much dislike since user asked for one CPU but got another
and when the same happens on another host migration probably would be
screwed up)

> > > 
> > > https://patchwork.ozlabs.org/patch/817598/
> > > ---
> > >  hw/ppc/spapr.c                  |    4 ++++
> > >  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++------------
> > >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> > >  target/ppc/kvm.c                |   12 ------------
> > >  4 files changed, 27 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0ce3ec87ac59..e82c8532ffb0 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *machine)
> > >      }
> > >  
> > >      /* init CPUs */
> > > +    if (kvm_enabled()) {
> > > +        spapr_cpu_core_register_host_type();
> > > +    }
> > > +
> > >      if (machine->cpu_model == NULL) {
> > >          machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
> > >      }
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index c08ee7571a50..6e224ba029ec 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -317,7 +317,7 @@ static Property spapr_cpu_core_properties[] = {
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >  
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      DeviceClass *dc = DEVICE_CLASS(oc);
> > >      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
> > > @@ -337,6 +337,20 @@ static const TypeInfo spapr_cpu_core_type_info = {
> > >      .class_size = sizeof(sPAPRCPUCoreClass),
> > >  };
> > >  
> > > +static void spapr_cpu_core_register_type(const char *model_name)
> > > +{
> > > +    TypeInfo type_info = {
> > > +        .parent = TYPE_SPAPR_CPU_CORE,
> > > +        .instance_size = sizeof(sPAPRCPUCore),
> > > +        .class_init = spapr_cpu_core_class_init,
> > > +        .class_data = (void *) model_name,
> > > +    };
> > > +
> > > +    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, model_name);
> > > +    type_register(&type_info);
> > > +    g_free((void *)type_info.name);
> > > +}
> > > +
> > >  static void spapr_cpu_core_register_types(void)
> > >  {
> > >      int i;
> > > @@ -344,18 +358,14 @@ static void spapr_cpu_core_register_types(void)
> > >      type_register_static(&spapr_cpu_core_type_info);
> > >  
> > >      for (i = 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> > > -        TypeInfo type_info = {
> > > -            .parent = TYPE_SPAPR_CPU_CORE,
> > > -            .instance_size = sizeof(sPAPRCPUCore),
> > > -            .class_init = spapr_cpu_core_class_init,
> > > -            .class_data = (void *) spapr_core_models[i],
> > > -        };
> > > -
> > > -        type_info.name = g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> > > -                                         spapr_core_models[i]);
> > > -        type_register(&type_info);
> > > -        g_free((void *)type_info.name);
> > > +        spapr_cpu_core_register_type(spapr_core_models[i]);
> > >      }
> > > +
> > > +}
> > > +
> > > +void spapr_cpu_core_register_host_type(void)
> > > +{
> > > +    spapr_cpu_core_register_type("host");
> > >  }
> > >  
> > >  type_init(spapr_cpu_core_register_types)
> > > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> > > index 93051e9ecf56..e3e906343048 100644
> > > --- a/include/hw/ppc/spapr_cpu_core.h
> > > +++ b/include/hw/ppc/spapr_cpu_core.h
> > > @@ -36,5 +36,5 @@ typedef struct sPAPRCPUCoreClass {
> > >  } sPAPRCPUCoreClass;
> > >  
> > >  char *spapr_get_cpu_core_type(const char *model);
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> > > +void spapr_cpu_core_register_host_type(void);
> > >  #endif
> > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > index 5b281b2f1b6d..8dd80993ec9e 100644
> > > --- a/target/ppc/kvm.c
> > > +++ b/target/ppc/kvm.c
> > > @@ -37,7 +37,6 @@
> > >  #include "hw/sysbus.h"
> > >  #include "hw/ppc/spapr.h"
> > >  #include "hw/ppc/spapr_vio.h"
> > > -#include "hw/ppc/spapr_cpu_core.h"
> > >  #include "hw/ppc/ppc.h"
> > >  #include "sysemu/watchdog.h"
> > >  #include "trace.h"
> > > @@ -2502,17 +2501,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> > >      oc = object_class_by_name(type_info.name);
> > >      g_assert(oc);
> > >  
> > > -#if defined(TARGET_PPC64)
> > > -    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> > > -    type_info.parent = TYPE_SPAPR_CPU_CORE,
> > > -    type_info.instance_size = sizeof(sPAPRCPUCore);
> > > -    type_info.instance_init = NULL;
> > > -    type_info.class_init = spapr_cpu_core_class_init;
> > > -    type_info.class_data = (void *) "host";
> > > -    type_register(&type_info);
> > > -    g_free((void *)type_info.name);
> > > -#endif
> > > -
> > >      /*
> > >       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
> > >       * we want "POWER8" to be a "family" alias that points to the current
> > >     
> >   
> 
> 
> 
