Received: from eggs.gnu.org ([209.51.188.92]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtodO-0003Vq-GD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtoVR-0000Zi-H1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:58:55 -0500
Date: Wed, 13 Feb 2019 14:58:30 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190213065830.GA26332@stefanha-x1.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
	<20190212032242.GC28401@stefanha-x1.localdomain>
	<20190212115840.GB5283@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20190212115840.GB5283@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 12:58:40PM +0100, Kevin Wolf wrote:
> Am 12.02.2019 um 04:22 hat Stefan Hajnoczi geschrieben:
> > On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievskiy =
wrote:
> > > 11.02.2019 6:42, Stefan Hajnoczi wrote:
> > > > On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievs=
kiy wrote:
> > > >> Hi all!
> > > >>
> > > >> We have a very frequent pattern of wrapping a coroutine_fn function
> > > >> to be called from non-coroutine context:
> > > >>
> > > >>    - create structure to pack parameters
> > > >>    - create function to call original function taking parameters f=
rom
> > > >>      struct
> > > >>    - create wrapper, which in case of non-coroutine context will
> > > >>      create a coroutine, enter it and start poll-loop.
> > > >>
> > > >> Here is a draft of template code + example how it can be used to d=
rop a
> > > >> lot of similar code.
> > > >>
> > > >> Hope someone like it except me)
> > > >=20
> > > > My 2 cents.  Cons:
> > > >=20
> > > >   * Synchronous poll loops are an anti-pattern.  They block all of =
QEMU
> > > >     with the big mutex held.  Making them easier to write is
> > > >     questionable because we should aim to have as few of these as
> > > >     possible.
> > >=20
> > > Understand. Do we have a concept or a kind of target for a future to =
get rid of
> > > these a lot of poll-loops? What is the right way? At least for block-=
layer?
> >=20
> > It's non-trivial.  The nested event loop could be flattened if there was
> > a mechanism to stop further activity on a specific object only (e.g.
> > BlockDriverState).  That way the event loop can continue processing
> > events for other objects and device emulation could continue for other
> > objects.
>=20
> The mechanism to stop activity on BlockDriverStates is bdrv_drain(). But
> I don't see how this is related. Nested event loops aren't for stopping
> concurrent activity (events related to async operations started earlier
> are still processed in nested event loops), but for making progress on
> the operation we're waiting for. They happen when synchronous code calls
> into asynchronous code.
>=20
> The way to get rid of them is making their callers async. I think we
> would come a long way if we ran QMP command handlers (at least the block
> related ones) and qemu-img operations in coroutines instead of blocking
> while we wait for the result.

A difficult caller is device reset, where we need to drain all requests.
But even converting some sync code paths to async is a win because it
removes places where QEMU can get stuck.

Regarding block QMP handlers, do you mean suspending the monitor when
a command yields?  The monitor will be unresponsive to the outside
world, so this doesn't solve the problem from the QMP client's
perspective.  This is why async QMP and jobs are interesting but it's a
lot of work both inside QEMU and for clients like libvirt.

>=20
> > Unfortunately there are interactions between objects like in block jobs
> > that act on multiple BDSes, so it becomes even tricky.
> >=20
> > A simple way of imagining this is to make each object an "actor"
> > coroutine.  The coroutine processes a single message (request) at a time
> > and yields when it needs to wait.  Callers send messages and expect
> > asynchronous responses.  This model is bad for efficiency (parallelism
> > is necessary) but at least it offers a sane way of thinking about
> > multiple asynchronous components coordinating together.  (It's another
> > way of saying, let's put everything into coroutines.)
> >=20
> > The advantage of a flat event loop is that a hang in one object (e.g.
> > I/O getting stuck in one file) doesn't freeze the entire event loop.
>=20
> I think this one is more theoretical because you'll still have
> dependencies between the components. blk_drain_all() isn't hanging
> because the code is designed suboptimally, but because its semantics is
> to wait until all requests have completed. And it's called because this
> semantics is required.

If we try to convert everything to async there will be two cases:
1. Accidental sync code which can be made async.  (Rare nowadays?)
2. Fundamental synchronization points that require waiting.

When you reach a point that hangs there is still the possibility of a
timeout or an explicit cancel.  Today QEMU supports neither, so a
command that gets stuck will hang QEMU for as long as it takes.

If QMP clients want timeouts or cancel then making everything async is
necessary.  If not, then we can leave it as is and simply audit the code
for accidental sync code (there used to be a lot of this but it's rarer
now) and convert it.

Stefan

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY8AWAAoJEJykq7OBq3PIqTYH/i65Lvpso68KnudxIeWqst4Y
z0g2EbPn/GqCZtYNutGVguV76SZSwZ45zMPsiK7iz3Oeo0SDLcm0zx3O6hRds2Iv
5e2VzVR9Eoyih7HJmmTw5xXUT4tOk9OXxE5fXm2f19hZV2twx3gIUMxjFq/xD31T
6o41i4sWl0KGidE0u3lgbRbofIbm6EvNUw/uKrbCVcQ2Azl5rp7fi76AJ+46LMpI
o0Ju4B29b89GU2hYxUv7QYUzALpN3OUvE4Bzwkb5QicG4qJ8Vum/pZhvfP37q08W
aetBE+t9tSakNqRUvEXEMMLv8mJwlXGaQXv/PMM1rNZukc1rAUz+3WghG02mw64=
=l2ta
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
