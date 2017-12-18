Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQtl0-0005E2-8E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQtkz-0008Ru-1G
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:54 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:39123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eQtky-0008Po-Jz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:52 -0500
Date: Mon, 18 Dec 2017 22:35:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218113531.GC4786@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20171115071632.GF6821@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
>=20
> [...]
>=20
> > I meant, in the current intel_iommu code, vtd_find_add_as() creates 1
> > IOMMU MR and 1 AS per PCIe device, right?
>=20
> I think this is the most tricky point - in QEMU IOMMU MR is not really
> a 1:1 relationship to devices.  For Intel, it's true; for Power, it's
> not.  On Power guests, one device's DMA address space can be splited
> into different translation windows, while each window corresponds to
> one IOMMU MR.

Right.

> So IMHO the real 1:1 mapping is between the device and its DMA address
> space, rather than MRs.

That's not true either.  With both POWER and Intel, several devices
can share a DMA address space: on POWER if they are in the same PE, on
Intel if they are place in the same IOMMU domain.

On x86 and on POWER bare metal we generally try to make the minimum
granularity for each PE/domain be a single function.  However, that
may not be possible in the case of PCIe to PCI bridges, or
multifunction devices where the functions aren't properly isolated
=66rom each other (e.g. function 0 debug registers which can affect
other functions are quite common).

For POWER guests we only have one PE/domain per virtual host bridge.
That's just a matter of implementation simplicity - if you want fine
grained isolation you can just create more virtual host bridges.

> It's been a long time since when I drafted the patches.  I think at
> least that should be a more general notifier mechanism comparing to
> current IOMMUNotifier thing, which was bound to IOTLB notifies only.
> AFAICT if we want to trap first-level translation changes, current
> notifier is not even close to that interface - just see the definition
> of IOMMUTLBEntry, it is tailored only for MAP/UNMAP of translation
> addresses, not anything else.  And IMHO that's why it's tightly bound
> to MemoryRegions, and that's the root problem.  The dynamic IOMMU MR
> switching problem is related to this issue as well.

So, having read and thought a bunch more, I think I know where you
need to start hooking this in.  The thing is the current qemu PCI DMA
structure assumes that each device belongs to just a single PCI
address space - that's what pci_device_iommu_address_space() returns.

For virt-SVM that's just not true.  IIUC, a virt-SVM capable device
could simultaneously write to multiple process address spaces, since
the process IDs actually go over the bus.

So trying to hook notifiers at the AddressSpace OR MemoryRegion level
just doesn't make sense - if we've picked a single addresss space for
the device, we've already made a wrong step.

Instead what you need I think is something like:
pci_device_virtsvm_context().  virt-SVM capable devices would need to
call that *before* calling pci_device_iommu_address_space ().  Well
rather the virt-SVM capable DMA helpers would need to call that.

That would return a new VirtSVMContext (or something) object, which
would roughly correspond to a single PASID table.  That's where the
methods and notifiers for managing that would need to go.

> I am not sure current "get IOMMU object from address space" solution
> would be best, maybe it's "too bigger a scope", I think it depends on
> whether in the future we'll have some requirement in such a bigger
> scope (say, something we want to trap from vIOMMU and deliver it to
> host IOMMU which may not even be device-related?  I don't know).  Now
> another alternative I am thinking is, whether we can provide a
> per-device notifier, then it can be bound to PCIDevice rather than
> MemoryRegions, then it will be in device scope.

I think that sounds like a version of what I've suggested above.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3p/4ACgkQbDjKyiDZ
s5K6rRAA26LBpY0FR6QAUKRJ+RiuOYgUlsG0diWiHwpud45Oz3/F1/i4yQ1YLK90
NN3zQRGHGdOh/rjh4vWNxpIlLGFib0FH6XRYom4+87r+5rqV9fHWO6yMvokgecAy
rIgYC4kAL6nCPC8JEwUun07RdxfNxnL/+D3QlM9G8NMgzWOlyQ6oFrROApH5eT1e
0oRfiukUD+Podr+Ib1UF530f2wlBjTpQbX0rkVySlHyWcUbpLxakftYCeXU6smat
Ntrocr/OASZjhI0NZAD4CcuwNLi2A2Z7Fil4H7xx0YmSy/NODXKQOL3yf91O4rRu
Xv6cA2Nr6+KjqczKLaa05smTHvJvIQ2GzjSFTOKMuJpng1L1ISAP/gNL3YH7h5e3
0G4flB5G/BY6B1S6Dt3mRM4VmdYEqsz5BHx6GOojKX+uuT4f0owOLkoP/0bJRtNM
ZraQd+NFezmvEPt+yilCzGAadmvRY4GIsrc7mYDimu0KNrZoCz/hRR87pVj/ZfhI
4XZYpe172b1nvpfg5EIhVuuej11eDjvlF6Q5eKWn2DvN/D4DLH5KwZq9EA8pN7pP
NXFqG+D+NNybDCWQpk41edugxzwozm1F1AaNdLEDGvK+/pQTPX4uTyE2sLv9JdLo
qH0bwgiWLWES7nJpop3UVcGUdZNOhoqS2ms9YPFYyvxsYEJcCOo=
=/dx3
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
