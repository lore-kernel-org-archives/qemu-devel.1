Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWX2E-0001sl-72
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWX2C-00021o-Ga
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:35:58 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:41895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eWX2B-0001ys-Pt
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:35:56 -0500
Date: Wed, 3 Jan 2018 11:28:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180103002817.GG24581@umbus.fritz.box>
References: <20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
	<20171220064730.GB7070@sky-dev>
	<20171220111816.GG5981@umbus.fritz.box>
	<20171221084019.GA13501@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <20171221084019.GA13501@sky-dev>
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 04:40:19PM +0800, Liu, Yi L wrote:
> On Wed, Dec 20, 2017 at 10:18:16PM +1100, David Gibson wrote:
> > On Wed, Dec 20, 2017 at 02:47:30PM +0800, Liu, Yi L wrote:
> > > On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> > > > On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > > > > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > > > >=20
> > > > >=20
> [...]
> > > > So, having read and thought a bunch more, I think I know where you
> > > > need to start hooking this in.  The thing is the current qemu PCI D=
MA
> > > > structure assumes that each device belongs to just a single PCI
> > > > address space - that's what pci_device_iommu_address_space() return=
s.
> > > >=20
> > > > For virt-SVM that's just not true.  IIUC, a virt-SVM capable device
> > > > could simultaneously write to multiple process address spaces, since
> > > > the process IDs actually go over the bus.
> > >=20
> > > Correct.
> > >=20
> > > > So trying to hook notifiers at the AddressSpace OR MemoryRegion lev=
el
> > > > just doesn't make sense - if we've picked a single addresss space f=
or
> > > > the device, we've already made a wrong step.
> > >=20
> > > That's also why we want to have notifiers based on IOMMUObject(may be
> > > not a suitable name, let me use it as the patch named).
> >=20
> > Right, I think "IOMMUObject" is a misleading name.
> >=20
> > > > Instead what you need I think is something like:
> > > > pci_device_virtsvm_context().  virt-SVM capable devices would need =
to
> > > > call that *before* calling pci_device_iommu_address_space ().  Well
> > > > rather the virt-SVM capable DMA helpers would need to call that.
> > > >=20
> > > > That would return a new VirtSVMContext (or something) object, which
> > > > would roughly correspond to a single PASID table.  That's where the
> > > > methods and notifiers for managing that would need to go.
> > >=20
> > > Correct, pci_device_iommu_address_space() returns an AS and it is
> > > a PCI address space. And if pci_device_virtsvm_context() is also
> > > called in vfio_realize(), it may not return an AS since there may
> > > be no 1st level translation page table bound.
> > >=20
> > > So as you said, return a new VirtSVMContext, this VirtSVMContext can
> > > hook some new notifiers. I think the IOMMUObject introduced in this p=
atch
> > > can meet the requirement. But it may be re-named.
> >=20
> > Ok.
> >=20
> > > So here it addressed the concern you raised before which is hook IOMM=
UObject
> > > via a PCI address space. Regards to VirtSVMContext, it may be a repla=
cement
> > > of IOMMUObject. As it is related to PASID, I'm considering to name it=
 as
> > > IOMMUPasidContext or IOMMUPasidObject. So it would be an abstraction =
of all
> > > the IOMMU PASID related operations.
> >=20
> > I'm ok with calling it a "PASID context".
> >=20
> > Thinking about this some more, here are some extra observations:
> >=20
> >  * I think each device needs both a PASID context and an ordinary
> >    address space.  The PASID context would be used for bus
> >    transactions which include a process id, the address space for
> >    those that don't.
>=20
> Correct. Also virt-SVM still needs the PCI Address space. And the PCI
> Address space =3D=3D Guest physical Address space.

Not necessarily.  That's true if you're only making the L1 translation
guest visible.  But I think we need to at least think about the case
where both L1 and L2 translations are guest visible, in which case the
PCI address space is not the same as the guest physical address space.

> For virt-SVM, requires
> pt mode to ensure the nested translation.

What is pt mode?

> >  * Theoretically, the PASID context could be modelled as an array/map
> >    of AddressSpace objects for each process ID.  However, creating all
>=20
> I also thought about creating AddressSpace objects for each process ID.
> But I don't think we need to do it. My reason as below:
>=20
> In theory, it is correct to have AddressSpace object for each process
> virtual address space in Qemu, and this is what we are doing for PCI
> address space so far. However, this is necessary when we want to mirror
> the mapping to host. Each time there is mapping changed within the PCI
> address space, we need to mirror it to host.
>=20
> While for virt-SVM, we don't need to mirror the changes within the guest
> process address space. The nested translation capability in HW brings us
> a convenience. In nested translation, HW can access a guest PASID table
> with a GPA(this is what Intel and AMD does, not sure about ARM, maybe or
> maybe not). For VT-d and AMD-IOMMU, even any change in guest PASID table,
> it is not necessary to mirror it to host. Based on the statements above,
> there is a candidate function to be included in PASIDContext. It could be
> bind_guest_pasid_table(). And be used to set the guest PASID Table to host
> translation structure when guest finds a device is has SVM
> capability.

That's true for passthrough devices, but not for qemu emulated
devices.  None of those support SVM yet, but there's no reason they
couldn't in future.

