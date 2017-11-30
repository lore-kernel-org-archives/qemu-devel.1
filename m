Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKPhP-00089q-5N
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKPhI-00083R-8p
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:20:22 -0500
Date: Thu, 30 Nov 2017 14:19:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130141954.GC14748@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20171130094709.GA20286@lemon>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 05:47:09PM +0800, Fam Zheng wrote:
> On Wed, 11/29 12:00, Stefan Hajnoczi wrote:
> > On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> >=20
> > Event loops and coroutines are good but they should not be used directly
> > by block drivers and block jobs.  We need safe, high-level APIs that
> > implement commonly-used operations.
> >=20
> > > - Documentation
> > >=20
> > >   There is no central developer doc about block layer, especially how=
 all pieces
> > >   fit together. Having one will make it a lot easier for new contribu=
tors to
> > >   understand better. Of course, we're facing the old problem: the cod=
e is
> > >   moving, maintaining an updated document needs effort.
> > >=20
> > >   Idea: add ./doc/deve/block.txt?
> >=20
> > IOThreads and AioContexts are addressed here:
> > docs/devel/multiple-iothreads.txt
> >=20
> > The game has become significantly more complex than what the document
> > describes.  It's lacking aio_co_wake() and aio_co_schedule() for
> > example.
> >=20
> > > - Simplified code, or more orthogonal/modularized architecture.
> > >=20
> > >   Each aspect of block layer is complex enough so isolating them as m=
uch as
> > >   possible is a reasonable approach to control the complexity. Block =
jobs and
> > >   throttling becoming block filters is a good example, we should iden=
tify more.
> > >=20
> > >   Idea: rethink event loops. Create coroutines ubiquitously (for exam=
ple for
> > >   each fd handler, BH and timer), so that many nested aio_poll() can =
be removed.
> > >=20
> > >   Crazy idea: move the whole block layer to a vhost process, and impl=
ement
> > >   existing features differently, especially in terms of multi-threadi=
ng (hint:
> > >   rust?).
> >=20
> > A reimplementation will not solve the problem because:
> >=20
> > 1. If it still has the same feature set and requirements then the level
> >    of complexity will be comparable.
> >=20
> > 2. We can reduce accidental (inessential) complexity by continuing the
> >    various efforts around the block graph, block jobs, multi-queue block
> >    layer with an eye towards higher level APIs.
>=20
> Starting over is certainly not the motivation to do qemu-vhost, but it wo=
uld be
> an opportunity to use different async/concurrency paradigms if that is go=
ing to
> happen. I think in current block layer, event loop + coroutine is a good
> combination, but having nested aio_poll()'s made it worse, then mixing IO=
Threads
> in makes it a lot more complicated.

Why alternative model are you thinking of?

One slight change is to make everything run in a coroutine so that there
are no while (aio_poll()) loops.  Instead the caller would yield.

But the fundamental problem remains that drain is necessary and the
storage stack does not support request cancellation.  For example, when
the virtio-blk-pci device is reset QEMU has no way of (safely)
cancelling requests so it has to wait for all requests to complete.
This means we're stuck with synchronization points.

I agree that adding threading makes thing more complicated but
ultimately there is a real requirement to do that.  It's like the
difference between a simple block driver that is designed only for
qemu-img convert versus a fully-featured block driver that supports
parallel I/O.  The complexity is much higher but you can't wish it away
if you want parallel I/O.

Stefan

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIBOKAAoJEJykq7OBq3PIPocH/iDAGYdJBAFc4nuT4bjXTWOi
K+8ZdBdj1Fj23F++DcDKsCJ6wQEZc99WmgyR8/xqKD+y1qpBv7DCif7Ng2De1+9O
3RF+3wBnyabd3NCk0uouo1wiQWBeSoiEgA8Tou0s0Vkhw3bV767AfDTNJfCpqM29
CBGMZfDd+iwF8jL/U7EDdJ39vzTB0un2AtVZ9VgK2ynFrTL+bB/F0VXWFg2CGh4u
yrPJOVSFJIJWAjPWtvZ7y0mA3aZ6QHhUj3axbpVa4K8wDWqWsRDe5zhCFyNncJTH
18QFyoLsUHz+VKGvJliXUlOamdKB+AAMvGA/7UqNRrjNWKL68/j6HO/Bmp/SW2k=
=qdae
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
