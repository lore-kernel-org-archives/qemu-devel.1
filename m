Received: from eggs.gnu.org ([2001:4830:134:3::10]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKqeJ-0003JE-8b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKqeF-0007gf-8V
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:34:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKqeE-0007gZ-VS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:34:39 -0400
Date: Tue, 13 Jun 2017 15:34:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170613183434.GY5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-14-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606181948.16238-14-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 13/23] hyperv: qdev-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Tue, Jun 06, 2017 at 09:19:38PM +0300, Roman Kagan wrote:
> Make Hyper-V SynIC a device which is attached as a child to X86CPU.  For
> now it only makes SynIC visibile in the qom hierarchy and exposes a few
> properties which are maintained in sync with the respecitve msrs of the
> parent cpu.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  target/i386/hyperv.h  |   4 ++
>  target/i386/hyperv.c  | 131 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/kvm.c     |   5 ++
>  target/i386/machine.c |   9 ++++
>  4 files changed, 147 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
> index ca5a32d..9dd5ca0 100644
> --- a/target/i386/hyperv.h
> +++ b/target/i386/hyperv.h
> @@ -34,4 +34,8 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
>  uint32_t hyperv_vp_index(X86CPU *cpu);
>  X86CPU *hyperv_find_vcpu(uint32_t vcpu_id);
>  
> +void hyperv_synic_add(X86CPU *cpu);
> +void hyperv_synic_reset(X86CPU *cpu);
> +void hyperv_synic_update(X86CPU *cpu);
> +
>  #endif
> diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
> index ae67f82..2d9e9fe 100644
> --- a/target/i386/hyperv.c
> +++ b/target/i386/hyperv.c
> @@ -13,12 +13,27 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
>  #include "hyperv.h"
>  #include "hyperv_proto.h"
>  
> +typedef struct SynICState {
> +    DeviceState parent_obj;
> +
> +    X86CPU *cpu;
> +
> +    bool enabled;
> +    hwaddr msg_page_addr;
> +    hwaddr evt_page_addr;
> +} SynICState;
> +
> +#define TYPE_SYNIC "hyperv-synic"
> +#define SYNIC(obj) OBJECT_CHECK(SynICState, (obj), TYPE_SYNIC)
> +
>  struct HvSintRoute {
>      uint32_t sint;
> -    X86CPU *cpu;
> +    SynICState *synic;
>      int gsi;
>      EventNotifier sint_set_notifier;
>      EventNotifier sint_ack_notifier;
> @@ -37,6 +52,37 @@ X86CPU *hyperv_find_vcpu(uint32_t vp_index)
>      return X86_CPU(qemu_get_cpu(vp_index));
>  }
>  
> +static SynICState *get_synic(X86CPU *cpu)
> +{
> +    SynICState *synic =
> +        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
> +    assert(synic);
> +    return synic;

How often this will run?  I think a new X86CPU struct field would
be acceptable to avoid resolving a QOM path on every hyperv exit.

Do you even need QOM for this?

> +}
> +
> +static void synic_update_msg_page_addr(SynICState *synic)
> +{
> +    uint64_t msr = synic->cpu->env.msr_hv_synic_msg_page;
> +    hwaddr new_addr = (msr & HV_SIMP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
> +
> +    synic->msg_page_addr = new_addr;
> +}
> +
> +static void synic_update_evt_page_addr(SynICState *synic)
> +{
> +    uint64_t msr = synic->cpu->env.msr_hv_synic_evt_page;
> +    hwaddr new_addr = (msr & HV_SIEFP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
> +
> +    synic->evt_page_addr = new_addr;
> +}
> +
> +static void synic_update(SynICState *synic)
> +{
> +    synic->enabled = synic->cpu->env.msr_hv_synic_control & HV_SYNIC_ENABLE;
> +    synic_update_msg_page_addr(synic);
> +    synic_update_evt_page_addr(synic);
> +}
> +
>  int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>  {
>      CPUX86State *env = &cpu->env;
> @@ -65,6 +111,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>          default:
>              return -1;
>          }
> +        synic_update(get_synic(cpu));
>          return 0;
>      case KVM_EXIT_HYPERV_HCALL: {
>          uint16_t code;
> @@ -95,10 +142,13 @@ HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
>                                     HvSintAckClb sint_ack_clb,
>                                     void *sint_ack_clb_data)
>  {
> +    SynICState *synic;
>      HvSintRoute *sint_route;
>      EventNotifier *ack_notifier;
>      int r, gsi;
>  
> +    synic = get_synic(cpu);
> +
>      sint_route = g_new0(HvSintRoute, 1);
>      r = event_notifier_init(&sint_route->sint_set_notifier, false);
>      if (r) {
> @@ -129,7 +179,7 @@ HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
>      sint_route->gsi = gsi;
>      sint_route->sint_ack_clb = sint_ack_clb;
>      sint_route->sint_ack_clb_data = sint_ack_clb_data;
> -    sint_route->cpu = cpu;
> +    sint_route->synic = synic;
>      sint_route->sint = sint;
>      sint_route->refcount = 1;
>  
> @@ -183,3 +233,80 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
>  {
>      return event_notifier_set(&sint_route->sint_set_notifier);
>  }
> +
> +static Property synic_props[] = {
> +    DEFINE_PROP_BOOL("enabled", SynICState, enabled, false),
> +    DEFINE_PROP_UINT64("msg-page-addr", SynICState, msg_page_addr, 0),
> +    DEFINE_PROP_UINT64("evt-page-addr", SynICState, evt_page_addr, 0),

What do you need the QOM properties for?  Are they supposed to be
configurable by the user?  Are they supposed to be queried from
outside QEMU?  On which cases?


> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void synic_realize(DeviceState *dev, Error **errp)
> +{
> +    Object *obj = OBJECT(dev);
> +    SynICState *synic = SYNIC(dev);
> +
> +    synic->cpu = X86_CPU(obj->parent);
> +}
> +
> +static void synic_reset(DeviceState *dev)
> +{
> +    SynICState *synic = SYNIC(dev);
> +    synic_update(synic);
> +}
> +
> +static void synic_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = synic_props;
> +    dc->realize = synic_realize;
> +    dc->reset = synic_reset;
> +    dc->user_creatable = false;
> +}
> +
> +void hyperv_synic_add(X86CPU *cpu)
> +{
> +    Object *obj;
> +
> +    if (!cpu->hyperv_synic) {
> +        return;
> +    }
> +
> +    obj = object_new(TYPE_SYNIC);
> +    object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
> +    object_unref(obj);
> +    object_property_set_bool(obj, true, "realized", &error_abort);
> +}
> +
> +void hyperv_synic_reset(X86CPU *cpu)
> +{
> +    if (!cpu->hyperv_synic) {
> +        return;
> +    }
> +
> +    device_reset(DEVICE(get_synic(cpu)));
> +}
> +
> +void hyperv_synic_update(X86CPU *cpu)
> +{
> +    if (!cpu->hyperv_synic) {
> +        return;
> +    }
> +
> +    synic_update(get_synic(cpu));
> +}
> +
> +static const TypeInfo synic_type_info = {
> +    .name = TYPE_SYNIC,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(SynICState),
> +    .class_init = synic_class_init,
> +};
> +
> +static void synic_register_types(void)
> +{
> +    type_register_static(&synic_type_info);
> +}
> +
> +type_init(synic_register_types)
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index eb9cde4..433c912 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -688,6 +688,9 @@ static int hyperv_handle_properties(CPUState *cs)
>          }
>          env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
>      }
> +
> +    hyperv_synic_add(cpu);
> +

The purpose of hyperv_handle_properties() is to just initialize
env->features based on hyperv flags, and it might even go away
some day.  I suggest moving this to x86_cpu_realizefn().

>      return 0;
>  }
>  
> @@ -1065,6 +1068,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
>          for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
>              env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
>          }
> +
> +        hyperv_synic_reset(cpu);
>      }
>  }
>  
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index eb00b19..8022c24 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -7,6 +7,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/isa/isa.h"
>  #include "migration/cpu.h"
> +#include "hyperv.h"
>  
>  #include "sysemu/kvm.h"
>  
> @@ -633,11 +634,19 @@ static bool hyperv_synic_enable_needed(void *opaque)
>      return false;
>  }
>  
> +static int hyperv_synic_post_load(void *opaque, int version_id)
> +{
> +    X86CPU *cpu = opaque;
> +    hyperv_synic_update(cpu);
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_msr_hyperv_synic = {
>      .name = "cpu/msr_hyperv_synic",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = hyperv_synic_enable_needed,
> +    .post_load = hyperv_synic_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
>          VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
> -- 
> 2.9.4
> 

-- 
Eduardo
