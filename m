Received: from eggs.gnu.org ([2001:4830:134:3::10]:38634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEVE7-0002zj-Gx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEVE2-00071y-Jk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:33:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fEVE2-00070f-Dg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A0AB30016F4
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:33:53 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3E617145
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:33:53 +0000 (UTC)
Date: Fri, 4 May 2018 03:33:53 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <678097095.20043806.1525419233386.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180504042231.GC28447@xz-mi>
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<20180417140802.16711-4-pbonzini@redhat.com>
	<20180504042231.GC28447@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org



----- Original Message -----
> From: "Peter Xu" <peterx@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org
> Sent: Friday, May 4, 2018 6:22:31 AM
> Subject: Re: [Qemu-devel] [PATCH 3/4] exec: extract address_space_translate_iommu, fix page_mask corner case
> 
> On Tue, Apr 17, 2018 at 04:08:01PM +0200, Paolo Bonzini wrote:
> 
> [...]
> 
> > +static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion
> > *iommu_mr,
> > +                                                         hwaddr *xlat,
> > +                                                         hwaddr *plen_out,
> > +                                                         hwaddr
> > *page_mask_out,
> > +                                                         bool is_write,
> > +                                                         bool is_mmio,
> > +                                                         AddressSpace
> > **target_as)
> > +{
> > +    MemoryRegionSection *section;
> > +    hwaddr page_mask = (hwaddr)-1;
> > +
> > +    do {
> > +        hwaddr addr = *xlat;
> > +        IOMMUMemoryRegionClass *imrc =
> > memory_region_get_iommu_class_nocheck(iommu_mr);
> > +        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
> > +                                              IOMMU_WO : IOMMU_RO);
> > +
> > +        if (!(iotlb.perm & (1 << is_write))) {
> > +            goto unassigned;
> > +        }
> > +
> > +        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
> > +                | (addr & iotlb.addr_mask));
> > +        page_mask &= iotlb.addr_mask;
> > +        *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
> > +        *target_as = iotlb.target_as;
> > +
> > +        section = address_space_translate_internal(
> > +                address_space_to_dispatch(iotlb.target_as), addr, xlat,
> > +                plen_out, is_mmio);
> > +        if (!section) {
> > +            goto unassigned;
> 
> (we won't reach here, will we?)

Good point, I'll fix that.

Paolo

> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> --
> Peter Xu
> 
