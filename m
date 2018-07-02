Received: from eggs.gnu.org ([2001:4830:134:3::10]:46374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZzIL-0000f5-3C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZzII-00061B-2W
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:55:09 -0400
Date: Mon, 2 Jul 2018 14:55:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702135502.GH2155@stefanha-x1.localdomain>
References: <CAFLvi203QwYCdfdhq6pb855xOZbt-bOiMsYU3cDSx6itHeu2=w@mail.gmail.com>
	<ceff4595-026d-ae13-5628-042cf043d0ac@redhat.com>
	<007fb94d-5a04-0ee1-5d1b-6fd41e67c9a4@redhat.com>
	<20180629203528.GM15588@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline
In-Reply-To: <20180629203528.GM15588@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [BUG] qed_aio_write_alloc: Assertion
 `s->allocating_acb == NULL' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Quytelda Kahja <quytelda@tamalin.org>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 10:35:28PM +0200, Kevin Wolf wrote:
> Am 29.06.2018 um 22:16 hat Eric Blake geschrieben:
> > On 06/29/2018 03:07 PM, John Snow wrote:
> > > CC Qemu Block; looks like QED is a bit busted.
> > >=20
> > > On 06/27/2018 10:25 AM, Quytelda Kahja wrote:
> > > > Hello all,
> > > > I wanted to submit a bug report in the tracker, but it seem to requ=
ire
> > > > an Ubuntu One account, which I'm having trouble with, so I'll just
> > > > give it here and hopefully somebody can make use of it.  The issue
> > > > seems to be in an experimental format, so it's likely not very
> > > > consequential anyway.
> >=20
> > Analysis in another thread may be relevant:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08963.html
>=20
> The assertion there was:
>=20
> qemu-system-x86_64: block.c:3434: bdrv_replace_node: Assertion `!atomic_r=
ead(&to->in_flight)' failed.
>=20
> Which quite clearly pointed to a drain bug. This one, however, doesn't
> seem to be related to drain, so I think it's probably a different bug.

Maybe there was a CoQueue regression in QEMU 2.10, 2.11, or 2.12.

My own commit c40a2545700e9ad2ef67d5972484bbee4c83b2a6 ("coroutine:
avoid co_queue_wakeup recursion") from QEMU 2.12.0 would be a good place
to start.  I wonder if it fails before this commit.

git-bisect(1) could be used to track down the commit that broken qed,
although bisecting using a BSD installer sounds time-consuming.

Stefan

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOi62AAoJEJykq7OBq3PITH0H/1fDzwsNtGEwkHIU4Bi1E36k
nbbtThRE/yxSC3hkSvn+Px0EPFgn0sKJg2W2uXVBE+qrqWc6+AJTYqMKbDxNnMbZ
vzBZ14iMO37D6ApNunrstOfvDNHKXG0Gd+AZMIkbuVQkXFIHPVXJod/OnucExgdb
6FtrfKEKbJa6sZ0Kxdl7n8AFoYLuxH1/xN9WqRWg24mnH8LvIhgt2SDtME1IIvTy
H/UdSr2+V5I5ldj9ZNbxtEBR1zHjKKRbxz7KvM0jT9LqRFFRyE1LKTU693+AhIL4
3C8JtAnQ4E6rDHwZJAfoWHdEWfqN0vLRVkOHXX8pcfzfKsESdZ3AcsK0qZ8cUx8=
=dtGg
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--
