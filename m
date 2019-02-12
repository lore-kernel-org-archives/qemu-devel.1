Received: from eggs.gnu.org ([209.51.188.92]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtWnA-00077P-Dz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtWn7-0005Wr-P9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:04:00 -0500
Date: Tue, 12 Feb 2019 12:58:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212115840.GB5283@localhost.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
	<20190212032242.GC28401@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20190212032242.GC28401@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] coroutines: generate
 wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.02.2019 um 04:22 hat Stefan Hajnoczi geschrieben:
> On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> > 11.02.2019 6:42, Stefan Hajnoczi wrote:
> > > On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> > >> Hi all!
> > >>
> > >> We have a very frequent pattern of wrapping a coroutine_fn function
> > >> to be called from non-coroutine context:
> > >>
> > >>    - create structure to pack parameters
> > >>    - create function to call original function taking parameters from
> > >>      struct
> > >>    - create wrapper, which in case of non-coroutine context will
> > >>      create a coroutine, enter it and start poll-loop.
> > >>
> > >> Here is a draft of template code + example how it can be used to dro=
p a
> > >> lot of similar code.
> > >>
> > >> Hope someone like it except me)
> > >=20
> > > My 2 cents.  Cons:
> > >=20
> > >   * Synchronous poll loops are an anti-pattern.  They block all of QE=
MU
> > >     with the big mutex held.  Making them easier to write is
> > >     questionable because we should aim to have as few of these as
> > >     possible.
> >=20
> > Understand. Do we have a concept or a kind of target for a future to ge=
t rid of
> > these a lot of poll-loops? What is the right way? At least for block-la=
yer?
>=20
> It's non-trivial.  The nested event loop could be flattened if there was
> a mechanism to stop further activity on a specific object only (e.g.
> BlockDriverState).  That way the event loop can continue processing
> events for other objects and device emulation could continue for other
> objects.

The mechanism to stop activity on BlockDriverStates is bdrv_drain(). But
I don't see how this is related. Nested event loops aren't for stopping
concurrent activity (events related to async operations started earlier
are still processed in nested event loops), but for making progress on
the operation we're waiting for. They happen when synchronous code calls
into asynchronous code.

The way to get rid of them is making their callers async. I think we
would come a long way if we ran QMP command handlers (at least the block
related ones) and qemu-img operations in coroutines instead of blocking
while we wait for the result.

> Unfortunately there are interactions between objects like in block jobs
> that act on multiple BDSes, so it becomes even tricky.
>=20
> A simple way of imagining this is to make each object an "actor"
> coroutine.  The coroutine processes a single message (request) at a time
> and yields when it needs to wait.  Callers send messages and expect
> asynchronous responses.  This model is bad for efficiency (parallelism
> is necessary) but at least it offers a sane way of thinking about
> multiple asynchronous components coordinating together.  (It's another
> way of saying, let's put everything into coroutines.)
>=20
> The advantage of a flat event loop is that a hang in one object (e.g.
> I/O getting stuck in one file) doesn't freeze the entire event loop.

I think this one is more theoretical because you'll still have
dependencies between the components. blk_drain_all() isn't hanging
because the code is designed suboptimally, but because its semantics is
to wait until all requests have completed. And it's called because this
semantics is required.

Kevin

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcYrTvAAoJEH8JsnLIjy/WrRUP/1cWjQAf6Xo1YN6R118vtOXZ
cc/HDQmOQm7TA8xl3ffkyGrKZMNJAnQaou2txkyF27iJG4QWu2OvDRNf3n15mLqo
C8EcZgpPB9mCpVtf7/ItvGal41xxZBo46t1lkHdc3mUK61xBL1qAkmHhe++KkWad
lZoP6iTZhKCnIiYaiaq5+yz59MsRki74vOpGCJGzfhARbrwGSIw9evrYiTGK3idl
67tNCTvlTNOq5Qm/4TnmOJB6s6LLUv9SrI8kvzFAtBODbhek0qd5lXn0FRrBVTTA
LgMLG/Zr1XiGWTyFhCKoYTM12Use9A62WnxcgVLcf26KTgkpDw0Jw7Yh76aZgSot
xSepEdpzQN3QS/GDu/1Ax0zcUdDdYixgZS/Nijb13l3TkzyNjM9pD/wT/6X9YEUC
6IDb5SxMQ4gt0Ogms9Lc4rSWkstxXEobWb7VB1AG3GpnFCKCpjAEdoVMTQqZ3g6q
237jxlQfRLIOjRiiMfs7kjzHegPioAW1auRps/mZChpigZZoU0f5jRUxhPFjK1Ay
kILfJlMUNr+R9dlSKOMMsPGnoF8N5IwXPDK/eY67BfNs8jgHb2Tk5JMFZUnIFOFp
iMvprJeB1fNKGq4fDLR//B0rgwRuZLZUUKW3d//NwSQWAOyYZLmv8UyItrohX+hk
do0QzOTv6rgvmFOBePJa
=BDni
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
