Received: from eggs.gnu.org ([2001:4830:134:3::10]:56508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctjgt-0000w0-Rn
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctjgq-0006Bc-Nu
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ctjgq-0006BD-G3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:41:16 -0400
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
	<1490750257-19907-3-git-send-email-mst@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66162fd5-969e-bfbf-f9fc-9ccab5102d2d@redhat.com>
Date: Fri, 31 Mar 2017 01:41:07 +0200
MIME-Version: 1.0
In-Reply-To: <1490750257-19907-3-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OfqCEGWOmXGSFFp6PxGrBssnRmdIVCcHm"
Subject: Re: [Qemu-devel] [PULL 2/3] pci: Add missing drop of bus master AS
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OfqCEGWOmXGSFFp6PxGrBssnRmdIVCcHm
From: Max Reitz <mreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66162fd5-969e-bfbf-f9fc-9ccab5102d2d@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/3] pci: Add missing drop of bus master AS
 reference
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
 <1490750257-19907-3-git-send-email-mst@redhat.com>
In-Reply-To: <1490750257-19907-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 03:18, Michael S. Tsirkin wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> The recent introduction of a bus master container added
> memory_region_add_subregion() into the PCI device registering path but
> missed memory_region_del_subregion() in the unregistering path leaving
> a reference to the root memory region of the new container.
>=20
> This adds missing memory_region_del_subregion().
>=20
> Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e6b08e1..bd8043c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci=
_dev)
>      pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
>      pci_config_free(pci_dev);
> =20
> +    memory_region_del_subregion(&pci_dev->bus_master_container_region,=

> +                                &pci_dev->bus_master_enable_region);
>      address_space_destroy(&pci_dev->bus_master_as);
>  }

I have yet to investigate how and why, but this may result in a failed
assertion:

$ qemu-system-x86_64 -drive if=3Dvirtio
qemu-system-x86_64: ./memory.c:2078: memory_region_del_subregion:
Assertion `subregion->container =3D=3D mr' failed.
[1]    15352 abort (core dumped)  qemu-system-x86_64 -drive if=3Dvirtio

I guess the subregion has not yet been added in this case and therefore
should not be deleted...?

(Caught by iotest 051.)

Max


--OfqCEGWOmXGSFFp6PxGrBssnRmdIVCcHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdl5MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEvAH/RfK1KVQzvkXz4fL5HN/lSSFP6IYq0m7
HgGohJQqHyWsZZnCViaqrHiQoqZxh1gZ/Gt7JIrZ2cQi9sJA6jfz4bD+M1IJnOUZ
tGYLm1nvj1ZoogndUb1vLVE7s/BKf/hlAEr/yL7egxTHYNtGmgdIreUylV1kmx3l
CtI3Q1ygpxFNEZdJGH3nJcrDPiUXftn9SaQ9lrpIshm0OMWGQijG2Bdrx7CIrYBL
TSAqAiPqB21xlvXCbPtYqm1Z0qoYpzrv/NfzblEAaWK4gltVuR71YZBYY7747p74
a3wp3N2C/E0FtUsx+R6FpQCmzqb2y9PA+oG7NsXgPGdxBsJTym8pr5M=
=tywV
-----END PGP SIGNATURE-----

--OfqCEGWOmXGSFFp6PxGrBssnRmdIVCcHm--
