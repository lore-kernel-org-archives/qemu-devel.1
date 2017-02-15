Received: from eggs.gnu.org ([2001:4830:134:3::10]:34053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdytt-0008Bx-UM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdytt-0002pw-3f
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:41:37 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36642 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdyts-0002pL-PE
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:41:37 -0500
References: <1487156985-18321-1-git-send-email-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <14737a38-e25f-3df1-16b6-4bbaedfeea40@virtuozzo.com>
Date: Wed, 15 Feb 2017 15:41:22 +0300
MIME-Version: 1.0
In-Reply-To: <1487156985-18321-1-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

15.02.2017 14:09, Vladimir Sementsov-Ogievskiy wrote:
> Currently backup to nbd target is broken, as nbd doesn't have
> .bdrv_get_info realization.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> v2: add WARNING
>
> =3D=3D=3D
>
> Since commit
>
> commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
> Author: John Snow <jsnow@redhat.com>
> Date:   Thu Feb 25 15:58:30 2016 -0500
>
>      block/backup: avoid copying less than full target clusters
>
> backup to nbd target is broken, we have "Couldn't determine the cluster=
 size of
> the target image".
>
> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve thi=
s problem.
> But until it is not realized, we need allow backup to nbd target due to=
 backward
> compatibility.
>
> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_ge=
t_info?
> Which behavior should be default: to fail backup or to use default clus=
ter size?
>
>   block/backup.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/block/backup.c b/block/backup.c
> index ea38733..a464b63 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -638,7 +638,15 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>        * backup cluster size is smaller than the target cluster size. E=
ven for
>        * targets with a backing file, try to avoid COW if possible. */
>       ret =3D bdrv_get_info(target, &bdi);
> -    if (ret < 0 && !target->backing) {
> +    if (ret =3D=3D -ENOTSUP) {
> +        /* Cluster size is not defined */
> +        error_report("WARNING: Target block device doesn't provide inf=
ormation "

ahah, even for such a small patches compilation should be checked.
implicit declaration of function =E2=80=98error_report'

will switch to fprintf(stderr,

> +                     "about block size and it doesn't have backing fil=
e. "
> +                     "Default block size of %u bytes is used. If actua=
l block "
> +                     "size of target exceeds this default, destination=
 image "
> +                     "may become unusable");
> +        job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
> +    } else if (ret < 0 && !target->backing) {
>           error_setg_errno(errp, -ret,
>               "Couldn't determine the cluster size of the target image,=
 "
>               "which has no backing file");


--=20
Best regards,
Vladimir
