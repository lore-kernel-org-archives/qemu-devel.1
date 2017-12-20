Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRcOP-0005c3-J4
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRcOM-0002ip-BY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:33 -0500
Received: from ozlabs.org ([103.22.144.67]:56049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eRcOL-0002gD-LI
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:30 -0500
Date: Wed, 20 Dec 2017 22:01:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220110110.GF5981@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
	<20171116085709.GA5072@sky-dev>
	<20171218061442.GW7753@umbus.fritz.box>
	<20171218091735.GA6002@sky-dev>
	<20171218112218.GB4786@umbus.fritz.box>
	<20171220063242.GA7070@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <20171220063242.GA7070@sky-dev>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, alex.williamson@redhat.com, pbonzini@redhat.com


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 02:32:42PM +0800, Liu, Yi L wrote:
> On Mon, Dec 18, 2017 at 10:22:18PM +1100, David Gibson wrote:
> > On Mon, Dec 18, 2017 at 05:17:35PM +0800, Liu, Yi L wrote:
> > > On Mon, Dec 18, 2017 at 05:14:42PM +1100, David Gibson wrote:
> > > > On Thu, Nov 16, 2017 at 04:57:09PM +0800, Liu, Yi L wrote:
[snip]
> > > > So for a typical PAPR setup, the device can access system RAM either
> > > > via DMA in the range 0..1GiB (the "32-bit window") or in the range
> > > > 2^59..2^59+<something> (the "64-bit window").  Typically the 32-bit
> > > > window has mappings dynamically created by drivers, and the 64-bit
> > > > window has all of system RAM mapped 1:1, but that's entirely up to =
the
> > > > OS, it can map each window however it wants.
> > > >=20
> > > > 32-bit devices (or "64 bit" devices which don't actually implement
> > > > enough the address bits) will only be able to use the 32-bit window,
> > > > of course.
> > > >=20
> > > > MMIOs of other devices, the "magic" MSI-X addresses belonging to the
> > > > host bridge and other things exist outside those ranges.  Those are
> > > > just the ranges which are used to DMA to RAM.
> > > >=20
> > > > Each PE (domain) can see a different version of what's in each
> > > > window.
> > >=20
> > > If I'm correct so far. PE actually defines a mapping between an addre=
ss
> > > range of an address space(aka. iova address space) and an address ran=
ge
> > > of the system physical address space.
> >=20
> > No.  A PE means several things, but basically it is an isolation
> > domain, like an Intel IOMMU domain.  Each PE has an independent set of
> > IOMMU mappings which translate part of the PCI address space to system
> > memory space.
> >=20
> > > Then my question is: does each PE define a separate iova address sapce
> > > which is flat from 0 - 2^AW -1, AW is address width? As a reference,
> > > VT-d domain defines a flat address space for each domain.
> >=20
> > Partly.  Each PE has an address space which all devices in the PE see.
> > Only some of that address space is mapped to system memory though,
> > other parts are occupied by devices, others are unmapped.
> >=20
> > Only the parts mapped by the IOMMU vary between PEs - the other parts
> > of the address space will be identical for all PEs on the host
>=20
> Thx, this comment addressed me well. This is different from what we have
> on VT-d.

Really?  That's hard to believe.  I'm pretty sure the VT-d IOMMU must
have a range < 2^64, and anything on the bus outside that range I
expect would be common between all domains.  In particular I'd expect
the BARs for other devices not to be remapped by the IOMMU (though
they may be inaccessible on PCI-E due peer to peer transactions being
blocked).  As well as things above the IOMMU's range, I'd expect the
region for 32-bit BARs to be common between all domains.

[snip]
> > > > > >  IIUC how SVM works, the whole point is that the device
> > > > > > no longer writes into a specific PCI address space.  Instead, it
> > > > > > writes directly into a process address space.  So it seems to m=
e more
> > > > > > that SVM should operate at the PCI level, and disassociate the =
device
> > > > > > from the normal PCI address space entirely, rather than hooking=
 up
> > > > > > something via that address space.
>=20
> After thinking more, I agree that it is not suitable to hook up something=
 for
> 1st level via the PCI address space. In the time 1st and 2nd level transl=
ation
> is exposed to guest, a device would write to multiple address spaces. PCI=
 address
> space is only one of them. I think your reply in another email is a good =
start,
> let me reply my thoughts under that email.
>=20
> Regards,
> Yi L
>=20
> > > > >=20
> > > > > As Peter replied, we still need the PCI address space, it would b=
e used
> > > > > to build up the 2nd level page table which would be used in nested
> > > > > translation.
> > > > >=20
> > > > > Thanks,
> > > > > Yi L
> > > > >=20
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> > > Regards,
> > > Yi L
> > >=20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo6QvQACgkQbDjKyiDZ
s5J8Sw//UF5kQgYolP9YRxDxG9/GbsdF9WbWcGsfXNIiPFKUdvZqHPdryfELBsI+
rCfrxdieaj6mqxV352Z1HBoc4VFr3ddTwBNE1UK4QaFb6VgKlN/9umyOzY2Wt2Vt
jPfuG6WAV3mPoM2KcfOc/JYv6QIFFdzuY4nActKTJLMBt01PcQW758Z8C0fFz0x2
YNo+BFNa6Np2LSJC4Rifgg+4tsifaIuHmgNF9GjpkKFHWIYn6XoTyfgaFUKj4k0g
q1tvA7aDaGAEjAx0v3tnXJmcC8qrIHL5kgusWliSk4YR8xdNSAsmqJKv+Kzr5FAn
wL+tCKyUxvBTx3xMkXbWHxVbYIJkXAlfTGxv8GlJ9fgWsZkpuk407rYqcLQU1Acc
oOJ9oBU8Dydw9knWEF21hego4zYTpCUfmW23eiN2/FfGETLImeNdEyd6TVhX1bAJ
sy6FD3MJBOJsEC+EWdvLLmfBg9csKRRYIW7dOpxvcpy0rNA7LIB8lbuSb2B81VEj
CaukA2yuWiTv+YMJLLNWNn34ENZqmn6sqwZeHpvqy2sPhWkA4GpmUdEofXkZcj2o
GWde3NQj4bzxIl+Z5NzjG3DK/CNPD/zSnlH2OH+f3g0h8ZNBLB+Vup04pHx4AR6R
ApXvUipRAW0AzGzNA7hwytwxT3WdZ1HqXR0kORI2pdpNzmTY8YA=
=kJve
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
