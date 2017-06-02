Received: from eggs.gnu.org ([2001:4830:134:3::10]:37591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGphR-0001RZ-2P
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGphM-0004nu-Vf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGphM-0004n2-Mi
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93B0380472
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 16:45:15 +0000 (UTC)
Date: Fri, 2 Jun 2017 19:45:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170602193713-mutt-send-email-mst@kernel.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496404254-17429-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] exec: add page_mask for
 address_space_do_translate
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

On Fri, Jun 02, 2017 at 07:50:52PM +0800, Peter Xu wrote:
> The function is originally used for address_space_translate() and what
> we care about most is (xlat, plen) range. However for iotlb requests, we
> don't really care about "plen", but the size of the page that "xlat" is
> located on. While, plen cannot really contain this information.
> 
> A simple example to show why "plen" is not good for IOTLB translations:
> 
> E.g., for huge pages, it is possible that guest mapped 1G huge page on
> device side that used this GPA range:
> 
>   0x100000000 - 0x13fffffff
> 
> Then let's say we want to translate one IOVA that finally mapped to GPA
> 0x13ffffe00 (which is located on this 1G huge page). Then here we'll
> get:
> 
>   (xlat, plen) = (0x13fffe00, 0x200)
> 
> So the IOTLB would be only covering a very small range since from
> "plen" (which is 0x200 bytes) we cannot tell the size of the page.
> 
> Actually we can really know that this is a huge page - we just throw the
> information away in address_space_do_translate().
> 
> This patch introduced "page_mask" optional parameter to capture that
> page mask info. Also, I made "plen" an optional parameter as well, with
> some comments for the whole function.
> 
> No functional change yet.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  exec.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 8fc0e78..63a3ff0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -465,21 +465,45 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
>      return section;
>  }
>  
> -/* Called from RCU critical section */
> +/**
> + * address_space_do_translate - translate an address in AddressSpace
> + *
> + * @as: the address space that we want to translate on
> + * @addr: the address to be translated in above address space
> + * @xlat: the translated address offset within memory region. It
> + *        cannot be @NULL.
> + * @plen_out: valid read/write length of the translated address. It
> + *            can be @NULL when we don't care about it.
> + * @page_mask_out: page mask for the translated address. This
> + *            should only be meaningful for IOMMU translated
> + *            addresses, since there may be huge pages that this bit
> + *            would tell. It can be @NULL if we don't care about it.

Why do we need plen or mask at all? It seems MemoryRegionSection
has address and length already. So if you want to find out
distance to section end, do section.size - xlat and you are done.


> + * @is_write: whether the translation operation is for write
> + * @is_mmio: whether this can be MMIO, set true if it can
> + *
> + * This function is called from RCU critical section
> + */
>  static MemoryRegionSection address_space_do_translate(AddressSpace *as,
>                                                        hwaddr addr,
>                                                        hwaddr *xlat,
> -                                                      hwaddr *plen,
> +                                                      hwaddr *plen_out,
> +                                                      hwaddr *page_mask_out,
>                                                        bool is_write,
>                                                        bool is_mmio)
>  {
>      IOMMUTLBEntry iotlb;
>      MemoryRegionSection *section;
>      MemoryRegion *mr;
> +    hwaddr page_mask = TARGET_PAGE_MASK;
> +    hwaddr plen = (hwaddr)(-1);
> +
> +    if (plen_out) {
> +        plen = *plen_out;
> +    }
>  
>      for (;;) {
>          AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
> -        section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
> +        section = address_space_translate_internal(d, addr, &addr, &plen, is_mmio);
>          mr = section->mr;
>  
>          if (!mr->iommu_ops) {
> @@ -490,7 +514,8 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
>                                           IOMMU_WO : IOMMU_RO);
>          addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
> -        *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
> +        page_mask = iotlb.addr_mask;
> +        plen = MIN(plen, (addr | iotlb.addr_mask) - addr + 1);
>          if (!(iotlb.perm & (1 << is_write))) {
>              goto translate_fail;
>          }
> @@ -500,6 +525,14 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
>  
>      *xlat = addr;
>  
> +    if (page_mask_out) {
> +        *page_mask_out = page_mask;
> +    }
> +
> +    if (plen_out) {
> +        *plen_out = plen;
> +    }
> +
>      return *section;
>  
>  translate_fail:
> @@ -518,7 +551,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>  
>      /* This can never be MMIO. */
>      section = address_space_do_translate(as, addr, &xlat, &plen,
> -                                         is_write, false);
> +                                         NULL, is_write, false);
>  
>      /* Illegal translation */
>      if (section.mr == &io_mem_unassigned) {
> @@ -560,7 +593,8 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
>      MemoryRegionSection section;
>  
>      /* This can be MMIO, so setup MMIO bit. */
> -    section = address_space_do_translate(as, addr, xlat, plen, is_write, true);
> +    section = address_space_do_translate(as, addr, xlat, plen,
> +                                         NULL, is_write, true);
>      mr = section.mr;
>  
>      if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
> -- 
> 2.7.4
