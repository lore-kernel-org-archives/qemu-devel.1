Received: from eggs.gnu.org ([2001:4830:134:3::10]:39266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwl6V-0006Li-G0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwl6U-0003XO-IW
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:25:03 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b79cdffa-a0d4-824c-b9fd-b5aba38e61bd@redhat.com>
Date: Mon, 3 Sep 2018 11:24:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180831222907.16257-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AFBrsUPTMNRe1JTITAGP29o6KGJrCOBJB"
Subject: Re: [Qemu-devel] [PATCH v3 05/15] block/mirror: don't install
 backing chain on abort
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
--AFBrsUPTMNRe1JTITAGP29o6KGJrCOBJB
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <b79cdffa-a0d4-824c-b9fd-b5aba38e61bd@redhat.com>
Subject: Re: [PATCH v3 05/15] block/mirror: don't install backing chain on
 abort
References: <20180831222907.16257-1-jsnow@redhat.com>
 <20180831222907.16257-6-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-01 00:28, John Snow wrote:
> In cases where we abort the block/mirror job, there's no point in
> installing the new backing chain before we finish aborting.
>=20
> Move this to the "success" portion of mirror_exit.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index cba555b4ef..c164fee883 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -642,16 +642,6 @@ static void mirror_exit(Job *job)
>       * required before it could become a backing file of target_bs. */=

>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>                              &error_abort);
> -    if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
> -        BlockDriverState *backing =3D s->is_none_mode ? src : s->base;=

> -        if (backing_bs(target_bs) !=3D backing) {
> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
> -            if (local_err) {
> -                error_report_err(local_err);
> -                ret =3D -EPERM;
> -            }
> -        }
> -    }
> =20
>      if (s->to_replace) {
>          replace_aio_context =3D bdrv_get_aio_context(s->to_replace);
> @@ -659,9 +649,18 @@ static void mirror_exit(Job *job)
>      }
> =20
>      if (s->should_complete && ret =3D=3D 0) {
> -        BlockDriverState *to_replace =3D src;
> -        if (s->to_replace) {
> -            to_replace =3D s->to_replace;
> +        BlockDriverState *to_replace =3D s->to_replace ? s->to_replace=
 : src;
> +
> +        if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
> +            BlockDriverState *backing =3D s->is_none_mode ? src : s->b=
ase;
> +            if (backing_bs(target_bs) !=3D backing) {
> +                bdrv_set_backing_hd(target_bs, backing, &local_err);
> +                if (local_err) {
> +                    error_report_err(local_err);
> +                    ret =3D -EPERM;
> +                    goto clean;
> +                }
> +            }
>          }
> =20
>          if (bdrv_get_flags(target_bs) !=3D bdrv_get_flags(to_replace))=
 {

Testing shows that on post-READY cancel, s->should_complete is 0 (which
makes sense, because all the rest in this path is about replacing
to_replace by target_bs, which we don't want to do on cancel), so this
would not be executed.

However, I think we do want to give the target the correct backing chain
when the job is canceled this way (as I suppose there are ways to keep
the target around even with drive-mirror).

So we should attach the backing chain whenever ret =3D=3D 0, not just whe=
n
s->should_complete is true.

Max

> @@ -678,6 +677,8 @@ static void mirror_exit(Job *job)
>              ret =3D -EPERM;
>          }
>      }
> +
> + clean:
>      if (s->to_replace) {
>          bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
>          error_free(s->replace_blocker);
>=20



--AFBrsUPTMNRe1JTITAGP29o6KGJrCOBJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluM/d4ACgkQ9AfbAGHV
z0ATjQf8DzPzvXuRSh5+7Xp8RTa1Xj4rEu7udHXkbT2cJG1D1m6ELhSDojq41ZYJ
cQqmXFQWa3k+q/B0ot5OoGNXtpqIOkfE6Rz4MdZJ6UysQofBZ1Jg0CrvV7zxQBxX
55dCTRtrE3v1fIDg28gaaH8DcQ6LrDQLM7R1P62S3qY6OQtcD3MHiZHqNmln7P1R
PgBdFMpSRz/zMsOGk1LnajEWgvwocMkhrDCKetOIqsWB6GExBEOfCzeX1mDJ3Ryk
WY0zOpxnJ+TfkftdPldS3urZDyvpGdKYT1uKazshFt7fY1WhIHqt5Q4syLoEUPR1
wA/9VqNCVuHsDPcRsnVSub9bbcXMGg==
=IYFa
-----END PGP SIGNATURE-----

--AFBrsUPTMNRe1JTITAGP29o6KGJrCOBJB--
