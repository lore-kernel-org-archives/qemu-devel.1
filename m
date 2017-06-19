Received: from eggs.gnu.org ([2001:4830:134:3::10]:45650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMzJd-0005Ov-P1
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMzJb-00043C-0g
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:14:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMzJa-00042s-O7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9B8E23E6C5
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:14:08 +0000 (UTC)
Date: Mon, 19 Jun 2017 13:14:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619161403.GU5016@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-7-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497876588-947-7-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/13] kvm: let kvm use
 AccelState.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 19, 2017 at 08:49:41PM +0800, Peter Xu wrote:
> Let KVM be the first user of the new AccelState.global_props field.
> Basically kvm accel only contains accel props for TYPE_X86_CPUs but not
> anything else yet.
> 
> There will be a change on how these global properties are applied for
> TYPE_X86_CPU devices. The general workflow of the global property stuff
> for TYPE_X86_CPU devices can be simplied as following (this is a example
> routine of KVM that contains both old/new workflow, similar thing apply
> to TCG, but even simpler):
> 
>    - HW_COMPAT/type_init() magic played before even entering main() [1]

What do you mean by this?  HW_COMPAT_* is used only in
MachineClass::compat_props[4], and type_init() magic is triggered
by module_call_init(MODULE_INIT_QOM) in main().

>    - main() in vl.c
>      - configure_accelerator()
>        - AccelClass.init_machine() [2]
>          - kvm_init() (for KVM accel)
>      - register global properties
>        - accel_register_compat_props(): register accel compat props [3]
>        - machine_register_compat_props(): register machine compat
>          props (here we'll apply all the HW_COMPAT magic into
>          global_props) [4]
>      - machine init()
>        - cpu init() [5]
>        - ...
> 
> Before this patch, the code setup TYPE_X86_CPU properties at [4] by
> keeping the kvm_default_props list and apply them directly to the device
> using x86_cpu_apply_props().
> 
> After this patch, the code setup the same properties in the sequence of
> [1]->[2]->[3][4]->[5]:
> 
>   - At [1] we setup machine global properties.  Note: there will be
>     properties that with value==NULL but it's okay - when it was applied
>     to global list, it'll be used to remove an entry at step [4], it
>     works just like the old kvm_default_props, but we just unified it to
>     a single place, which is the global_props list.
> 
>   - At [2] we setup accel global properties.

Why isn't AccelClass::global_props set up at class_init(), just
like we do on MachineClass::compat_props?

> 
>   - At [3]/[4] we move machine/accel properties into global property
>     list. One thing to mention is that, we do [3] before [4], since we
>     have some cross-relation properties, e.g., property that is required
>     when both PC=2.1 && ACCEL=kvm happen. For now, all this kind of
>     properties are still in machine compat properties.
> 
>   - At [5] when TYPE_X86_CPU creates, it applies the global property from
>     the global property list, which is now a merged list of three: accel
>     property list, machine property list, and user specified "-global"
>     properties.

On which category above would the x86_cpu_change_kvm_default()
calls in pc_piix.c would be?  We would need to ensure they
override the globals registered by the accel code, but they must
not override the user-provided global properties (including
-global and -cpu options).

This is where things get tricky and fragile: the translation from
-cpu to global properties is done very late inside machine init
today, but we should be able to do that much earlier, once we
refactor the -cpu parsing code.

Hence my suggestion is to not touch x86_cpu_change_kvm_default()
and just move the other properties (everything in
kvm_default_props except svm, x2apic, and kvm-pv-eoi) to a static
AccelClass::global_props field.

> 
> So it's getting more complex in workflow, but better modulized.
> 
> After the refactoring, x86_cpu_change_kvm_default() is moved directly to
> pc_piix.c since that'll be the only place to use it, also it is
> rewritten to use the global property APIs.
> 
> One defect is that we hard coded TYPE_X86_CPU (both of its definitions,
> for 32/64 bits) in accel_register_x86_cpu_props(). Comment explains
> itself.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel.c                | 22 ++++++++++++++++++++++
>  hw/i386/pc_piix.c      |  8 ++++++++
>  include/sysemu/accel.h |  9 +++++++++
>  kvm-all.c              | 30 ++++++++++++++++++++++++++++++
>  target/i386/cpu.c      | 42 +-----------------------------------------
>  target/i386/cpu.h      | 11 -----------
>  vl.c                   |  5 +++++
>  7 files changed, 75 insertions(+), 52 deletions(-)
> 
> diff --git a/accel.c b/accel.c
> index f747d65..ca1d0f5 100644
> --- a/accel.c
> +++ b/accel.c
> @@ -130,6 +130,28 @@ void configure_accelerator(MachineState *ms)
>      }
>  }
>  
> +void accel_register_prop(AccelState *accel, const char *driver,
> +                         const char *prop, const char *value)
> +{
> +    accel->global_props = global_prop_list_add(accel->global_props,
> +                                               driver, prop,
> +                                               value, false);
> +}

