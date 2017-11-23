Received: from eggs.gnu.org ([2001:4830:134:3::10]:32996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHofQ-0005wj-EY
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHofP-0001HJ-FH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:23:36 -0500
Date: Thu, 23 Nov 2017 10:23:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171123102325.GA26022@stefanha-x1.localdomain>
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
	<20171122170607.GA8217@stefanha-x1.localdomain>
	<20171122180426.GC10954@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20171122180426.GC10954@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Deepa Srinivasan <deepa.srinivasan@oracle.com>, mreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 07:04:26PM +0100, Kevin Wolf wrote:
> Am 22.11.2017 um 18:06 hat Stefan Hajnoczi geschrieben:
> > On Wed, Nov 22, 2017 at 07:33:28AM -0800, Deepa Srinivasan wrote:
> > > Starting qemu with the following arguments causes qemu to segfault:
> > > ... -device lsi,id=3Dlsi0 -drive file=3Discsi:<...>,format=3Draw,if=
=3Dnone,node-name=3D
> > > iscsi1 -device scsi-block,bus=3Dlsi0.0,id=3D<...>,drive=3Discsi1
> > >=20
> > > This patch fixes blk_aio_ioctl() so it does not pass stack addresses =
to
> > > blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() retu=
rns. More
> > > details about the bug follow.
> > >=20
> > > blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
> > > coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
> > >=20
> > > When blk_aio_ioctl() is executed from within a coroutine context (e.g.
> > > iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entr=
y) to
> > > the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
> > >=20
> > > When blk_aio_ioctl_entry() executes later, it accesses an invalid poi=
nter:
> > > ....
> > >     BlkRwCo *rwco =3D &acb->rwco;
> > >=20
> > >     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
> > >                              rwco->qiov->iov[0].iov_base);  <--- qiov=
 is
> > >                                                                  inva=
lid here
> > > ...
> > >=20
> > > In the case when blk_aio_ioctl() is called from a non-coroutine conte=
xt,
> > > blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() ca=
lls
> > > qemu_coroutine_yield(), blk_aio_ioctl() will return. When the corouti=
ne
> > > execution is complete, control returns to blk_aio_ioctl_entry() after=
 the call
> > > to blk_co_ioctl(). There is no invalid reference after this point, bu=
t the
> > > function is still holding on to invalid pointers.
> > >=20
> > > The fix is to allocate memory for the QEMUIOVector and struct iovec a=
s part of
> > > the request struct which the IO buffer is part of. The memory for thi=
s struct is
> > > guaranteed to be valid till the AIO is completed.
> >=20
> > Thanks for the patch!
> >=20
> > AIO APIs currently don't require the caller to match qiov's lifetime to
> > the I/O request lifetime.  This patch changes that for blk_aio_ioctl()
> > only.  If we want to do this consistently then all aio callers need to
> > be audited and fixed.
> >=20
> > The alternative is to make the API copy qiov when necessary.  That is
> > less efficient but avoids modifying all callers.
> >=20
> > Either way, the lifetime of qiov must be consistent across all aio APIs,
> > not just blk_aio_ioctl().
>=20
> Don't all blk_aio_*() APIs that take a qiov pointer require that it
> remains valid until the request completes? I don't think they are copied
> anywhere for blk_aio_preadv/pwritev() before being passed to the block
> driver.
>=20
> So this does look consistent with the existing functions to me.

You are right.  I audited the blk_aio_preadv() callers and they all keep
qiov around until the request is complete.

Actually this makes sense because even in the simple non-coroutine case
with aio=3Dthreads the qiov hasn't necessarily been read yet when the
function returns.  The aio_worker() function executes later and only
then is qiov handed to the host kernel.

So this is a one-off bug in blk_aio_ioctl() callers.

Stefan

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFqGdAAoJEJykq7OBq3PIxY8IAJ1LeY8/DQD9cyaIrr/GonbE
kwJAxPvsCGELT4vspCSefjlMFqGhPHhBxfA5hO8VK/24KlWOZ+vebY2j19CPjLGl
vE2+ucWTtO0jPXZ1VKgYPl3YzSGfzxQdQOKwKwSiaiW+158rzrJvF7j82KpjMYsw
CCgbYKUtH4jGtZxSCoPuVNG3Azjr4KO/KjbJhmiMRXA227QmT4/1iB3VDz7+Zdne
ZbgZ9B/Xnj6U0KitIiVCidwad3bt81Vy6CNB1lDS0HbAxLqfr3HdmtB9h/+RKz/7
qv29SGIadXmjdc78noj6836SjM/b6EnFlkY+08Inb276lDuRVQUxq54pp8P5ePI=
=A0jf
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
