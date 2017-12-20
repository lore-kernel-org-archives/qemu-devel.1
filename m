Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRcOO-0005bp-0q
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRcOM-0002iv-CC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:32 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:36911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eRcOL-0002gB-LN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:30 -0500
Date: Wed, 20 Dec 2017 22:18:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220111816.GG5981@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
	<20171220064730.GB7070@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20171220064730.GB7070@sky-dev>
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


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 02:47:30PM +0800, Liu, Yi L wrote:
> On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> > On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > >=20
> > > [...]
> > >=20
> > > > I meant, in the current intel_iommu code, vtd_find_add_as() creates=
 1
> > > > IOMMU MR and 1 AS per PCIe device, right?
> > >=20
> > > I think this is the most tricky point - in QEMU IOMMU MR is not really
> > > a 1:1 relationship to devices.  For Intel, it's true; for Power, it's
> > > not.  On Power guests, one device's DMA address space can be splited
> > > into different translation windows, while each window corresponds to
> > > one IOMMU MR.
> >=20
> > Right.
> >=20
> > > So IMHO the real 1:1 mapping is between the device and its DMA address
> > > space, rather than MRs.
> >=20
> > That's not true either.  With both POWER and Intel, several devices
> > can share a DMA address space: on POWER if they are in the same PE, on
> > Intel if they are place in the same IOMMU domain.
> >=20
> > On x86 and on POWER bare metal we generally try to make the minimum
> > granularity for each PE/domain be a single function.  However, that
> > may not be possible in the case of PCIe to PCI bridges, or
> > multifunction devices where the functions aren't properly isolated
> > from each other (e.g. function 0 debug registers which can affect
> > other functions are quite common).
> >=20
> > For POWER guests we only have one PE/domain per virtual host bridge.
> > That's just a matter of implementation simplicity - if you want fine
> > grained isolation you can just create more virtual host bridges.
> >=20
> > > It's been a long time since when I drafted the patches.  I think at
> > > least that should be a more general notifier mechanism comparing to
> > > current IOMMUNotifier thing, which was bound to IOTLB notifies only.
> > > AFAICT if we want to trap first-level translation changes, current
> > > notifier is not even close to that interface - just see the definition
> > > of IOMMUTLBEntry, it is tailored only for MAP/UNMAP of translation
> > > addresses, not anything else.  And IMHO that's why it's tightly bound
> > > to MemoryRegions, and that's the root problem.  The dynamic IOMMU MR
> > > switching problem is related to this issue as well.
> >=20
> > So, having read and thought a bunch more, I think I know where you
> > need to start hooking this in.  The thing is the current qemu PCI DMA
> > structure assumes that each device belongs to just a single PCI
> > address space - that's what pci_device_iommu_address_space() returns.
> >=20
> > For virt-SVM that's just not true.  IIUC, a virt-SVM capable device
> > could simultaneously write to multiple process address spaces, since
> > the process IDs actually go over the bus.
>=20
> Correct.
>=20
> > So trying to hook notifiers at the AddressSpace OR MemoryRegion level
> > just doesn't make sense - if we've picked a single addresss space for
> > the device, we've already made a wrong step.
>=20
> That's also why we want to have notifiers based on IOMMUObject(may be
> not a suitable name, let me use it as the patch named).

Right, I think "IOMMUObject" is a misleading name.

> > Instead what you need I think is something like:
> > pci_device_virtsvm_context().  virt-SVM capable devices would need to
> > call that *before* calling pci_device_iommu_address_space ().  Well
> > rather the virt-SVM capable DMA helpers would need to call that.
> >=20
> > That would return a new VirtSVMContext (or something) object, which
> > would roughly correspond to a single PASID table.  That's where the
> > methods and notifiers for managing that would need to go.
>=20
> Correct, pci_device_iommu_address_space() returns an AS and it is
> a PCI address space. And if pci_device_virtsvm_context() is also
> called in vfio_realize(), it may not return an AS since there may
> be no 1st level translation page table bound.
>=20
> So as you said, return a new VirtSVMContext, this VirtSVMContext can
> hook some new notifiers. I think the IOMMUObject introduced in this patch
> can meet the requirement. But it may be re-named.

