Received: from eggs.gnu.org ([2001:4830:134:3::10]:50194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM8qr-0006KH-Kw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM8qo-0005Ma-UN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:17:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fM8qo-0005ME-Pj
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:17:30 -0400
Date: Fri, 25 May 2018 10:17:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525091724.GC14757@stefanha-x1.localdomain>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
	<20180518120239.GA31915@stefanha-x1.localdomain>
	<87h8n5dmrk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <87h8n5dmrk.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: famz@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 04:08:47PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Fri, May 18, 2018 at 10:14:40AM +0100, Alex Benn=E9e wrote:
> >> The following tests keep showing up in failed Travis runs:
> >>
> >>   - test-aio
> >
> > What is the issue?
>=20
> GTESTER tests/test-thread-pool
> **
> ERROR:tests/test-aio.c:501:test_timer_schedule: assertion failed: (aio_po=
ll(ctx, true))
> GTester: last random seed: R02S66126aca97f9606b33e5d7be7fc9b625
> make: *** [check-tests/test-aio] Error 1
> make: *** Waiting for unfinished jobs....

The test_timer_schedule test case relies on timing and is
non-deterministic.

I couldn't figure out how it managed to fail that specific assertion.
aio_poll(ctx, true) =3D=3D false happens when aio_notify() was called but I
don't understand why it happened here.

However, I do see that this test case will fail if the machine is very
heavily loaded.  The test simply won't reach the places where it should
wait for the timer.  The timer may expire too early.

Maybe a steppable clock should be used (vmclock), but then the test
would have to be simplified because the aio_poll(ctx, true) part relies
on ppoll(2)'s timeout.

Any thoughts, Paolo?

Stefan

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbB9SkAAoJEJykq7OBq3PI4L8H/AhfbpkLDxxXmJgel8up30ar
wUXHHHPSwwnzsDlaEOQWGUCcaFNcH7Hs/gU7Nl9tmV3jdebc4VVZjjvpDU7oAKbr
++ny8Jux+ht7OAyF/SMncOnfkyBjaZjdeeX9zeuUQVvW8G3r1UXB/X5S9uvHPaep
yxuqE9A5R2Z5GFJkgK+BnXu5XVGykhcxCD6PX4vMKBGIdnufUkr3X08uodFat1aa
z+OYx7t6R7niWS5tRIhM2f2XdN0fqJzs5kQz9JdFmJTKQUJ+5tJ+jMWv7TKw59UB
AzfHLyBLxAJFQt0O3a78nNGyzuaV/TPlsmoJK/nxdjOVRYB5LTVPrMKG0Yrr+h8=
=+uc1
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
