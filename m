Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRI8a-0006lj-EK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRI8U-0004Kf-EY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gRI8U-0004II-1O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:45:18 -0500
Date: Mon, 26 Nov 2018 15:45:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181126154503.291d395a@redhat.com>
In-Reply-To: <20180921082217.29481-4-rkagan@virtuozzo.com>
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<20180921082217.29481-4-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] hyperv: only add SynIC in compatible
 configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Fri, 21 Sep 2018 11:22:10 +0300
Roman Kagan <rkagan@virtuozzo.com> wrote:

> Certain configurations do not allow SynIC to be used in QEMU.  In
> particular,
> 
> - when hyperv_vpindex is off, SINT routes can't be used as they refer to
>   the destination vCPU by vp_index
> 
> - older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
>   SynIC message and event pages on every msr load, breaking migration
> 
> OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
> configurations, and we shouldn't stop the guest from using them.
> 
> To cover both scenarios, introduce an X86CPU property that makes CPU
> init code to skip creation of the SynIC object (and thus disables any
> SynIC use in QEMU) but keeps the KVM part of the SynIC working.
> The property is clear by default but is set via compat logic for older
> machine types.
> 
> As a result, when hv_synic and a modern machine type are specified, QEMU
> will refuse to run unless vp_index is on and the kernel is recent
> enough.  OTOH with an older machine type QEMU will run fine with
> hv_synic=on against an older kernel and/or without vp_index enabled but
> will disallow the in-QEMU uses of SynIC (in e.g. VMBus).
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

With current upstream and x-hv-synic-kvm-only=on QEMU will SIGSEGV.
Problem was unnoticed since added compat property wasn't actually used
until much later commit
  4a93722f9c hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
which put compat property in use.

qemu-system-x86_64 -machine pc-i440fx-2.10,accel=kvm \
 -cpu host,-vmx,hv-relaxed,hv_spinlocks=0x1fff,hv-vpindex,hv-synic 

simpler reproducer:
 qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=on

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
>  include/hw/i386/pc.h |  8 ++++++++
>  target/i386/cpu.h    |  1 +
>  target/i386/cpu.c    |  2 ++
>  target/i386/kvm.c    | 30 ++++++++++++++++++++++--------
>  4 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6894f37df1..dfe6746692 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -294,6 +294,14 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
> +#define PC_COMPAT_3_0 \
> +    HW_COMPAT_3_0 \
> +    {\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "x-hv-synic-kvm-only",\
> +        .value    = "on",\
> +    }
> +
>  #define PC_COMPAT_2_12 \
>      HW_COMPAT_2_12 \
>      {\
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index b572a8e4aa..e2e87dc13f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1376,6 +1376,7 @@ struct X86CPU {
>      bool hyperv_vpindex;
>      bool hyperv_runtime;
>      bool hyperv_synic;
> +    bool hyperv_synic_kvm_only;
>      bool hyperv_stimer;
>      bool hyperv_frequencies;
>      bool hyperv_reenlightenment;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f24295e6e4..9c29c5db81 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5575,6 +5575,8 @@ static Property x86_cpu_properties[] = {
>       * to the specific Windows version being used."
>       */
>      DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
> +    DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
> +                     false),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 47427d98f8..056a482d3a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -733,8 +733,18 @@ static int hyperv_handle_properties(CPUState *cs)
>          env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
>      }
>      if (cpu->hyperv_synic) {
> -        if (!has_msr_hv_synic ||
> -            !kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_SYNIC)) {
> +        unsigned int cap = KVM_CAP_HYPERV_SYNIC;
> +        if (!cpu->hyperv_synic_kvm_only) {
> +            if (!cpu->hyperv_vpindex) {
> +                fprintf(stderr, "Hyper-V SynIC "
> +                        "(requested by 'hv-synic' cpu flag) "
> +                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
> +            return -ENOSYS;
> +            }
> +            cap = KVM_CAP_HYPERV_SYNIC2;
> +        }
> +
> +        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap)) {
>              fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu flag) "
>                      "is not supported by kernel\n");
>              return -ENOSYS;
> @@ -783,18 +793,22 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>      }
>  
>      if (cpu->hyperv_synic) {
> -        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0);
> +        uint32_t synic_cap = cpu->hyperv_synic_kvm_only ?
> +            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
> +        ret = kvm_vcpu_enable_cap(cs, synic_cap, 0);
>          if (ret < 0) {
>              error_report("failed to turn on HyperV SynIC in KVM: %s",
>                           strerror(-ret));
>              return ret;
>          }
>  
> -        ret = hyperv_x86_synic_add(cpu);
> -        if (ret < 0) {
> -            error_report("failed to create HyperV SynIC: %s",
> -                         strerror(-ret));
> -            return ret;
> +        if (!cpu->hyperv_synic_kvm_only) {
> +            ret = hyperv_x86_synic_add(cpu);
> +            if (ret < 0) {
> +                error_report("failed to create HyperV SynIC: %s",
> +                             strerror(-ret));
> +                return ret;
> +            }
>          }
>      }
>  
