Received: from eggs.gnu.org ([2001:4830:134:3::10]:32998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezSZG-0007MD-6s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezSZD-0004y8-1c
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:41:38 -0400
Date: Fri, 23 Mar 2018 16:41:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323194131.GL3417@localhost.localdomain>
References: <20180323125808.4479-1-rkagan@virtuozzo.com>
	<20180323125808.4479-2-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323125808.4479-2-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] i386/hyperv: add
 hv-frequencies cpu property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-stable@nongnu.org

On Fri, Mar 23, 2018 at 03:58:07PM +0300, Roman Kagan wrote:
> In order to guarantee compatibility on migration, QEMU should have
> complete control over the features it announces to the guest via CPUID.
> 
> However, the declared availability of Hyper-V frequency MSRs
> (HV_X64_MSR_TSC_FREQUENCY and HV_X64_MSR_APIC_FREQUENCY) depends solely
> on the support for them in the underlying KVM.

So this problem was introduced fairly recently (in v2.11).  This
makes the decision to break compatibility of (some[1]) existing
configurations that didn't specify "hv-frequency" a bit easier.

> Introduce "hv-frequencies" cpu property (off by default) which gives
> QEMU full control over whether these MSRs are announced.
> 

So, as we have two possible results when running QEMU-2.11, we
need to make a guess and choose which half of our users will be
affected:

a) People running "-machine pc-2.11 -cpu ...,+hv-time" on Linux 4.14+
   (including commit 72c139bacfa3), that have hv-frequencies
   enabled automatically.
b) People running "-machine pc-2.11 -cpu ...,+hv-time" on Linux
   4.13 and older (without commit 72c139bacfa3), that have
   hv-frequencies disabled.

If we set hv-frequencies=off by default on pc-2.11 (this patch),
we will inconvenience group (a).  The consequence for them is
having hv-frequencies disabled suddenly on CPUID after updating
QEMU.  The MSRs will still be available to the guest, however (so
the guest won't crash), and they can add hv-frequencies=on to
their configuration manually.

If we set hv-frequencies=on by default on pc-2.11, we will
inconvenience group (b).  The consequence for them is having the
VM not being runnable anymore until they change the machine-type
or add hv-frequencies=off to their configuration.

So it looks like this patch is the safest solution, but I will
get back to the "[PATCH v3 2/2] i386/kvm: lower requirements for
Hyper-V frequency MSRs exposure" thread to be sure we are not
missing anything.


> While at this, drop the redundant check of the cpu tsc frequency, and
> decouple this feature from hv-time.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
> Note: this patch introduces a new cpu property, which is not what we
> normally do in stable branches.  However, this appears to be the minimal
> effort/churn approach to reduce the number of published QEMU releases
> where the behavior of the feature is unpredictable, with potentially
> fatal consequences for the guest.
> 
>  target/i386/cpu.h |  1 +
>  target/i386/cpu.c |  1 +
>  target/i386/kvm.c | 12 ++++++++----
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 78db1b833a..1b219fafc4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1296,6 +1296,7 @@ struct X86CPU {
>      bool hyperv_runtime;
>      bool hyperv_synic;
>      bool hyperv_stimer;
> +    bool hyperv_frequencies;
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 555ae79d29..1a6b082b6f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4761,6 +4761,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("hv-runtime", X86CPU, hyperv_runtime, false),
>      DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
>      DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
> +    DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index d23fff12f5..fb20ff18c2 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -648,11 +648,15 @@ static int hyperv_handle_properties(CPUState *cs)
>          env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
> -
> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> -            env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
> -            env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
> +    }
> +    if (cpu->hyperv_frequencies) {
> +        if (!has_msr_hv_frequencies) {
> +            fprintf(stderr,
> +                    "Hyper-V frequency MSRs are not supported by kernel\n");
> +            return -ENOSYS;
>          }
> +        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
> +        env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>      }
>      if (cpu->hyperv_crash && has_msr_hv_crash) {
>          env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
> -- 
> 2.14.3
> 

-- 
Eduardo
