Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGH8-0003ju-HV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGH7-0000cJ-BD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:12:30 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa12ad3e-c335-2e8a-e9ac-d55ba0fb91d5@redhat.com>
Date: Sat, 12 May 2018 00:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8GI2eMmgDI21L1J6ckYlXMQQpSk9WnVuC"
Subject: Re: [Qemu-devel] [PATCH 02/42] blockjob: Wrappers for progress
 counter access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8GI2eMmgDI21L1J6ckYlXMQQpSk9WnVuC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <aa12ad3e-c335-2e8a-e9ac-d55ba0fb91d5@redhat.com>
Subject: Re: [PATCH 02/42] blockjob: Wrappers for progress counter access
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-3-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:25, Kevin Wolf wrote:
> Block job drivers are not expected to mess with the internals of the
> BlockJob object, so provide wrapper functions for one of the cases wher=
e
> they still do it: Updating the progress counter.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/blockjob.h | 19 +++++++++++++++++++
>  block/backup.c           | 22 +++++++++++++---------
>  block/commit.c           | 16 ++++++++--------
>  block/mirror.c           | 11 +++++------
>  block/stream.c           | 14 ++++++++------
>  blockjob.c               | 10 ++++++++++
>  6 files changed, 63 insertions(+), 29 deletions(-)
>=20

[...]

> diff --git a/block/backup.c b/block/backup.c
> index 453cd62c24..5d95805472 100644
> --- a/block/backup.c
> +++ b/block/backup.c
>

[...]

> @@ -420,8 +421,9 @@ static void backup_incremental_init_copy_bitmap(Bac=
kupBlockJob *job)
>          bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
>      }
> =20
> -    job->common.offset =3D job->common.len -
> -                         hbitmap_count(job->copy_bitmap) * job->cluste=
r_size;
> +    /* TODO block_job_progress_set_remaining() would make more sense *=
/

Extremely true, especially considering that at least there was an
assignment before.

> +    block_job_progress_update(&job->common,
> +        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size=
);

Now, with an incremental update, you have to know that the progress was
0 before this call to make any sense of it.

I could ask: Why don't you just resolve the TODO immediately with

    block_job_progress_set_remaining(&job->common,
        hbitmap_count(job->copy_bitmap) * job->cluster_size);

?

I suppose one possible answer is that this series has 42 patches as it
is, but I have to say that it took me more time to figure this hunk out
than it would have taken me to acknowledge the above change.

Considering that job->len and job->common.len are now separate after
this patch, and that there is only a single other
block_job_progress_update() call in this file, I can't see any side effec=
ts.

> =20
>      bdrv_dirty_iter_free(dbi);
>  }

[...]

> diff --git a/block/mirror.c b/block/mirror.c
> index 99da9c0858..77ee9b1791 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c

[...]

> @@ -792,11 +792,10 @@ static void coroutine_fn mirror_run(void *opaque)=

>          block_job_pause_point(&s->common);
> =20
>          cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
> -        /* s->common.offset contains the number of bytes already proce=
ssed so
> -         * far, cnt is the number of dirty bytes remaining and
> -         * s->bytes_in_flight is the number of bytes currently being
> -         * processed; together those are the current total operation l=
ength */
> -        s->common.len =3D s->common.offset + s->bytes_in_flight + cnt;=

> +        /* cnt is the number of dirty bytes remaining and s->bytes_in_=
flight is
> +         * the number of bytes currently being processed; together tho=
se are
> +         * the current total operation length */

No, together, those are the current remaining operation length.

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        block_job_progress_set_remaining(&s->common, s->bytes_in_fligh=
t + cnt);
> =20
>          /* Note that even when no rate limit is applied we need to yie=
ld
>           * periodically with no pending I/O so that bdrv_drain_all() r=
eturns.


--8GI2eMmgDI21L1J6ckYlXMQQpSk9WnVuC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2FUMACgkQ9AfbAGHV
z0Btigf8Cm+mPgOTvByH1wx+8Dx4vfrKGhre/YeVT/7gjyfIOjzkv4NV3upjojLs
S6yp2D6TxqR9XPbPBNvZx7JLhMQZXd+5RIHfjKu1T0SQuSAqdcC8/y97W0VY17Yh
zFA0gktuItMYVMUVvSt16z80Qs+wHbbm+hE2OkJhB9tLfGKG3OjbJFk/yNopkJpW
84WT8KqAPNC1YDec7kjNLn/0s8BZZzv1Fnx8C5YgJW/phNv9HJPFVa9VC9gbfk4j
qjYjovKwkomY4IINZzyOIZY79jKjyfy/slPW7EhuIB0l+mq7HBZSZRIAeUTS14/a
fPVOWf/ErOYq/wrRc+cdfDj/kzNQRA==
=KkYw
-----END PGP SIGNATURE-----

--8GI2eMmgDI21L1J6ckYlXMQQpSk9WnVuC--