Ok.

> So here it addressed the concern you raised before which is hook IOMMUObj=
ect
> via a PCI address space. Regards to VirtSVMContext, it may be a replaceme=
nt
> of IOMMUObject. As it is related to PASID, I'm considering to name it as
> IOMMUPasidContext or IOMMUPasidObject. So it would be an abstraction of a=
ll
> the IOMMU PASID related operations.

I'm ok with calling it a "PASID context".

Thinking about this some more, here are some extra observations:

 * I think each device needs both a PASID context and an ordinary
   address space.  The PASID context would be used for bus
   transactions which include a process id, the address space for
   those that don't.

 * Theoretically, the PASID context could be modelled as an array/map
   of AddressSpace objects for each process ID.  However, creating all
   those AddressSpace objects in advance might be too expensive.  I
   can see a couple of options to avoid this:

1) Have the PASID context class include a 'translate' method similar
to the one in IOMMUMemoryRegionClass, but taking a process ID as well
as an address.  This would avoid creating extra AddressSpace objects,
but might require duplicating a bunch of the translation code that
already exists for AddressSpace.

2) "Lazily" create AddressSpace objects.  The generic part of the
PASID aware DMA helper functions would use a cache of AddressSpace's
for particular process IDs, using the AddressSpace (and MemoryRegion
within) to translate accesses for a particular process ID.  However,
these AddressSpace and MemoryRegion objects would only be created when
the device first accesses that address space.  In the common case,
where a single device is just being used by a single process or a
small number, this should keep the number of AddressSpace objects
relatively small.  Obviously the cache would need to be invalidated,
cleaning up the AddressSpace objects, when the PASID table is altered.

 * I realize that the expected case here is with KVM, where the guest
   controls the first level translation, but the host controls the
   second level translation.  However, we should also be able to model
   the case where the guest controls both levels for the sake of full
   system emulation.  I think understanding this case will lead to a
   better design even for the simpler case.

Do you have a plan for what the virt-SVM aware DMA functions will look
like?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo6RvYACgkQbDjKyiDZ
s5I2nhAAkvATp40bCxnQcXjEoMLMEeuZqjLNXgCXi4+p2dfjnOHHrAuTfp4gfs8P
MRKu1KjrV+osRsP+5jrcIWwCAx9GFvjrJkUVBpcGub/HInTevvI/ccXeLzWduZz0
Ix6yEfQf73d5Ywntc0LmwCKEeBAYdAln3cGY+Eyrat1Jotla71JhUhK0ANqERvAP
XXLEsENhXV0SvM2t5vRq3iMAwNqoPcMKTkElDcTyDhutuiUKa6/j5uyeHcVCAAPs
Yk5KrKKcf+q4OB2qHTBr+NDpF+4tOTTgObaAbOSvoqMIiijXzTcDEXiwfso8r7qU
sJYZvdZxhwC7POs1AYqu0Mehe3l7unx+UMSvPe+FcsV4Mp0Sh8dtL0NC1nG22tNV
QB8mJsxaMw7C/Vlm4p6S64jRfns9o/RD2ezP6iuEVQN3Wcq5JHL4qltJKE/33SCG
6BAvsQy9ugakVL15k1EVNyaTFyqjaOTJyf3BrugC2xPKKeOoOznIU5HKy3ygKFgy
qCqeE7hBz4/tL++NoPvcReuB6rfM5KHUv3zv0X75VoD+yhjhTfv2za3OaT6Bew2+
iWqmFJ1o2LKDW3MaJgKHBkWDNddZVoGErvy360NiK8ecu47bUtlMMbMBa74gZCXy
G8g6Fv8n2qBO2zBlTzO53vnldz3JOuM704bvJrb0/14NbAebEK0=
=aXez
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
