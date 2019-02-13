Received: from eggs.gnu.org ([209.51.188.92]:41205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtrUY-0005E6-AR
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtrUW-0005Kz-W6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:10:10 -0500
Date: Wed, 13 Feb 2019 11:09:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190213100956.GB994@localhost.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
	<20190212032242.GC28401@stefanha-x1.localdomain>
	<20190212115840.GB5283@localhost.localdomain>
	<20190213065830.GA26332@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20190213065830.GA26332@stefanha-x1.localdomain>
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>, armbru@redhat.com


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.02.2019 um 07:58 hat Stefan Hajnoczi geschrieben:
> On Tue, Feb 12, 2019 at 12:58:40PM +0100, Kevin Wolf wrote:
> > Am 12.02.2019 um 04:22 hat Stefan Hajnoczi geschrieben:
> > > On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievski=
y wrote:
> > > > 11.02.2019 6:42, Stefan Hajnoczi wrote:
> > > > > On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogie=
vskiy wrote:
> > > > >> Hi all!
> > > > >>
> > > > >> We have a very frequent pattern of wrapping a coroutine_fn funct=
ion
> > > > >> to be called from non-coroutine context:
> > > > >>
> > > > >>    - create structure to pack parameters
> > > > >>    - create function to call original function taking parameters=
 from
> > > > >>      struct
> > > > >>    - create wrapper, which in case of non-coroutine context will
> > > > >>      create a coroutine, enter it and start poll-loop.
> > > > >>
> > > > >> Here is a draft of template code + example how it can be used to=
 drop a
> > > > >> lot of similar code.
> > > > >>
> > > > >> Hope someone like it except me)
> > > > >=20
> > > > > My 2 cents.  Cons:
> > > > >=20
> > > > >   * Synchronous poll loops are an anti-pattern.  They block all o=
f QEMU
> > > > >     with the big mutex held.  Making them easier to write is
> > > > >     questionable because we should aim to have as few of these as
> > > > >     possible.
> > > >=20
> > > > Understand. Do we have a concept or a kind of target for a future t=
o get rid of
> > > > these a lot of poll-loops? What is the right way? At least for bloc=
k-layer?
> > >=20
> > > It's non-trivial.  The nested event loop could be flattened if there =
was
> > > a mechanism to stop further activity on a specific object only (e.g.
> > > BlockDriverState).  That way the event loop can continue processing
> > > events for other objects and device emulation could continue for other
> > > objects.
> >=20
> > The mechanism to stop activity on BlockDriverStates is bdrv_drain(). But
> > I don't see how this is related. Nested event loops aren't for stopping
> > concurrent activity (events related to async operations started earlier
> > are still processed in nested event loops), but for making progress on
> > the operation we're waiting for. They happen when synchronous code calls
> > into asynchronous code.
> >=20
> > The way to get rid of them is making their callers async. I think we
> > would come a long way if we ran QMP command handlers (at least the block
> > related ones) and qemu-img operations in coroutines instead of blocking
> > while we wait for the result.
>=20
> A difficult caller is device reset, where we need to drain all requests.
> But even converting some sync code paths to async is a win because it
> removes places where QEMU can get stuck.

Yes, as I said, draining a node can hang. And it can hang not because
there are nested event loops or because of any other bad design
decision, but because waiting for all requests to complete is required.

The only thing we could try to improve this is cancelling requests after
a timeout (or triggered by an OOB QMP command?) during a drain
operation, but cancelling requests hasn't really been a success story so
far.

> Regarding block QMP handlers, do you mean suspending the monitor when
> a command yields?  The monitor will be unresponsive to the outside
> world, so this doesn't solve the problem from the QMP client's
> perspective.  This is why async QMP and jobs are interesting but it's a
> lot of work both inside QEMU and for clients like libvirt.

Yes, it wouldn't keep the monitor responsive as long as the monitor
protocol is synchronous. But it would keep the VM running at least, the
GUI would stay responsive etc.

