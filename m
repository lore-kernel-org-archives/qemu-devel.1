Received: from eggs.gnu.org ([2001:4830:134:3::10]:48107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dDYcD-0001pe-Dy
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dDYc8-0008BU-EI
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:25 -0400
Received: from mail-eopbgr10096.outbound.protection.outlook.com
	([40.107.1.96]:8224
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dDYc7-0008A5-PP
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:20 -0400
Date: Wed, 24 May 2017 18:54:09 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170524155408.GF14372@rkaganb.sw.ru>
References: <1495634844-14777-1-git-send-email-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1495634844-14777-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [svt-core] [PATCH] kvmclock: update
 system_time_msr address forcibly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com

On Wed, May 24, 2017 at 05:07:24PM +0300, Denis Plotnikov wrote:
> Do an update of system_time_msr address every time before reading
> the value of tsc_timestamp from guest's kvmclock page.
> 
> It should be done in a forcible manner because there is a situation
> when system_time_msr has been set by kvm but qemu doesn't aware of it.
> This leads to updates of kvmclock_offset without respect of guest's
> kvmclock values.
> 
> The situation appears when L2 linux guest runs over L1 linux guest and
> the action inducing system_time_msr update is tpr access reporting.
> Some L1 linux guests turn off processing TPR access and when L0
> gets an L2 exit induced by TPR MSR access it doesn't enter L1 and
> processed it by itself.
> Thus, L1 kvm doesn't know about that TPR access happening and doesn't
> exit to qemu which in turn doesn't set system_time_msr address.
> 
> This patch fixes this by making sure it knows the correct address every
> time it is needed.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/i386/kvm/clock.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index e713162..035196a 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -48,11 +48,38 @@ struct pvclock_vcpu_time_info {
>      uint8_t    pad[2];
>  } __attribute__((__packed__)); /* 32 bytes */
>  
> +static void update_all_system_time_msr(void)
> +{
> +    CPUState *cpu;
> +    CPUX86State *env;
> +    struct {
> +        struct kvm_msrs info;
> +        struct kvm_msr_entry entries[1];
> +    } msr_data;
> +    int ret;
> +
> +    msr_data.info.nmsrs = 1;
> +    msr_data.entries[0].index = MSR_KVM_SYSTEM_TIME;
> +
> +    CPU_FOREACH(cpu) {
> +        ret = kvm_vcpu_ioctl(cpu, KVM_GET_MSRS, &msr_data);
> +
> +        if (ret < 0) {
> +            fprintf(stderr, "KVM_GET_MSRS failed: %s\n", strerror(ret));
> +            abort();
> +        }
> +
> +        assert(ret == 1);
> +        env = cpu->env_ptr;
> +        env->system_time_msr = msr_data.entries[0].data;
> +    }
> +}
> +
>  static uint64_t kvmclock_current_nsec(KVMClockState *s)
>  {
>      CPUState *cpu = first_cpu;
>      CPUX86State *env = cpu->env_ptr;
> -    hwaddr kvmclock_struct_pa = env->system_time_msr & ~1ULL;
> +    hwaddr kvmclock_struct_pa;
>      uint64_t migration_tsc = env->tsc;
>      struct pvclock_vcpu_time_info time;
>      uint64_t delta;
> @@ -60,6 +87,9 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
>      uint64_t nsec_hi;
>      uint64_t nsec;
>  
> +    update_all_system_time_msr();

I'd rather just cpu_synchronize_state(cpu) here.  

> +    kvmclock_struct_pa = env->system_time_msr & ~1ULL;
> +
>      if (!(env->system_time_msr & 1ULL)) {
>          /* KVM clock not active */
>          return 0;

Roman.