I don't think we need yet another layer of indirection where
global properties are registered at runtime in AccelState before
being actually registered as global properties.

I expected this to be

  void accel_class_append_global_prop(AccelClass *acc,
                                      const char *driver,
                                      const char *prop,
                                      const char *value);

And the only places calling accel_class_append_global_prop()
would be the accel classes' class_init functions.

I would even consider making AccelClass::global_props an array,
instead of a linked list.  It would help making sure the data is
really static.

> +
> +void accel_register_x86_cpu_props(AccelState *accel, const char *prop,
> +                                  const char *value)
> +{
> +    /*
> +     * We hard-coded this for x86 cpus, trying to match TYPE_X86_CPU.
> +     * We cannot just use TYPE_X86_CPU since that's target-dependent
> +     * while accel.c is target-independent. For x86 platform, only one
> +     * of below two lines will be used, but it does not hurt to
> +     * register both. On non-x86 platforms, none of them are used.
> +     */
> +    accel_register_prop(accel, "i386-cpu", prop, value);
> +    accel_register_prop(accel, "x86_64-cpu", prop, value);

I don't know why we need this helper.  The list of
(driver, property, value) tuples could be hardcoded inside the
initialization of AccelClass::global_props, just like we already
do in MachineClass::compat_props.

> +}
> +
>  static void accel_prop_pass_to_global(gpointer data, gpointer user_data)
>  {
>      GlobalProperty *prop = data;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 46a2bc4..d1d8979 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -304,6 +304,14 @@ static void pc_init1(MachineState *machine,
>      }
>  }
>  
> +static void x86_cpu_change_kvm_default(const char *prop,
> +                                       const char *value)
> +{
> +    if (kvm_enabled()) {
> +        register_compat_prop(TYPE_X86_CPU, prop, value, false);
> +    }

This will be called very late, and can override -cpu options if
we refactor -cpu option parsing in the future.

(It is hard to ensure we have the ordering right if we have too
many register_compat_prop() calls scattered around the code.)


> +}
> +
>  /* Looking for a pc_compat_2_4() function? It doesn't exist.
>   * pc_compat_*() functions that run on machine-init time and
>   * change global QEMU state are deprecated. Please don't create
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 83bb60e..ee2fbad 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -65,8 +65,17 @@ typedef struct AccelClass {
>  
>  extern int tcg_tb_size;
>  
> +typedef struct AccelPropValue {
> +    const char *prop, *value;

Why not add a "driver" field here?

> +} AccelPropValue;
> +
>  void configure_accelerator(MachineState *ms);
>  /* Register accelerator specific global properties */
>  void accel_register_compat_props(AccelState *accel);
> +/* Register single global property to the AccessState property list */
> +void accel_register_prop(AccelState *accel, const char *driver,
> +                         const char *prop, const char *value);
> +void accel_register_x86_cpu_props(AccelState *accel, const char *prop,
> +                                  const char *value);
>  
>  #endif
> diff --git a/kvm-all.c b/kvm-all.c
> index ab8262f..ef60ddf 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1564,6 +1564,34 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
>      return vcpu_id >= 0 && vcpu_id < kvm_max_vcpu_id(s);
>  }
>  
> +static AccelPropValue x86_kvm_default_props[] = {
> +    { "kvmclock", "on" },
> +    { "kvm-nopiodelay", "on" },
> +    { "kvm-asyncpf", "on" },
> +    { "kvm-steal-time", "on" },
> +    { "kvm-pv-eoi", "on" },
> +    { "kvmclock-stable-bit", "on" },
> +    { "x2apic", "on" },
> +    { "acpi", "off" },
> +    { "monitor", "off" },
> +    { "svm", "off" },
> +    { NULL, NULL },

If we add a 'driver' field here, we won't need the
accel_register_x86_cpu_props() helper anymore.

> +};
> +
> +static void kvm_register_accel_props(KVMState *kvm)
> +{
> +    AccelState *accel = ACCEL(kvm);
> +    AccelPropValue *entry;
> +
> +    for (entry = x86_kvm_default_props; entry->prop; entry++) {
> +        accel_register_x86_cpu_props(accel, entry->prop, entry->value);
> +    }

I suggest:

* Moving the list inside AccelClass instead of AccelState.
* Doing this inside kvm_accel_class_init() instead.
* Not dealing with x2apic right now, as its rules are more
  complex.

> +
> +    if (!kvm_irqchip_in_kernel()) {
> +        accel_register_x86_cpu_props(accel, "x2apic", "off");
> +    }
> +}
> +
>  static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -1776,6 +1804,8 @@ static int kvm_init(MachineState *ms)
>  
>      cpu_interrupt_handler = kvm_handle_interrupt;
>  
> +    kvm_register_accel_props(s);
> +
>      return 0;
>  
>  err:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1bd20e2..5214fba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1484,23 +1484,6 @@ typedef struct PropValue {
>      const char *prop, *value;
>  } PropValue;
>  
> -/* KVM-specific features that are automatically added/removed
> - * from all CPU models when KVM is enabled.
> - */
> -static PropValue kvm_default_props[] = {
> -    { "kvmclock", "on" },
> -    { "kvm-nopiodelay", "on" },
> -    { "kvm-asyncpf", "on" },
> -    { "kvm-steal-time", "on" },
> -    { "kvm-pv-eoi", "on" },
> -    { "kvmclock-stable-bit", "on" },
> -    { "x2apic", "on" },
> -    { "acpi", "off" },
> -    { "monitor", "off" },
> -    { "svm", "off" },
> -    { NULL, NULL },
> -};
> -
>  /* TCG-specific defaults that override all CPU models when using TCG
>   */
>  static PropValue tcg_default_props[] = {
> @@ -1508,23 +1491,6 @@ static PropValue tcg_default_props[] = {
>      { NULL, NULL },
>  };
>  
> -
> -void x86_cpu_change_kvm_default(const char *prop, const char *value)
> -{
> -    PropValue *pv;
> -    for (pv = kvm_default_props; pv->prop; pv++) {
> -        if (!strcmp(pv->prop, prop)) {
> -            pv->value = value;
> -            break;
> -        }
> -    }
> -
> -    /* It is valid to call this function only for properties that
> -     * are already present in the kvm_default_props table.
> -     */
> -    assert(pv->prop);
> -}
> -
>  static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
>                                                     bool migratable_only);
>  
> @@ -2335,13 +2301,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>      }
>  
>      /* Special cases not set in the X86CPUDefinition structs: */
> -    if (kvm_enabled()) {
> -        if (!kvm_irqchip_in_kernel()) {
> -            x86_cpu_change_kvm_default("x2apic", "off");
> -        }
> -
> -        x86_cpu_apply_props(cpu, kvm_default_props);
> -    } else if (tcg_enabled()) {
> +    if (tcg_enabled()) {
>          x86_cpu_apply_props(cpu, tcg_default_props);
>      }
>  
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index de0551f..93aebfb 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1669,17 +1669,6 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
>  void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
>                                     TPRAccess access);
>  
> -
> -/* Change the value of a KVM-specific default
> - *
> - * If value is NULL, no default will be set and the original
> - * value from the CPU model table will be kept.
> - *
> - * It is valid to call this function only for properties that
> - * are already present in the kvm_default_props table.
> - */
> -void x86_cpu_change_kvm_default(const char *prop, const char *value);
> -
>  /* mpx_helper.c */
>  void cpu_sync_bndcs_hflags(CPUX86State *env);
>  
> diff --git a/vl.c b/vl.c
> index d3f5594..a564139 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4553,6 +4553,11 @@ int main(int argc, char **argv, char **envp)
>              exit (i == 1 ? 1 : 0);
>      }
>  
> +    /*
> +     * Here we need to first register accelerator compat properties
> +     * then machine properties, since cross-relationed properties are
> +     * setup in machine compat bits.
> +     */
>      accel_register_compat_props(current_machine->accelerator);
>      machine_register_compat_props(current_machine);

Note for later: It would be very nice if this was the only place
in the code where qdev_prop_register_global()/register_compat_prop()
is called.  Probably a register_user_provided_compat_props() call
here would make sure the ordering is always right.

-- 
Eduardo
