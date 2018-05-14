Received: from eggs.gnu.org ([2001:4830:134:3::10]:35025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIAX5-0004xX-BB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIAX3-0003WW-SK
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:16:42 -0400
Date: Mon, 14 May 2018 12:16:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180514101636.GB6665@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-3-kwolf@redhat.com>
	<aa12ad3e-c335-2e8a-e9ac-d55ba0fb91d5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <aa12ad3e-c335-2e8a-e9ac-d55ba0fb91d5@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.05.2018 um 00:12 hat Max Reitz geschrieben:
> On 2018-05-09 18:25, Kevin Wolf wrote:
> > Block job drivers are not expected to mess with the internals of the
> > BlockJob object, so provide wrapper functions for one of the cases where
> > they still do it: Updating the progress counter.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  include/block/blockjob.h | 19 +++++++++++++++++++
> >  block/backup.c           | 22 +++++++++++++---------
> >  block/commit.c           | 16 ++++++++--------
> >  block/mirror.c           | 11 +++++------
> >  block/stream.c           | 14 ++++++++------
> >  blockjob.c               | 10 ++++++++++
> >  6 files changed, 63 insertions(+), 29 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/block/backup.c b/block/backup.c
> > index 453cd62c24..5d95805472 100644
> > --- a/block/backup.c
> > +++ b/block/backup.c
> >
>=20
> [...]
>=20
> > @@ -420,8 +421,9 @@ static void backup_incremental_init_copy_bitmap(Bac=
kupBlockJob *job)
> >          bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
> >      }
> > =20
> > -    job->common.offset =3D job->common.len -
> > -                         hbitmap_count(job->copy_bitmap) * job->cluste=
r_size;
> > +    /* TODO block_job_progress_set_remaining() would make more sense */
>=20
> Extremely true, especially considering that at least there was an
> assignment before.
>=20
> > +    block_job_progress_update(&job->common,
> > +        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size=
);
>=20
> Now, with an incremental update, you have to know that the progress was
> 0 before this call to make any sense of it.
>=20
> I could ask: Why don't you just resolve the TODO immediately with
>=20
>     block_job_progress_set_remaining(&job->common,
>         hbitmap_count(job->copy_bitmap) * job->cluster_size);
>=20
> ?
>=20
> I suppose one possible answer is that this series has 42 patches as it
> is, but I have to say that it took me more time to figure this hunk out
> than it would have taken me to acknowledge the above change.
>=20
> Considering that job->len and job->common.len are now separate after
> this patch, and that there is only a single other
> block_job_progress_update() call in this file, I can't see any side effec=
ts.

Basically just because I tried to make the naive change whenever I had
to touch something that isn't what the patch changes as its main
purpose. The old code changed offset rather than len, so I used the
function that does the same.

If I reduced len instead of increasing offset, I suppose that at least a
few test cases would have to be updated etc. and who knows what else
(QMP clients shouldn't rely on the current way, but do they?).

I'd rather not make such a change as a side effect of a patch that tries
to do something quite different.

> > =20
> >      bdrv_dirty_iter_free(dbi);
> >  }
>=20
> [...]
>=20
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 99da9c0858..77ee9b1791 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
>=20
> [...]
>=20
> > @@ -792,11 +792,10 @@ static void coroutine_fn mirror_run(void *opaque)
> >          block_job_pause_point(&s->common);
> > =20
> >          cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
> > -        /* s->common.offset contains the number of bytes already proce=
ssed so
> > -         * far, cnt is the number of dirty bytes remaining and
> > -         * s->bytes_in_flight is the number of bytes currently being
> > -         * processed; together those are the current total operation l=
ength */
> > -        s->common.len =3D s->common.offset + s->bytes_in_flight + cnt;
> > +        /* cnt is the number of dirty bytes remaining and s->bytes_in_=
flight is
> > +         * the number of bytes currently being processed; together tho=
se are
> > +         * the current total operation length */
>=20
> No, together, those are the current remaining operation length.

Thanks, will fix.

Kevin

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+WIEAAoJEH8JsnLIjy/WaJMP/icf98Iq/dS/s8gyKVL4FA5t
wzrGajBFoHD+dRh35utyXiUSfHa6vC3uTyASafcwufb8sHncjjuRm5XhVGyEmTEW
+DBct+9F8/FqW5TM8K2xANii1n4UBBY8k4q5tT1/ysPSfMGW+I+DLgeg6whQ+H4d
t0nWestvS2fGvje/d2pLmRKfZmAKPw5Xjp9piSvu+jDoi5BPA6wAu8mP9JSUmUNm
GDtrjit8aWrJBJi2wk6g/6HMyfED58BLxkXViIrcveMB2nZyURZdbwteo3e70YOY
R/KqqvHmZ1FBdponssFZrWlIy1ZwrUNB2lAVYDk95ARWuNQjs4l/PyrTg+d7bNeZ
6vgZ4xXnVdvznfCHoNiFIo1RMllHaSmejfDqtbdD4tA3jrmWcfM0Ai0Rq78aYd6a
nuMHzeXid9g3vJ6O5///hAHzjIzLAgdMkG3VR8P8hkue2vbVbJIUGFsWSqIyPNhl
gXgVW0pz04jfj2S4rfuJ/qHzCXn3DJIOtz57ZxrZsl02Z8HkL3ZlP6DJuAANxvMu
yeNWuSiawMj9cHPbVlK5HWCPleeQwknnYLyTrRpO65RL6QKHS80uFdzHcFr8W1uT
llfuzzlRQi/LyKuc944AxbYPZwdHIMo/jZQ7Xy6uyJ9DQGOY1WfMjro6ccrrsKDn
n+jLjntFHgEfNlzzDAbM
=htVB
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
