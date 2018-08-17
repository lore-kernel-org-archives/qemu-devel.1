Received: from eggs.gnu.org ([2001:4830:134:3::10]:38672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqkGQ-00034W-PP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqkGP-0007Uk-Vz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:18:26 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-5-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
Date: Fri, 17 Aug 2018 15:18:11 -0400
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>



On 08/17/2018 03:04 PM, John Snow wrote:
> Change the manual deferment to commit_complete into the implicit
> callback to job_exit, renaming commit_complete to commit_exit.
>=20
> This conversion does change the timing of when job_completed is
> called to after the bdrv_replace_node and bdrv_unref calls, which
> could have implications for bjob->blk which will now be put down
> after this cleanup.
>=20
> Kevin highlights that we did not take any permissions for that backend
> at job creation time, so it is safe to reorder these operations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index 4a17bb73ec..93c3b6a39e 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -68,19 +68,13 @@ static int coroutine_fn commit_populate(BlockBacken=
d *bs, BlockBackend *base,
>      return 0;
>  }
> =20
> -typedef struct {
> -    int ret;
> -} CommitCompleteData;
> -
> -static void commit_complete(Job *job, void *opaque)
> +static void commit_exit(Job *job)
>  {
>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job=
);
>      BlockJob *bjob =3D &s->common;
> -    CommitCompleteData *data =3D opaque;
>      BlockDriverState *top =3D blk_bs(s->top);
>      BlockDriverState *base =3D blk_bs(s->base);
>      BlockDriverState *commit_top_bs =3D s->commit_top_bs;
> -    int ret =3D data->ret;
>      bool remove_commit_top_bs =3D false;
> =20
>      /* Make sure commit_top_bs and top stay around until bdrv_replace_=
node() */
> @@ -93,8 +87,8 @@ static void commit_complete(Job *job, void *opaque)
> =20
>      if (!job_is_cancelled(job) && ret =3D=3D 0) {

forgot to actually squash the change in here that replaces `ret` with
`job->ret`.

>          /* success */
> -        ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
> -                                     s->backing_file_str);
> +        job->ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
> +                                          s->backing_file_str);
>      } else {
>          /* XXX Can (or should) we somehow keep 'consistent read' block=
ed even
>           * after the failed/cancelled commit job is gone? If we alread=
y wrote
> @@ -117,9 +111,6 @@ static void commit_complete(Job *job, void *opaque)
>       * bdrv_set_backing_hd() to fail. */
>      block_job_remove_all_bdrv(bjob);
> =20
> -    job_completed(job, ret);
> -    g_free(data);
> -
>      /* If bdrv_drop_intermediate() didn't already do that, remove the =
commit
>       * filter driver from the backing chain. Do this as the final step=
 so that
>       * the 'consistent read' permission can be granted.  */
> @@ -137,7 +128,6 @@ static void commit_complete(Job *job, void *opaque)
>  static int coroutine_fn commit_run(Job *job, Error **errp)
>  {
>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job=
);
> -    CommitCompleteData *data;
>      int64_t offset;
>      uint64_t delay_ns =3D 0;
>      int ret =3D 0;
> @@ -210,9 +200,6 @@ static int coroutine_fn commit_run(Job *job, Error =
**errp)
>  out:
>      qemu_vfree(buf);
> =20
> -    data =3D g_malloc(sizeof(*data));
> -    data->ret =3D ret;
> -    job_defer_to_main_loop(&s->common.job, commit_complete, data);
>      return ret;
>  }
> =20
> @@ -224,6 +211,7 @@ static const BlockJobDriver commit_job_driver =3D {
>          .user_resume   =3D block_job_user_resume,
>          .drain         =3D block_job_drain,
>          .run           =3D commit_run,
> +        .exit          =3D commit_exit,
>      },
>  };
> =20
>=20

--=20
=E2=80=94js
