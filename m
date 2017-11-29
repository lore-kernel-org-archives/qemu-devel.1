Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eK12V-0007QW-RG
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eK12U-0006Xh-Np
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:00:31 -0500
Date: Wed, 29 Nov 2017 12:00:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171129120018.GB2601@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20171129035502.GD8889@lemon>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> As we move forwards with new features in the block layer, the chances of =
tricky
> bugs happening have been increasing alongside - block jobs, coroutines,
> throttling, AioContext, op blockers and image locking combined together m=
ake a
> large and complex picture that is hard to fully understand and work with.=
 Some
> bugs we've encountered are quite challenging already.  Examples are:
>=20
> - segfault in parallel blockjobs (iotest 30)
>   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html
>=20
> - Intermittent hang of iotest 194 (bdrv_drain_all after non-shared storage
>   migration)
>   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01626.html
>=20
> - Drainage in bdrv_replace_child_noperm()
>   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00868.html
>=20
> - Regression from 2.8: stuck in bdrv_drain()
>   https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02193.html
>=20
> So in principle, what should we do to make the block layer easy to unders=
tand,
> develop with and debug?

The assumptions that the code relies on are unclear so it's easy to
introduce new bugs.

We are at a point where code review isn't finding certain bugs because
no single person knows all the assumptions.  Previously the problem was
contained because maintainers spotted problems before patches were
merged.

This is not primarily a documentation problem though.  We cannot
document our way out of this because no single person (patch author or
code reviewer) can know or check everything anymore due to the scale.

I think it's a (lack of) design problem because we have many incomplete
abstractions like block jobs, IOThreads, block graph, image locking,
etc.  They do not cover all possibly states and interactions today.
Extending them leads to complex bugs.

A little progress has been made with defining higher-level APIs for
block drivers and block jobs.  This way they either don't deal with
low-level details of the concurrency and event loop models (e.g.
bdrv_coroutine_enter()) or there is an interface that prompts them to
integrate properly like bdrv_attach/detach_aio_context().

Event loops and coroutines are good but they should not be used directly
by block drivers and block jobs.  We need safe, high-level APIs that
implement commonly-used operations.

> - Documentation
>=20
>   There is no central developer doc about block layer, especially how all=
 pieces
>   fit together. Having one will make it a lot easier for new contributors=
 to
>   understand better. Of course, we're facing the old problem: the code is
>   moving, maintaining an updated document needs effort.
>=20
>   Idea: add ./doc/deve/block.txt?

IOThreads and AioContexts are addressed here:
docs/devel/multiple-iothreads.txt

The game has become significantly more complex than what the document
describes.  It's lacking aio_co_wake() and aio_co_schedule() for
example.

> - Simplified code, or more orthogonal/modularized architecture.
>=20
>   Each aspect of block layer is complex enough so isolating them as much =
as
>   possible is a reasonable approach to control the complexity. Block jobs=
 and
>   throttling becoming block filters is a good example, we should identify=
 more.
>=20
>   Idea: rethink event loops. Create coroutines ubiquitously (for example =
for
>   each fd handler, BH and timer), so that many nested aio_poll() can be r=
emoved.
>=20
>   Crazy idea: move the whole block layer to a vhost process, and implement
>   existing features differently, especially in terms of multi-threading (=
hint:
>   rust?).

A reimplementation will not solve the problem because:

1. If it still has the same feature set and requirements then the level
   of complexity will be comparable.

2. We can reduce accidental (inessential) complexity by continuing the
   various efforts around the block graph, block jobs, multi-queue block
   layer with an eye towards higher level APIs.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHqFSAAoJEJykq7OBq3PI/EUH/2ReIk7SY9B/3MB4SYVe6GJb
PfzdkuMpjx0j/4BGhbcW0BOlyibQFuJWFyVCFDP1E2OklEcHHhChMn/Lvy8BK/B0
b0W5IA7gZWPeetg/VIZR7LJBAyiJs7Nr4tMWlgg0I+lrG67Pg0QrHYDbnfetBRUL
+dZmog7I3L7bP1VmZlJYHgFBaLzX0UnXwaGT2k0kCMWL+WleefBRSuaK1jTpcaLK
bH7QD2Id7GUtL8LeoIeS14DpnUYvnsdsOoEt1i7Z3RzmjTuvei85RIxoc30xqVRh
Si5rt5HG/voWD2KP1K6XZrCF9ciZKcrVy7BTMIAbjF/L7B3g1uXBWm68FuIk38w=
=Sbfu
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
