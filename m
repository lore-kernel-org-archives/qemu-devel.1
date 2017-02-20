Received: from eggs.gnu.org ([2001:4830:134:3::10]:39661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfoB4-0003De-3r
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfoB2-0004KN-Oc
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:38:54 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-26-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dbc67cad-cfe7-3bb0-dc67-35bb0d674a9c@redhat.com>
Date: Mon, 20 Feb 2017 14:38:39 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-26-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qm0C9tXKjfnrpwkc0UhmBwqnsbN0btXH6"
Subject: Re: [Qemu-devel] [RFC PATCH 25/41] blockjob: Add permissions to
 block_job_add_bdrv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qm0C9tXKjfnrpwkc0UhmBwqnsbN0btXH6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <dbc67cad-cfe7-3bb0-dc67-35bb0d674a9c@redhat.com>
Subject: Re: [RFC PATCH 25/41] blockjob: Add permissions to
 block_job_add_bdrv()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-26-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Block jobs don't actually do I/O through the the reference they create
> with block_job_add_bdrv(), but they might want to use the permisssion
> system to express what the block job does to intermediate nodes. This
> adds permissions to block_job_add_bdrv() to provide the means to reques=
t
> permissions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c           |  3 ++-
>  block/commit.c           |  7 +++++--
>  block/mirror.c           |  7 +++++--
>  block/stream.c           |  3 ++-
>  blockjob.c               | 27 +++++++++++++++++++++------
>  include/block/blockjob.h |  4 +++-
>  6 files changed, 38 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 12ab25c..22171f4 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -657,7 +657,8 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>          job->cluster_size =3D MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.clu=
ster_size);
>      }
> =20
> -    block_job_add_bdrv(&job->common, target);
> +    /* FIXME Use real permissions */
> +    block_job_add_bdrv(&job->common, target, 0, BLK_PERM_ALL, &error_a=
bort);
>      job->common.len =3D len;
>      block_job_txn_add_job(txn, &job->common);
> =20
> diff --git a/block/commit.c b/block/commit.c
> index 60d29a9..68fa2a4 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -267,13 +267,16 @@ void commit_start(const char *job_id, BlockDriver=
State *bs,
>       * disappear from the chain after this operation. */
>      assert(bdrv_chain_contains(top, base));
>      for (iter =3D top; iter !=3D backing_bs(base); iter =3D backing_bs=
(iter)) {
> -        block_job_add_bdrv(&s->common, iter);
> +        /* FIXME Use real permissions */
> +        block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_a=
bort);
>      }
>      /* overlay_bs must be blocked because it needs to be modified to
>       * update the backing image string, but if it's the root node then=

>       * don't block it again */
>      if (bs !=3D overlay_bs) {
> -        block_job_add_bdrv(&s->common, overlay_bs);
> +        /* FIXME Use real permissions */
> +        block_job_add_bdrv(&s->common, overlay_bs, 0, BLK_PERM_ALL,
> +                           &error_abort);
>      }
> =20
>      /* FIXME Use real permissions */
> diff --git a/block/mirror.c b/block/mirror.c
> index 22680d7..9532b18 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1020,13 +1020,16 @@ static void mirror_start_job(const char *job_id=
, BlockDriverState *bs,
>          return;
>      }
> =20
> -    block_job_add_bdrv(&s->common, target);
> +    /* FIXME Use real permissions */
> +    block_job_add_bdrv(&s->common, target, 0, BLK_PERM_ALL, &error_abo=
rt);
> +
>      /* In commit_active_start() all intermediate nodes disappear, so
>       * any jobs in them must be blocked */
>      if (bdrv_chain_contains(bs, target)) {
>          BlockDriverState *iter;
>          for (iter =3D backing_bs(bs); iter !=3D target; iter =3D backi=
ng_bs(iter)) {
> -            block_job_add_bdrv(&s->common, iter);
> +            /* FIXME Use real permissions */
> +            block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &err=
or_abort);
>          }
>      }
> =20
> diff --git a/block/stream.c b/block/stream.c
> index 7f49279..47f0ffb 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -248,7 +248,8 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
>      /* Block all intermediate nodes between bs and base, because they
>       * will disappear from the chain after this operation */
>      for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D bac=
king_bs(iter)) {
> -        block_job_add_bdrv(&s->common, iter);
> +        /* FIXME Use real permissions */
> +        block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_a=
bort);
>      }
> =20
>      s->base =3D base;
> diff --git a/blockjob.c b/blockjob.c
> index 27833c7..0bcc099 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -55,6 +55,10 @@ struct BlockJobTxn {
> =20
>  static QLIST_HEAD(, BlockJob) block_jobs =3D QLIST_HEAD_INITIALIZER(bl=
ock_jobs);
> =20
> +static const BdrvChildRole child_job =3D {
> +    .stay_at_node   =3D true,

(1) Not a big fan of such alignment without further users.

(2) No problem though because I'd like to ask for get_link_name() and/or
get_name() here.

It should be easy to generate a nice description when using the BlockJob
as BdrvChild.opaque.

> +};
> +
>  BlockJob *block_job_next(BlockJob *job)
>  {
>      if (!job) {
> @@ -115,11 +119,22 @@ static void block_job_detach_aio_context(void *op=
aque)
>      block_job_unref(job);
>  }
> =20
> -void block_job_add_bdrv(BlockJob *job, BlockDriverState *bs)
> +int block_job_add_bdrv(BlockJob *job, BlockDriverState *bs,
> +                       uint64_t perm, uint64_t shared_perm, Error **er=
rp)
>  {
> -    job->nodes =3D g_slist_prepend(job->nodes, bs);
> +    BdrvChild *c;
> +
> +    c =3D bdrv_root_attach_child(bs, "job", &child_job, perm, shared_p=
erm,

"job" doesn't make much sense as the child's name, it's rather a generic
name for the parent.

"job-child" or something caller-provided would be better. (I'd vote for
caller-provided. We don't have that many callers.)

Max

> +                               NULL, errp);
> +    if (c =3D=3D NULL) {
> +        return -EPERM;
> +    }
> +
> +    job->nodes =3D g_slist_prepend(job->nodes, c);
>      bdrv_ref(bs);
>      bdrv_op_block_all(bs, job->blocker);
> +
> +    return 0;
>  }
> =20
>  void *block_job_create(const char *job_id, const BlockJobDriver *drive=
r,

[...]



--qm0C9tXKjfnrpwkc0UhmBwqnsbN0btXH6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq8V8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArVEIALyb1O1wvohaJgzqBGA5ADiht277S0OP
nZuhA6Y7m5+ABDbL+N3vERafOU2u6TyA5DwQM5aqhPYmDnBzM2+lKjJSfHmghUgZ
IG6DADgNoyeGNh2HO2w9Jh4JGoaGsaUMn7B9UhfSQoKTV2oJ6f/nmz3wsC/U8RT7
WBh/Y/KaSaSm7PQDKfvYfqYC5kmwGQAoVKllwRRDMTO+3EkdGIN1tRoow9swVkFD
4BAP9E+Ub2pLRa1oCZQuFX4iOTDXaVkVSAwlAJ3ZCPodcgIumrImfaz301ztp3Sv
lm0bFMB421RhzY9HqP8OGetMA0fyMwSn6fhBOX1j0gCRgCwp3jJYxAU=
=w8Aa
-----END PGP SIGNATURE-----

--qm0C9tXKjfnrpwkc0UhmBwqnsbN0btXH6--
