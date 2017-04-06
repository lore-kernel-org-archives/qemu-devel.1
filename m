Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw4BO-0008Hl-L8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw4BL-0004bi-K4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:58:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:2249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cw4BL-0004ai-8B
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:58:23 -0400
Date: Thu, 6 Apr 2017 17:58:18 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170406095818.vshfv2jgqfzxjhrd@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<2f298f0a-cf07-d131-90c2-bef89537d981@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f298f0a-cf07-d131-90c2-bef89537d981@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: qemu-devel@nongnu.org, dan.j.williams@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 04/06/17 17:39 +0800, Xiao Guangrong wrote:
> 
> 
> On 31/03/2017 4:41 PM, Haozhong Zhang wrote:
> > This patch series constructs the flush hint address structures for
> > nvdimm devices in QEMU.
> > 
> > It's of course not for 2.9. I send it out early in order to get
> > comments on one point I'm uncertain (see the detailed explanation
> > below). Thanks for any comments in advance!
> > 
> > 
> > Background
> > ---------------
> > Flush hint address structure is a substructure of NFIT and specifies
> > one or more addresses, namely Flush Hint Addresses. Software can write
> > to any one of these flush hint addresses to cause any preceding writes
> > to the NVDIMM region to be flushed out of the intervening platform
> > buffers to the targeted NVDIMM. More details can be found in ACPI Spec
> > 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
> > 
> > 
> > Why is it RFC?
> > ---------------
> > RFC is added because I'm not sure whether the way in this patch series
> > that allocates the guest flush hint addresses is right.
> > 
> > QEMU needs to trap guest accesses (at least for writes) to the flush
> > hint addresses in order to perform the necessary flush on the host
> > back store. Therefore, QEMU needs to create IO memory regions that
> > cover those flush hint addresses. In order to create those IO memory
> > regions, QEMU needs to know the flush hint addresses or their offsets
> > to other known memory regions in advance. So far looks good.
> > 
> > Flush hint addresses are in the guest address space. Looking at how
> > the current NVDIMM ACPI in QEMU allocates the DSM buffer, it's natural
> > to take the same way for flush hint addresses, i.e. let the guest
> > firmware allocate from free addresses and patch them in the flush hint
> > address structure. (*Please correct me If my following understand is wrong*)
> > However, the current allocation and pointer patching are transparent
> > to QEMU, so QEMU will be unaware of the flush hint addresses, and
> > consequently have no way to create corresponding IO memory regions in
> > order to trap guest accesses.
> 
> Er, it is awkward and flush-hint-table is static which may not be
> easily patched.
> 
> > 
> > Alternatively, this patch series moves the allocation of flush hint
> > addresses to QEMU:
> > 
> > 1. (Patch 1) We reserve an address range after the end address of each
> >    nvdimm device. Its size is specified by the user via a new pc-dimm
> >    option 'reserved-size'.
> > 
> 
> We should make it only work for nvdimm?
>

Yes, we can check whether the machine option 'nvdimm' is present when
plugging the nvdimm.

> >    For the following example,
> >         -object memory-backend-file,id=mem0,size=4G,...
> >         -device nvdimm,id=dimm0,memdev=mem0,reserved-size=4K,...
> >         -device pc-dimm,id=dimm1,...
> >    if dimm0 is allocated to address N ~ N+4G, the address of dimm1
> >    will start from N+4G+4K or higher. N+4G ~ N+4G+4K is reserved for
> >    dimm0.
> > 
> > 2. (Patch 4) When NVDIMM ACPI code builds the flush hint address
> >    structure for each nvdimm device, it will allocate them from the
> >    above reserved area, e.g. the flush hint addresses of above dimm0
> >    are allocated in N+4G ~ N+4G+4K. The addresses are known to QEMU in
> >    this way, so QEMU can easily create IO memory regions for them.
> > 
> >    If the reserved area is not present or too small, QEMU will report
> >    errors.
> > 
> 
> We should make 'reserved-size' always be page-aligned and should be
> transparent to the user, i.e, automatically reserve 4k if 'flush-hint'
> is specified?
>

4K alignment is already enforced by current memory plug code.

About the automatic reservation, is a non-zero default value
acceptable by qemu design/convention in general?

Thanks,
Haozhong
