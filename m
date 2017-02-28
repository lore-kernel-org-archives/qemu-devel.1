Received: from eggs.gnu.org ([2001:4830:134:3::10]:53787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1cipvf-0002yo-PO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1cipvc-0000RT-LV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:07:31 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:48952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1cipvc-0000QJ-DF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:07:28 -0500
Date: Tue, 28 Feb 2017 17:07:19 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170228220719.GD2352@char.us.ORACLE.com>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC Design Doc v3] Enable Shared Virtual Memory
 feature in pass-through scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hao, Xudong" <xudong.hao@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, 'Peter Xu' <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

On Wed, Nov 30, 2016 at 08:49:24AM +0000, Liu, Yi L wrote:
> What's changed from v2:
> a) Detailed feature description
> b) refine description in "Address translation in virtual SVM"
> b) "Terms" is added
> 
> Content
> ===============================================
> 1. Feature description
> 2. Why use it?
> 3. How to enable it
> 4. How to test
> 5. Terms
> 
> Details
> ===============================================
> 1. Feature description
> Shared virtual memory(SVM) is to let application program share its virtual
> address with SVM capable devices. 
> 
> Shared virtual memory details:
> a) SVM feature requires ATS/PRQ/PASID support on both device side and
> IOMMU side.
> b) SVM capable devices could send DMA requests with PASID, the address
> in the request would be a virtual address within a program's virtual address
> space.
> c) IOMMU would use first level page table to translate the address in the
> request.
> d) First level page table is a HVA->HPA mapping on bare metal.
> 
> Shared Virtual Memory feature in pass-through scenarios is actually SVM
> virtualization. It is to let application programs(running in guest)share their
> virtual address with assigned device(e.g. graphics processors or accelerators).

I think I am missing something obvious, but the current way that DRM
works is that the kernel sets up its VA addresses for the GPU and it uses
that for its ring. It also setups an user level mapping for the GPU if the
application (Xorg) really wants it - but most of the time the kernel is
in charge of poking at the ring, and the memory that is shared with the
Xorg is normal RAM allocated via alloc_pages (see drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
and drivers/gpu/drm/ttm/ttm_page_alloc.c).

So are talking about the guest applications having access to the 
ring of the GPU?
