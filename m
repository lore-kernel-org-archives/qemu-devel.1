Received: from eggs.gnu.org ([2001:4830:134:3::10]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cznk0-0008N8-2S
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 13:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cznjz-00074j-2P
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 13:13:36 -0400
Date: Sun, 16 Apr 2017 10:37:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170416093743.GA24137@stefanha-x1.localdomain>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
	<80449391-88a6-d517-0682-de555fe4c169@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <80449391-88a6-d517-0682-de555fe4c169@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9-rc5 v2] block: Drain
 BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 15, 2017 at 01:10:02AM +0800, Paolo Bonzini wrote:
>=20
>=20
> On 14/04/2017 16:51, Stefan Hajnoczi wrote:
> > On Fri, Apr 14, 2017 at 9:02 AM, Fam Zheng <famz@redhat.com> wrote:
> >> @@ -398,11 +399,15 @@ void bdrv_drain_all(void);
> >>           */                                                \
> >>          assert(!bs_->wakeup);                              \
> >>          bs_->wakeup =3D true;                                \
> >> -        while ((cond)) {                                   \
> >> -            aio_context_release(ctx_);                     \
> >> -            aio_poll(qemu_get_aio_context(), true);        \
> >> -            aio_context_acquire(ctx_);                     \
> >> -            waited_ =3D true;                                \
> >> +        while (busy_) {                                    \
> >> +            if ((cond)) {                                  \
> >> +                waited_ =3D busy_ =3D true;                    \
> >> +                aio_context_release(ctx_);                 \
> >> +                aio_poll(qemu_get_aio_context(), true);    \
> >> +                aio_context_acquire(ctx_);                 \
> >> +            } else {                                       \
> >> +                busy_ =3D aio_poll(ctx_, false);             \
> >> +            }                                              \
> >=20
> > Wait, I'm confused.  The current thread is not in the BDS AioContext.
> > We're not allowed to call aio_poll(ctx_, false).
>=20
> It's pretty ugly indeed.  Strictly from a thread-safety point of view,
> everything that aio_poll calls will acquire the AioContext, so that is
> safe and in fact the release/acquire pair can beeven  hoisted outside
> the "if".
>=20
> If we did that for blocking=3Dtrue in both I/O and main thread, then that
> would be racy.  This is the scenario mentioned in the commit message for
> c9d1a56, "block: only call aio_poll on the current thread's AioContext",
> 2016-10-28).
>=20
> If only one thread has blocking=3Dtrue, it's subject to races too.  In
> this case, the I/O thread may fail to be woken by iothread_stop's
> aio_notify.  However, by the time iothread_stop is called there should
> be no BlockDriverStates (and thus no BDRV_POLL_WHILE running the above
> code) for the I/O thread's AioContext.

The scenario I have in mind is:

BDRV_POLL_WHILE() is called from the IOThread and the main loop also
invokes BDRV_POLL_WHILE().

The IOThread is blocked in aio_poll(ctx, true).

The main loop calls aio_poll(ctx, false) and can therefore steal the
event/completion condition.

I *think* ppoll() will return in both threads and they will race to
invoke handlers, but I'm not 100% sure that two BDRV_POLL_WHILE() calls
in parallel are safe.

What do you think?

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY8ztnAAoJEJykq7OBq3PIaocIAJ/w/SiYyGinP50y0/5kuuav
FyTnlAKVaWtb7fZvTQPCeAor+G8yI/jI4eLI2ovmm56T/F65YYvMMZ67pq8v3IZ3
jmrpZQE0jAkwZlRn3pul6ixzJcjHyH+mHd71zD8HzZ1uc578YIzflj8opa8t/JwC
eNLOBZVqpbGELB+BsqGmOz+iX+WKnoCqCWJWMay7nACuP++GJPau4tWrL+edW5M8
lrU9GAkGK3BMoji65hvUflM6ypLRBgbwqoLyNbO2obzFWcFQKQJnzz+hCbUkRgDD
Z4c9qcZmJvu1ksYKamSaxvHw+fLse+akjh/gvC8YZGR17X/g9NdgCYu07bm6T/4=
=BogA
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
