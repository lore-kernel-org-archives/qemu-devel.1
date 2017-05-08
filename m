Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bwx-0003Kw-M3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bwu-0000KN-HD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:15 -0400
Received: from ozlabs.org ([103.22.144.67]:41617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d7bwt-0000IJ-KE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:12 -0400
Date: Mon, 8 May 2017 16:07:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170508060744.GG25748@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <20170508054814.GA2820@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 01:48:14PM +0800, Peter Xu wrote:
> On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> > On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > > This is something similar to MemoryRegionOps, it's just for address
> > > spaces to store arch-specific hooks.
> > >=20
> > > The first hook I would like to introduce is iommu_get().
> > >=20
> > > For systems that have IOMMUs, we will create a special address space =
per
> > > device which is different from system default address space for
> > > it (please refer to pci_device_iommu_address_space()). Normally when
> > > that happens, there will be one specific IOMMU (or say, translation
> > > unit) stands right behind that new address space.
> > >=20
> > > This iommu_get() fetches that guy behind the address space. Here, the
> > > guy is defined as IOMMUObject, which is currently a (void *). In the
> > > future, maybe we can make it a better definition, but imho it's good
> > > enough for now, considering it's arch-dependent.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >=20
> > This doesn't make sense to me.  It would be entirely possible for a
> > single address space to have different regions mapped by different
> > IOMMUs.  Or some regions mapped by IOMMUs and others direct mapped to
> > a device or memory block.
>=20
> Oh, so it's more complicated than I thought... Then, do we really have
> existing use case that one device is managed by more than one IOMMU
> (on any of the platform)? Frankly speaking I haven't thought about
> complicated scenarios like this, or nested IOMMUs yet.

Sort of, it depends what you count as "more than one IOMMU".

spapr can - depending on guest configuration - have two IOMMU windows
for each guest PCI domain.  In theory the guest can set these up
however it wants, in practice there's usually a small (~256MiB) at PCI
address 0 for the benefit of 32-bit PCI devices, then a much larger
window up at a high address to allow better performance for 64-bit
capable devices.

Those are the same IOMMU in the sense that they're both implemented by
logic built into the same virtual PCI host bridge.  However, they're
different IOMMUs in the sense that they have independent data
structures describing the mappings and are currently modelled as two
different IOMMU memory regions.


I don't believe we have any existing platforms with both an IOMMU and
a direct mapped window in a device's address space.  But it seems to
be just too plausible a setup to not plan for it. [1]

> This patch derived from a requirement in virt-svm project (on x86).
> Virt-svm needs some notification mechanism for each IOMMU (or say, the
> IOMMU that managers the SVM-enabled device). For now, all IOMMU
> notifiers are per-memory-region not per-iommu, and that's imho not
> what virt-svm wants. Any suggestions?

I don't know SVM, so I can't really make sense of that.  What format
does this identifier need?  What does "for one IOMMU" mean in this
context - i.e. what guest observable properties require the IDs to be
the same or to be different.


[1] My reasoning here is similar to the reason sPAPR allows the two
windows.  For PAPR, the guest is paravirtualized, so both windows
essentially have to be remapped IOMMU windows.  For a bare metal
platform it seems a very reasonable tradeoff would be to have a
small(ish) 32-bit IOMMU window to allow 32-bit devices to work on a
large RAM machine, along with a large direct mapped "bypass" window
for maxmimum performance for 64-bit devices.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEAsuAAoJEGw4ysog2bOSJMwP/2S6gIzTYFdk7vC/r/5+FdL3
vZ/LyutOQA4DEQVveVwR5G9W32VA4wkVpOGmZaLXKLoYlkbAEDiJhmhP5YSMJ6CX
K9iAtWz+Xz5bRIpm/CqNbSGW3glHbZtc/s1iUZVJ8MUWVQP5B4Juw9QVtf2ZXlO3
ur0omNP0wKGVSQfozuOCuzF0xAuUWPyAkq7tpNpRhSbflQCjxB2DqlLoQ7uWNZQh
1pvolGZ64jn2L+cePfgRN97kEyt32h1SLcSKn/LWnK/PvEDZczPJwLcbBDH5PX35
ZcwQEKDifd/UgGec5zbuCqIkb1JsHvre2c5mHLPqxOVQADxL3cJtY3Z6t11RjLUu
/fmHCJPZdsquk8ELi4vzXfmQnJ94S9wxsM12euQ6cu57gyrj48TmnpiEpTVQVmpz
w/IXZSb8TI1wc3hKRHEJ/QhkQpghXkm/E427Tn5d5W2CeHqRGBoPbkOhCFrjW5a1
2TSZwx6mrI9rM1+8gZTHX48DRbhmbZSUVPbHQgGuK9rE3AdeVkR5FVmt9kvKDufj
Kv8k4K+4aLnQpehq0yvWnbmlqLHQwXfwPaKxi7dtedfMVOwkoqLS4isPLwjg1DM8
c7XPzYGUd0Zfo17xDKYUDMl+BSBmLdWMhvd3gck/gSLxvkwzI85DHhog6IRqE3uY
g41NYuHZ6br5G4vu3uXA
=69eO
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
