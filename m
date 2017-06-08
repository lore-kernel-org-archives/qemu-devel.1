Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1dIskG-0003Lg-4k
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1dIskB-0001e4-D2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:24:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:61518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1dIskA-0001ds-Va
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:24:39 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 8 Jun 2017 08:24:33 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743908C040@shsmsx102.ccr.corp.intel.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
	<20170508060744.GG25748@umbus.fritz.box>
	<20170508073217.GD2820@pxdev.xzpeter.org>
	<20170510070406.GU25748@umbus.fritz.box>
	<20170511050426.GF28293@pxdev.xzpeter.org>
	<20170515053211.GB11105@umbus.fritz.box>
	<20170525072430.GA22816@pxdev.xzpeter.org>
	<20170526053014.GL12929@umbus.fritz.box>
In-Reply-To: <20170526053014.GL12929@umbus.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

Hi David,

I added some update on your question. See if it make any sense.

> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Friday, May 26, 2017 1:30 PM
> To: Peter Xu <peterx@redhat.com>
> On Thu, May 25, 2017 at 03:24:30PM +0800, Peter Xu wrote:

[...]

> > > > > > >
> > > > > > > I don't believe we have any existing platforms with both an
> > > > > > > IOMMU and a direct mapped window in a device's address
> > > > > > > space.  But it seems to be just too plausible a setup to not
> > > > > > > plan for it. [1]
> > > > > > >
> > > > > > > > This patch derived from a requirement in virt-svm project (=
on x86).
> > > > > > > > Virt-svm needs some notification mechanism for each IOMMU
> > > > > > > > (or say, the IOMMU that managers the SVM-enabled device).
> > > > > > > > For now, all IOMMU notifiers are per-memory-region not
> > > > > > > > per-iommu, and that's imho not what virt-svm wants. Any sug=
gestions?
> > > > > > >
> > > > > > > I don't know SVM, so I can't really make sense of that.
> > > > > > > What format does this identifier need?  What does "for one
> > > > > > > IOMMU" mean in this context - i.e. what guest observable
> > > > > > > properties require the IDs to be the same or to be different.
> > > > > >
> > > > > > Virt-svm should need to trap the content of a register
> > > > > > (actually the data is in the memory, but, let's assume it's a
> > > > > > mmio operation for simplicity, considering it is finally
> > > > > > delivered via invalidation requests), then pass that info down
> > > > > > to kernel. So the listened element is per-iommu not per-mr
> > > > > > this time. When the content changed, vfio will need to be notif=
ied, then
> pass this info down.
> > > > >
> > > > > I don't entirely follow what you're saying.  When the virtual
> > > > > hardware gets an invalidate request, it looks up the unit to
> > > > > invalidate in memory?  Which component gets to decide that ID?
> > > > > How is it advertised to the guest OS?
> > > > >
> > > > > If your ID is tied to the AS now, you could just iterate through
> > > > > the AS and invalidate any IOMMU MRs that are present within it.
> > > > >
> > > > > Alternatively, if the ID is tied to something more concrete,
> > > > > like a specific PCI host bridge (which incorporates the IOMMU
> > > > > logic), then that device probably already has a handle on the
> > > > > right IOMMU MR to invalidate it.
> > > >
> > > > Sorry to be unclear on the requirement. I don't know what's the ID
> > > > you mentioned above... Anyway, let me try to further simplify the
> > > > use case.
> > >
> > > Right, the ID was me guessing badly at what's going on here, so I
> > > think it confused rather than clarifying.
> > >
> > > > Just assume we have such a requirement: when one register of
> > > > vIOMMU changes, we need to pass this register data to the hardware
> > > > IOMMU by some way. And, let's assume this is a notification
> > > > mechanism, so that every device in the system can listen to this
> > > > register change, then capture what has changed to what. Here the
> > > > point is, in all cases this event is not related to memory region
> > > > at all. So imho we need some other way to do it besides memory regi=
on
> IOMMU notifiers.
> > >
> > > Ok.  So is this right?
> > > 	* You have a single bank of vIOMMU registers
> > > 	* Which control two (or more) IOMMU regions in in the guest's
> > >           address space
> > > 	* Assuming the host also has an AMD IOMMU, those will be
> > >           backed by a single IOMMU on the host ("single" meaning
> > >           controlled by a single bank of host registers)
> > >
> > > I'm assuming the guest IOMMU code must know which IOMMU regions it
> > > is managing, so getting from the guest registers to the set of IOMMU
> > > MRs should be easy.
> > >
> > > What's the operation that needs to happen on the host IOMMU, in
> > > terms of the VFIO IOMMU interface?
> >
> > (Sorry to respond so late...)
> >
> > It'll pass the captured data downward to host IOMMU in some way.
> >
> > IMHO if we are discussing the notifier thing only, we don't really
> > need to know what would it do after it gets the data. The point is how
> > we should define this kind if notifies, which differs from current
> > memory region based notifiers.
>=20
> I'm trying to understand how it differs - I still don't have a clear pict=
ure.  That's why
> I'm asking what needs to be passed to the host MMU, so I can see why you =
need this
> different notifier.

It differs in the registration. For the MemoryRegion based notifier(MAP/UNM=
AP), it
is registered when IOMMU MemoryRegion is used. On VT-d, it is the time swit=
ch
system memory address space to vtd address space. This is introduced by the=
 patch
below:

[Qemu-devel] [PATCH v9 8/9] intel_iommu: allow dynamic switch of IOMMU regi=
on

For virt-SVM, it wants to add two more notfiers. If we add the notifiers at=
 the same
time with the MAP/UNMAP notifier, then virt-SVM cannot work if there is no =
IOMMU
region switch. This scenario happens when passthru-mode is used in the vIOM=
MU.

So in order to solve the scenario above, I discussed with Peter. My initial=
 plan is to move
the registration of new notifiers to be in vfio_realize(). The logic is if =
vIOMMU is exposed
to guest, then the new notifiers would be registered. This approach is prop=
osed in my
RFC patch for virt-SVM.

https://www.spinics.net/lists/kvm/msg148803.html

However, Peter mentioned the approach in the RFC patch may not be compatibl=
e with
sPAPR since there may be multiple MemoryRegion for sPARR. It would result i=
n multiple
notifier registration on sPARR.

Due to it, Peter tries to introduce the IOMMUObject. It would help the dete=
ction in
vfio_realize() to check if vIOMMU is exposed to guest. Also it moves the io=
mmu specific
notifiers to be tied on the exposure of vIOMMU instead of IOMMU Region swit=
ching.

Any further comments, pls let me know.

Thanks,
Yi L
