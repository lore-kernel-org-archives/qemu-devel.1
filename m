Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOL8R-0002i8-Ji
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOL8M-0004z0-LZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:16:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOL8M-0004yS-FA
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:16:26 -0500
Date: Mon, 11 Dec 2017 10:16:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171211101620.GB13593@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
	<20171208153010.GD8998@stefanha-x1.localdomain>
	<43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 06:56:12PM +0100, Paolo Bonzini wrote:
> On 08/12/2017 16:30, Stefan Hajnoczi wrote:
> > On Fri, Dec 08, 2017 at 11:55:50AM +0100, Paolo Bonzini wrote:
> >=20
> > The implementation is somewhat complex.  Please structure the header
> > file so the public interfaces are clear and documented.  Move the
> > implementation out of the way and mark it private.  That will make it
> > easier for someone to figure out "how do I use lock-guard.h".
>=20
> Right, unfortunately you pretty much have to place it in the header to
> guarantee that everything is inlined.

Yes, that's fine.  I think the important part is to put public
interfaces next to each other and document them.

> >> +#define QEMU_WITH_LOCK(type, name, lock)                             =
      \
> >> +    for (QEMU_LOCK_GUARD(type, name, lock);                          =
      \
> >> +         qemu_lock_guard_is_taken(&name);                            =
      \
> >> +         qemu_lock_guard_unlock(&name))
> >=20
> > I don't understand the need for the qemu_lock_guard_is_taken(&name)
> > condition, why not do the following?
> >=20
> >   for (QEMU_LOCK_GUARD(type, name, lock);
> >        ;
> >        qemu_lock_guard_unlock(&name))
>=20
> Because that would be an infinite loop. :)

Sorry, I mean for (...; false; ...).  Is there any reason to do
qemu_lock_guard_is_taken(&name)?

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLlr0AAoJEJykq7OBq3PIN64IAJ6ou2Jo5wC3lLb88s3eRQCL
+mQ4/Gy1q1M0fg7vnFRixAFIlbfqWTlKLpvD+0XyOKVcqBtqfqDpIbGykmbmH2vu
FdR4rp3pon936qzAmY+n9Tx64uDCZFJfc/9pkXvv+FiG5mF+rQkObxGGH3FoP7br
6EGvRQV/+4GtSyPq8W2lNNmo/7o0afTtUQFBPMxAwm1tWKJaBnU/0UD6dKz6y3CN
dqFyJcAOpj+pd/bkl2iGrTBQjyOoOifTALZYcuR1uW/QC50e3t5sUr5hkP316l05
vDXDOT/K5yfSL1wGu7Ilx8lsO+TJ83TjzOgX3ktqOA/G7jU6BeH62nFzekCMWHg=
=9Xfc
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
