Received: from eggs.gnu.org ([2001:4830:134:3::10]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnx-0000U4-Aw
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnw-0001YN-7Y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:01 -0500
Date: Tue, 31 Jan 2017 10:56:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131105646.GD18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-4-git-send-email-vsementsov@virtuozzo.com>
	<20170124071726.GC27126@lemon.Home>
	<c7ab4cec-2d0d-8a49-7fc3-fe617d5f61fd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <c7ab4cec-2d0d-8a49-7fc3-fe617d5f61fd@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 03/21] backup: improve non-dirty bits
 progress processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 12:12:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 24.01.2017 10:17, Fam Zheng wrote:
> > On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
> > > Set fake progress for non-dirty clusters in copy_bitmap initializatio=
n,
> > > to:
> > > 1. set progress in the same place where corresponding clusters are
> > > consumed from copy_bitmap (or not initialized, as here)
> > > 2. earlier progress information for user
> > > 3. simplify the code
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > >   block/backup.c | 18 +++---------------
> > >   1 file changed, 3 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/block/backup.c b/block/backup.c
> > > index 621b1c0..f1f87f6 100644
> > > --- a/block/backup.c
> > > +++ b/block/backup.c
> > > @@ -383,7 +383,6 @@ static int coroutine_fn backup_run_incremental(Ba=
ckupBlockJob *job)
> > >       int64_t sector;
> > >       int64_t cluster;
> > >       int64_t end;
> > > -    int64_t last_cluster =3D -1;
> > >       int64_t sectors_per_cluster =3D cluster_size_sectors(job);
> > >       BdrvDirtyBitmapIter *dbi;
> > > @@ -395,12 +394,6 @@ static int coroutine_fn backup_run_incremental(B=
ackupBlockJob *job)
> > >       while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
> > >           cluster =3D sector / sectors_per_cluster;
> > > -        /* Fake progress updates for any clusters we skipped */
> > > -        if (cluster !=3D last_cluster + 1) {
> > > -            job->common.offset +=3D ((cluster - last_cluster - 1) *
> > > -                                   job->cluster_size);
> > > -        }
> > > -
> > >           for (end =3D cluster + clusters_per_iter; cluster < end; cl=
uster++) {
> > >               do {
> > >                   if (yield_and_check(job)) {
> > > @@ -422,14 +415,6 @@ static int coroutine_fn backup_run_incremental(B=
ackupBlockJob *job)
> > >           if (granularity < job->cluster_size) {
> > >               bdrv_set_dirty_iter(dbi, cluster * sectors_per_cluster);
> > >           }
> > > -
> > > -        last_cluster =3D cluster - 1;
> > > -    }
> > > -
> > > -    /* Play some final catchup with the progress meter */
> > > -    end =3D DIV_ROUND_UP(job->common.len, job->cluster_size);
> > > -    if (last_cluster + 1 < end) {
> > > -        job->common.offset +=3D ((end - last_cluster - 1) * job->clu=
ster_size);
> > >       }
> > >   out:
> > > @@ -462,6 +447,9 @@ static void backup_incremental_init_copy_bitmap(B=
ackupBlockJob *job)
> > >           bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_=
cluster);
> > >       }
> > > +    job->common.offset =3D job->common.len -
> > > +                         hbitmap_count(job->copy_bitmap) * job->clus=
ter_size;
> > > +
> > >       bdrv_dirty_iter_free(dbi);
> > >   }
> > Is this effectively moving the progress reporting from cluster copying =
to dirty
> > bitmap initialization? If so the progress will stay "100%" once
> > backup_incremental_init_copy_bitmap returns, but the backup has merely =
started.
> > I don't think this is a good idea.
> >=20
> > Fam
>=20
> Currently progress tracking for incremental backup is bad too. Holes are =
bad
> for progress in any way. To make good progress we should calculate it like
> (cluters _physically_ copied) / (full amount of clusters to be _physicall=
y_
> copied). And with current qapi scheme it is not possible. This formula may
> be approximated by (offset - skipped_clusters) / (len - skipped_clusters),
> where offset and len are old good len, and skipped_clusters should be add=
ed
> to query_block_jobs. And with such approximation it is obvious that it wi=
ll
> be more presize if we skip all clusters that should be skipped earlier. T=
he
> best way of course is to skip them in initialization. It is not possible =
(if
> I understand things right) for full mode, as it skips clusters using
> get_block_status which may be long operation, so we should start notifier
> handling before skipping operation is finished...
>=20
> Any way, it is work of management tool to show beautiful progress, qemu o=
nly
> provides information for it, and with current scheme, the only way to
> provide information about cluster skipping in copying progress is by offs=
et
> field. And it is not bad to provide this information earlier. And again, =
to
> produce really beautiful progress we at least need one more field -
> skipped_clusters.

If you want to change the semantics of the progress indicator, please
send it as a separate series.

I'm not convinced by this patch but it shouldn't block the rest of
the series from being merged.

Stefan

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkG1uAAoJEJykq7OBq3PIA3wH/3U3Z/1fKKc0i7o8Yp1Ko88p
I6sKs4N2TnAiLw2SPvDsGEl7E5Lgd+N1TfFe46YJuWiUvUBrv8mjBbWSmtPJSazp
zznsxpqLGAaFXkvITnynzS2q2/erkLa6L/v3PsL1pEiqSxSqwGYzCoN/mWNVF/CB
fIKFQXWp6fl8eW0iXRPWDoPgbGl5GJjUAxUf2CLlnr97FPXerTNefRZGM6RwVxmT
62KtzxHXZMMsUi8hsPQXZnQ4CMfNIwkE4xlyS+oGZCBWXnRn+X+27u28jvMXQu6T
CP5OimrjhOnd17an/2cCqgSOadUTvKoRPsJMHX0iyfTgu7scHrVuanLEnY7DWEM=
=BO58
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
