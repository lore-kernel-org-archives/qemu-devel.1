Received: from eggs.gnu.org ([2001:4830:134:3::10]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIvGh-00024E-BR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIvGd-0000lu-GJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:06:23 -0400
Date: Thu, 8 Jun 2017 17:42:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608074250.GE25805@umbus.fritz.box>
References: <20170607083243.8983-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <20170607083243.8983-1-aik@ozlabs.ru>
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


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 06:32:43PM +1000, Alexey Kardashevskiy wrote:
> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> as a parent.
>=20
> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> dymanic QOM casting in fast path (address_space_translate, etc),
> this adds an @is_iommu boolean flag to MR and provides new helper to
> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> is set in the instance init callback. This defines
> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
>=20
> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> the ones where MemoryRegion may be an alias.
>=20
> This defines memory_region_init_iommu_type() to allow creating
> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> this splits memory_region_init() to object_initialize() +
> memory_region_do_init.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

So.. this seems like an only halfway QOMification.  The main init
function still takes an ops structure, whereas the QOMish way to do
this would be to have the base IOMMUMemoryRegion be an abstract class,
and have the IOMMUOps pointers as part of the IOMMUMemoryRegionClass.

Maybe you can persuade me this is a useful interim step?

[snip]
> -void memory_region_init_iommu(MemoryRegion *mr,
> -                              Object *owner,
> -                              const MemoryRegionIOMMUOps *ops,
> -                              const char *name,
> -                              uint64_t size)
> +void memory_region_init_iommu_type(const char *mrtypename,
> +                                   IOMMUMemoryRegion *iommu_mr,
> +                                   Object *owner,
> +                                   const MemoryRegionIOMMUOps *ops,
> +                                   const char *name,
> +                                   uint64_t size)
>  {
> -    memory_region_init(mr, owner, name, size);
> -    mr->iommu_ops =3D ops,
> +    struct MemoryRegion *mr;
> +    size_t instance_size =3D object_type_get_instance_size(mrtypename);
> +
> +    object_initialize(iommu_mr, instance_size, mrtypename);

This looks exceedingly dangerous.  AIUI, the entire purpose of the
size parameter to object_initialize() (which can certainly get the
instance size from the type, just as you do) is to verify that the
buffer you're initializing actually has space for the object type
you're putting there.

By looking up the instance size yourself and passing it to
object_initialize(), you're disabling that check.

If someone allocates an array of plain IOMMUMemoryRegion structures,
then uses this to initialize a derived IOMMU MR type with more fields,
the user will get no warning that something is wrong before the memory
corruption starts.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOP/4AAoJEGw4ysog2bOSsgAQAKzjBSKlHlIqgw/CW9akk55q
eZGQNZn7k7wFAQxh1Qq45OPoeEYCSEqn7g/XGJccH5HqcviUuDqAKL6ZjESM5rwd
hCceGTyi9AWRaleREinBMstlq8ZG9vhwskqbex0GC1ev4mLTBHri0PEU0JNjATnS
141+InhaUiolHD9vYvlHPKsevf2StpUAW6/3rGT18tidR8dhrdBbCwfjxYZ7LUf3
jpc3QwnIFLiRjT07uUc0fRCujbs9xVjq3oAys7ckLtx61RoJsZmW36AstDlIsiTU
Pz7P+uy5wGTte4+FZYXedUuPLhatK14IZdxBTuNR5l/rVDyJjVR7Yl4HCQNHNtSU
AjRjPUVaCCUlSPtuBB84xVOA6qHNbDgb6f2YUTkqhwys+mtHFRH7wseGFC6jffdD
sXQ5FANpWoFvTR9VAkt/k2ImSGYRJTNPUz/TQgc+8fMY1f/InSrsPdgEtWLgHssd
fWSKfKgNASCdN0AZc9AwHorWLJ64WacJ6PNfnmziOGStcFCuz4JsSQKO/++g+6yP
EESv/DCqM6hJ0pVNSSckVoJ4cD/Z/aJ3mCEkqd+Rpm/bwWTq/FODUJAfgj/SxEcn
qsl4y9x1IabpqZXBsxyacj1XwVsY3cpqZUU0rn0im2t1tuU14b9vrjdhyOC2kXVw
cV9N1FrYTzB2SK2jSBS2
=Y9dN
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
