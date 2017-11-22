Received: from eggs.gnu.org ([2001:4830:134:3::10]:47516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHdta-0004Ww-Vy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHdtZ-00068D-PG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:53:31 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eHdtZ-00066T-1t
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:53:29 -0500
Date: Thu, 23 Nov 2017 00:39:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122133952.GT2380@umbus.fritz.box>
References: <20171122051552.3529-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Content-Disposition: inline
In-Reply-To: <20171122051552.3529-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow fallback to SPAPR
 TCE IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 04:15:52PM +1100, Alexey Kardashevskiy wrote:
> The vfio_iommu_spapr_tce driver always advertises v1 and v2 IOMMU support,
> however PR KVM (a special version of KVM designed to work in
> a paravirtualized system; these days used for nested virtualizaion) only
> supports the "pseries" platform which does not support v2. Since there is
> no way to choose the IOMMU version in QEMU, it fails to start.
>=20
> This adds a fallback to the v1 IOMMU if v2 cannot be used.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

The fallback itself isn't a bad idea, but your commit message contains
several inaccurracies.  KVM PR is not particularly designed to work in
a paravirtualized system, and it doesn't only support the pseries
platform (as guest *or* host).  It's actually a lot more general than
KVM HV - just slow, not that well tested and missing a number of
features that no-one's bothered to port to it.

> ---
>  hw/vfio/common.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c..cd81cc9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
>              v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
>          ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>          if (ret) {
> +            container->iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
> +            v2 =3D false;
> +            ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> +        }
> +        if (ret) {
>              error_setg_errno(errp, errno, "failed to set iommu for conta=
iner");
>              ret =3D -errno;
>              goto free_container_exit;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloVfiYACgkQbDjKyiDZ
s5KpqxAAt6krUyTLvQUrJPwxhEL/tGRHPBUAHJxJBjdNIoNd2XqYbbY52pkl0Cn3
oTYvhi7OWYAGYSIT7xbMND3ZpJspkCgV2VbTMlrPU91wQSwBuFqsHVGDBCMYgMaZ
gNWgRI6fhuXsZRiN+9XvD3z8CctSZ0337TIXHrimhCLAyH17mFfvs6igrvaxsSxx
AAp6qiLdUjVPHhPiPcLSWcpOJVDxTqgZslhRwrPtRvjzWa88/fIo0z45yn1ELvqn
KjgkvsHRU3/8VbadS7xeoy0ca/XFO8qjYHcKAiDUy4vz3kT3TV/NH55EvaGcdT7I
j9KpbyimUNW4cXXkRG/N9gIHOenuP+7svh5daDLbMt4nLOHV9XiLoqNXowzI2kqZ
rYTUANtJyTWa6DQNp5oAZw2x+q7aD/1hYyDVcqi4BsRPu4zWxPNHI7Gg+ye7nM6Z
CAnmoDgdBByQDJNCUxRmBHksFCmEtXp8pz0BVoU1+YkDMk7ja3j6ejVxPFfuuYiV
aerQpL6V77sIRYxU/99sdSKkTZRGmCaLcsuBZABaf/A/tXUhgLVp58dJQiX7l7L/
8rLyiCXYags9xgFDj7BY3O+uQONh9p3TrxO3CKoZrkmpLMhroaMbbtzASvvaxNu0
DtSX4ddHBKo2VUntSrT2UEdYxTQ2uM2RXuHuDsMfW+DpXCAwGes=
=pMdb
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
