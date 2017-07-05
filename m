Received: from eggs.gnu.org ([2001:4830:134:3::10]:55128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSskk-0008B0-Ny
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSskh-0006KH-Hw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:26:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dSskh-0006Ic-60
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:26:31 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 5 Jul 2017 22:26:24 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D2697F@SHSMSX101.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
In-Reply-To: <20170705112816.56554f65@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, July 6, 2017 1:28 AM
>=20
> On Wed, 5 Jul 2017 13:42:03 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
>=20
> > On 05/07/17 07:45, Tian, Kevin wrote:
> > >> From: Liu, Yi L
> > >> Sent: Monday, July 3, 2017 6:31 PM
> > >>
> > >> Hi Jean,
> > >>
> > >>
> > >>>
> > >>>> 2. Define a structure in include/uapi/linux/iommu.h(newly added
> header
> > >> file)
> > >>>>
> > >>>> struct iommu_tlb_invalidate {
> > >>>> 	__u32	scope;
> > >>>> /* pasid-selective invalidation described by @pasid */
> > >>>> #define IOMMU_INVALIDATE_PASID	(1 << 0)
> > >>>> /* address-selevtive invalidation described by (@vaddr, @size) */
> > >>>> #define IOMMU_INVALIDATE_VADDR	(1 << 1)
> > >
> > > For VT-d above two flags are related. There is no method of flushing
> > > (@vaddr, @size) for all pasids, which doesn't make sense. address-
> > > selective invalidation is valid only for a given pasid. So it's not a=
ppropriate
> > > to put them in same level of scope definition at least for VT-d.
> >
> > For ARM SMMU the "flush all by VA" operation is valid. Although it's
> > unclear at this point if we will ever allow that, it should probably st=
ay
> > in the common format, if there is one.
> >
> > >>>> 	__u32	flags;
> > >>>> /*  targets non-pasid mappings, @pasid is not valid */
> > >>>> #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> > >>>
> > >>> Although it was my proposal, I don't like this flag. In ARM SMMU, w=
e're
> > >>> using a special mode where PASID 0 is reserved and any traffic with=
out
> > >>> PASID uses entry 0 of the PASID table. So I proposed the "NO_PASID"
> flag
> > >>> to invalidate that special context explicitly. But this means that
> > >>> invalidation packet targeted at that context will have "scope =3D P=
ASID"
> and
> > >>> "flags =3D NO_PASID", which is utterly confusing.
> > >>>
> > >>> I now think that we should get rid of the
> IOMMU_INVALIDATE_NO_PASID
> > >> flag
> > >>> and just use PASID 0 to invalidate this context on ARM. I don't thi=
nk
> > >>> other architectures would use the NO_PASID flag anyway, but might b=
e
> > >> mistaken.
> > >>
> > >> I may suggest to keep it so far. On VT-d, we may pass some data in
> opaque,
> > >> so
> > >> we may work without it. But if other vendor want to issue non-PASID
> tagged
> > >> cache, then may encounter problem.
> > >
> > > I'm worried about what's the criteria which attribute should be
> abstracted
> > > in common structure and which can be left to opaque. It doesn't make
> > > much sense to do such abstraction purely because different vendor
> formats
> > > have some common fields. Usually we do such abstraction because
> > > vendor-agnostic code need to do some common handling before going to
> > > vendor specific code. However in this case VFIO is not expected to do
> anything
> > > with those IOMMU specific attributes. Then the structure is directly
> forwarded
> > > to IOMMU driver, which simply translates the structure into vendor
> specific
> > > opaque data again. Then why bothering to do double translations in
> Qemu
> > > and IOMMU driver side?>
> > > Take VT-d for example. Below is a summary of all possible selections
> around
> > > invalidation of 1st level structure for svm:
> > >
> > > Scope: All PASIDs, single PASID
> > > for each PASID:
> > > 	all mappings, or page-selective mappings (addr, size)
> > > invalidation target:
> > > 	IOTLB entries (leaf)
> > > 	paging structure cache (non-leaf)
> >
> > I'm curious, can you invalidate all intermediate paging structures for =
a
> > given PASID without invalidating the leaves?
> >
> > > 	PASID cache (pasid->cr3)
> > I guess any implementations that gives the whole PASID table to userspa=
ce
> > will need the PASID cache invalidation. This was missing from my propos=
al
> > since it was from virtio-iommu.
> >
> > > invalidation hint:
> > > 	whether global pages are included
> > > 	drain reads/writes>
> > > Above are pretty architectural attributes if just looking at function=
al
> > > purpose. Then if we really consider defining a common structure, it
> > > might be more natural to define a superset of all vendors' capabiliti=
es
> > > and remove the opaque field at all. But as said earlier the purpose o=
f
> > > doing such abstraction is not clear if there is no vendor-agnostic
> > > user actually digesting those fields. Then should we reconsider the
> > > full opaque approach?
> > >
> > > Welcome comments since I may overlook something here. :-)
> >
> > I guess on x86 the invalidation packet formats are stable, but for ARM =
I'm
> > reluctant to deal with vendor-specific formats at the API level, becaus=
e
> > they tend to be volatile. If a virtual IOMMU version is different from =
the
> > physical one, then the page table format will be the same but invalidat=
ion
> > format will not.
> >
> > So it would be good to define common fields that have the same effects
> > regardless on the underlying pIOMMU. And the fields that differ between
> > ARM and x86 seem to only be hints.
> >
> > In addition on ARM SMMU, the guest cannot build an invalidation
> command
> > that the host could simply copy into the hardware command queue. The
> > pIOMMU driver needs to craft an invalidation command with a Virtual
> > Machine ID, that the guest is never aware of, and a separate ATS
> > invalidation command. It might also need to retrieve an Address Space I=
D
> > associated with the given PASID if it chose to hide it from the guest.
> >
> > So for us the invalidation structure would always be different from the
> > hardware one. That's why I do not have any reason the prefer an opaque
> > structure in the first place, and defining generic fields looks much
> > neater :) Then again, I don't have any strong technical objection to it=
.
>=20
> I have an objection to opaque data, it's not documented for users,
> can't be considered a stable ABI, introduces compatibility issues, and

So far there are three options discussed:

1) full opaque
2) partial specified + opaque
3) fully specified

I take your objection as going 3), since as long as there is still
opaque the same ABI compatibility issue still exist, right? Then
even vendor specific capabilities will be explicitly defined in
this structure, and then we may also need a query interface
to know which capabilities are supported underlying.

> makes debugging difficult.  vfio should have the right to and the
> ability to validate anything coming from the user, whether it's vendor

this part I didn't quite get. Which part in such structure will be
validated by VFIO? From current description, they are all IOMMU
specific knowledge.

> specific or generic.  Your concern about hardware changing is just as
> valid on VT-d.  Even if we're emulating VT-d in userspace on a VT-d
> host, how do we know that the two are strictly compatible?  It may be

It makes sense

> today, but we cannot predict the future.  A fully specified ABI means
> that we can properly version it, and if necessary provide compatibility
> handlers if the hardware changes.  Thanks,
>=20

Thanks
Kevin
