Received: from eggs.gnu.org ([2001:4830:134:3::10]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyDlk-0006Bh-Iz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyDlh-0007Nr-HB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:41:24 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:49242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eyDlh-0007L9-AS
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:41:21 -0400
Received: from player758.ha.ovh.net (unknown [10.109.122.233])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7CA2CA1064
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 10:41:12 +0100 (CET)
Date: Tue, 20 Mar 2018 10:41:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180320104103.56d541c2@bahia.lan>
In-Reply-To: <20180320022319.17199-1-david@gibson.dropbear.id.au>
References: <20180320022319.17199-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix backwards migration of
 msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, wei.guo.simon@gmail.com, ldoktor@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 20 Mar 2018 13:23:19 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> 21b786f "PowerPC: Add TS bits into msr_mask" added the transaction states
> to msr_mask for recent POWER CPUs to allow correct migration of machines
> that are in certain interim transactional memory states.
> 
> This was correct, but unfortunately breaks backwards of pseries-2.7 and
> earlier machine types which (stupidly) transferred the msr_mask in the
> migration stream and failed if it wasn't equal on each end.
> 
> This works around the problem by masking out the new MSR bits in the
> compatibility code to send the msr_mask on old machine types.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

>  target/ppc/machine.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index e475206c6a..0634cdb295 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -190,7 +190,15 @@ static int cpu_pre_save(void *opaque)
>  
>      /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
>      if (cpu->pre_2_8_migration) {
> -        cpu->mig_msr_mask = env->msr_mask;
> +        /* Mask out bits that got added to msr_mask since the versions
> +         * which stupidly included it in the migration stream. */
> +        target_ulong metamask = 0
> +#if defined(TARGET_PPC64)
> +            | (1ULL << MSR_TS0)
> +            | (1ULL << MSR_TS1)
> +#endif
> +            ;
> +        cpu->mig_msr_mask = env->msr_mask & ~metamask;
>          cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
>          cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
>          cpu->mig_nb_BATs = env->nb_BATs;
