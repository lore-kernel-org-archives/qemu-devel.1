Received: from eggs.gnu.org ([2001:4830:134:3::10]:33503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVtbD-00049P-Q7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVtb8-00086U-PN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:01:43 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:51213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVtb8-00085f-Iz
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:01:38 -0400
Received: from player732.ha.ovh.net (unknown [10.109.122.80])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D63A1D1993
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:01:36 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f829daa0-c870-f835-2195-df795c0e47b9@kaod.org>
Date: Thu, 21 Jun 2018 09:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] spapr: Limit available pagesizes to
 provide a consistent guest environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, abologna@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On 06/18/2018 08:36 AM, David Gibson wrote:
> KVM HV has some limitations (deriving from the hardware) that mean not all
> host-cpu supported pagesizes may be usable in the guest.  At present this
> means that KVM guests and TCG guests may see different available page sizes
> even if they notionally have the same vcpu model.  This is confusing and
> also prevents migration between TCG and KVM.
> 
> This patch makes the environment consistent by always allowing the same set
> of pagesizes.  Since we can't remove the KVM limitations, we do this by
> always applying the same limitations it has, even to TCG guests.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
> ---
>  hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9fc739b3f5..0584c7c6ab 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -334,6 +334,38 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
>      spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
>  }
>  
> +static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uint32_t pshift)
> +{
> +    unsigned maxshift = *((unsigned *)opaque);
> +
> +    assert(pshift >= seg_pshift);

you could check that elsewhere.

> +    /* Don't allow the guest to use pages bigger than the configured
> +     * maximum size */
> +    if (pshift > maxshift) {
> +        return false;
> +    }
> +
> +    /* For whatever reason, KVM doesn't allow multiple pagesizes
> +     * within a segment, *except* for the case of 16M pages in a 4k or
> +     * 64k segment.  Always exclude other cases, so that TCG and KVM
> +     * guests see a consistent environment */
> +    if ((pshift != seg_pshift) && (pshift != 24)) {
> +        return false;
> +    }
> +
> +    return true;
> +}

So, do we really need ppc_hash64_filter_pagesizes() to have a callback ? 

It seems that we only use the routine once in the patchset and that the
only thing we need to check is 'maxshift'.

Do you envision other usage of the routine ?

Thanks,

C.

> +static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
> +                                          PowerPCCPU *cpu,
> +                                          uint8_t val, Error **errp)
> +{
> +    unsigned maxshift = val;
> +
> +    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -401,6 +433,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .set = spapr_cap_set_pagesize,
>          .type = "int",
>          .apply = cap_hpt_maxpagesize_apply,
> +        .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
>      },
>  };
>  
> 
