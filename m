Received: from eggs.gnu.org ([2001:4830:134:3::10]:60484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdgkA-00063y-LY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdgk9-00055O-FQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:18:22 -0500
References: <1487083704-51658-1-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <33339f34-9cc3-ca0c-07c1-36c18ba034d2@redhat.com>
Date: Tue, 14 Feb 2017 12:18:13 -0500
MIME-Version: 1.0
In-Reply-To: <1487083704-51658-1-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] backup: allow target without .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 02/14/2017 09:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> Currently backup to nbd target is broken, as nbd doesn't have
> .bdrv_get_info realization.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> Since commit
>=20
> commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
> Author: John Snow <jsnow@redhat.com>
> Date:   Thu Feb 25 15:58:30 2016 -0500
>=20
>     block/backup: avoid copying less than full target clusters
>=20

Tch.

> backup to nbd target is broken, we have "Couldn't determine the cluster=
 size of
> the target image".
>=20
> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve thi=
s problem.
> But until it is not realized, we need allow backup to nbd target due to=
 backward
> compatibility.
>=20
> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_ge=
t_info?
> Which behavior should be default: to fail backup or to use default clus=
ter size?
>=20
>  block/backup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index ea38733..095a390 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -638,7 +638,10 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>       * backup cluster size is smaller than the target cluster size. Ev=
en for
>       * targets with a backing file, try to avoid COW if possible. */
>      ret =3D bdrv_get_info(target, &bdi);
> -    if (ret < 0 && !target->backing) {
> +    if (ret =3D=3D -ENOTSUP) {
> +        /* Cluster size is not defined */
> +        job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;

I realize this is necessary for backwards compatibility, but perhaps we
need a warning message that explains why this backup *may* not be usable
in the incremental/top cases.

(I think none/full should be ok?)

> +    } else if (ret < 0 && !target->backing) {
>          error_setg_errno(errp, -ret,
>              "Couldn't determine the cluster size of the target image, =
"
>              "which has no backing file");
>=20

--=20
=97js
