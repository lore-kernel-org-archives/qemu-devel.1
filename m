Received: from eggs.gnu.org ([2001:4830:134:3::10]:38585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9S9n-0003ID-Pm
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9S9k-0006bg-HW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:16:39 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:55122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9S9k-0006aP-Bu
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:16:36 -0400
Received: from player699.ha.ovh.net (unknown [10.109.122.114])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E872612C23B
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:16:34 +0200 (CEST)
Date: Fri, 20 Apr 2018 11:16:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420111627.53428980@bahia.lan>
In-Reply-To: <20180417071722.9399-5-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 04/10] spapr: Set compatibility
 mode before the rest of spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Apr 2018 17:17:16 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Although the order doesn't really matter at the moment, it's possible
> other initializastions could depend on the compatiblity mode, so make sure
> we set it first in spapr_cpu_reset().
> 
> While we're at it drop the test against first_cpu.  Setting the compat mode
> to the value it already has is redundant, but harmless, so we might as well
> make a small simplification to the code.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_cpu_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f39d99a8da..2aab6ccd15 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -31,6 +31,11 @@ static void spapr_cpu_reset(void *opaque)
>  
>      cpu_reset(cs);
>  
> +    /* Set compatibility mode to match the boot CPU, which was either set
> +     * by the machine reset code or by CAS. This should never fail.
> +     */
> +    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
> +
>      /* All CPUs start halted.  CPU0 is unhalted from the machine level
>       * reset code and the rest are explicitly started up by the guest
>       * using an RTAS call */
> @@ -43,12 +48,6 @@ static void spapr_cpu_reset(void *opaque)
>          env->spr[SPR_LPCR] &= ~pcc->lpcr_pm;
>      }
>  
> -    /* Set compatibility mode to match the boot CPU, which was either set
> -     * by the machine reset code or by CAS. This should never fail.
> -     */
> -    if (cs != first_cpu) {
> -        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
> -    }
>  }
>  
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