Blocking the monitor is again nothing that restructuring the code could
fix. It requires a change to the QMP protocol, but then it will easily
fit in the current design.

Nested event loops are unrelated.

> > > Unfortunately there are interactions between objects like in block jo=
bs
> > > that act on multiple BDSes, so it becomes even tricky.
> > >=20
> > > A simple way of imagining this is to make each object an "actor"
> > > coroutine.  The coroutine processes a single message (request) at a t=
ime
> > > and yields when it needs to wait.  Callers send messages and expect
> > > asynchronous responses.  This model is bad for efficiency (parallelism
> > > is necessary) but at least it offers a sane way of thinking about
> > > multiple asynchronous components coordinating together.  (It's another
> > > way of saying, let's put everything into coroutines.)
> > >=20
> > > The advantage of a flat event loop is that a hang in one object (e.g.
> > > I/O getting stuck in one file) doesn't freeze the entire event loop.
> >=20
> > I think this one is more theoretical because you'll still have
> > dependencies between the components. blk_drain_all() isn't hanging
> > because the code is designed suboptimally, but because its semantics is
> > to wait until all requests have completed. And it's called because this
> > semantics is required.
>=20
> If we try to convert everything to async there will be two cases:
> 1. Accidental sync code which can be made async.  (Rare nowadays?)
> 2. Fundamental synchronization points that require waiting.
>=20
> When you reach a point that hangs there is still the possibility of a
> timeout or an explicit cancel.  Today QEMU supports neither, so a
> command that gets stuck will hang QEMU for as long as it takes.
>=20
> If QMP clients want timeouts or cancel then making everything async is
> necessary.  If not, then we can leave it as is and simply audit the code
> for accidental sync code (there used to be a lot of this but it's rarer
> now) and convert it.

I'm not sure what makes sync code only "accidentally" sync, but at least
everything the monitor does is sync.

With your assessment that we can leave everything as it is if QMP
clients don't want improvements, you're ignoring that currently, not
only the QMP monitor becomes unresponsive, but it holds the BQL while
doing so and brings down the whole VM this way. So even without changing
the QMP protocol, there is something to be gained by making it async
(i.e. executing the block layer command handlers in a coroutine).

Kevin

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcY+z0AAoJEH8JsnLIjy/WPfkP/irIRo8UKhwJ7fo1QSccT8Mu
7JdYNVKiKAb38933F1ldtFdjKYgzXzzgGaUA2fveH5w0K8brV0h070aDkCjZ178r
1ba0YnY60vRYEgp3nSem+U/yn8+dKNriUlMzxlvoslF4C0E6nOVakIN4Xz5CRJ5o
oNSHj4JeCzV6UE9v4PWBe6MtAFSP3ERXZBpNZ1oVVp0ZSHd4DKdRBftz6DYVK/Wd
/LCMY7aUYdPlSrU6r/8cFBZIdiw+j+lqQTqzZ/SXsbF9TwM5R+D24kVrn6UTSJpZ
yBGOYo6V+pH0mPbeLwThFG0uyL8srhgJ5ADMAgF/0T0aczJzBm5QHKpIPwg6PWvO
DrbDn2QAa0uLekU0I/BLIxDx5xFst7A2K3i/Fs2mf7PAQa5Z7uSxKWDqeQaLYNyM
RrHFjCl+ykQbgdWhKDeVEd9vBwGymO4OCoW1AipPM/54m7JH1gqJOTq9Y26lu4UH
pMKy2h2rFryuS+BNfgyN2XrNc82z44rX9cuaBFve9NXCw/mPzmPUkODisoDzklUT
w+tUana+geBOM9SBZ7t2/BcMEpDp5QekHBb57Jcu/yFaXu8qorXZCPgxooTi7m25
SMEwmNskw/ciCdaBdY5z55R21ptZw49/7wqmaFhMrxOM1ljmyEuPo0C4I3cX15aE
Yo+5uQ5S2tUm3aD4wdRd
=dTEO
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
