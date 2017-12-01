Received: from eggs.gnu.org ([2001:4830:134:3::10]:54387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoIt-0004im-Pw
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoIr-0002wB-Vr
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:43 -0500
Date: Fri, 1 Dec 2017 14:08:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171201140833.GB12803@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20171201101644.GB11092@lemon>
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


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 06:16:44PM +0800, Fam Zheng wrote:
> On Thu, 11/30 14:19, Stefan Hajnoczi wrote:
> > On Thu, Nov 30, 2017 at 05:47:09PM +0800, Fam Zheng wrote:
> > > On Wed, 11/29 12:00, Stefan Hajnoczi wrote:
> > > > On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> > > >=20
> > > > Event loops and coroutines are good but they should not be used dir=
ectly
> > > > by block drivers and block jobs.  We need safe, high-level APIs that
> > > > implement commonly-used operations.
> > > >=20
> > > > > - Documentation
> > > > >=20
> > > > >   There is no central developer doc about block layer, especially=
 how all pieces
> > > > >   fit together. Having one will make it a lot easier for new cont=
ributors to
> > > > >   understand better. Of course, we're facing the old problem: the=
 code is
> > > > >   moving, maintaining an updated document needs effort.
> > > > >=20
> > > > >   Idea: add ./doc/deve/block.txt?
> > > >=20
> > > > IOThreads and AioContexts are addressed here:
> > > > docs/devel/multiple-iothreads.txt
> > > >=20
> > > > The game has become significantly more complex than what the docume=
nt
> > > > describes.  It's lacking aio_co_wake() and aio_co_schedule() for
> > > > example.
> > > >=20
> > > > > - Simplified code, or more orthogonal/modularized architecture.
> > > > >=20
> > > > >   Each aspect of block layer is complex enough so isolating them =
as much as
> > > > >   possible is a reasonable approach to control the complexity. Bl=
ock jobs and
> > > > >   throttling becoming block filters is a good example, we should =
identify more.
> > > > >=20
> > > > >   Idea: rethink event loops. Create coroutines ubiquitously (for =
example for
> > > > >   each fd handler, BH and timer), so that many nested aio_poll() =
can be removed.
> > > > >=20
> > > > >   Crazy idea: move the whole block layer to a vhost process, and =
implement
> > > > >   existing features differently, especially in terms of multi-thr=
eading (hint:
> > > > >   rust?).
> > > >=20
> > > > A reimplementation will not solve the problem because:
> > > >=20
> > > > 1. If it still has the same feature set and requirements then the l=
evel
> > > >    of complexity will be comparable.
> > > >=20
> > > > 2. We can reduce accidental (inessential) complexity by continuing =
the
> > > >    various efforts around the block graph, block jobs, multi-queue =
block
> > > >    layer with an eye towards higher level APIs.
> > >=20
> > > Starting over is certainly not the motivation to do qemu-vhost, but i=
t would be
> > > an opportunity to use different async/concurrency paradigms if that i=
s going to
> > > happen. I think in current block layer, event loop + coroutine is a g=
ood
> > > combination, but having nested aio_poll()'s made it worse, then mixin=
g IOThreads
> > > in makes it a lot more complicated.
> >=20
> > Why alternative model are you thinking of?
>=20
> To utilize whatever is offered in the different language. In particular I=
've
> heard good things about rust (without programming it myself) that doing
> concurrency correctly is easier with it. We'll probably lose all the good=
 bits
> about coroutine (unlike what is special in Go), but I expects using simpl=
er
> concurrency models (IOW threads only) can lead to simpler code. (I have no
> problem with coroutine excpet the debuggability problem I pointed out, wh=
ich
> hopefully can be solved by writing more gdb extensions.)

[A long rant here but I hope it contains useful points.]

Rust's threading model is 1:1.  Besides mutexes it also has channels
(looks similar to Go and communicating sequential processes-style
channels).

It is probably not feasible to make each I/O request a thread (i.e. 1M
IOPS means creating/destroying 1M threads/sec).  There would have to be
some machinery like a request queue and a thread pool to process
requests.  That way requests can be held before those that are ready to
be executed can run as threads.  Hmm...this sounds similar to what we
have.

The important thing is this:

Coroutines with a single event loop (current model in QEMU) are simpler
than threads.  Why?  Because coroutine code is atomic with respect to
other coroutines in the same event loop.  Only yield points or nested
event loops allow other coroutines to execute.  That means less explicit
synchronization is necessary.

When the block layer goes multiqueue this advantage will be lost and
coroutine code will have to synchronize explicitly just like threaded
code.  Coroutines will remain lighter weight than threads and will allow
M:N threading to be configured via IOThreads.

I'm not hopeful that dropping coroutines helps and I don't see that Rust
brings anything new to the table here.  I do like other aspects of Rust
and am open to using it for new code.

What I'm getting at is that the essential complexity of a parallel I/O
engine with a runtime reconfigurable graph, background operations, and
non-trivial disk image file formats sets a certain floor (minimum)
complexity.  The consequence is that our code needs to handle
concurrency and this is where we fall down today.

Switching programming language will not reduce complexity below this
floor.  We'd have to abandon features in order to reduce complexity.
"Let's start from scratch" attempts often hope to do this but ultimately
users don't want to lose features.

We need to think through the corner cases we've been hitting and in the
process of fixing them we should consider if simplified interfaces/APIs
with less concurrency would allow us to write better code at the expense
of less control and performance in cases where we don't need it.

That means insulate block jobs and drivers as much as possible.  Don't
make them use low-level primitives.  Make them use high-level APIs where
the concurrency is baked in and as safe as we can make it without giving
up performance.

> Another thing about rust is it can call into C code so maybe the change c=
an be
> done incrementally like suggested by Dan in his libvirt discussion about =
using
> Go:
>=20
> https://www.redhat.com/archives/libvir-list/2017-November/msg00528.html

Max's qcow2 in Rust driver didn't make me very optimistic about mixed C
and Rust.  Putting a Rust layer on top of C looks sane.  I don't think
you can mix C and Rust side-by-side without a lot of duplication and
boilerplate, but my knowledge is limited to looking at Max's qcow2
driver.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIWJhAAoJEJykq7OBq3PI7wsH/i5KnzIViRC5rn6O84rfc2+x
PZF1CBTqCCbiCrGf7prjFOnLhVzhhaCKMiA7ZpM1+Akq0GqMh8Nv+AFEGYyEIx/h
azAZXPU38eLo3KEUk1wqgFDXHXwY6qmI58a7hy3R3ohhxQJVL8zOr44ZxOWRzFNI
48642jh8KVe3SWsFTjqgzZ62YSCcmK0Uz1s7g1aJBPy4hyG6aki45zVkBMiW85SB
gYEMMibxJ9efQ2ejhWhcayKaIxMfOsLYzZPESgqVXnpCjj14UFRznYACP9T94l2a
RbHizA2jzbPTpvi0vdJa7dFOySCfPK2dcLduxu8rcJHbMCC46UsTzKdzU3ozdC8=
=c+sF
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
