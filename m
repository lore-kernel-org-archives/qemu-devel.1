Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVEx-0002qR-2d
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVEw-00027D-BC
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:40:51 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
Date: Wed, 5 Sep 2018 12:40:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180904170930.28619-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dgh1VTNOKyU9t0jJnlXOX3MHRLzkXwBGH"
Subject: Re: [Qemu-devel] [PATCH v4 05/15] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dgh1VTNOKyU9t0jJnlXOX3MHRLzkXwBGH
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>
Message-ID: <ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
Subject: Re: [PATCH v4 05/15] block/mirror: don't install backing chain on
 abort
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-6-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-04 19:09, John Snow wrote:
> In cases where we abort the block/mirror job, there's no point in
> installing the new backing chain before we finish aborting.
>=20
> Move this to the "success" portion of mirror_exit.

Sounds a bit weird now that you don't do any moving.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index cba555b4ef..3365bcfdfb 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -642,7 +642,7 @@ static void mirror_exit(Job *job)
>       * required before it could become a backing file of target_bs. */=

>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>                              &error_abort);
> -    if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
> +    if (ret =3D=3D 0 && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_C=
HAIN) {
>          BlockDriverState *backing =3D s->is_none_mode ? src : s->base;=

>          if (backing_bs(target_bs) !=3D backing) {
>              bdrv_set_backing_hd(target_bs, backing, &local_err);
> @@ -659,10 +659,7 @@ static void mirror_exit(Job *job)
>      }
> =20
>      if (s->should_complete && ret =3D=3D 0) {
> -        BlockDriverState *to_replace =3D src;
> -        if (s->to_replace) {
> -            to_replace =3D s->to_replace;
> -        }
> +        BlockDriverState *to_replace =3D s->to_replace ? s->to_replace=
 : src;
> =20
>          if (bdrv_get_flags(target_bs) !=3D bdrv_get_flags(to_replace))=
 {
>              bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);

And this hunk now looks out of place.  Sure, it makes sense, but why is
it in this patch now? :-)

(Moving it into the next patch would make more sense, I think.)

I'd like to give an R-b anyway, but I know that I shouldn't, so I won't.

Max


--dgh1VTNOKyU9t0jJnlXOX3MHRLzkXwBGH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPsqUACgkQ9AfbAGHV
z0Cb8wf/dJAMeIlFmm6oyiI9nycawjuQ5f3b1UZYB2vYzy1XBPjLbCjQ+XVKfc+Y
6yFFqh8aVSWETeGx6RCHtj7cJ8kqvrqsDNC8iPRAGZr0bGvE0TlWSrX6PsYstjDk
h2QEfk6hcCJs+kX70ROqmZuwrFvmxqkofyu2AY6xlJkeb2e82xFo4sjMP7vOdKtM
8tSlWxOvEALqSFdYqxdKgwW0if/Ajs1smaNdPU3hYgTRUyxCycIQLINiCGsHHjaF
0HNpjU/K+B8f0YFRg305FehrF3bMsSpD1wV50ttu1Wf80XUYRUli1jrKi5MBfmkM
8XGJR4K3cGedpCSBKO7GSTdldIfD2Q==
=rwEt
-----END PGP SIGNATURE-----

--dgh1VTNOKyU9t0jJnlXOX3MHRLzkXwBGH--
