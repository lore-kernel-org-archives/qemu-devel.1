Received: from eggs.gnu.org ([2001:4830:134:3::10]:56462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuGRz-0005np-31
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuGIu-0003ZH-Og
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:07:33 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-5-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b363ad7-4a3f-e0d7-fa0c-a3fa006f7f00@redhat.com>
Date: Mon, 27 Aug 2018 14:07:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aM0gpOiEa6nry0VU5UXiHZdsJUavqR7nt"
Subject: Re: [Qemu-devel] [PATCH v2 04/13] block/commit: refactor commit to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aM0gpOiEa6nry0VU5UXiHZdsJUavqR7nt
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <9b363ad7-4a3f-e0d7-fa0c-a3fa006f7f00@redhat.com>
Subject: Re: [PATCH v2 04/13] block/commit: refactor commit to use job
 callbacks
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-5-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Use the component callbacks; prepare, abort, and clean.
>=20
> NB: prepare is only called when the job has not yet failed;
> and abort can be called after prepare.
>=20
> complete -> prepare -> abort -> clean
> complete -> abort -> clean
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 90 ++++++++++++++++++++++++++++++++------------------=
--------
>  1 file changed, 49 insertions(+), 41 deletions(-)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index b6e8969877..9bf50385cf 100644
> --- a/block/commit.c
> +++ b/block/commit.c

[...]

> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBacken=
d *bs, BlockBackend *base,

[...]

> +static void commit_abort(Job *job)
> +{
> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job=
);
> +    BlockDriverState *top_bs =3D blk_bs(s->top);
> +
> +    /* Make sure commit_top_bs and top stay around until bdrv_replace_=
node() */
> +    bdrv_ref(top_bs);
> +    bdrv_ref(s->commit_top_bs);
> +
> +    if (s->base) {
> +        blk_unref(s->base);
>      }
> =20
> +    /* free the blockers on the intermediate nodes so that bdrv_replac=
e_nodes
> +     * can succeed */
> +    block_job_remove_all_bdrv(&s->common);
> +
> +    /* If bdrv_drop_intermediate() didn't already do that, remove the =
commit
> +     * filter driver from the backing chain. Do this as the final step=
 so that
> +     * the 'consistent read' permission can be granted.

I'd suggest rewording this to "If bdrv_drop_intermediate() failed (or
was not invoked at all), remove the commit filter driver from the
backing chain now."

Right now it sounds like maybe bdrv_drop_intermediate() removes the
filter, and maybe it doesn't.  But actually it is supposed to always
remove it -- but it may fail, and then we have to force-remove the filter=
=2E

Apart from that:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +     *
> +     * XXX Can (or should) we somehow keep 'consistent read' blocked e=
ven
> +     * after the failed/cancelled commit job is gone? If we already wr=
ote
> +     * something to base, the intermediate images aren't valid any mor=
e. */
> +    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL=
,
> +                            &error_abort);
> +    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
> +                      &error_abort);
> +
> +    bdrv_unref(s->commit_top_bs);
> +    bdrv_unref(top_bs);
> +}



--aM0gpOiEa6nry0VU5UXiHZdsJUavqR7nt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD6XkACgkQ9AfbAGHV
z0A3JwgAphRKthfjkg2mpA7efGJ6jyEEzG8hAXbHAdq06VgjU7DL24lQPrdOvR46
PRRgeicovYW10CdLB9/6+rdNZKFPw4vr8tQMS4Gh+77HPxxhR8s7DP3VuBaK6HBy
dbT9VefhZ/vZUwx3RFdpVwWMHL/O3Je7w3AU9QP0ERqzs6JUexWoLX1fkgKsQnO2
MnrcefM8T4k5zwX2AXcssmHxmjSOt2hWvVMKJ9ZWcZMGPttiYMTKL2ivLY1XvKn1
InVw/7+/iGsk4ohce3IE7ebiXnMkbPlx+cr+yIzFJmYfFqe/ikp0GE01gkUAz+63
cdujvRCWGyE3UhBHeEeh+BoPw9z89g==
=eQ/4
-----END PGP SIGNATURE-----

--aM0gpOiEa6nry0VU5UXiHZdsJUavqR7nt--
