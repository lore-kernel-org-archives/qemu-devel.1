Received: from eggs.gnu.org ([209.51.188.92]:59476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtOey-0006bj-MR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtOex-00078O-He
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:23:00 -0500
Date: Tue, 12 Feb 2019 11:22:42 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190212032242.GC28401@stefanha-x1.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 11.02.2019 6:42, Stefan Hajnoczi wrote:
> > On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> >> Hi all!
> >>
> >> We have a very frequent pattern of wrapping a coroutine_fn function
> >> to be called from non-coroutine context:
> >>
> >>    - create structure to pack parameters
> >>    - create function to call original function taking parameters from
> >>      struct
> >>    - create wrapper, which in case of non-coroutine context will
> >>      create a coroutine, enter it and start poll-loop.
> >>
> >> Here is a draft of template code + example how it can be used to drop a
> >> lot of similar code.
> >>
> >> Hope someone like it except me)
> >=20
> > My 2 cents.  Cons:
> >=20
> >   * Synchronous poll loops are an anti-pattern.  They block all of QEMU
> >     with the big mutex held.  Making them easier to write is
> >     questionable because we should aim to have as few of these as
> >     possible.
>=20
> Understand. Do we have a concept or a kind of target for a future to get =
rid of
> these a lot of poll-loops? What is the right way? At least for block-laye=
r?

It's non-trivial.  The nested event loop could be flattened if there was
a mechanism to stop further activity on a specific object only (e.g.
BlockDriverState).  That way the event loop can continue processing
events for other objects and device emulation could continue for other
objects.

Unfortunately there are interactions between objects like in block jobs
that act on multiple BDSes, so it becomes even tricky.

A simple way of imagining this is to make each object an "actor"
coroutine.  The coroutine processes a single message (request) at a time
and yields when it needs to wait.  Callers send messages and expect
asynchronous responses.  This model is bad for efficiency (parallelism
is necessary) but at least it offers a sane way of thinking about
multiple asynchronous components coordinating together.  (It's another
way of saying, let's put everything into coroutines.)

The advantage of a flat event loop is that a hang in one object (e.g.
I/O getting stuck in one file) doesn't freeze the entire event loop.

> >=20
> >   * Code generation makes the code easier to write but harder to read.
> >     Code is read more than written.  In this case I think open coding
> >     isn't too bad and I prefer it to reading a code generation script to
> >     understand how it works.
>=20
> But you can read generated code in same way. You only need to read genera=
tor
> script if it generates something wrong, but should be rare.

Generated code isn't visible unless the code has been built and indexed
(if you're using ctags).  This makes it harder for people to navigate
the code.

> >=20
> > If we were planning to add lots more of these then I agree code
> > generation would help.  But in this case I'd rather not.
> >=20
>=20
> What do you think at least of generating code to create a coroutine from =
a function
> with multiple arguments?

If it's easy to read without requiring one to figure out how the magic
works, then I like it.

Stefan

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYjwCAAoJEJykq7OBq3PIqj0H/izsUR2/oe5ulLW65Mnv189g
bB6r0+HaYBicddkMxjI2hXkK0/UeuadWr61pJwPYoTb75Sq6+C5GWw6hVqNr4gea
O/xpk5ToB7gnM22N0ITd3uG1/kGeo1FKgnlgBEhV1cct3xvvtesRFaoMEnu4CYsP
9doSMxaOwvBAik2kf336zqLJGn8QfwWgmP32yQBG3Cgg8pNZxEN3UPL+YfdsbP+3
d3GLIzuvgx6mNbCzXfIjIauONJ6iNgJnlGTMs2kO/pPMtucYFPwC/CaI8kE/QTE7
JOuxwni9A6gLmJfmoqAYBRUyUM/3BvfzhBBC58GaoRh/JCgeyVLiYpsBEvRTGNM=
=QoS1
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
