Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpm1-0004cc-UY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpm0-00008h-Nq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:50:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpm0-00007S-FP
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:50:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3638A80F9B
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 16:50:03 +0000 (UTC)
Date: Fri, 2 Jun 2017 19:49:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170602194523-mutt-send-email-mst@kernel.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496404254-17429-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Jun 02, 2017 at 07:50:53PM +0800, Peter Xu wrote:
> This patch let address_space_get_iotlb_entry() to use the newly
> introduced page_mask parameter in address_space_do_translate(). Then we
> will be sure the IOTLB can be aligned to page mask, also we should
> nicely support huge pages now when introducing a764040.
> 
> Fixes: a764040 ("exec: abstract address_space_do_translate()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  exec.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 63a3ff0..1f86253 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -544,14 +544,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>                                              bool is_write)
>  {
>      MemoryRegionSection section;
> -    hwaddr xlat, plen;
> +    hwaddr xlat, page_mask;
>  
> -    /* Try to get maximum page mask during translation. */
> -    plen = (hwaddr)-1;
> -
> -    /* This can never be MMIO. */
> -    section = address_space_do_translate(as, addr, &xlat, &plen,
> -                                         NULL, is_write, false);
> +    /*
> +     * This can never be MMIO, and we don't really care about plen,
> +     * but page mask.
> +     */
> +    section = address_space_do_translate(as, addr, &xlat, NULL,
> +                                         &page_mask, is_write, false);
>  
>      /* Illegal translation */
>      if (section.mr == &io_mem_unassigned) {


Can we just use section.size - xlat here?

> @@ -562,20 +562,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>      xlat += section.offset_within_address_space -
>          section.offset_within_region;
>  
> -    if (plen == (hwaddr)-1) {
> -        /* If not specified during translation, use default mask */
> -        plen = TARGET_PAGE_MASK;
> -    } else {
> -        /* Make it a valid page mask */
> -        assert(plen);
> -        plen = pow2floor(plen) - 1;
> -    }
> -
>      return (IOMMUTLBEntry) {
>          .target_as = section.address_space,
> -        .iova = addr & ~plen,
> -        .translated_addr = xlat & ~plen,
> -        .addr_mask = plen,
> +        .iova = addr & ~page_mask,
> +        .translated_addr = xlat & ~page_mask,
> +        .addr_mask = page_mask,
>          /* IOTLBs are for DMAs, and DMA only allows on RAMs. */

BTW this comment is pretty confusing. What does it mean?

>          .perm = IOMMU_RW,
>      };

Looks like we should change IOMMUTLBEntry to pass size and not mask -
then we could simply pass info from section as is. iova would be
addr - xlat.

> -- 
> 2.7.4
