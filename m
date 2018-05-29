Received: from eggs.gnu.org ([2001:4830:134:3::10]:49559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNcxi-0006d9-Kf
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNcxh-0003Aw-G1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:38:46 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-5-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a8246b04-65e2-9169-69b5-fd57edcf1089@redhat.com>
Date: Tue, 29 May 2018 13:38:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qJ9izLw46zm4u7OLxPHpFP3vlwuG5PVJv"
Subject: Re: [Qemu-devel] [PATCH 04/14] block/create: Make x-blockdev-create
 a job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qJ9izLw46zm4u7OLxPHpFP3vlwuG5PVJv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <a8246b04-65e2-9169-69b5-fd57edcf1089@redhat.com>
Subject: Re: [PATCH 04/14] block/create: Make x-blockdev-create a job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-5-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This changes the x-blockdev-create QMP command so that it doesn't block=

> the monitor and the main loop any more, but starts a background job tha=
t
> performs the image creation.
>=20
> The basic job as implemented here is all that is necessary to make imag=
e
> creation asynchronous and to provide a QMP interface that can be marked=

> stable, but it still lacks a few features that jobs usually provide: Th=
e
> job will ignore pause commands and it doesn't publish progress yet (so
> both current-progress and total-progress stay at 0). These features can=

> be added later without breaking compatibility.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json     | 14 +++++++----
>  qapi/job.json            |  4 +++-
>  block/create.c           | 61 ++++++++++++++++++++++++++++++++--------=
--------
>  tests/qemu-iotests/group | 14 ++++++-----
>  4 files changed, 61 insertions(+), 32 deletions(-)

[...]

> diff --git a/block/create.c b/block/create.c
> index 8bd8a03719..87fdab3b72 100644
> --- a/block/create.c
> +++ b/block/create.c
> @@ -24,28 +24,49 @@
> =20
>  #include "qemu/osdep.h"
>  #include "block/block_int.h"
> +#include "qemu/job.h"
>  #include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> =20
> -typedef struct BlockdevCreateCo {
> +typedef struct BlockdevCreateJob {
> +    Job common;
>      BlockDriver *drv;
>      BlockdevCreateOptions *opts;
>      int ret;
> -    Error **errp;
> -} BlockdevCreateCo;
> +    Error *err;
> +} BlockdevCreateJob;
> =20
> -static void coroutine_fn bdrv_co_create_co_entry(void *opaque)
> +static void blockdev_create_complete(Job *job, void *opaque)
>  {
> -    BlockdevCreateCo *cco =3D opaque;
> -    cco->ret =3D cco->drv->bdrv_co_create(cco->opts, cco->errp);
> +    BlockdevCreateJob *s =3D container_of(job, BlockdevCreateJob, comm=
on);
> +
> +    job_completed(job, s->ret, s->err);
>  }
> =20
> -void qmp_x_blockdev_create(BlockdevCreateOptions *options, Error **err=
p)
> +static void coroutine_fn blockdev_create_run(void *opaque)
>  {
> +    BlockdevCreateJob *s =3D opaque;
> +
> +    s->ret =3D s->drv->bdrv_co_create(s->opts, &s->err);
> +
> +    qapi_free_BlockdevCreateOptions(s->opts);
> +    job_defer_to_main_loop(&s->common, blockdev_create_complete, NULL)=
;

Better be safe than sorry, but probably not strictly necessary
considering the job is always run in the main loop anyway (more on that
below, though).

> +}
> +
> +static const JobDriver blockdev_create_job_driver =3D {
> +    .instance_size =3D sizeof(BlockdevCreateJob),
> +    .job_type      =3D JOB_TYPE_CREATE,
> +    .start         =3D blockdev_create_run,
> +};
> +
> +void qmp_x_blockdev_create(const char *job_id, BlockdevCreateOptions *=
options,
> +                           Error **errp)
> +{
> +    BlockdevCreateJob *s;
>      const char *fmt =3D BlockdevDriver_str(options->driver);
>      BlockDriver *drv =3D bdrv_find_format(fmt);
> -    Coroutine *co;
> -    BlockdevCreateCo cco;
> =20
>      /* If the driver is in the schema, we know that it exists. But it =
may not
>       * be whitelisted. */
> @@ -61,16 +82,16 @@ void qmp_x_blockdev_create(BlockdevCreateOptions *o=
ptions, Error **errp)

Minor note: The comment above this if () block reads:

    /* Call callback if it exists */

Which is now no longer really what is happening.  It just checks whether
the block driver supports blockdev-create.

>          return;
>      }
> =20
> -    cco =3D (BlockdevCreateCo) {
> -        .drv =3D drv,
> -        .opts =3D options,
> -        .ret =3D -EINPROGRESS,
> -        .errp =3D errp,
> -    };
> -
> -    co =3D qemu_coroutine_create(bdrv_co_create_co_entry, &cco);
> -    qemu_coroutine_enter(co);
> -    while (cco.ret =3D=3D -EINPROGRESS) {
> -        aio_poll(qemu_get_aio_context(), true);
> +    /* Create the block job */
> +    s =3D job_create(job_id, &blockdev_create_job_driver, NULL,
> +                   qemu_get_aio_context(), JOB_DEFAULT | JOB_MANUAL_DI=
SMISS,

Hmmm...  The old code already used the main AIO context, but is that
correct?  When you create a qcow2 node on top of a file node, shouldn't
you use the AIO context of the file node?

I see that figuring out the correct context generically may be difficult
to impossible, so OK, maybe we should just run image creation in the
main context for now.  But then, qcow2 (and other formats) should at
least take a lock on their file's context, which they don't seem to do.

So I suppose I can give a

Reviewed-by: Max Reitz <mreitz@redhat.com>

for this patch, but I think some block drivers need some locking.

Max
=09
> +                   NULL, NULL, errp);
> +    if (!s) {
> +        return;
>      }
> +
> +    s->drv =3D drv,
> +    s->opts =3D QAPI_CLONE(BlockdevCreateOptions, options),
> +
> +    job_start(&s->common);
>  }


--qJ9izLw46zm4u7OLxPHpFP3vlwuG5PVJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNO70ACgkQ9AfbAGHV
z0CzUAf6A1oyDDHhrRlbjF07dYhyMbtgRv2QJ0Tds/MzyQMxiVQmWoib7/FHtdzI
L6VZAsf0Gjp/6oSZQZpZxPRV13qj5ISbmcoTpWNG0vdHfeeEDqdydl53Zz1l6C1s
/v4DWz5V77gulCeMMCcRLFRFHws83/4tP3f9xwyuxXyYkgkXSo3rQIAgAZuu4c8e
PqhvstC7Byh8lpLiZQJp6nnxSnAjFcSIqqV0RStj4f1dYtAaSvPGXqt3iFxeD4Qh
LKGsFq7oyMUyImUkFvphQcDTHWphBwQl6ahmD+fzAGF+VWaUKuCQGfYiIY+uFd6f
Tug4TrHBU5Vfzx8AWKc1O4lI4hb+pQ==
=7DVp
-----END PGP SIGNATURE-----

--qJ9izLw46zm4u7OLxPHpFP3vlwuG5PVJv--
