Received: from eggs.gnu.org ([2001:4830:134:3::10]:43907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7OE-0006Kn-Tp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7OA-0008Dl-0F
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gM7O9-0008C3-O2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:05 -0500
Date: Mon, 12 Nov 2018 16:15:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181112081546.GB20675@xz-x1>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-2-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541764187-10732-2-git-send-email-yu.c.zhang@linux.intel.com>
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
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Nov 09, 2018 at 07:49:45PM +0800, Yu Zhang wrote:
> Currently, vIOMMU is using the value of IOVA address width, instead of
> the host address width(HAW) to calculate the number of reserved bits in
> data structures such as root entries, context entries, and entries of
> DMA paging structures etc.
> 
> However values of IOVA address width and of the HAW may not equal. For
> example, a 48-bit IOVA can only be mapped to host addresses no wider than
> 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> in an invalid IOVA being accepted.
> 
> To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> whose value is initialized based on the maximum physical address set to
> guest CPU. Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> to clarify.

IIRC I raised this question some time ago somewhere but no one
remembered to follow that up.  Thanks for fixing it.

It looks mostly good to me, only one tiny comment below...

[...]

> @@ -887,6 +887,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>      uint64_t iova = start;
>      uint64_t iova_next;
>      int ret = 0;
> +    uint8_t haw = info->as->iommu_state->haw_bits;

For now vtd_page_walk_info->aw_bits caches the GAW information and we
use a single vtd_page_walk_info during one page walk, maybe we can
also do the same for HAW instead of fetching it every time here from
info->as->iommu_state->haw_bits?

Regards,

-- 
Peter Xu
