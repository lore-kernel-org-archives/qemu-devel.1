Received: from eggs.gnu.org ([2001:4830:134:3::10]:45886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2n-000866-5a
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2l-0007v8-Jh
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:01 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:45685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eQq2k-0007ta-Tb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:40:59 -0500
Date: Mon, 18 Dec 2017 17:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218063055.GY7753@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="npbjE3dh3wBH6WIP"
Content-Disposition: inline
In-Reply-To: <ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com


--npbjE3dh3wBH6WIP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 09:53:07AM +0100, Auger Eric wrote:
> Hi Yi L,
>=20
> On 13/11/2017 10:58, Liu, Yi L wrote:
> > On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
> >> On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> >>> From: Peter Xu <peterx@redhat.com>
> >>>
> >>> AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> >>> spaces to store arch-specific hooks.
> >>>
> >>> The first hook I would like to introduce is iommu_get(). Return an
> >>> IOMMUObject behind the AddressSpace.
> >>>
> >>> For systems that have IOMMUs, we will create a special address
> >>> space per device which is different from system default address
> >>> space for it (please refer to pci_device_iommu_address_space()).
> >>> Normally when that happens, there will be one specific IOMMU (or
> >>> say, translation unit) stands right behind that new address space.
> >>>
> >>> This iommu_get() fetches that guy behind the address space. Here,
> >>> the guy is defined as IOMMUObject, which includes a notifier_list
> >>> so far, may extend in future. Along with IOMMUObject, a new iommu
> >>> notifier mechanism is introduced. It would be used for virt-svm.
> >>> Also IOMMUObject can further have a IOMMUObjectOps which is similar
> >>> to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> >>> on MemoryRegion.
> >>>
> >>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >>
> >> Hi, sorry I didn't reply to the earlier postings of this after our
> >> discussion in China.  I've been sick several times and very busy.
> >=20
> > Hi David,
> >=20
> > Fully understood. I'll try my best to address your question. Also,
> > feel free to input further questions, anyhow, the more we discuss the
> > better work we done.
> >=20
> >> I still don't feel like there's an adequate explanation of exactly
> >> what an IOMMUObject represents.   Obviously it can represent more than
> >=20
> > IOMMUObject is aimed to represent the iommu itself. e.g. the iommu
> > specific operations. One of the key purpose of IOMMUObject is to
> > introduce a notifier framework to let iommu emulator to be able to
> > do iommu operations other than MAP/UNMAP. As IOMMU grows more and
> > more feature, MAP/UNMAP is not the only operation iommu emulator needs
> > to deal. e.g. shared virtual memory. So far, as I know AMD/ARM also
> > has it. may correct me on it. As my cover letter mentioned, MR based
> > notifier framework doesn=E2=80=99t work for the newly added IOMMU opera=
tions.
> > Like bind guest pasid table pointer to host and propagate guest's
> > iotlb flush to host.
> >=20
> >> a single translation window - since that's represented by the
> >> IOMMUMR.  But what exactly do all the MRs - or whatever else - that
> >> are represented by the IOMMUObject have in common, from a functional
> >> point of view.
> >=20
> > Let me take virt-SVM as an example. As far as I know, for virt-SVM,
> > the implementation of different vendors are similar. The key design
> > is to have a nested translation(aka. two stage translation). It is to
> > have guest maintain gVA->gPA mapping and hypervisor builds gPA->hPA
> > mapping. Similar to EPT based virt-MMU solution.
> >=20
> > In Qemu, gPA->hPA mapping is done through MAP/UNMAP notifier, it can
> > keep going. But for gVA->gPA mapping, only guest knows it, so hypervisor
> > needs to trap specific guest iommu operation and pass the gVA->gPA
> > mapping knowledge to host through a notifier(newly added one). In VT-d,
> > it is called bind guest pasid table to host.
>=20
> What I don't get is the PASID table is per extended context entry. I
> understand this latter is indexed by PCI device function. And today MR
> are created per PCIe device if I am not wrong. So why can't we have 1
> new MR notifier dedicated to PASID table passing? My understanding is
> the MR, having a 1-1 correspondence with a PCIe device and thus a
> context could be of right granularity.

Not really.  The MR(s) and AS is created per a group of devices which
will always see the same mappings.  On Intel that's the IOMMU domain.
On PAPR that's a partitionable-endpoint - except that we choose to
only have one PE per guest host bridge (but multiple host bridges is
standard for POWER).

There's a qemu hook to get the right AS for a device, which takes the
devfn as a parameter.  Depending on the host bridge implementation,
though, it won't necessary return a different AS for every device
though.

> Then I understand the only flags
> we currently have are NONE, MAP and UNMAP but couldn't we add a new one
> for PASID TABLE passing? So this is not crystal clear to me why MR
> notifiers are not adapted to PASID table passing.

Right, to me either.  Things get more complicated if both the 1st
level (per PASID) and 2nd level translations (per PCI RID) are visible
to the guest.  Having level 1 owned by the guest and 2nd level owned
by the host is the typical mode of operation, but if we want to model
bare metal machines we do need to handle the case of both.  Similarly,
implementing virt-SVM can't go and break our modelling of
"traditional" non-PASID aware IOMMUs.  Those are not usually present
in x86 guests, although they can be, and they are *always* present for
PAPR guests.

> > Also, for the gVA iotlb flushing, only guest knows it. So hypervisor
> > needs to propagate it to host. Here, MAP/UNMAP is not suitable since
> > this gVA iotlb flush here doesn=E2=80=99t require to modify host iommu
> > translation table.
> I don't really get this argument. IOMMUNotifier just is a notifier that
> is attached to an IOMMU MR and calls a an IOMMUNotify function, right?
> Then the role of the function currently is attached to the currently
> existing flags, MAP, UNMAP. This is not linked to an action on the
> physical IOMMU, right?

Maybe, maybe not.  In the case of emulated devices, it need not touch
the host MMU.  However, for the case of VFIO devices, we need to
mirror mappings in the guest IOMMU to the host IOMMU.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--npbjE3dh3wBH6WIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3YJ0ACgkQbDjKyiDZ
s5JXdRAAl+W5E13C4CzgmnzRG3ny9IRoU3Hf70bs9w/vVfA3lFODCGIe6+5JSmfk
GvMcYGYwPL8EeveQXyid30mOu3mmNtSC00xrnyXAzVbyyNA4RfeO/Q+WBjlklrLW
/LPg2xvV+NKjjTFb8WgGvw1pENDgkwxKsOaSz10uxqeQ49cCCfnR49jeJTH75uDr
iLiPgBosx5ktZpB1474c+kCv5neRKjGZ4Cd0g7MDB3erjuWEVimHIki3k/aRQFx9
EqG7vjtVCAGt2ZJeKoUBT1x3BJ1xjghERYL4iysxL1l3ysNcR9V+IvbdPflyHLwi
Z2SFTN/LliLOmAtUZSn9NKr5N6DgZ46aNwQx9zF71+GeyTAKk44YTTSYCH5Nmpao
khKWXXSFQ/vR8ezHbZL43k4GSRC4TCr0AKMASr6+ti9QIWsSGedZzDf9Rz1Fw3EW
kgJtmUeoXTFHX5WamMqceVz1AJ9l1CGfAnTVamj/HmdDJK8NdU+HP5sreUG4fm3Z
W8wNcnIb1xMQ6UI/+BGEF1YlGn1aVcgSI77B9yZMmoYoqLfQbLWexaABtIZQ4ISc
9vUjhEFttF29IFJFIJ4tLvE/dhX40yAY7+7WgKjKuMlmbo8bTQ4LEZ5Na/AchwP2
rgHDrLuKkMTt3qTAjXaAAEicMy3PYHytfPGmZAo5/b8RvHlINQo=
=eYkx
-----END PGP SIGNATURE-----

--npbjE3dh3wBH6WIP--
