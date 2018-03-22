Received: from eggs.gnu.org ([2001:4830:134:3::10]:34361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ez5HQ-0005kB-Bl
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ez5HN-00017D-AT
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ez5HN-000170-3k
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:49:37 -0400
Date: Thu, 22 Mar 2018 15:49:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180322184933.GI3417@localhost.localdomain>
References: <20180322131358.15096-1-vkuznets@redhat.com>
	<20180322131358.15096-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322131358.15096-3-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] i386/kvm: expose Hyper-V frequency
 MSRs with reenlightenment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On Thu, Mar 22, 2018 at 02:13:58PM +0100, Vitaly Kuznetsov wrote:
> We can also expose Hyper-V frequency MSRs when reenlightenment feature is
> enabled and TSC frequency is known, Hyper-V on KVM will provide stable TSC
> page clocksources to its guests.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Expose frequency MSRs only when either INVTSC or Reenlightenment is
>   provided [Paolo Bonzini]
> ---
>  target/i386/kvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 75f4e1d69e..2c3c19d690 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -651,7 +651,8 @@ static int hyperv_handle_properties(CPUState *cs)
>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
>  
> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> +        if (has_msr_hv_frequencies && env->tsc_khz &&

Why is the check for env->tsc_khz necessary?

Are there known circumstances where HV_X64_MSR_TSC_FREQUENCY will be supported
by KVM but ioctl(KVM_GET_TSC_KHZ) will return 0, or this is just for extra
safety?

> +            (tsc_is_stable_and_known(env) || cpu->hyperv_reenlightenment)) {
>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>          }
> -- 
> 2.14.3
> 

-- 
Eduardo
