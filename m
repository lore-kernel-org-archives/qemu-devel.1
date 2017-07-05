Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSe4N-0004Ae-6P
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSe4K-0005Il-1m
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:45:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:7978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dSe4J-0005Ej-M6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:45:47 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 5 Jul 2017 06:45:38 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
In-Reply-To: <20170703103115.GB22053@gmail.com>
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will
	Deacon <Will.Deacon@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

> From: Liu, Yi L
> Sent: Monday, July 3, 2017 6:31 PM
>=20
> Hi Jean,
>=20
>=20
> >
> > > 2. Define a structure in include/uapi/linux/iommu.h(newly added heade=
r
> file)
> > >
> > > struct iommu_tlb_invalidate {
> > > 	__u32	scope;
> > > /* pasid-selective invalidation described by @pasid */
> > > #define IOMMU_INVALIDATE_PASID	(1 << 0)
> > > /* address-selevtive invalidation described by (@vaddr, @size) */
> > > #define IOMMU_INVALIDATE_VADDR	(1 << 1)

For VT-d above two flags are related. There is no method of flushing
(@vaddr, @size) for all pasids, which doesn't make sense. address-
selective invalidation is valid only for a given pasid. So it's not appropr=
iate
to put them in same level of scope definition at least for VT-d.

> > > 	__u32	flags;
> > > /*  targets non-pasid mappings, @pasid is not valid */
> > > #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> >
> > Although it was my proposal, I don't like this flag. In ARM SMMU, we're
> > using a special mode where PASID 0 is reserved and any traffic without
> > PASID uses entry 0 of the PASID table. So I proposed the "NO_PASID" fla=
g
> > to invalidate that special context explicitly. But this means that
> > invalidation packet targeted at that context will have "scope =3D PASID=
" and
> > "flags =3D NO_PASID", which is utterly confusing.
> >
> > I now think that we should get rid of the IOMMU_INVALIDATE_NO_PASID
> flag
> > and just use PASID 0 to invalidate this context on ARM. I don't think
> > other architectures would use the NO_PASID flag anyway, but might be
> mistaken.
>=20
> I may suggest to keep it so far. On VT-d, we may pass some data in opaque=
,
> so
> we may work without it. But if other vendor want to issue non-PASID tagge=
d
> cache, then may encounter problem.

I'm worried about what's the criteria which attribute should be abstracted
in common structure and which can be left to opaque. It doesn't make
much sense to do such abstraction purely because different vendor formats
have some common fields. Usually we do such abstraction because=20
vendor-agnostic code need to do some common handling before going to
vendor specific code. However in this case VFIO is not expected to do anyth=
ing
with those IOMMU specific attributes. Then the structure is directly forwar=
ded
to IOMMU driver, which simply translates the structure into vendor specific
opaque data again. Then why bothering to do double translations in Qemu
and IOMMU driver side?

Take VT-d for example. Below is a summary of all possible selections around
invalidation of 1st level structure for svm:

Scope: All PASIDs, single PASID
for each PASID:
	all mappings, or page-selective mappings (addr, size)
invalidation target:
	IOTLB entries (leaf)
	paging structure cache (non-leaf)
	PASID cache (pasid->cr3)
invalidation hint:
	whether global pages are included
	drain reads/writes

Above are pretty architectural attributes if just looking at functional
purpose. Then if we really consider defining a common structure, it
might be more natural to define a superset of all vendors' capabilities
and remove the opaque field at all. But as said earlier the purpose of
doing such abstraction is not clear if there is no vendor-agnostic
user actually digesting those fields. Then should we reconsider the
full opaque approach?

Welcome comments since I may overlook something here. :-)

Thanks
Kevin
