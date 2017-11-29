Received: from eggs.gnu.org ([2001:4830:134:3::10]:46191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2MR-0002Aw-GQ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2MO-0003Td-AC
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:11 -0500
Date: Wed, 29 Nov 2017 13:24:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171129132455.GA4281@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Block layer complexity: what to do to
 keep it under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 01:24:46PM +0100, Paolo Bonzini wrote:
> On 29/11/2017 13:00, Stefan Hajnoczi wrote:
> > We are at a point where code review isn't finding certain bugs because
> > no single person knows all the assumptions.  Previously the problem was
> > contained because maintainers spotted problems before patches were
> > merged.
> >=20
> > This is not primarily a documentation problem though.  We cannot
> > document our way out of this because no single person (patch author or
> > code reviewer) can know or check everything anymore due to the scale.
> >=20
> > I think it's a (lack of) design problem because we have many incomplete
> > abstractions like block jobs, IOThreads, block graph, image locking,
> > etc.  They do not cover all possibly states and interactions today.
> > Extending them leads to complex bugs.
>=20
> I think the main interactions are:
>=20
> 1) block graph modifications and drain.  This has always been a carnage.
>  Implementing BlockBackend isolation instead of drain would probably be
> a starting point to fix it, because IIRC there are extremely few cases
> where we really need "drain" semantics.

Yes, this is a big one.

> 2) block jobs and coroutines.  Block jobs were too clever about
> coroutines.  Using a simplified API is going to fix this problem.
> Ideally, if you're not in a coroutine "co", the only coroutine APIs you
> should use on "co" are:
>=20
> - aio_co_enter/qemu_coroutine_enter (start a coroutine, respectively on
> another AioContext or this context);
>=20
> - aio_co_schedule/aio_co_wake (restart a coroutine that has yielded,
> respectively on a given AioContext or its own original.
>=20
> 3) block jobs and drain.  This is related to (1) because drain can
> terminate jobs and in turn that can cause block graph modifications.
> I'm not even sure it's a separate issue.
>=20
>=20
> Regarding documentation, the include file documentation is good for
> coroutines and block jobs.  But it's bad for block graph modification
> APIs, and even for coroutines + block jobs the docs/devel documentation
> could be improved *and* it's ugly that we're not generating anything
> readable from include file documentation, to go with docs/devel.

We still need to be careful about block job completion code that runs in
the main loop, too.  That has been a source of several bugs.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHrUnAAoJEJykq7OBq3PIL/oH/j7tg2tQrjFNdB0ICCJDUQzA
JOD+Wn+Xxxl9luG9ugV+z/TFMpkfMayjAMPcuLQhodzPEBAe8de4jTMFCW4mRUsx
qYQ/N8XKN4uEGvwTJmhTlFENxYyr4cbeUwDqj/kg6SgEVj32+hQIBsEPezrHpaij
Reg3VUtx8d+UEmNnq5UEPfcxT4cvzGVJ1KrN0lwuMp+8T7Zm9yecrS2xsoVrL3jH
TsbdvqCrHKfl9p9dBQvTtr37oOf0YcTW1NG2M63VsRq4ctlwAr6sJhLfcAqdRZ9T
+nfkyPoZ7eIhCEfOLA4re2meXw96Hb4GqC/KUfR6JApnwAcP4pHAWVNKDPNyPtI=
=+kmk
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
