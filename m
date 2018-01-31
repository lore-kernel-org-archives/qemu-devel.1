Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egssX-0003Rk-Mr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egssW-00019A-QT
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:56:45 -0500
Date: Wed, 31 Jan 2018 13:56:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180131135628.GB23336@stefanha-x1.localdomain>
References: <20180130153835.7372-1-stefanha@redhat.com>
	<20180130165456.GD4503@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20180130165456.GD4503@localhost.localdomain>
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


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 05:54:56PM +0100, Kevin Wolf wrote:
> Am 30.01.2018 um 16:38 hat Stefan Hajnoczi geschrieben:
> > Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop threads
> > before main() quits") introduced iothread_stop_all() to avoid the
> > following virtio-scsi assertion failure:
> >=20
> >   assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx);
> >=20
> > Back then the assertion failed because when bdrv_close_all() made
> > d->conf.blk NULL, blk_get_aio_context() returned the global AioContext
> > instead of s->ctx.
> >=20
> > The same assertion can still fail today when vcpus submit new I/O
> > requests after iothread_stop_all() has moved the BDS to the global
> > AioContext.
> >=20
> > This patch hardens the iothread_stop_all() approach by pausing vcpus
> > before calling iothread_stop_all().
> >=20
> > Note that the assertion failure is a race condition.  It is not possible
> > to reproduce it reliably.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Does pausing the vcpus actually make sure that the iothread isn't active
> any more, or do we still have a small window where the vcpu is already
> stopped, but the iothread is still processing requests?
>=20
> Essentially, I think the bdrv_set_aio_context() in iothread_stop_all()
> does either not have any effect, or if it does have an effect, it's
> wrong. You can't just force an in-use BDS into a different AioContext
> when the user that set the AioContext is still there.
>=20
> At the very least, do we need a blk_drain_all() before stopping the
> iothreads?

bdrv_set_aio_context() contains aio_disable_external() +
bdrv_parent_drained_begin() + bdrv_drain(bs).  This should complete all
requests, even those sitting in a descriptor ring that hasn't been
processed yet.

> It would still just be a hack, the proper way seens to be
> getting the virtio device out of dataplane mode so that the iothread is
> actually unused and doesn't just happen to not process something at the
> moment.

Agreed, the existing approach is a hack.  I'm not keen on implementing
a proper device<->IOThread detach operation because vl.c:main() seems to
be the only place that needs it - and it can get away with just
quiescing requests and the IOThread instead.

Stefan

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaccsMAAoJEJykq7OBq3PI1B0IAKH1LzB9UhUJIYKcHaxKawqM
rZHGcG9e6nP7pvekxNMkrkauRValBxB0NRY1Zuldb4R1xe/nd4hApQT2XbemwR1o
o9KI2bmqlGznFft3Bgstt8yROLiE5bdwuGtTElu4+FlkYutnPB8mqm2enqAoeWjO
FxoehHFYHCR3L+cRO6gAClP84+kbqcXoaaI0y5XkRA11Az+x2Bg6cH1n3wIYdQB6
epyU8/ceTfa19DI49RYlCNCoUWzltGW94wUcxXseOnk10h5k3LTH7ztoBpCZgjRN
s8RCHVsw4AvJ89ywIk84GP2RuDjysXoIuJW901W6NjLKsRqk9rIPF0MQPEyO2yY=
=6EgG
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
