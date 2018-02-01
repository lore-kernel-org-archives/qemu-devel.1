Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehCip-0007sz-Kq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehCio-0007ia-K7
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:08:03 -0500
Date: Thu, 1 Feb 2018 11:07:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201110748.GC5783@stefanha-x1.localdomain>
References: <20180130153835.7372-1-stefanha@redhat.com>
	<20180130165456.GD4503@localhost.localdomain>
	<20180131135628.GB23336@stefanha-x1.localdomain>
	<20180131143127.GC3598@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20180131143127.GC3598@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vl: pause vcpus before stopping iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 03:31:27PM +0100, Kevin Wolf wrote:
> Am 31.01.2018 um 14:56 hat Stefan Hajnoczi geschrieben:
> > On Tue, Jan 30, 2018 at 05:54:56PM +0100, Kevin Wolf wrote:
> > > Am 30.01.2018 um 16:38 hat Stefan Hajnoczi geschrieben:
> > > > Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop th=
reads
> > > > before main() quits") introduced iothread_stop_all() to avoid the
> > > > following virtio-scsi assertion failure:
> > > >=20
> > > >   assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx);
> > > >=20
> > > > Back then the assertion failed because when bdrv_close_all() made
> > > > d->conf.blk NULL, blk_get_aio_context() returned the global AioCont=
ext
> > > > instead of s->ctx.
> > > >=20
> > > > The same assertion can still fail today when vcpus submit new I/O
> > > > requests after iothread_stop_all() has moved the BDS to the global
> > > > AioContext.
> > > >=20
> > > > This patch hardens the iothread_stop_all() approach by pausing vcpus
> > > > before calling iothread_stop_all().
> > > >=20
> > > > Note that the assertion failure is a race condition.  It is not pos=
sible
> > > > to reproduce it reliably.
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >=20
> > > Does pausing the vcpus actually make sure that the iothread isn't act=
ive
> > > any more, or do we still have a small window where the vcpu is already
> > > stopped, but the iothread is still processing requests?
> > >=20
> > > Essentially, I think the bdrv_set_aio_context() in iothread_stop_all()
> > > does either not have any effect, or if it does have an effect, it's
> > > wrong. You can't just force an in-use BDS into a different AioContext
> > > when the user that set the AioContext is still there.
> > >=20
> > > At the very least, do we need a blk_drain_all() before stopping the
> > > iothreads?
> >=20
> > bdrv_set_aio_context() contains aio_disable_external() +
> > bdrv_parent_drained_begin() + bdrv_drain(bs).  This should complete all
> > requests, even those sitting in a descriptor ring that hasn't been
> > processed yet.
>=20
> Ah, yes. Not very obvious, so I wouldn't mind a comment, but you can
> have my R-b either way then:
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks for the review!  I have sent v2 with a comment for you to review.

Stefan

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacvUEAAoJEJykq7OBq3PIl3cIAKvX1S96Ma4RTTxskVZ5oyf8
yOvTmAnxCfaCAy5H+IiHKh7/jJX9dMBngsZnej3AuBzfepN8DcIXOo59hJwcsB/v
OZo7tgYeGRwWt/TpPqk8H16ytxCNvyCaa16nAMUldMk+pX7NwVD6L10QcL/4iKG8
jEkI3Hs9YIg1BcV7IImaJdGOKB13HxTy7raEH1GuyhqqZkl/h1TeXSI7t9WvnkLZ
KRM+cwMJTfQWxaeusv4ACd0H+HJANxUWw+YKsvKnUGexeReqgg9wS3X5huMX3zyq
Pyz28uvhmaStvBerIUsYCDLXWc8XI5cp+cLPQ3agkQQqjuPo689QSZ/bdpF1K+w=
=ET+G
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
