Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlE4-00063J-Ix
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlE0-0007N9-G2
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:32:52 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-7-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97a9bb99-2894-3185-da39-b214f5f8e92f@redhat.com>
Date: Mon, 3 Sep 2018 11:32:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180831222907.16257-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xo2rJwLJuKuUkwZoUpwupTOcyReeTiGYT"
Subject: Re: [Qemu-devel] [PATCH v3 06/15] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xo2rJwLJuKuUkwZoUpwupTOcyReeTiGYT
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <97a9bb99-2894-3185-da39-b214f5f8e92f@redhat.com>
Subject: Re: [PATCH v3 06/15] block/mirror: conservative mirror_exit refactor
References: <20180831222907.16257-1-jsnow@redhat.com>
 <20180831222907.16257-7-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-01 00:28, John Snow wrote:
> For purposes of minimum code movement, refactor the mirror_exit
> callback to use the post-finalization callbacks in a trivial way.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index c164fee883..5067f1764d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c

[...]

> @@ -617,7 +618,13 @@ static void mirror_exit(Job *job)
>      BlockDriverState *target_bs =3D blk_bs(s->target);
>      BlockDriverState *mirror_top_bs =3D s->mirror_top_bs;
>      Error *local_err =3D NULL;
> -    int ret =3D job->ret;
> +    bool abort =3D !!job->ret;

I think "job->ret < 0" could be read more easily.

> +    int ret =3D 0;
> +
> +    if (s->prepared) {
> +        return 0;
> +    }
> +    s->prepared =3D true;
> =20
>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
> =20

[...]

> @@ -712,7 +719,17 @@ static void mirror_exit(Job *job)
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
> =20
> -    job->ret =3D ret;
> +    return ret;
> +}
> +
> +static int mirror_prepare(Job *job)
> +{
> +    return mirror_exit_common(job);
> +}
> +
> +static void mirror_abort(Job *job)
> +{
> +    assert(mirror_exit_common(job) =3D=3D 0);

You shouldn't execute vital code in assert(), as NDEBUG would make that
code disappear.  As far as I know, we have decided (at some point) not
to ever enable NDEBUG in qemu, but, you know.  Doing it right only costs
one more line, and it would get you a

Reviewed-by: Max Reitz <mreitz@redhat.com>

>  }
> =20
>  static void mirror_throttle(MirrorBlockJob *s)


--Xo2rJwLJuKuUkwZoUpwupTOcyReeTiGYT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluM/7IACgkQ9AfbAGHV
z0AJ6wgAmlNyeuTjgnHMykmOYqf1VI0S9vubGyENJ3QQywAiTdOfQJoQpjO1WUOq
xiA/c+HkiEoNmh5eo+AVvKlEd242u8qXeownjfBtV6t6Mx1PNGiSus56aI38gl8D
LIw1bruTlMIrrnoWoOZjVjsW6RT9itYAIt631op6qZtEhbYYssCWkLYOi1kM3xVi
OWPdiNu7EyLk2Oeya5+IsHhztTAdHOuZg1vWd4a8sGEsUZRRhXsAVY27OclOudy1
R86NYcgXfzQidAO10r55mnnkZ+oFaJfaTS85TBMyttsIr0bVlUPoD95tZfiar0kV
B99Zj/0MJLlsv8H0pues93yEdu68KA==
=BMOf
-----END PGP SIGNATURE-----

--Xo2rJwLJuKuUkwZoUpwupTOcyReeTiGYT--
