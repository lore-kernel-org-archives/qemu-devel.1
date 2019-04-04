Received: from eggs.gnu.org ([209.51.188.92]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBwLz-0001UJ-0q
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBwLx-0005Uu-PA
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hBwLx-0005RP-E3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:01 -0400
Date: Thu, 4 Apr 2019 14:59:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190404065948.GB23212@xz-x1>
References: <AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401102515.GD8853@xz-x1>
	<AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
	<AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190403024018.GK11008@xz-x1>
	<AM6PR05MB6616802C8D185F294565E74CBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<AM6PR05MB66164C0598CFA23FFEEC6C4BBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR05MB66164C0598CFA23FFEEC6C4BBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
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
To: Elijah Shakkour <elijahsh@mellanox.com>
Cc: Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>

On Wed, Apr 03, 2019 at 10:10:35PM +0000, Elijah Shakkour wrote:

[...]

> > > > > > > You can also try to enable VT-d device log by appending:
> > > > > > >
> > > > > > >   -trace enable="vtd_*"
> > > > > > >
> > > > > > > In case it dumps anything useful for you.
> > > >
> > > > Here is the relevant dump (dev 01:00.01 is my VF):
> > > > "
> > > > vtd_inv_desc_cc_device context invalidate device 01:00.01
> > > > vtd_ce_not_present Context entry bus 1 devfn 1 not present
> > > > vtd_switch_address_space Device 01:00.1 switching address space
> > > > (iommu
> > > > enabled=1) vtd_ce_not_present Context entry bus 1 devfn 1 not
> > > > present vtd_err Detected invalid context entry when trying to sync
> > > > shadow page table
> > >
> > > These lines mean that the guest sent a device invalidation to your VF
> > > but the IOMMU found that the device context entry is missing.
> > >
> > > > vtd_iotlb_cc_update IOTLB context update bus 0x1 devfn 0x1 high
> > > > 0x102 low 0x2d007003 gen 0 -> gen 2 vtd_err_dmar_slpte_resv_error
> > > > iova
> > > > 0xf08e7000 level 2 slpte 0x2a54008f7
> > >
> > > This line should not exist in latest QEMU.  Are you sure you're using
> > > the latest QEMU?
> > 
> > I moved now to QEMU 4.0 RC2.
> > This is the what I get now:
> > vtd_iotlb_cc_update IOTLB context update bus 0x1 devfn 0x1 high 0x102 low
> > 0x2f007003 gen 0 -> gen 1
> > qemu-system-x86_64: vtd_iova_to_slpte: detected splte reserve non-zero
> > iova=0xf0d29000, level=0x2slpte=0x29f6008f7) vtd_fault_disabled Fault
> > processing disabled for context entry
> > qemu-system-x86_64: vtd_iommu_translate: detected translation failure
> > (dev=01:00:01, iova=0xf0d29000) Unassigned mem read 00000000f0d29000
> > 
> > I'm not familiar with vIOMMU registers, but I noticed that I must report
> > snoop control support to Hyper-V (i.e. bit 7 in extended capability register of
> > vIOMMU) in-order to satisfy IOMMU support for SRIOV.
> > vIOMMU.ecap before    0xf00f5e
> > vIOMMU.ecap after       0xf00fde
> > But I see that vIOMMU doesn't really support snoop control.
> > Could this be the problem that fails IOVA range check in this function
> > vtd_iova_range_check()?
> 
> Sorry, I meant the SLPTE reserved non-zero check failure in vtd_slpte_nonzero_rsvd()
> And NOT IOVA range check failure (since range check didn't fail)

Probably.  Currently VT-d emulation does not support snooping control,
and if you modify that ecap only you probably will encounter this
problem because then the guest kernel will setup the SNP bit in the
IOMMU page table entries which will violate the reserved bits in the
emulation code then you can see these errors.

Now talking about implementing the Snoop Control for Intel IOMMU for
real (which corresponds to vt-d ecap bit 7) - I'd confess I'm not 100%
clear on what does the "snooping" mean and what we need to do as an
emulator. I'm quotting from spec:

  "Snoop behavior for a memory access (to a translation structure
  entry or access to the mapped page) specifies if the access is
  coherent (snoops the processor caches) or not."

If it is only a capability showing that whether the hardware is
capable of snooping processor caches, then I don't think we need to do
much here as an emulator of VT-d simply because when we access the
data we're still from the processor's side (because we're emulating
the IOMMU behavior only) so the cache should always been coherent from
the POV of guest vCPUs, just like how the processors provide cache
coherence between two cores (so IMHO here the VT-d emulation code can
be run on one core/thread, and the vcpu which runs the guest iommu
driver can be run on another core/thread).  If so, maybe we can simply
declare support of that but we at least also need to remove the SNP
bit from vtd_paging_entry_rsvd_field[] array to reflect that we
understand that bit.

CCing Alex and Kevin to see whether I'm misunderstanding or in case of
any further input on the snooping support.

Regards,

-- 
Peter Xu
