Received: from eggs.gnu.org ([209.51.188.92]:49572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFDB-0006Rn-Bx
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFDA-00034a-B8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:52:05 -0500
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-4-git-send-email-liq3ea@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5bb8eea-bbcf-ccb6-98ac-742ad3511f81@redhat.com>
Date: Wed, 9 Jan 2019 15:51:56 +0100
MIME-Version: 1.0
In-Reply-To: <1540876720-9574-4-git-send-email-liq3ea@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iX4O5EYFnQO4e9nUmckk9LUBhI1qtUHRr"
Subject: Re: [Qemu-devel] [PATCH 3/4] nvme: check msix_init_exclusive_bar
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iX4O5EYFnQO4e9nUmckk9LUBhI1qtUHRr
From: Max Reitz <mreitz@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <d5bb8eea-bbcf-ccb6-98ac-742ad3511f81@redhat.com>
Subject: Re: [PATCH 3/4] nvme: check msix_init_exclusive_bar return value
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
 <1540876720-9574-4-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-4-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.18 06:18, Li Qiang wrote:
> As this function can fail.
>=20
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 72c9644..a406c23 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1250,7 +1250,10 @@ static void nvme_realize(PCIDevice *pci_dev, Err=
or **errp)
>      pci_register_bar(&n->parent_obj, 0,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>          &n->iomem);
> -    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
> +    if (msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL=
)) {
> +        error_setg(errp, "msix_init_exclusive_bar failed");
> +        return;
> +    }

Commit ee640c625e1 which last touched this function stated that creating
this device won't fail if this function fails, so I suppose it's
intential that the error isn't checked.


But if you think the error should be checked and device creation should
be aborted if this function failed, then I suppose there'd be some
cleaning up to instead of just returning.

Also, we should just pass errp to that function (as its last parameter,
instead of NULL).

Max

> =20
>      id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VE=
NDOR_ID));
>=20



--iX4O5EYFnQO4e9nUmckk9LUBhI1qtUHRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2CowACgkQ9AfbAGHV
z0ChPQf/XMR0QlznY6Fmxy/1r8sjazxTsh7raHEtGYGAUFyX5VC1gEJOYv1bXQM/
ZW4bSFPYxYWwIk4doS2d0ZBwFzgAH0lTjQsPHce2u+FyCa6cmYK/tFc0Oa8kUB2N
qBWCl1RDeFp3c2ShJn0B0wHUFiNMGT0wC+EVOQeWVDrp9bFx6ZY64qJp8JA8QYpg
lPNjB/N4/LGYi1BLlDMnFlqYSa2ITpHgDZEZttSGgnS89e78HvjzoygHXoph/jAy
uF9mx2kXd1Uh925n0T7++y6kTgbhLmPGbbbUHxpOZ8gCo+L6d+uluU7ywORE9oWW
TfVT2ExS2Yt3e0JvQlFidFWsd6yQ/g==
=quR1
-----END PGP SIGNATURE-----

--iX4O5EYFnQO4e9nUmckk9LUBhI1qtUHRr--
