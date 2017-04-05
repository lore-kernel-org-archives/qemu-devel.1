Received: from eggs.gnu.org ([2001:4830:134:3::10]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmzj-0006de-64
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmzg-0002SV-3n
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvmzf-0002RH-QX
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:37:12 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
	<1491405505-31620-3-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b9dc574-b6bb-e0ef-adf0-84d35bf4a883@redhat.com>
Date: Wed, 5 Apr 2017 10:37:09 -0500
MIME-Version: 1.0
In-Reply-To: <1491405505-31620-3-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5PGhGRNIXHq4CbxHsuO9IHGrv8Txf2qpe"
Subject: Re: [Qemu-devel] [PATCH 2/2] block: assert no image modification
 under BDRV_O_INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5PGhGRNIXHq4CbxHsuO9IHGrv8Txf2qpe
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <9b9dc574-b6bb-e0ef-adf0-84d35bf4a883@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block: assert no image modification
 under BDRV_O_INACTIVE
References: <1491405505-31620-1-git-send-email-den@openvz.org>
 <1491405505-31620-3-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-3-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 10:18 AM, Denis V. Lunev wrote:
> As long as BDRV_O_INACTIVE is set, the image file is only opened so we
> have a file descriptor for it. We're definitely not supposed to modify
> the image, it's still owned by the migration source.
>=20
> This commit is an addition to 09e0c771 but the assert() is added to
> bdrv_truncate().
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)

I don't feel comfortable adding an assert this late in the 2.9 phase,
but think it makes perfect sense as a 2.10 addition.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block.c b/block.c
> index 927ba89..9273741 100644
> --- a/block.c
> +++ b/block.c
> @@ -3279,6 +3279,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offse=
t)
>      if (bs->read_only)
>          return -EACCES;
> =20
> +    assert(!(bs->open_flags & BDRV_O_INACTIVE));
> +
>      ret =3D drv->bdrv_truncate(bs, offset);
>      if (ret =3D=3D 0) {
>          ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);=

>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5PGhGRNIXHq4CbxHsuO9IHGrv8Txf2qpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5Q8lAAoJEKeha0olJ0NqdoMIAIrd+8Wfkbuv7T8XgabHByRa
K65kcWX76tXqUnYsaYoYbfqfoJwIsxoDMgGEDHeVd8Up2oIzYHTghIgw+pmrLeol
L54ExMDogUj4Gq+gk2tnd49ClyhgOAaNDVM7op8cC0zZCz1cQTr0lz615YOyCCSW
2au41XFjQ9eQcWQ7Md2SklZav8pr0t4m4ndWIpX90RcObq1LJ/2Q6pCBOuIdUT0w
n8TcS3OqznnkBhTrOpAAB9ClF7NKPFAtLbEZwM+GcFHeTWnz8eDpfZgjKYuHeWT+
RrcBjYDK9+hKQ0LNHQM4b9ALockaohvuoRJG2p631ZADlPgyzqwx0Uyhq/jOG+c=
=nfk6
-----END PGP SIGNATURE-----

--5PGhGRNIXHq4CbxHsuO9IHGrv8Txf2qpe--
