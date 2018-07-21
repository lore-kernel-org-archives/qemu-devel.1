Received: from eggs.gnu.org ([2001:4830:134:3::10]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgz7P-0006oD-DL
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgz7O-0006ca-K0
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:08:47 -0400
References: <20180719034118.27741-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
Date: Sat, 21 Jul 2018 23:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180719034118.27741-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PxWgkH6j27n1z6QPJ1AjGDiE8gjm1UJwz"
Subject: Re: [Qemu-devel] [PATCH] block: Don't lock /dev/null and /dev/zero
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxWgkH6j27n1z6QPJ1AjGDiE8gjm1UJwz
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
Subject: Re: [PATCH] block: Don't lock /dev/null and /dev/zero automatically
References: <20180719034118.27741-1-famz@redhat.com>
In-Reply-To: <20180719034118.27741-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-19 05:41, Fam Zheng wrote:
> On my Fedora 28, /dev/null is locked by some other process (couldn't
> inspect it due to the current lslocks limitation), so iotests 226 fails=

> with some unexpected image locking errors because it uses qemu-io to
> open it.
>=20
> Actually it's safe to not use any lock on /dev/null or /dev/zero.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..8bf034108a 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *bs, Q=
Dict *options,
>          s->use_lock =3D false;
>          break;
>      case ON_OFF_AUTO_AUTO:
> -        s->use_lock =3D qemu_has_ofd_lock();
> +        if (!strcmp(filename, "/dev/null") ||
> +                   !strcmp(filename, "/dev/zero")) {

I=E2=80=99m not sure I like a strcmp() based on filename (though it shoul=
d work
for all of the cases where someone would want to specify either of those
for a qemu block device).  Isn=E2=80=99t there some specific major/minor =
number
we can use to check for these two files?  Or are those Linux-specific?

I could also imagine just not locking any host_device, but since people
do use qcow2 immediately on block devices, maybe we do want to lock them.=


Finally, if really all you are trying to do is to make test code easier,
then I don=E2=80=99t know exactly why.  Just disabling locking in 226 sho=
uldn=E2=80=99t
be too hard.

Max

> +            s->use_lock =3D false;
> +        } else {
> +            s->use_lock =3D qemu_has_ofd_lock();
> +        }
>          break;
>      default:
>          abort();
>=20



--PxWgkH6j27n1z6QPJ1AjGDiE8gjm1UJwz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltToNMACgkQ9AfbAGHV
z0D6gggAtk/HVFVY2EYcZKIaIBaeBpkfkPVfpY0mQFv1QtIRjNcqtCePOx0o4ECT
dJJfTFCDuz6Pt6XO8po358HFDGR20ffmCReXDVS90U6MkMkAA/jDm4Jv5UnADNuN
HXS++7V5hJi0qIfyJpOY8/QK2UnxKpHaA0ubHJ+mBqCP5ZolUiL4bPkiFgWSSndt
r78naTnt83bJJmnoyeJl5nxOfRQAy3lDctoOYxYxrwCI9dFCty5B36gj9OgRLJxO
oOUgL8Yy9/rdJuSvY4bFy/Zigcykc3C2ev1TMDFZokQfF3US+EiA+DzVC2djx5mS
5gOYRaYZ6j5LXgar4fwAjop/tF/5WQ==
=r0iW
-----END PGP SIGNATURE-----

--PxWgkH6j27n1z6QPJ1AjGDiE8gjm1UJwz--
