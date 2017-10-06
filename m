Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0Prx-0003WF-4L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0Prt-00048C-33
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:28:37 -0400
References: <20171005171309.1250-1-maxime.coquelin@redhat.com>
	<20171005171309.1250-2-maxime.coquelin@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <cdcc828e-bd75-cd06-9c95-9e661055a7b4@redhat.com>
Date: Fri, 6 Oct 2017 12:28:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171005171309.1250-2-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [REBASED 1/2] exec: add page_mask for
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org



On 10/05/2017 07:13 PM, Maxime Coquelin wrote:
>   static MemoryRegionSection flatview_do_translate(FlatView *fv,
>                                                    hwaddr addr,
>                                                    hwaddr *xlat,
> -                                                 hwaddr *plen,
> +                                                 hwaddr *plen_out,
> +                                                 hwaddr *page_mask_out,
>                                                    bool is_write,
>                                                    bool is_mmio,
>                                                    AddressSpace **target_as)
> @@ -480,11 +498,17 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
>       MemoryRegionSection *section;
>       IOMMUMemoryRegion *iommu_mr;
>       IOMMUMemoryRegionClass *imrc;
> +    hwaddr page_mask = TARGET_PAGE_MASK;

There is a bug here that breaks the case when iommu is not enabled in
kernel cmdline. In this case returned page_mask is the about init value.

But TARGET_PAGE_MASK actually represents the pfn mask, from cpu-all.h:
#define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
With TARGET_PAGE_SIZE being 12 on x86.

What we expect here as init value is its complement, i.e. 0xfff on x86.

I'll send a follow-up patch in a short while.

Regards,
Maxime
