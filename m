Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKTz-000540-Ft
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKTy-0002ZP-Hk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:54:11 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-33-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
Date: Mon, 14 May 2018 22:53:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-33-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HkDK0ZUhu9KFn7qdEXMCbM0F8bKEtBkph"
Subject: Re: [Qemu-devel] [PATCH 32/42] job: Move completion and
 cancellation to Job
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
--HkDK0ZUhu9KFn7qdEXMCbM0F8bKEtBkph
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
Subject: Re: [PATCH 32/42] job: Move completion and cancellation to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-33-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-33-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the top-level job completion and cancellation functions from=

> BlockJob to Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     | 55 -------------------------------
>  include/block/blockjob_int.h | 18 ----------
>  include/qemu/job.h           | 58 ++++++++++++++++++++++++++++----
>  block.c                      |  2 +-
>  block/backup.c               |  3 +-
>  block/commit.c               |  8 ++---
>  block/mirror.c               |  6 ++--
>  block/replication.c          |  4 +--
>  block/stream.c               |  2 +-
>  blockdev.c                   |  8 ++---
>  blockjob.c                   | 76 ------------------------------------=
------
>  job.c                        | 78 ++++++++++++++++++++++++++++++++++++=
+++++---
>  qemu-img.c                   |  2 +-
>  tests/test-bdrv-drain.c      |  5 ++-
>  tests/test-blockjob-txn.c    | 14 ++++----
>  tests/test-blockjob.c        | 21 ++++++------
>  block/trace-events           |  3 --
>  trace-events                 |  1 +
>  18 files changed, 162 insertions(+), 202 deletions(-)

After this patch, there are a couple of places left that mention
block_job_enter(), those should be fixed.  Well, and those two
block_job_completed() mentions.

[...]

> diff --git a/block.c b/block.c
> index 676e57f562..7a149bfea9 100644
> --- a/block.c
> +++ b/block.c
> @@ -3362,7 +3362,7 @@ static void bdrv_close(BlockDriverState *bs)
> =20
>  void bdrv_close_all(void)
>  {
> -    block_job_cancel_sync_all();
> +    job_cancel_sync_all();

Do we really want to cancel jobs that might have nothing to do with the
block layer?

>      nbd_export_close_all();
> =20
>      /* Drop references from requests still in flight, such as canceled=
 block

[...]

> diff --git a/block/commit.c b/block/commit.c
> index 02a8af9127..56c3810bad 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -112,12 +112,12 @@ static void commit_complete(Job *job, void *opaqu=
e)
>      blk_unref(s->top);
> =20
>      /* If there is more than one reference to the job (e.g. if called =
from
> -     * block_job_finish_sync()), block_job_completed() won't free it a=
nd
> -     * therefore the blockers on the intermediate nodes remain. This w=
ould
> -     * cause bdrv_set_backing_hd() to fail. */
> +     * block_job_finish_sync()), job_completed() won't free it and the=
refore

Nice start, but there is more to do in this line. :-)

(Though probably in some other patch.)

Max

> +     * the blockers on the intermediate nodes remain. This would cause=

> +     * bdrv_set_backing_hd() to fail. */
>      block_job_remove_all_bdrv(bjob);
> =20
> -    block_job_completed(&s->common, ret);
> +    job_completed(job, ret);
>      g_free(data);
> =20
>      /* If bdrv_drop_intermediate() didn't already do that, remove the =
commit


--HkDK0ZUhu9KFn7qdEXMCbM0F8bKEtBkph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr592YACgkQ9AfbAGHV
z0CyowgAv0q835OBLqAxoENSxMCWe+Jl8QRE7HF//zc+L3qMNTYOk+14G+n+C4WQ
QyuX8jCvuMahzIGmTPq1WridiOv8kJZy8e94Y8jVAfap806LyzXe2MtrPU8DR/jw
73qRkvkqVXgUyAXkPMvgg/cGhT8OBwcS0YV8hjZQ6iu5YTdYs3WF4zZ/tmIyO712
ynOIKVRsdVEYF4A5qo9xsATaeArOEEmqRmKMIhcItf0yXUG3+s2z7Mad3etWvlXL
Dp780XeZum64GG8HBQ23OaPMuVfpTfa8f5iQKLIi32fggWdVYzrj60fhDVQNlUkw
niAp6UHjUsFidHmQxTJFc02Pgblu6A==
=MaGX
-----END PGP SIGNATURE-----

--HkDK0ZUhu9KFn7qdEXMCbM0F8bKEtBkph--
