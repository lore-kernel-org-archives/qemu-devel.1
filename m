Received: from eggs.gnu.org ([2001:4830:134:3::10]:42441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIyt9-0007Wi-NX
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIyt6-0004fD-Jb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:58:19 -0400
Date: Fri, 9 Jun 2017 00:58:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608145803.GI25805@umbus.fritz.box>
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
	<d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Content-Disposition: inline
In-Reply-To: <d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 12:28:35AM +1000, Alexey Kardashevskiy wrote:
> On 08/06/17 17:42, David Gibson wrote:
> > On Wed, Jun 07, 2017 at 06:32:43PM +1000, Alexey Kardashevskiy wrote:
> >> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> >> as a parent.
> >>
> >> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> >> dymanic QOM casting in fast path (address_space_translate, etc),
> >> this adds an @is_iommu boolean flag to MR and provides new helper to
> >> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> >> is set in the instance init callback. This defines
> >> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
> >>
> >> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> >> the ones where MemoryRegion may be an alias.
> >>
> >> This defines memory_region_init_iommu_type() to allow creating
> >> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> >> this splits memory_region_init() to object_initialize() +
> >> memory_region_do_init.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > So.. this seems like an only halfway QOMification.  The main init
> > function still takes an ops structure, whereas the QOMish way to do
> > this would be to have the base IOMMUMemoryRegion be an abstract class,
> > and have the IOMMUOps pointers as part of the IOMMUMemoryRegionClass.
>=20
> This would mean getting the class pointer from an IOMMUMR object every ti=
me
> IOMMUOps::translate() is called and Paolo pointed out earlier that we do
> not want that in the fast path.

So, doing that via the standard macro wrappers would be slow, because
it does type verification.  However, looking up the class function is
fundamentally:

	((IOMMUMemoryRegionClass *)(((Object *)mr)->class))->translate

i.e. two pointers followed, which is just the same as
	mr->ops->translate

So putting the IOMMU ops into the class structure doesn't preclude a
fast path.

> > Maybe you can persuade me this is a useful interim step?
> >=20
> > [snip]
> >> -void memory_region_init_iommu(MemoryRegion *mr,
> >> -                              Object *owner,
> >> -                              const MemoryRegionIOMMUOps *ops,
> >> -                              const char *name,
> >> -                              uint64_t size)
> >> +void memory_region_init_iommu_type(const char *mrtypename,
> >> +                                   IOMMUMemoryRegion *iommu_mr,
> >> +                                   Object *owner,
> >> +                                   const MemoryRegionIOMMUOps *ops,
> >> +                                   const char *name,
> >> +                                   uint64_t size)
> >>  {
> >> -    memory_region_init(mr, owner, name, size);
> >> -    mr->iommu_ops =3D ops,
> >> +    struct MemoryRegion *mr;
> >> +    size_t instance_size =3D object_type_get_instance_size(mrtypename=
);
> >> +
> >> +    object_initialize(iommu_mr, instance_size, mrtypename);
> >=20
> > This looks exceedingly dangerous.  AIUI, the entire purpose of the
> > size parameter to object_initialize() (which can certainly get the
> > instance size from the type, just as you do) is to verify that the
> > buffer you're initializing actually has space for the object type
> > you're putting there.
> >=20
> > By looking up the instance size yourself and passing it to
> > object_initialize(), you're disabling that check.
> >=20
> > If someone allocates an array of plain IOMMUMemoryRegion structures,
> > then uses this to initialize a derived IOMMU MR type with more fields,
> > the user will get no warning that something is wrong before the memory
> > corruption starts.
>=20
> Hm. How can I fix it then for a generic case? Pass the actual amount of
> bytes occupied by *iommu_mr?

I think you need to make the signature similar to
object_initialize().  So instead of taking an IOMMUMemoryRegion *, it
will take a void * and a size_t, which it passes directly to
object_initialize().   A typical caller will then do
	memory_region_init_iommu_type(TYPE_WHATEVER,
				      &mystruct->mr,
				      sizeof(mystruct->mr),
				     ...)

And object_initialize() will verify that the size works for TYPE_WHATEVER.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOWX7AAoJEGw4ysog2bOSjvUP/0WXSDdFD4N5ZZ/WdjWqS9se
XdW2yk0eRqNGB8au2On2nzVkcwW9iutWFrRh3Wy/zu3NCkEJcz17WZ/fCMzDX7cn
sQOU2cbni11Q3Mahrp04YPVknJmmSP58CI4bU0v7o9UihFaHPL77O116jkwDFQUi
wBtYwS2J7ftdtpWJL/WbKD/LiLEAE+VvtaRELMP1dAaLAuK4ekoxbNfmTa4JnNCz
+ciX618DYmW2vZUAFaGBlbfidQNi2YgW5rr37oXcDCbKTbiHt5R40pviwdi/es+C
7dtorxEZd+BOhDr+0k3zCSXR4qLRv9HhqeHNyeCRTLPqmknza/H+SD35oylRHcKV
rcAXA4xY1CrGnHm0C4ltfyTTh2BIpzfeLeZDtfDQ6F6m8LgF72dkkjR5tCVCtzvN
3jrph9JABz5NwGMi1TqfOxJRrw+3R+I2nrXKVwrJfg+WBpf6wJF/vEPQ7VX0ZhYc
HxsqFp7/v01IP2HAN6O1GFOIxZTeqyJ3HIZ6rydfgE1H0RwRgcn5E8nKmGoimbnk
rqVJlKSt8SLx6TrkVMhGJaqgVDvbfGfgYMKwdwGahN6q4bE9i7R5WTVDNYR8SHIp
kTQkUxnB6OTFczT6qWqZcufdY44qH6CwpgtbTOQnn0SmAoIBz67njfrwquXos46H
qj560LtTaAWO0T+CaeNk
=ql7F
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--
