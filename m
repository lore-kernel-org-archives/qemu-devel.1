Received: from eggs.gnu.org ([2001:4830:134:3::10]:46519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egtRQ-000322-1D
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egtRM-00020m-2v
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:32:48 -0500
Date: Wed, 31 Jan 2018 15:31:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180131143127.GC3598@localhost.localdomain>
References: <20180130153835.7372-1-stefanha@redhat.com>
	<20180130165456.GD4503@localhost.localdomain>
	<20180131135628.GB23336@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20180131135628.GB23336@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vl: pause vcpus before stopping iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.01.2018 um 14:56 hat Stefan Hajnoczi geschrieben:
> On Tue, Jan 30, 2018 at 05:54:56PM +0100, Kevin Wolf wrote:
> > Am 30.01.2018 um 16:38 hat Stefan Hajnoczi geschrieben:
> > > Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop thre=
ads
> > > before main() quits") introduced iothread_stop_all() to avoid the
> > > following virtio-scsi assertion failure:
> > >=20
> > >   assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx);
> > >=20
> > > Back then the assertion failed because when bdrv_close_all() made
> > > d->conf.blk NULL, blk_get_aio_context() returned the global AioContext
> > > instead of s->ctx.
> > >=20
> > > The same assertion can still fail today when vcpus submit new I/O
> > > requests after iothread_stop_all() has moved the BDS to the global
> > > AioContext.
> > >=20
> > > This patch hardens the iothread_stop_all() approach by pausing vcpus
> > > before calling iothread_stop_all().
> > >=20
> > > Note that the assertion failure is a race condition.  It is not possi=
ble
> > > to reproduce it reliably.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Does pausing the vcpus actually make sure that the iothread isn't active
> > any more, or do we still have a small window where the vcpu is already
> > stopped, but the iothread is still processing requests?
> >=20
> > Essentially, I think the bdrv_set_aio_context() in iothread_stop_all()
> > does either not have any effect, or if it does have an effect, it's
> > wrong. You can't just force an in-use BDS into a different AioContext
> > when the user that set the AioContext is still there.
> >=20
> > At the very least, do we need a blk_drain_all() before stopping the
> > iothreads?
>=20
> bdrv_set_aio_context() contains aio_disable_external() +
> bdrv_parent_drained_begin() + bdrv_drain(bs).  This should complete all
> requests, even those sitting in a descriptor ring that hasn't been
> processed yet.

Ah, yes. Not very obvious, so I wouldn't mind a comment, but you can
have my R-b either way then:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

> > It would still just be a hack, the proper way seens to be
> > getting the virtio device out of dataplane mode so that the iothread is
> > actually unused and doesn't just happen to not process something at the
> > moment.
>=20
> Agreed, the existing approach is a hack.  I'm not keen on implementing
> a proper device<->IOThread detach operation because vl.c:main() seems to
> be the only place that needs it - and it can get away with just
> quiescing requests and the IOThread instead.

As long as we don't want to switch devices between iothreads at runtime
(and create/delete iothreads over QMP), we probably won't really need
it, yes.

Kevin

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJacdM+AAoJEH8JsnLIjy/WMzkP/2xbybgt7GN5feQSLh7SfOay
gUmpc1BBixdnKeWZN1QUnhPqabKusGeNgfBHqY0P3THFcNlFi1e2bNm93n/xzZYv
xImyrgv9CLmH57HDisgKErC9s0j6X2qS2jd4xqejoH6HJaQjRxrOuybBYiJit8A6
2SASMsBOeaLPyQAElJ/D1ZqWJFersw7+j6vYaOsMNmClBRDc3UMKQ/oLTOPzSPvT
NWErWR2UMoLWDjlkz3xtEG4n+a6fV8cKaUfpYOM+HAmRBdSV65ww8lQgATBOwoed
yCw7beoSrFtNBey+0ofYmLIueQ6+s/3UZK8As6g1JWFDWSM96rQLORvxEmYYXl1J
8LG3FoM0i+7uHUOnyH+6wmyqV04JXzF0RKWryRyw3TMpWck4Px4MhDKcSF6Lk1Ex
vd3A8xk857SRs+oi8zUX8A9RLjil2BZ/drSsvzEU/W++WBcBZv4oj7YAIW0kXlup
Z9XJYpuYiQD5+N2bWY9r9853kC1pM3g9cF5fQMXxWB8n4mbMLnAIKVAY+yb6H2IL
WvESX+qPLuJFushkiGtZHvbaHszwfgkr1qnBF872g5alt/gGBiPG9CWWVkNJNGUY
yuObKRdhvTWCuMg213Zn9xrW267MxPAwzZWgqHuSUeG8w9DsTJglPS1vrJsNDhuE
DwBa0HSASKYGEFT9J/ag
=sZbk
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
