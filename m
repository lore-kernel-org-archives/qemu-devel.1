Received: from eggs.gnu.org ([2001:4830:134:3::10]:47394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZUo-0007tb-Nl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZUn-0004Rd-UQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:33:22 -0500
Date: Tue, 31 Jan 2017 14:33:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131143312.GM18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters
 for full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:51PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> In case of full backup we can skip unallocated clusters if the target
> disk is already zero-initialized.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c         | 8 ++++++--
>  tests/qemu-iotests/055 | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 2afd1b6..4ef8daf 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -562,9 +562,13 @@ static void coroutine_fn backup_run(void *opaque)
>          if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>              backup_incremental_init_copy_bitmap(job);
>          } else {
> +            /* top or full mode */
> +            bool is_top =3D job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP;
> +            BlockDriverState *base =3D
> +                    is_top ? backing_bs(blk_bs(job->common.blk)) : NULL;
>              hbitmap_set(job->copy_bitmap, 0, end);
> -            if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
> -                backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)=
));
> +            if (is_top || bdrv_has_zero_init(blk_bs(job->target))) {
> +                backup_skip_loop(job, base);
>              }

An alternative that I find easier to read:

hbitmap_set(job->copy_bitmap, 0, end);
if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
    backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)));
} else if (bdrv_has_zero_init(blk_bs(job->target))) {
    backup_skip_loop(job, NULL);
}

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKAoAAoJEJykq7OBq3PIhx0H/ia9w+mANNDIOCp52zUNIlO5
SD+vo3iCtIR/hJ4JORkoIfnKLyk/3yzJVA7x83yzln0oybpt7BRTYvO/zKYUT82+
v2KfdZ/6sCwYR6a13SjVT/iGSQ03H9pfrAcc1xvV3lLcbBomZkqllhCEl/gEieiE
NN6PC7Chads83caNrdRZWPRVzcGaZNW2RTRSgvuPiIG0Q+oIMlGMENEJIxBmxXb6
RkZSE6wOIsn90QOOpbb2DaFL/pRbDTkExdIrB7udMQnzu4jV9gDbFKSEg8NlLx5Y
htqeDbeFsTifHt0mXSY8M+Lt+4TJ10PCjZmzyHKGV5zhmZvRefmtSYl7dRQ88ww=
=2eX6
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
