Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAhx-0002Nq-6v
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAhw-0005MC-A5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:59:09 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f2d887b-ef2f-2669-72ca-13d6d9b7fd9d@redhat.com>
Date: Wed, 31 May 2017 15:58:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KvEmf8gVjpstMOdovpSVpSKNow2UHrpOV"
Subject: Re: [Qemu-devel] [PATCH 04/11] vpc: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KvEmf8gVjpstMOdovpSVpSKNow2UHrpOV
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <2f2d887b-ef2f-2669-72ca-13d6d9b7fd9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] vpc: make it thread-safe
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-5-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/vpc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20

> @@ -705,10 +700,13 @@ static int64_t coroutine_fn vpc_co_get_block_stat=
us(BlockDriverState *bs,
>                 (sector_num << BDRV_SECTOR_BITS);
>      }
> =20
> -    offset =3D get_sector_offset(bs, sector_num, 0);
> +    qemu_co_mutex_lock(&s->lock);
> +
> +    offset =3D get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, 0)=
;

s/0/false/

(Phooey - your code and my efforts to turn block_status into byte-based
code collide; I'll have to rebase again...)

>          if (nb_sectors =3D=3D 0) {
>              break;
>          }
> -        offset =3D get_sector_offset(bs, sector_num, 0);
> +        offset =3D get_image_offset(bs, sector_num << BDRV_SECTOR_BITS=
, 0);

s/0/false/

With the correct parameter,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KvEmf8gVjpstMOdovpSVpSKNow2UHrpOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLy6RAAoJEKeha0olJ0NqMKgIAJTdaVLe2cMWGr1RaymNMcfZ
YooqeViFIpNOcWdg8jFSMCETEt0+KJ1qJRx+nu8U9BilYgQ10+G+kZFNW2VUKMVz
1NFH7Kl5bP2tUkLNLmKp/WkBRzxBYkhT95N47sXa+uxdlasKbLxOrkHI0OsVwG0X
ZpniRnl6yjBL8YExGiqVLWX3Uc/GzwBKzC9WLJH8nFhgKAMkBWyztWYZv+ydoeBy
w7YB2llon9db6gTKJp/KCzkN02lCuINkMIlXWKsvm20PEGJ45jjUknAnxgVw+dB+
Q/9Ghagh0gPnt0oMmz7YRwWhoTjezVh2QQAfc0Nejz6vEyFN4/h8YA6QViZfrlM=
=CkmW
-----END PGP SIGNATURE-----

--KvEmf8gVjpstMOdovpSVpSKNow2UHrpOV--
