Received: from eggs.gnu.org ([2001:4830:134:3::10]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBH6B-0004x2-J5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBH68-0002MV-Vx
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:27 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:45297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBH68-0002LA-Nw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:24 -0400
Received: from player774.ha.ovh.net (unknown [10.109.108.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 19D5DE09A9
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:52:23 +0200 (CEST)
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a01bebe8-85b7-f2b4-3675-401367471204@kaod.org>
Date: Wed, 25 Apr 2018 11:52:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180417071722.9399-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 03/10] target/ppc:
 Remove unnecessary initialization of LPCR_UPRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/17/2018 09:17 AM, David Gibson wrote:
> In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initialized
> based on on ppc64_radix_guest().  Which seems reasonable, except that
> ppc64_radix_guest() is based on spapr->patb_entry which is only set up
> in spapr_machine_reset, called much later than cpu_ppc_set_papr().
> 
> So the initialization here is pointless.  The base cpu initialization
> already sets a value that's good enough until the guest uses an hcall to
> configure it's preferred MMU mode.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/translate_init.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index bb79d23b50..14f346f441 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8897,22 +8897,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>      lpcr->default_value &= ~LPCR_RMLS;
>      lpcr->default_value |= 1ull << LPCR_RMLS_SHIFT;
>  
> -    if (env->mmu_model == POWERPC_MMU_3_00) {
> -        /* By default we choose legacy mode and switch to new hash or radix
> -         * when a register process table hcall is made. So disable process
> -         * tables and guest translation shootdown by default
> -         *
> -         * Hot-plugged CPUs inherit from the guest radix setting under
> -         * KVM but not under TCG. Update the default LPCR to keep new
> -         * CPUs in sync when radix is enabled.
> -         */


This is breaking CPU hotplug under TCG. Should we reintroduce the same 
settings in spapr_cpu_reset() now ?

Thanks,

C. 


> -        if (ppc64_radix_guest(cpu)) {
> -            lpcr->default_value |= LPCR_UPRT | LPCR_GTSE;
> -        } else {
> -            lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
> -        }
> -    }
> -
>      /* Only enable Power-saving mode Exit Cause exceptions on the boot
>       * CPU. The RTAS command start-cpu will enable them on secondaries.
>       */
> 
