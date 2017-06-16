Received: from eggs.gnu.org ([2001:4830:134:3::10]:45017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLsKo-0007QZ-T1
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLsKi-0005J4-AF
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:34:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLsKi-0005Ia-1A
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:34:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 087DD4ACB3
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 14:34:42 +0000 (UTC)
Date: Fri, 16 Jun 2017 11:34:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170616143432.GO5016@thinpad.lan.raisama.net>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-4-git-send-email-peterx@redhat.com>
	<20170609134010.GK22043@thinpad.lan.raisama.net>
	<20170612081356.GD12928@pxdev.xzpeter.org>
	<20170613034102.GA11751@pxdev.xzpeter.org>
	<20170613111635.GU5016@thinpad.lan.raisama.net>
	<20170616075820.GE30118@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616075820.GE30118@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: move
 global_state.optional out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 16, 2017 at 03:58:20PM +0800, Peter Xu wrote:
> On Tue, Jun 13, 2017 at 08:16:35AM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 13, 2017 at 11:41:02AM +0800, Peter Xu wrote:
> > > On Mon, Jun 12, 2017 at 04:18:06PM +0800, Peter Xu wrote:
> > > > On Fri, Jun 09, 2017 at 10:40:10AM -0300, Eduardo Habkost wrote:
> > > > > On Fri, Jun 09, 2017 at 11:48:59AM +0800, Peter Xu wrote:
> > > > > > Put it into MigrationState then we can use the properties to specify
> > > > > > whether to enable storing global state.
> > > > > > 
> > > > > > Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
> > > > > > for x86/power in general, and the register_compat_prop() for xen_init().
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > [...]
> > > > > > diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> > > > > > index 0bed577..8240d50 100644
> > > > > > --- a/hw/xen/xen-common.c
> > > > > > +++ b/hw/xen/xen-common.c
> > > > > > @@ -138,7 +138,13 @@ static int xen_init(MachineState *ms)
> > > > > >      }
> > > > > >      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> > > > > >  
> > > > > > -    global_state_set_optional();
> > > > > > +    /*
> > > > > > +     * TODO: make sure global MigrationState has not yet been created
> > > > > > +     * (otherwise the compat trick won't work). For now we are in
> > > > > > +     * configure_accelerator() so we are mostly good. Better to
> > > > > > +     * confirm that in the future.
> > > > > > +     */
> > > > > 
> > > > > So, this makes accelerator initialization very sensitive to
> > > > > ordering.
> > > > > 
> > > > > > +    register_compat_prop("migration", "store-global-state", "off");
> > > > > 
> > > > > It's already hard to track down machine-type stuff that is
> > > > > initialized at machine->init() time but it's not introspectable,
> > > > > let's not do the same mistake with accelerators.
> > > > > 
> > > > > Can't this be solved by a AcceleratorClass::global_props field,
> > > > > so we are sure there's a single place in the code where globals
> > > > > are registered?  (Currently, they are all registered by the few
> > > > > lines around the machine_register_compat_props() call in main()).
> > > > > 
> > > > > I think I see other use cases for a new
> > > > > AcceleratorClass::global_props field.  e.g.: replacing
> > > > > kvm_default_props and tcg_default_props in target/i386/cpu.c.
> > > > 
> > > > Hmm, this sounds nice.  Then we can also get rid of the TODO above.
> > > > 
> > > > Thanks for your suggestion and review! I'll see whether I can writeup
> > > > something as RFC for this.
> > > 
> > > After a second thought, I see these requirements are slightly
> > > different.
> > > 
> > > For xen_init(), AccelClass::global_props may help since that's mainly
> > > properties to be setup for TYPE_MIGRATION (let's assume it's okay that
> > > MigrationState can be a QDev).
> > > 
> > > For kvm_default_props and tcg_default_props, AccelClass::global_props
> > > may not help since they are setting up properties for TYPE_CPU, and
> > > TYPE_CPU cannot really use global property features yet. :(
> > 
> > TYPE_CPU can use global properties, for sure.  TYPE_CPU is a
> > TYPE_DEVICE subclass, and -cpu is implemented internally using
> > global properties.
> 
> Hi, Eduardo,
> 
> I'm working on providing a AccelState.global_props, then let KVM/TCG
> to use it to handle X86_CPU properties there.  However, I stuck at a
> point where TCG/KVM cannot know what is the macro "TYPE_X86_CPU"
> (since it's only there on X86).  The change is something like this (it
> cannot be applied directly to master since it's only one patch among
> my series, it is used to show what I am doing and the problem):

Unfortunately TYPE_X86_CPU macro is arch-specific because it may
be expanded to "x86_64-cpu" or "i386-cpu" depending on the QEMU
target.  So it actually represents two different classes, because
the target/i386/cpu.c code is compiled twice (once for i386 and
once for x86_64).

In this case, you will need two entries on the tcg default
property list:

  x86_64-cpu.vme=off
  i386-cpu.vme=off

Now, we could hardcode the class names, or provide TYPE_I386_CPU
and TYPE_X86_64_CPU macros from a header available to generic
code[1].  I don't know what's the best solution.

[1] i.e. not cpu.h. I was going to suggest including
    "target/i386/cpu-qom.h", but I'm not sure if
    it can be safely included by generic code.

> 
> --8<--
> diff --git a/accel.c b/accel.c
> index 82b318c..db503b6 100644
> --- a/accel.c
> +++ b/accel.c
> @@ -34,13 +34,34 @@
>  #include "sysemu/qtest.h"
>  #include "hw/xen/xen.h"
>  #include "qom/object.h"
> +#if TARGET_I386
> +#include "target/i386/cpu-qom.h"
> +#endif
> 
>  int tcg_tb_size;
>  static bool tcg_allowed = true;
> 
> +static AccelPropValue x86_tcg_default_props[] = {
> +    { "vme", "off" },
> +    { NULL, NULL },

You need a "driver" (type) field too.  I suggest using struct
GlobalProperty like we do on MachineClass.

> +};
> +
> +static void tcg_register_accel_props(AccelState *accel)
> +{
> +#if TARGET_I386
> +    AccelPropValue *entry;
> +
> +    for (entry = x86_tcg_default_props; entry->prop; entry++) {
> +        global_property_list_register(accel->global_props, TYPE_X86_CPU,
> +                                      entry->prop, entry->value, false);
> +    }
> +#endif
> +}
> +
>  static int tcg_init(MachineState *ms)
>  {
>      tcg_exec_init(tcg_tb_size * 1024 * 1024);
> +    tcg_register_accel_props(ms->accelerator);
>      return 0;
>  }
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5214fba..89f67b0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1480,17 +1480,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>      },
>  };
> 
> -typedef struct PropValue {
> -    const char *prop, *value;
> -} PropValue;
> -
> -/* TCG-specific defaults that override all CPU models when using TCG
> - */
> -static PropValue tcg_default_props[] = {
> -    { "vme", "off" },
> -    { NULL, NULL },
> -};
> -
>  static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
>                                                     bool migratable_only);
> 
> @@ -2262,18 +2251,6 @@ static void x86_cpu_report_filtered_features(X86CPU *cpu)
>      }
>  }
> 
> -static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
> -{
> -    PropValue *pv;
> -    for (pv = props; pv->prop; pv++) {
> -        if (!pv->value) {
> -            continue;
> -        }
> -        object_property_parse(OBJECT(cpu), pv->value, pv->prop,
> -                              &error_abort);
> -    }
> -}
> -
>  /* Load data from X86CPUDefinition into a X86CPU object
>   */
>  static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
> @@ -2300,11 +2277,6 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>          env->features[w] = def->features[w];
>      }
> 
> -    /* Special cases not set in the X86CPUDefinition structs: */
> -    if (tcg_enabled()) {
> -        x86_cpu_apply_props(cpu, tcg_default_props);
> -    }
> -
>      env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
> 
>      /* sysenter isn't supported in compatibility mode on AMD,
> -->8--
> 
> What above patch did is something like "moving x86_cpu properties from
> x86 CPU codes into tcg" (I am using tcg as example, kvm is more
> complex but has similar issue).
> 
> Here the general problem is that, there are some properties to be
> applied when both conditions match:
> 
> - target is X86 (so using X86 cpus)
> - accel is tcg
> 
> In the old code, it works since in x86 cpu.c codes we can use this:
> 
>   if (tcg_enabled()) {
>       x86_cpu_apply_props(cpu, tcg_default_props);
>   }
> 
> to know "whether accel is TCG". However I cannot do similar thing in
> TCG code to know "whether target is x86". (I was trying to use
> TARGET_I386 but it was poisoned, of course...)
> 
> Any thoughts? (Markus/Paolo/others?)

You don't need to make the property conditional on the target, if
you just use the right class name on the "driver' field.

-- 
Eduardo