Even though that will never be the main production case, I think we'll
get a better model if we think about these edge cases carefully.

> >    those AddressSpace objects in advance might be too expensive.  I
> >    can see a couple of options to avoid this:
> >=20
> > 1) Have the PASID context class include a 'translate' method similar
> > to the one in IOMMUMemoryRegionClass, but taking a process ID as well
> > as an address.  This would avoid creating extra AddressSpace objects,
> > but might require duplicating a bunch of the translation code that
> > already exists for AddressSpace.
>=20
> Translation code actually walks the guest CR3 table to get a
> GVA->GPA map.

Right, but that's clearly x86 specific.

> But it is not really required so far due to HW capability.
>=20
> >=20
> > 2) "Lazily" create AddressSpace objects.  The generic part of the
> > PASID aware DMA helper functions would use a cache of AddressSpace's
> > for particular process IDs, using the AddressSpace (and MemoryRegion
> > within) to translate accesses for a particular process ID.  However,
> > these AddressSpace and MemoryRegion objects would only be created when
> > the device first accesses that address space.  In the common case,
> > where a single device is just being used by a single process or a
> > small number, this should keep the number of AddressSpace objects
> > relatively small.  Obviously the cache would need to be invalidated,
> > cleaning up the AddressSpace objects, when the PASID table is altered.
>=20
> This "Lazily" mechanism is not required. But I agree with the last statem=
ent.
> When PASID Table altered, the cache should be invalidated. Additionally, =
the
> cache for the mappings(GVA) within the guest process address space should=
 also
> be invalidated when there is change. This also calls for a candidate func=
tion
> in PASIDContext. It could be svm_invalidate_tlb(). And be used to invalid=
ate
> GVA cache and also PASID entry cache.
>=20
> >=20
> >  * I realize that the expected case here is with KVM, where the guest
> >    controls the first level translation, but the host controls the
> >    second level translation.  However, we should also be able to model
>=20
> Yeah, this is the case. And to be accurate, both the 1st level and 2nd le=
vel
> translation here happens on HW IOMMU. The 1st level page table is actually
> like "linked" from guest. And the 2nd level page table is created/conroll=
ed
> by Qemu(with MAP/UNMAP).
>=20
> >    the case where the guest controls both levels for the sake of full
> >    system emulation.  I think understanding this case will lead to a
> >    better design even for the simpler case.
>=20
> Not sure if I got your point accurately. Let me try to reply based on
> what I got. If guest enables virt-IOVA(DMA isolaton in guest scope) and
> virt-SVM. I think this is a case which guest controls both 1st and 2nd
> level translation.

That sounds right, from my limited knowledge of the x86 IOMMU.

> For virt-IOVA, we need to mirror all the guest IOVA mapping to host(aka.
> shadow). Current MemoryRegion based notifiers(MAP/UNMAP) should be enough.
> Peter has already upstreamed it.

Right, but we also need to model the translations for emulated
devices.

> > Do you have a plan for what the virt-SVM aware DMA functions will look
> > like?
>=20
> I think there are two candidates so far. This should be enough for VT-d a=
nd
> AMD-IOMMU. For ARM-SMMU, it may need extra function.
> * bind_guest_pasid_table()
> * svm_invalidate_tlb()

That's not really what I meant.  What I was getting it if you were
writing an emulated device which supported SVM, what would the
functions to perform SVM-aware DMA look like?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMI54ACgkQbDjKyiDZ
s5Lw+xAAn6Zywmh28lSiFPm2m0zXfgDihyioV4Obl/31vNjUIjQrE9jq5Wtxb/T+
nm8733mJSLEVyt7pYxZi4/32fdieX2CRbz2H1G6+Tw7wGmt5MvosJHu7UIgYy4BB
Dw4kpP4yye8Qnf5hkOYp/Kd4MrD6DXhJAw//suuWNAexyXNgu4XodOM0pcwk9QMg
xGOajy9P0Z5jdjs03gYYS5P/Qv8heN6HRSA4p5jSoTe9mDJylHl8MZvZ1U8a5cDV
ldZ2xSa6f0dp+gQ/QPSuKjLR8Zl3uaeTXTzBrKSGPBzmKF8DMH3GDQHy0K2B2KpB
UiX75lQa66iZCS0PnbI0aye7OvuAkPD9N2rr+388R3Pmw8r9QRblNwYRn58MKtsv
jycXmntob34X+ETgRLMncACBUxxuGCdM7YYN9Qh1OF2oNIFQvgExpsg6X+PpJOF1
GgAk2sG69N4UKziZ4X1FEREHVQ+7iVMZxa7XROxljd0xTrje73tyYHhGqMJFjgDF
x/EyNeaGEFiYK1ke8O69/7WoVaGH6aJf41Tj3pl9cDFPNECBs39XtVZL2175VD0S
TAAZzOKWj8BYHRTe5jh4X7t++MkFILvnoQ1N96d8ka4yQ+WRjWzKVa4AZwfxb197
5tMMNDgIUzJ3Q0X/SyKc4lM8+YglejZ6RqzSU43j2HjLLpyug3c=
=8zAH
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
