Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fESEy-00064E-BO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fESEv-0007mr-7N
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:22:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fESEv-0007me-2t
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:22:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF29281A88A8
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 04:22:36 +0000 (UTC)
Date: Fri, 4 May 2018 12:22:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180504042231.GC28447@xz-mi>
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<20180417140802.16711-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417140802.16711-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] exec: extract
 address_space_translate_iommu, fix page_mask corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 17, 2018 at 04:08:01PM +0200, Paolo Bonzini wrote:

[...]

> +static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iommu_mr,
> +                                                         hwaddr *xlat,
> +                                                         hwaddr *plen_out,
> +                                                         hwaddr *page_mask_out,
> +                                                         bool is_write,
> +                                                         bool is_mmio,
> +                                                         AddressSpace **target_as)
> +{
> +    MemoryRegionSection *section;
> +    hwaddr page_mask = (hwaddr)-1;
> +
> +    do {
> +        hwaddr addr = *xlat;
> +        IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
> +        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
> +                                              IOMMU_WO : IOMMU_RO);
> +
> +        if (!(iotlb.perm & (1 << is_write))) {
> +            goto unassigned;
> +        }
> +
> +        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
> +                | (addr & iotlb.addr_mask));
> +        page_mask &= iotlb.addr_mask;
> +        *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
> +        *target_as = iotlb.target_as;
> +
> +        section = address_space_translate_internal(
> +                address_space_to_dispatch(iotlb.target_as), addr, xlat,
> +                plen_out, is_mmio);
> +        if (!section) {
> +            goto unassigned;

(we won't reach here, will we?)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
