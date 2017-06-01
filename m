Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGQ7P-0003P0-7D
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGQ7O-0008Si-9u
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:26:27 -0400
Date: Thu, 1 Jun 2017 14:26:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170601132616.GB23154@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-7-famz@redhat.com>
	<20170511194100.GI24584@stefanha-x1.localdomain>
	<20170524021844.GG12279@lemon.lan>
	<20170531093921.GA15666@stefanha-x1.localdomain>
	<20170531095746.GC6170@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20170531095746.GC6170@lemon.lan>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 06/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 05:57:46PM +0800, Fam Zheng wrote:
> On Wed, 05/31 10:39, Stefan Hajnoczi wrote:
> > On Wed, May 24, 2017 at 10:18:44AM +0800, Fam Zheng wrote:
> > > On Thu, 05/11 15:41, Stefan Hajnoczi wrote:
> > > > On Wed, Apr 19, 2017 at 05:43:46PM +0800, Fam Zheng wrote:
> > > > > What's done in the source's context change notifier is moving the
> > > > > target's context to follow the new one, so we request this permis=
sion
> > > > > here.
> > > >=20
> > > > It's true that the backup block job must be able to set target's
> > > > AioContext, but does this change also allow other users to set targ=
et's
> > > > AioContext while the backup job is running?  If yes, then we need to
> > > > handle that.
> > >=20
> > > If through job->target, yes, but I don't think there is any user of j=
ob->target.
> > > Otherwise, it's not allowed, because the second parameter of blk_new =
doesn't
> > > have BLK_PERM_AIO_CONTEXT_CHANGE.
> > >=20
> > > So it's okay.
> >=20
> > What about blockdev-backup?  It allows the user to specify 'target'.
> > Therefore the user can also run other monitor commands on target.  Some
> > of them could change the AioContext and the backup job wouldn't know!
>=20
> That will be rejected.
>=20
> The contract is that any code that wants to change the AioContext of a BD=
S, in
> this case the "target BDS", must do this:
>=20
> 1) create its own BB with perm.BLK_PERM_AIO_CONTEXT_CHANGE
>=20
> 2) attach BDS to this BB
>=20
> 3) call blk_set_aio_context and change the AioContext
>=20
> This is basically how all users of a BDS coordinate through Kevin's new op
> blocker API, and in your concerned case, when a user runs a second monitor
> command that changes AioContext, step 2 will fail, because as in this pat=
ch, the
> first job->target BB didn't set shared_perm.BLK_PERM_AIO_CONTEXT_CHANGE.

I was wondering how that works since do_blockdev_backup() does not use
BB to access target, but it does check whether a BB is already attached:

    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
    if (!target_bs) {
        goto out;
    }

    if (bdrv_get_aio_context(target_bs) !=3D aio_context) {
        if (!bdrv_has_blk(target_bs)) {   <----- fails when job is running
            /* The target BDS is not attached, we can safely move it to ano=
ther
             * AioContext. */
            bdrv_set_aio_context(target_bs, aio_context);
        } else {
            error_setg(errp, "Target is attached to a different thread from=
 "
                             "source.");
            goto out;
        }
    }

Thanks!

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZMBX4AAoJEJykq7OBq3PIg9sH/jGHmLT8b5Zzm0ChtOF8pWQ0
HNPDeG/+I1NhZVJGyLjOvrwgh80DE+pjeMe4siRAkuz5VwMdBaMSaVsJSkmwZsFd
aU+qE6SAUgRzarPLK70E7eboxd5G7/bURl3o09Ckv8TRsjWVsF2OrPhPdp+Bv90l
AUgvsdsunE8KFx8Ps9XHnI1zc5ThlZ4xulWE14HgOpGmWIBVZ75BHPD85d+9oQKl
hUUHw8SDxcP4nyzx2HgD1lY30yv7Jy0+p9QSIMqvjt9Q0dLCO9iOqEhPreWRV9V2
Hv2QP/MegdbEz53vLI7rWfpMhUhNNcZM/04DZ+GThNJYFHfGon13ZLcMS79oecI=
=qWBM
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
