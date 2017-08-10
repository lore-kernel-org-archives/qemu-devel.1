Received: from eggs.gnu.org ([2001:4830:134:3::10]:56003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfnz6-0006Dc-JL
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfnz5-0000Go-Cp
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:58:48 -0400
References: <20170810080108.31047-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f587d8ac-476d-e285-6579-3a8188de1790@redhat.com>
Date: Thu, 10 Aug 2017 08:58:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170810080108.31047-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="celb0QqH6v6JaWrGMxtrbTOuOgHsvJ6G8"
Subject: Re: [Qemu-devel] [PATCH for-2.10?] file-posix: Clear out first
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--celb0QqH6v6JaWrGMxtrbTOuOgHsvJ6G8
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f587d8ac-476d-e285-6579-3a8188de1790@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10?] file-posix: Clear out first sector
 in hdev_create
References: <20170810080108.31047-1-famz@redhat.com>
In-Reply-To: <20170810080108.31047-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 03:01 AM, Fam Zheng wrote:
> People get surprised when, after "qemu-imc create -f raw /dev/sdX", the=
y
> still see qcow2 with "qemu-img info", if previously the bdev had a qcow=
2
> header. While this is natural because raw doesn't need to write any
> magic bytes during creation, hdev_create is free to clear out the first=

> sector to make sure the stale qcow2 header doesn't cause such a
> confusion.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f4de022ae0..1d8ef6f873 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2703,6 +2703,17 @@ static int hdev_create(const char *filename, Qem=
uOpts *opts,
>          ret =3D -ENOSPC;
>      }
> =20
> +    if (total_size) {
> +        int64_t zero_size =3D MIN(BDRV_SECTOR_SIZE, total_size);
> +        uint8_t *buf;

Since BDRV_SECTOR_SIZE is small enough to stack-allocate, you could skip
the malloc by doing:

uint8_t buf[BDRV_SECTOR_SIZE] =3D "";

> +        if (lseek(fd, 0, SEEK_SET) =3D=3D -1) {
> +            ret =3D -errno;
> +        } else {
> +            buf =3D g_malloc0(zero_size);
> +            ret =3D qemu_write_full(fd, buf, zero_size);

Instead of doing lseek + qemu_write_full, can we just use
qemu_pwritev(fd, &iov, 1, 0) with an iov set up to point to the
appropriate amount of buf?

At any rate, my ideas are micro-optimizations, so I can also live with
how you wrote it.

Reviewed-by: Eric Blake <eblake@redhat.com>

Are you arguing that this is a bug-fix worthy of inclusion in 2.10,
because it helps avoid user confusion? Or are you delaying it to 2.11,
because we've had the existing behavior for longer than one release, so
one release more won't hurt?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--celb0QqH6v6JaWrGMxtrbTOuOgHsvJ6G8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMZowACgkQp6FrSiUn
Q2q8Ygf/Z1hyMZJrB8GICObTislpznQyrqqanu4AMPTwr+8k56SEy7184+4omdKk
BD3kMw3nMcALd2jK2RekZOIdJ3DH3MoolykoXN6sx02aADOU02AzgqiqwZZOFThg
gs9HNZRan4MZ+YIBx847iAc78u6l9Nca4C7JDvIoYTc+RLNW4bjQ43Hi908/aM5K
s42bnbVnMt+2lZYOzey4lcMwkdcY8Ec0vWbqwHfeiRpGp/SY6XGhViqTq433ny3F
7hOiVi801we0yTxmAdlsKE4hZvmslGy4BbMUbsZmM/Bmfe0aq+2DJt/HwxV0aQ1+
W4iFH6CmQmISRG2Lpkur7GpzCB2y3A==
=wagM
-----END PGP SIGNATURE-----

--celb0QqH6v6JaWrGMxtrbTOuOgHsvJ6G8--
