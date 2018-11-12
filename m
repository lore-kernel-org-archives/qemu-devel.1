Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gM8YR-0001m5-72
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gM8YL-0003EB-GS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:30:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:2155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gM8YJ-0003CS-Nw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:30:41 -0500
Date: Mon, 12 Nov 2018 17:28:25 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181112092825.rqvp7lcq56to7dsa@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-2-git-send-email-yu.c.zhang@linux.intel.com>
	<20181112081546.GB20675@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112081546.GB20675@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v1 1/3] intel-iommu: differentiate host
 address width from IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Nov 12, 2018 at 04:15:46PM +0800, Peter Xu wrote:
> On Fri, Nov 09, 2018 at 07:49:45PM +0800, Yu Zhang wrote:
> > Currently, vIOMMU is using the value of IOVA address width, instead of
> > the host address width(HAW) to calculate the number of reserved bits in
> > data structures such as root entries, context entries, and entries of
> > DMA paging structures etc.
> > 
> > However values of IOVA address width and of the HAW may not equal. For
> > example, a 48-bit IOVA can only be mapped to host addresses no wider than
> > 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> > in an invalid IOVA being accepted.
> > 
> > To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> > whose value is initialized based on the maximum physical address set to
> > guest CPU. Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> > to clarify.
> 
> IIRC I raised this question some time ago somewhere but no one
> remembered to follow that up.  Thanks for fixing it.
> 
> It looks mostly good to me, only one tiny comment below...
> 
> [...]
> 
> > @@ -887,6 +887,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> >      uint64_t iova = start;
> >      uint64_t iova_next;
> >      int ret = 0;
> > +    uint8_t haw = info->as->iommu_state->haw_bits;
> 
> For now vtd_page_walk_info->aw_bits caches the GAW information and we
> use a single vtd_page_walk_info during one page walk, maybe we can
> also do the same for HAW instead of fetching it every time here from
> info->as->iommu_state->haw_bits?

Thank you, Peter. And yes, using haw_bits in vtd_page_walk_info is better. :)

> 
> Regards,
> 
> -- 
> Peter Xu
> 

B.R.
Yu
