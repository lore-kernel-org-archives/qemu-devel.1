Received: from eggs.gnu.org ([2001:4830:134:3::10]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezSnd-00058J-Ie
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezSnZ-0004gS-51
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:56:29 -0400
Date: Fri, 23 Mar 2018 16:56:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323195621.GN3417@localhost.localdomain>
References: <20180323125808.4479-1-rkagan@virtuozzo.com>
	<20180323125808.4479-3-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323125808.4479-3-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] i386/hyperv: error out if
 features requested but unsupported
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

On Fri, Mar 23, 2018 at 03:58:08PM +0300, Roman Kagan wrote:
> In order to guarantee compatibility on migration, QEMU should have
> complete control over the features it announces to the guest via CPUID.
> 
> However, for a number of Hyper-V-related cpu properties, if the
> corresponding feature is not supported by the underlying KVM, the
> propery is silently ignored and the feature is not announced to the
> guest.
> 
> Refuse to start with an error instead.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

I wonder if we should make these just warnings on -stable, and
make them fatal errors only on 2.12.  I wouldn't want to make
existing running VMs not runnable on a stable update.


> ---
>  target/i386/kvm.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index fb20ff18c2..c9c359241c 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -658,17 +658,34 @@ static int hyperv_handle_properties(CPUState *cs)
>          env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>          env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>      }
> -    if (cpu->hyperv_crash && has_msr_hv_crash) {
> +    if (cpu->hyperv_crash) {
> +        if (!has_msr_hv_crash) {
> +            fprintf(stderr,
> +                    "Hyper-V crash MSRs are not supported by kernel\n");

I would mention the corresponding "hv-..." -cpu option
explicitly, for clarity.

> +            return -ENOSYS;
> +        }
>          env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
>      }
>      env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
> -    if (cpu->hyperv_reset && has_msr_hv_reset) {
> +    if (cpu->hyperv_reset) {
> +       if (!has_msr_hv_reset) {
> +            fprintf(stderr, "Hyper-V reset MSR is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
>          env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
>      }
> -    if (cpu->hyperv_vpindex && has_msr_hv_vpindex) {
> +    if (cpu->hyperv_vpindex) {
> +        if (!has_msr_hv_vpindex) {
> +            fprintf(stderr, "Hyper-V VP_INDEX is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
>          env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
>      }
> -    if (cpu->hyperv_runtime && has_msr_hv_runtime) {
> +    if (cpu->hyperv_runtime) {
> +        if (!has_msr_hv_runtime) {
> +            fprintf(stderr, "Hyper-V VP_INDEX is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
>          env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
>      }
>      if (cpu->hyperv_synic) {
> -- 
> 2.14.3
> 

-- 
Eduardo
