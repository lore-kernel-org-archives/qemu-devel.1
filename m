Received: from eggs.gnu.org ([209.51.188.92]:49072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtVjS-0002QI-Q4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtVjQ-0003DC-SV
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:56:06 -0500
Date: Tue, 12 Feb 2019 18:55:33 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190212105533.GA30788@stefanha-x1.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
	<20190212032242.GC28401@stefanha-x1.localdomain>
	<ba74c0e8-e5d0-fe43-278c-6ed1cd7bb195@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <ba74c0e8-e5d0-fe43-278c-6ed1cd7bb195@virtuozzo.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 10:03:19AM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 12.02.2019 6:22, Stefan Hajnoczi wrote:
> > On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievskiy =
wrote:
> >> 11.02.2019 6:42, Stefan Hajnoczi wrote:
> >>> On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> >>>> Hi all!
> >>>>
> >>>> We have a very frequent pattern of wrapping a coroutine_fn function
> >>>> to be called from non-coroutine context:
> >>>>
> >>>>     - create structure to pack parameters
> >>>>     - create function to call original function taking parameters fr=
om
> >>>>       struct
> >>>>     - create wrapper, which in case of non-coroutine context will
> >>>>       create a coroutine, enter it and start poll-loop.
> >>>>
> >>>> Here is a draft of template code + example how it can be used to dro=
p a
> >>>> lot of similar code.
> >>>>
> >>>> Hope someone like it except me)
> >>>
> >>> My 2 cents.  Cons:
> >>>
> >>>    * Synchronous poll loops are an anti-pattern.  They block all of Q=
EMU
> >>>      with the big mutex held.  Making them easier to write is
> >>>      questionable because we should aim to have as few of these as
> >>>      possible.
> >>
> >> Understand. Do we have a concept or a kind of target for a future to g=
et rid of
> >> these a lot of poll-loops? What is the right way? At least for block-l=
ayer?
> >=20
> > It's non-trivial.  The nested event loop could be flattened if there was
> > a mechanism to stop further activity on a specific object only (e.g.
> > BlockDriverState).  That way the event loop can continue processing
> > events for other objects and device emulation could continue for other
> > objects.
> >=20
> > Unfortunately there are interactions between objects like in block jobs
> > that act on multiple BDSes, so it becomes even tricky.
> >=20
> > A simple way of imagining this is to make each object an "actor"
> > coroutine.  The coroutine processes a single message (request) at a time
> > and yields when it needs to wait.  Callers send messages and expect
> > asynchronous responses.  This model is bad for efficiency (parallelism
>=20
> hmm, and with all these loops, where is parallelism?

In this model all activity, including the async operations that work in
parallel today, go through an actor coroutine.  The loss of parallelism
isn't in synchronous polling operations, it's in the async operations.

But I'm just using this as a simple model for reasoning about a world
where no synchronous polling loops are necessary.  I don't think we
would try to implement it - at least not without a lot more thought into
how to make it efficient.

Stefan

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYqYlAAoJEJykq7OBq3PI5NgH/iHhtjpUCn2KJM8X7ipyo5I7
JQcET4+/SCl7pfU8vkg0OatW+3xFEz6WBjf9CIKkOSBaaCSP9m80ATILbXXsJP+5
N4ccubtl/ozzFkEp5V0ctfgdPzQYUvfRzLHMq87zuy0rLPpN6HuHfFs3IxzEIFCd
ZYmIorFGC3YRG4imbuTU8jRuoeNouzHMZBdgHayE/ugF2d2scJYxih9PS6GC2LsM
/UqGxnIwX2uY1y4t3NvHLVmzQzunxFWQOche4N7qTUrX9nr13IAbOFtd083MYYL+
ioI5lZEznTcMxBKX+f5Uf0tsWztjGdvEAZfCjnNW8dkqbZyvzp8dbSwv5YHMcx0=
=dM9L
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
