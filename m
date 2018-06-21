Received: from eggs.gnu.org ([2001:4830:134:3::10]:51459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVydm-0006Oj-5G
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVydj-0008Gz-0j
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:24:42 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:43934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVydi-0008Dn-Ov
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:24:38 -0400
Received: from player789.ha.ovh.net (unknown [10.109.108.97])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5D9E410A1EF
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:24:29 +0200 (CEST)
Date: Thu, 21 Jun 2018 14:24:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180621142419.5c6d2ce2@bahia.lan>
In-Reply-To: <20180618063606.2513-9-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On Mon, 18 Jun 2018 16:36:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

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
> +
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

Unless I'm missing something, I don't see how we could get "other cases"
with TCG, at least with the current content of ppc_hash64_opts_POWER7.

> +    if ((pshift != seg_pshift) && (pshift != 24)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
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
