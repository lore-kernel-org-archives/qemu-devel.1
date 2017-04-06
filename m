Received: from eggs.gnu.org ([2001:4830:134:3::10]:45391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw5VK-0000rY-Gz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw5VJ-0004nW-Bk
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:23:06 -0400
Date: Thu, 6 Apr 2017 13:22:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406112256.GF4341@noname.redhat.com>
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
	<d74fad45-9f89-6f34-020f-87e6b20ea59b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <d74fad45-9f89-6f34-020f-87e6b20ea59b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com, Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com, qemu-devel@nongnu.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.04.2017 um 15:22 hat Max Reitz geschrieben:
> On 04.04.2017 17:35, Kevin Wolf wrote:
> > Usually guest devices don't like other writers to the same image, so
> > they use blk_set_perm() to prevent this from happening. In the migration
> > phase before the VM is actually running, though, they don't have a
> > problem with writes to the image. On the other hand, storage migration
> > needs to be able to write to the image in this phase, so the restrictive
> > blk_set_perm() call of qdev devices breaks it.
> >=20
> > This patch flags all BlockBackends with a qdev device as
> > blk->disable_perm during incoming migration, which means that the
> > requested permissions are stored in the BlockBackend, but not actually
> > applied to its root node yet.
> >=20
> > Once migration has finished and the VM should be resumed, the
> > permissions are applied. If they cannot be applied (e.g. because the NBD
> > server used for block migration hasn't been shut down), resuming the VM
> > fails.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/block-backend.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >  include/block/block.h |  2 ++
> >  migration/migration.c |  8 ++++++++
> >  qmp.c                 |  6 ++++++
> >  4 files changed, 55 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index 0b63773..f817040 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
>=20
> [...]
>=20
> > @@ -597,15 +598,52 @@ void blk_get_perm(BlockBackend *blk, uint64_t *pe=
rm, uint64_t *shared_perm)
> >      *shared_perm =3D blk->shared_perm;
> >  }
> > =20
> > +/*
> > + * Notifies the user of all BlockBackends that migration has completed=
=2E qdev
> > + * devices can tighten their permissions in response (specifically rev=
oke
> > + * shared write permissions that we needed for storage migration).
> > + *
> > + * If an error is returned, the VM cannot be allowed to be resumed.
> > + */
> > +void blk_resume_after_migration(Error **errp)
> > +{
> > +    BlockBackend *blk;
> > +    Error *local_err =3D NULL;
> > +
> > +    for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {
>=20
> Shouldn't we use blk_all_next()?

Good catch, thanks.

At first I added it into the loop in qmp_cont() and then copied it here
without noticing the resetting the iostatus is really only needed for
monitor-owned BBs at the moment, but this one is different.

Of course, as soon as we improve query-block to work reasonably well
with -device drive=3D<node-name>, qmp_cont() needs to use blk_all_next(),
too.

> Trusting you that silently disabling autostart is something the upper
> layers can deal with, the rest looks good to me.
>=20
> (The only other runtime changes of autostart apart from stop/cont appear
> to be in blockdev_init() (if (bdrv_key_required()), but I don't think
> that can happen anymore) and in migration/colo.c (which enables it and
> emits an error message).)

I think in practice libvirt always sets -S on the destination anyway.

Kevin

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY5iUQAAoJEH8JsnLIjy/WgC0P/RkED5mLmESbceywnfDnqf1x
Js7Bhotm65msEnGRy8hi/Q4MD1BaywKQqjPSqWptplRIJv3xTFTKMydydGZNCHIr
AxyW/z0cxoBmnTPYoPkHPb0/NyzDf3UhWA9+bc2N4C/P1QFTA9PoAgCQQtuU7vKl
4J9NzcrOYC4yzhx/CMVkGtTCyAtXI9HZikxT6TSRYdfPG1NYHkvBkMvfc418ENdc
MM4rNW7/bQ8GbSbXijKtUjvzEKzxInleeAQUJ/+D+CZgsCuxkrk7ZJUU5VF1xQlI
SvaGTrFUTIb9UOoGgcz/0qs5mC7Gq7u1HtoClMocQ0dgY3SmlsMs16p0AiAJyjh1
qrGVo5QGdpwGJDaOwHrYguvQHUWThaTqhGpbHHQDi73Z0b30iTPrquL+3NV7pc9P
nqhb68xNQqx8F/M2T1w+aXI8PNiWVOmQelS3ZamwrOoFueos+Vs6cqPFUGhQKYui
x2EYKKFkArrChjN72ZHzRzQrYLuNWyatxxU62bRxufVQ84WYFs5Fw5z1/8qaqc2U
Ez4SnJ8QF18vBFin7VmqZ8vHFc4HYj93J8QlYWsnWMFkaGbVCNpS/6JUI39/+wX+
VZdYaTMcWF3NQHarr8zqFuN+Zb1Nrlef5AkGTbEj7V8QW0/mf5bP5J5NyPimcQf+
09mmNdJ2EkaiWrISw8O8
=FHzh
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
