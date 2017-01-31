Received: from eggs.gnu.org ([2001:4830:134:3::10]:50145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnr-0000P2-II
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnq-0001XA-Qe
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:55 -0500
Date: Tue, 31 Jan 2017 10:36:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131103643.GC18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 02/21] backup: init copy_bitmap from
 sync_bitmap for incremental
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


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 05:28:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> +/* init copy_bitmap from sync_bitmap */
> +static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
> +{
> +    int64_t sector;
> +    BdrvDirtyBitmapIter *dbi;
> +    uint32_t sect_gran =
> +        bdrv_dirty_bitmap_granularity(job->sync_bitmap) >> BDRV_SECTOR_BITS;
> +    int64_t sz = bdrv_dirty_bitmap_size(job->sync_bitmap);
> +    int64_t sectors_per_cluster = cluster_size_sectors(job);
> +    uint32_t cl_gran = MAX(1, sect_gran / sectors_per_cluster);
> +
> +    dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);
> +    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
> +        int64_t cluster = sector / sectors_per_cluster;
> +        int64_t next_sector = (cluster + cl_gran) * sectors_per_cluster;
> +
> +        hbitmap_set(job->copy_bitmap, cluster, cl_gran);
> +
> +        if (next_sector >= sz) {
> +            break;
> +        }
> +
> +        bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_cluster);

Simpler and clearer:
bdrv_set_dirty_iter(dbi, next_sector);

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkGi7AAoJEJykq7OBq3PIlBMH/3H3YdtdWzQniNxMCelQQ34W
7n8xFzRBr6aujbUrCDz2J9IN7P61geiOG+Bz1QP6SJXM8/xsMi7j4xsMZRTJ/GKe
t1Dl4eqBTlu0Vqnz3p+o+8Xe9dX/ah8oDoHg1wJkmErSitTPPF1jAHxaohVwNDlA
09xILZT8AvIi7DS7rJ+cqRUMGaE8Ls6EOY235+Dg7Cp1MXRTjcRogFCF8d2eGnOR
XneTP1BzArSPuylwlQS96Ww9i577irXkN97nic3Cqn3+91YFtTdLRn2amogEGPkF
92x0uwSKPBldLRW18rStocp2ueJbgjrAKesKt0dWGyPT+ATmiDBECoMbAMfkde4=
=P2So
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
