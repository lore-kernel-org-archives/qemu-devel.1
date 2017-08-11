Received: from eggs.gnu.org ([2001:4830:134:3::10]:39354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgB9N-0000Vs-Cs
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgB9M-0002V9-1v
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:42:57 -0400
References: <20170811080939.22304-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f508bf20-c60d-6947-eb54-727d9fa8d686@redhat.com>
Date: Fri, 11 Aug 2017 09:42:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170811080939.22304-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8KRMusDbDRDUFQJIvBxvR360Ixkx7JXK9"
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8KRMusDbDRDUFQJIvBxvR360Ixkx7JXK9
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <f508bf20-c60d-6947-eb54-727d9fa8d686@redhat.com>
Subject: Re: [PATCH for-2.11 v2] file-posix: Clear out first sector in
 hdev_create
References: <20170811080939.22304-1-famz@redhat.com>
In-Reply-To: <20170811080939.22304-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 03:09 AM, Fam Zheng wrote:
> People get surprised when, after "qemu-img create -f raw /dev/sdX", the=
y
> still see qcow2 with "qemu-img info", if previously the bdev had a qcow=
2
> header. While this is natural because raw doesn't need to write any
> magic bytes during creation, hdev_create is free to clear out the first=

> sector to make sure the stale qcow2 header doesn't cause such confusion=
=2E
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Use stack allocated buffer. [Eric]
>     Fix return value.
>     (Keep qemu_write_full instead of switching to qemu_pwritev because
>     the former handles short writes.)
>     Fix typo "qemu-img". [Changlong]
> ---
>  block/file-posix.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f4de022ae0..a63bbf2b90 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2703,6 +2703,16 @@ static int hdev_create(const char *filename, Qem=
uOpts *opts,
>          ret =3D -ENOSPC;
>      }
> =20
> +    if (total_size) {
> +        uint8_t buf[BDRV_SECTOR_SIZE] =3D { 0 };
> +        int64_t zero_size =3D MIN(BDRV_SECTOR_SIZE, total_size);
> +        if (lseek(fd, 0, SEEK_SET) =3D=3D -1) {
> +            ret =3D -errno;
> +        } else {
> +            ret =3D qemu_write_full(fd, buf, zero_size);
> +            ret =3D ret =3D=3D zero_size ? 0 : -errno;
> +        }
> +    }

Question: are we ever constrained by O_DIRECT where writing only 512
bytes would be too small for a block device that mandates 4k alignment?
If so, then we need MAX(minimum write size, MIN(BDRV_SECTOR_SIZE,
total_size)) - it would also mean we can't stack-allocate any more, but
that we have to do an aligned buffer allocation (where g_malloc is not
necessarily suitably aligned).

If O_DIRECT is not a problem, then this is okay:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8KRMusDbDRDUFQJIvBxvR360Ixkx7JXK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmNwlwACgkQp6FrSiUn
Q2ojLggAokpxkA1crh93rAk58+oMz+BaKHkcvo57BckPKwKUvxQPSDib/LsDAaAY
sDCeVdAzkc31OH+N5LKOmD3rSTFWuBpukmCsmQKj3YJjqLxRFQ1tUsZl3E8s9mVw
631jnVJ3+aeamJsUvbNkm2bP+2LB+4OfIAM6mpNLnHypmnJThpvyN/xpnxGXQW0t
sqqrA8Tw7siLXObJHVbrU8BhkEHbgPo8w7w/MfifzSavOvQmwL2b3Ieo2FzhInRr
cG68xua8avhU7Bto0uQc8avbrb1dDvZuoJEBdjkDY+O1RKeVM7X4PX5xNFWf49x9
JePDVjJU/QaOsM4m1oMVOhY+2hfT/g==
=cwvl
-----END PGP SIGNATURE-----

--8KRMusDbDRDUFQJIvBxvR360Ixkx7JXK9--
