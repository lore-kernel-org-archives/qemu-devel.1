Received: from eggs.gnu.org ([2001:4830:134:3::10]:48452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMFXr-0006DY-IO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMFXn-00060I-JX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:54:07 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <89bee1c4-05f8-8f60-f5c7-2913cc1c3a41@redhat.com>
Date: Tue, 5 Dec 2017 16:53:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171204125505.29203-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 2/5] s390x/tcg: fix and cleanup
 mcck injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 04.12.2017 13:55, David Hildenbrand wrote:
> The architecture mode indication wasn't stored. The split of certain
> 64bit fields was unnecessary. Also, the complete clock comparator, not
> just bit 0-55 (starting at byte 1) was stored.
> 
> We now generate a proper MCIC via the same helper we use for KVM.
> 
> While at it, also get rid of two local variables. There is be more to
> clean up, but we will change the other parts later on either way.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 18 ++++++++----------
>  target/s390x/internal.h    |  6 +++---
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index d831537544..840cf7641a 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -369,7 +369,6 @@ static void do_io_interrupt(CPUS390XState *env)
>  static void do_mchk_interrupt(CPUS390XState *env)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> -    uint64_t mask, addr;
>      LowCore *lowcore;
>      MchkQueue *q;
>      int i;
> @@ -395,6 +394,9 @@ static void do_mchk_interrupt(CPUS390XState *env)
>  
>      lowcore = cpu_map_lowcore(env);
>  
> +    /* we are always in z/Architecture mode */
> +    lowcore->ar_access_id = 1;
> +
>      for (i = 0; i < 16; i++) {
>          lowcore->floating_pt_save_area[i] = cpu_to_be64(get_freg(env, i)->ll);
>          lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
> @@ -404,17 +406,12 @@ static void do_mchk_interrupt(CPUS390XState *env)
>      lowcore->prefixreg_save_area = cpu_to_be32(env->psa);
>      lowcore->fpt_creg_save_area = cpu_to_be32(env->fpc);
>      lowcore->tod_progreg_save_area = cpu_to_be32(env->todpr);
> -    lowcore->cpu_timer_save_area[0] = cpu_to_be32(env->cputm >> 32);
> -    lowcore->cpu_timer_save_area[1] = cpu_to_be32((uint32_t)env->cputm);
> -    lowcore->clock_comp_save_area[0] = cpu_to_be32(env->ckc >> 32);
> -    lowcore->clock_comp_save_area[1] = cpu_to_be32((uint32_t)env->ckc);
> +    lowcore->cpu_timer_save_area = cpu_to_be64(env->cputm);
> +    lowcore->clock_comp_save_area = cpu_to_be64(env->ckc >> 8);
>  
> -    lowcore->mcck_interruption_code[0] = cpu_to_be32(0x00400f1d);
> -    lowcore->mcck_interruption_code[1] = cpu_to_be32(0x40330000);
> +    lowcore->mcic = cpu_to_be64(s390_build_validity_mcic() | MCIC_SC_CP);
>      lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
>      lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
> -    mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
> -    addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
>  
>      cpu_unmap_lowcore(lowcore);

Lowcore gets unmapped here...

> @@ -426,7 +423,8 @@ static void do_mchk_interrupt(CPUS390XState *env)
>      DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
>              env->psw.mask, env->psw.addr);
>  
> -    load_psw(env, mask, addr);
> +    load_psw(env, be64_to_cpu(lowcore->mcck_new_psw.mask),
> +             be64_to_cpu(lowcore->mcck_new_psw.addr));

... but here you still touch it? Looks like a bug to me...?

 Thomas
