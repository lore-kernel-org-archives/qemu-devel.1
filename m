Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKr0q-0001kv-V7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKr0l-0007kc-UA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKr0l-0007jA-MI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:57:55 -0400
Date: Tue, 13 Jun 2017 15:57:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170613185752.GZ5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606181948.16238-6-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jun 06, 2017 at 09:19:30PM +0300, Roman Kagan wrote:
> Hyper-V identifies vcpus by the virtual processor (VP) index which is
> normally queried by the guest via HV_X64_MSR_VP_INDEX msr.
> 
> It has to be owned by QEMU in order to preserve it across migration.
> 
> However, the current implementation in KVM doesn't allow to set this
> msr, and KVM uses its own notion of VP index.  Fortunately, the way
> vcpus are created in QEMU/KVM basically guarantees that the KVM value is
> equal to QEMU cpu_index.

This might not be true in the future.  cpu_index is not a good
identifier for CPUs, and we would like to remove it in the
future.

But it looks like we have no choice, see extra comments below:

> 
> So, for back and forward compatibility, attempt to set the msr at vcpu
> init time to cpu_index, but ignore the errors; then query the msr value
> from KVM and assert that it's equal to cpu_index.  On current kernels
> this will work by luck; future ones will accept the value from
> userspace.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  target/i386/hyperv.h |  2 ++
>  target/i386/hyperv.c |  5 +++++
>  target/i386/kvm.c    | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
> index 0c3b562..35da0b1 100644
> --- a/target/i386/hyperv.h
> +++ b/target/i386/hyperv.h
> @@ -39,4 +39,6 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
>  
>  int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
>  
> +uint32_t hyperv_vp_index(X86CPU *cpu);
> +
>  #endif
> diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
> index 227185c..27de5bc 100644
> --- a/target/i386/hyperv.c
> +++ b/target/i386/hyperv.c
> @@ -16,6 +16,11 @@
>  #include "hyperv.h"
>  #include "hyperv_proto.h"
>  
> +uint32_t hyperv_vp_index(X86CPU *cpu)
> +{
> +    return CPU(cpu)->cpu_index;
> +}
> +

You are introducing a wrapper, but you are using cs->cpu_index
directly at hyperv_set_vp_index().  The knowledge that vp_index
== cpu_index is duplicated on two places, and the functions risk
getting out of sync.

I suggest using the wrapper inside hyperv_set_vp_index() too.


>  int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>  {
>      CPUX86State *env = &cpu->env;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 251aa95..eb9cde4 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -610,11 +610,37 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
>      return 0;
>  }
>  
> +static void hyperv_set_vp_index(CPUState *cs)
> +{
> +    struct {
> +        struct kvm_msrs info;
> +        struct kvm_msr_entry entries[1];
> +    } msr_data;
> +    int ret;
> +
> +    msr_data.info.nmsrs = 1;
> +    msr_data.entries[0].index = HV_X64_MSR_VP_INDEX;
> +
> +    /*
> +     * Some kernels don't support setting HV_X64_MSR_VP_INDEX.  However,
> +     * they use VP_INDEX equal to cpu_index due to the way vcpus are created.
> +     * So ignore the errors from SET_MSRS, but verify that GET_MSRS returns the
> +     * expected value.
> +     */

Oh.  This sounds like a problem.  As reference for others, this
is the KVM code in kvm_hv_get_msr():

	case HV_X64_MSR_VP_INDEX: {
		int r;
		struct kvm_vcpu *v;

		kvm_for_each_vcpu(r, v, vcpu->kvm) {
			if (v == vcpu) {
				data = r;
				break;
			}
		}
		break;
	}

The problem with that is that it will break as soon as we create
VCPUs in a different order.  Unsolvable on hosts that don't allow
HV_X64_MSR_VP_INDEX to be set, however.

> +    msr_data.entries[0].data = cs->cpu_index;
> +    kvm_vcpu_ioctl(cs, KVM_SET_MSRS, &msr_data);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_MSRS, &msr_data);
> +    assert(ret == 1);
> +    assert(msr_data.entries[0].data == cs->cpu_index);

If KVM already initializes the MSR to cpu_index and we will abort
if it was not set to anything except cpu_index here, why exactly
do we need the KVM_SET_MSRS call?

> +}
> +
>  static int hyperv_handle_properties(CPUState *cs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
>  
> +    hyperv_set_vp_index(cs);
> +

The purpose of hyperv_handle_properties() is just to initialize
cpu->features[] CPUID data based on the hyperv options.  I suggest
creating a new hyperv_vcpu_init() or x86_cpu_hyperv_init()
function for these initialization steps.

>      if (cpu->hyperv_time &&
>              kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <= 0) {
>          cpu->hyperv_time = false;
> -- 
> 2.9.4
> 

-- 
Eduardo
