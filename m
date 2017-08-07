Received: from eggs.gnu.org ([2001:4830:134:3::10]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1deivO-0003rh-MT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1deivL-0005zw-9X
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1deivL-0005zU-38
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:22:27 -0400
References: <20170807085703.32267-1-lprosek@redhat.com>
	<20170807085703.32267-4-lprosek@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cfa7082c-9809-7226-c891-9576c2eda82a@redhat.com>
Date: Mon, 7 Aug 2017 16:22:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170807085703.32267-4-lprosek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] i386/kvm: introduce
 tsc_is_stable_and_known()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rkrcmar@redhat.com

On 07.08.2017 10:57, Ladi Prosek wrote:
> Move the "is TSC stable and known" condition to a reusable helper.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  target/i386/kvm.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 15d56ae..2dc01c9 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -611,6 +611,15 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
>      return 0;
>  }
>  
> +static bool tsc_is_stable_and_known(CPUX86State *env)
> +{
> +    if (!env->tsc_khz) {
> +        return false;
> +    }
> +    return (env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
> +        || env->user_tsc_khz;
> +}> +
>  static int hyperv_handle_properties(CPUState *cs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
> @@ -986,9 +995,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          && cpu->expose_kvm
>          && kvm_base == KVM_CPUID_SIGNATURE
>          /* TSC clock must be stable and known for this feature. */
> -        && ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
> -            || env->user_tsc_khz != 0)
> -        && env->tsc_khz != 0) {
> +        && tsc_is_stable_and_known(env)) {
>  
>          c = &cpuid_data.entries[cpuid_i++];
>          c->function = KVM_CPUID_SIGNATURE | 0x10;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
