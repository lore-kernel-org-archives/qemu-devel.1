Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzKO-0007wn-0u
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzKK-0000xG-5Y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:27:40 -0500
Date: Thu, 8 Mar 2018 17:27:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308172726.GG2769@stefanha-x1.localdomain>
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<20180306115124.GG31045@stefanha-x1.localdomain>
	<dfd15486-e90b-50cd-0271-37a55c3cfc74@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <dfd15486-e90b-50cd-0271-37a55c3cfc74@kamp.de>
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 09:36:38PM +0100, Peter Lieven wrote:
> Am 06.03.2018 um 12:51 schrieb Stefan Hajnoczi:
> > On Tue, Feb 20, 2018 at 06:04:02PM +0100, Peter Lieven wrote:
> >> I remember we discussed a long time ago to limit the stack usage of al=
l functions that are executed in a coroutine
> >> context to a very low value to be able to safely limit the coroutine s=
tack size as well.
> >>
> >> I checked through all functions in block/, migration/ and nbd/ and the=
re are only very few larger or unbound stack
> >> allocations that can easily be fixed.
> >>
> >> Now my question: Is there an easy way to add a cflag like -Wstack-usag=
e=3D2048 to all objects in a given directory only?
> >> I tried to add a llimit to the whole project, but fixing this will be =
a larger task.
> > 2KB is fine for QEMU code but actual coroutine stack sizes will have to
> > be at least 8KB, I guess, in order for third-party libraries to work
> > (e.g. curl, rbd).  PATH_MAX is 4KB on Linux.
> >
> > Nested event loops in QEMU code can also result in deep call stacks.
> > This happens when aio_poll() invokes an fd handler or BH that also
> > invokes aio_poll().
>=20
> The plan was to limit the stack usage only as a compiler option. I would =
leave the coroutine stack size at 1MB
> for now until we have a way to identify the worst case usage.

I'm not sure we'll be able to confidently set a small stack size, but a
compile-time check doesn't hurt.

Maybe someday we'll switch to stackless coroutines.  Clang now has
coroutines support and maybe gcc will get it too (for C++20).  If the
compiler transforms the code then coroutine state can be kept in a
smaller data area that is not a call stack.  A single per-thread call
stack is used to run any coroutine and only during coroutine execution.

Stefan

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoXJ+AAoJEJykq7OBq3PIc2cH/0qdNdwR3/Qu5PwkfZ3h+O1t
gb2aYqYuSwcR5MQ8SXHpGleobTpvP0g/fAIcpjrr+3arwpOxXSS5TcsDksHor2xI
lNFvIwQSch8QR9ta5mQCpRonqDdq+TpdYp43KrzRxQ4RYZJPHOG+2INy4jIhPFoe
yasaLYaHq5rQ063kOktF89Xc72DMBOPWogAZjxZAwi4EpLM4Qq3isviE1HeXzwxL
jGaAw3U6VeOA+eSWFs22eOFIdV0ERxy79L3wdrFFVi6mEHj75lF7KxhluZBgugU4
gkNJ9d9YCenAEUOb77LWQZLy0HlMu63XXOTRoalYgZM8WANJzNi8/QYROyg5YUw=
=5/iy
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
