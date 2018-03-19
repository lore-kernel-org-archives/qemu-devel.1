Received: from eggs.gnu.org ([2001:4830:134:3::10]:59479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1exyEp-0004O9-Gm
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1exyEm-0007wV-B7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:06:23 -0400
Received: from mail-he1eur01hn0205.outbound.protection.outlook.com
	([104.47.0.205]:60256
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1exyEl-0007ta-18
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:06:20 -0400
Date: Mon, 19 Mar 2018 20:06:03 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180319170603.GA12962@rkaganb.sw.ru>
References: <20180316170020.8212-1-vkuznets@redhat.com>
	<20180316170020.8212-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316170020.8212-2-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 16, 2018 at 06:00:19PM +0100, Vitaly Kuznetsov wrote:
> KVM recently gained support for Hyper-V Reenlightenment MSRs which are
> required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
> when INVTSC is not passed to it (and it is not passed by default in Qemu
> as it effectively blocks migration).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
> - add vmstate_msr_hyperv_reenlightenment subsection to vmstate_x86_cpu
>   [Paolo Bonzini]
> ---
>  target/i386/cpu.h          |  3 +++
>  target/i386/hyperv-proto.h |  9 ++++++++-
>  target/i386/kvm.c          | 33 +++++++++++++++++++++++++++++++++
>  target/i386/machine.c      | 24 ++++++++++++++++++++++++
>  4 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2e2bab5ff3..0b1b556a56 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1174,6 +1174,9 @@ typedef struct CPUX86State {
>      uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
>      uint64_t msr_hv_stimer_config[HV_STIMER_COUNT];
>      uint64_t msr_hv_stimer_count[HV_STIMER_COUNT];
> +    uint64_t msr_hv_reenlightenment_control;
> +    uint64_t msr_hv_tsc_emulation_control;
> +    uint64_t msr_hv_tsc_emulation_status;
>  
>      uint64_t msr_rtit_ctrl;
>      uint64_t msr_rtit_status;
> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
> index cb4d7f2b7a..93352ebd2a 100644
> --- a/target/i386/hyperv-proto.h
> +++ b/target/i386/hyperv-proto.h
> @@ -35,7 +35,7 @@
>  #define HV_RESET_AVAILABLE           (1u << 7)
>  #define HV_REFERENCE_TSC_AVAILABLE   (1u << 9)
>  #define HV_ACCESS_FREQUENCY_MSRS     (1u << 11)
> -
> +#define HV_ACCESS_REENLIGHTENMENTS_CONTROL  (1u << 13)
>  
>  /*
>   * HV_CPUID_FEATURES.EDX bits
> @@ -129,6 +129,13 @@
>  #define HV_X64_MSR_CRASH_CTL                    0x40000105
>  #define HV_CRASH_CTL_NOTIFY                     (1ull << 63)
>  
> +/*
> + * Reenlightenment notification MSRs
> + */
> +#define HV_X64_MSR_REENLIGHTENMENT_CONTROL      0x40000106
> +#define HV_X64_MSR_TSC_EMULATION_CONTROL        0x40000107
> +#define HV_X64_MSR_TSC_EMULATION_STATUS         0x40000108
> +
>  /*
>   * Hypercall status code
>   */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index d23fff12f5..accf50eac3 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -90,6 +90,7 @@ static bool has_msr_hv_runtime;
>  static bool has_msr_hv_synic;
>  static bool has_msr_hv_stimer;
>  static bool has_msr_hv_frequencies;
> +static bool has_msr_hv_reenlightenment;
>  static bool has_msr_xss;
>  static bool has_msr_spec_ctrl;
>  static bool has_msr_smi_count;
> @@ -653,6 +654,11 @@ static int hyperv_handle_properties(CPUState *cs)
>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>          }
> +
> +        if (has_msr_hv_reenlightenment) {
> +            env->features[FEAT_HYPERV_EAX] |=
> +                HV_ACCESS_REENLIGHTENMENTS_CONTROL;
> +        }

Can you please add a matching comment to the definition of
feature_word_info[FEAT_HYPERV_EAX].feat_names[]?

Also there appears to be no cpu property to turn this on/off, does it?
It's enabled based only on the support in the KVM it's running against.
So I guess we may have a problem migrating between the hosts with
different KVM versions, one supporting it and the other not.
(This is also a problem with has_msr_hv_frequencies, and is in general a
long-standing issue of hv_* properties being done differently from the
rest of CPUID features.)

Thanks,
Roman.
