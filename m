Received: from eggs.gnu.org ([209.51.188.92]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hDNLK-00042v-UX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hDNGs-0006Ne-Gg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hDNGq-0006Km-QM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:56:41 -0400
Date: Mon, 8 Apr 2019 13:56:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190408055629.GA4340@xz-x1>
References: <AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
	<AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190403024018.GK11008@xz-x1>
	<AM6PR05MB6616802C8D185F294565E74CBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<AM6PR05MB66164C0598CFA23FFEEC6C4BBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190404065948.GB23212@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9CE809@SHSMSX104.ccr.corp.intel.com>
	<AM6PR05MB6616FF1FD229194F40882133BD530@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9D1F97@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C9D1F97@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Elijah Shakkour <elijahsh@mellanox.com>, Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Apr 08, 2019 at 12:32:12AM +0000, Tian, Kevin wrote:

[...]

> > > > Probably.  Currently VT-d emulation does not support snooping control,
> > > > and if you modify that ecap only you probably will encounter this
> > > > problem because then the guest kernel will setup the SNP bit in the
> > > > IOMMU page table entries which will violate the reserved bits in the
> > > > emulation code then you can see these errors.
> > > >
> > > > Now talking about implementing the Snoop Control for Intel IOMMU for
> > > > real (which corresponds to vt-d ecap bit 7) - I'd confess I'm not 100%
> > > > clear on what does the "snooping" mean and what we need to do as an
> > > > emulator. I'm quotting from spec:
> > > >
> > > >   "Snoop behavior for a memory access (to a translation structure
> > > >   entry or access to the mapped page) specifies if the access is
> > > >   coherent (snoops the processor caches) or not."
> > > >
> > > > If it is only a capability showing that whether the hardware is
> > > > capable of snooping processor caches, then I don't think we need to do
> > > > much here as an emulator of VT-d simply because when we access the
> > > > data we're still from the processor's side (because we're emulating
> > > > the IOMMU behavior only) so the cache should always been coherent
> > from
> > > > the POV of guest vCPUs, just like how the processors provide cache
> > > > coherence between two cores (so IMHO here the VT-d emulation code
> > can
> > > > be run on one core/thread, and the vcpu which runs the guest iommu
> > > > driver can be run on another core/thread).  If so, maybe we can simply
> > > > declare support of that but we at least also need to remove the SNP
> > > > bit from vtd_paging_entry_rsvd_field[] array to reflect that we
> > > > understand that bit.
> > > >
> > > > CCing Alex and Kevin to see whether I'm misunderstanding or in case of
> > > > any further input on the snooping support.
> > > >
> > >
> > > for software DMA yes snoop is guaranteed since it's just CPU access.
> > >
> > > However for VFIO device i.e. hardware DMA, snoop should be reported
> > > based on physical IOMMU capability. It's fine to report no snoop control on
> > > vIOMMU (current state) even when it's physically supported. It just results
> > > that L1 VMM must favor guest cache attributes instead of forcing WB in L1
> > > EPT when doing nested passthrough. However it's incorrect to report snoop
> > > control on vIOMMU when physically it's not supported, otherwise L1 VMM
> > > may force WB in L1 EPT and enable snoop field in vIOMMU 2nd level PTE
> > with
> > > assumption that hardware snoop is guaranteed (however it isn't). Then it
> > > becomes a correctness issue.
> > >
> > 
> > If my device is fully emulated, can I ignore the SNP bit in the SLPTE? What is
> > the cost of ignoring it in such a case? What could go wrong?
> > (I tried to ignore it and it seems that translations work for me now).
> > 
> 
> I'm not sure what you meant by 'ignore' here. But as earlier pointed
> out by Peter, for emulated devices you don't need do anything special
> here. You can just report snoop capability and then remove it from
> reserved bit check in SLPTE.

Yes.  For simplicity, you can add a new patch for a new property
"x-snooping" into vtd_properties and make it false by default, then
allow the user to turn it on manually considering that the user should
be clear on the consequence of this knob.

Later on we can consider to enrich this property by checking the host
configurations when detected assigned devices (I feel like it can be a
VFIO_DMA_CC_IOMMU ioctl upon every assigned device, or container), or
more.

Regards,

-- 
Peter Xu
