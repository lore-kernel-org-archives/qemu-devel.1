Received: from eggs.gnu.org ([2001:4830:134:3::10]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eK1Ht-0004NM-6r
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eK1Hs-0005Wk-20
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:16:25 -0500
Date: Wed, 29 Nov 2017 12:16:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171129121611.GC2601@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129063006.GD18521@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20171129063006.GD18521@localhost.localdomain>
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
To: Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 01:30:06AM -0500, Jeff Cody wrote:
> On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> > Hi all,
> >=20
> > As we move forwards with new features in the block layer, the chances o=
f tricky
> > bugs happening have been increasing alongside - block jobs, coroutines,
> > throttling, AioContext, op blockers and image locking combined together=
 make a
> > large and complex picture that is hard to fully understand and work wit=
h. Some
> > bugs we've encountered are quite challenging already.  Examples are:
> >=20
> > - segfault in parallel blockjobs (iotest 30)
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html
> >=20
> > - Intermittent hang of iotest 194 (bdrv_drain_all after non-shared stor=
age
> >   migration)
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01626.html
> >=20
> > - Drainage in bdrv_replace_child_noperm()
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00868.html
> >=20
> > - Regression from 2.8: stuck in bdrv_drain()
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02193.html
> >=20
>=20
> I agree, it seems the complexity is growing by quite a bit.
>=20
> > So in principle, what should we do to make the block layer easy to unde=
rstand,
> > develop with and debug? I think we have opportunities in these aspects:
> >=20
> > - Documentation
> >=20
> >   There is no central developer doc about block layer, especially how a=
ll pieces
> >   fit together. Having one will make it a lot easier for new contributo=
rs to
> >   understand better. Of course, we're facing the old problem: the code =
is
> >   moving, maintaining an updated document needs effort.
> >=20
> >   Idea: add ./doc/deve/block.txt?
> >=20
>=20
> There are some bits of brilliance in what is already there; for instance,
> devel/atomics.txt is very thorough.  But I agree that a major piece missi=
ng
> is an overall design document, that provides the "why" to the "what".

While the atomics documentation is good, atomics themselves have been a
source of difficult bugs.

They should be used as little as possible and only where they can be
encapsulated in a composable abstraction (i.e. don't expect users of
your abstraction to understand atomics).

Why?  They are damn hard to use.  None of us is capable of using them
without introducing difficult bugs.

There is also a temptation to rely on implicit effects of other code
(e.g. when you know there is a barrier in another function) for best
performance.  That's a bad property for code to have because it becomes
hard to change safely.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHqULAAoJEJykq7OBq3PIossIALjZjYr62hz9wvhCxa5Bcb0Y
MYsi8uA8++uj3YXDN5K25Gl7yW2LElqHT5kFh0/FZhEwplFMlP1L11M6HgdzxzWg
tfTe9OmRE9HbjfYz6TFEWyfEH8B8497My1RcRiZ51RwWTA6cLO/GdXJqDxJJp4ZI
VDgjhQpHXLJloTzzSIiwpjrczi/PzJwj+5ToVewPIgNTdEkOeNdxmumEnNmqJpLF
FFApXgE3K3W+rDUhd71I4dtgxTgHnsRsf7Hb+I4URlN7hC9QHmRmrY5TvMSbfBKP
NDEquhNnmcxY0Dzw+SuXkAK69Qswsa20/I39/CZ48epjE/+5LZ7a4GzfO352ing=
=lfOU
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
