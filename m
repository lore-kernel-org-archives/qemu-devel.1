Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df416-0006gg-OY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df411-0007xU-NB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:53:48 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df411-0007wq-Go
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:53:43 -0400
Received: by mail-wm0-x232.google.com with SMTP id m85so6474999wma.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:53:43 -0700 (PDT)
Date: Tue, 8 Aug 2017 13:53:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808125337.GO16801@stefanha-x1.localdomain>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qa0ccP92Gc0Ko3P8"
Content-Disposition: inline
In-Reply-To: <9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Prasad Pandit <ppandit@redhat.com>


--Qa0ccP92Gc0Ko3P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 01:46:17PM +0200, Paolo Bonzini wrote:
> On 04/08/2017 11:58, Stefan Hajnoczi wrote:
> >> the root cause of this bug is related to this as well:
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
> >>
> >> From commit 99723548 we started assuming (incorrectly?) that blk_
> >> functions always WILL have an attached BDS, but this is not always tru=
e,
> >> for instance, flushing the cache from an empty CDROM.
> >>
> >> Paolo, can we move the flight counter increment outside of the
> >> block-backend layer, is that safe?
> > I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
> > regardless of the throttling timer issue discussed below.  BB cannot
> > assume that the BDS graph is non-empty.
>=20
> Can we make bdrv_aio_* return NULL (even temporarily) if there is no
> attached BDS?  That would make it much easier to fix.

There are many blk_aio_*() callers.  Returning NULL forces them to
perform extra error handling.

When you say "temporarily" do you mean it returns NULL but schedules a
one-shot BH to invoke the callback?  I wonder if we can use a singleton
aiocb instead of NULL for -ENOMEDIUM errors.

Stefan

--Qa0ccP92Gc0Ko3P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZibRRAAoJEJykq7OBq3PIvGcH/1a45MioeYWuEYpoKz2s0zLd
FPqb4TxNNKS1H21SP33tYmfAaBnCkZpYDkdlAI2hnd8DevgY8uXosS9AXKDCjeiM
yrmpHOe+EjTtJdCax2dmIOjiTMa+nR8MczpF0BOhKGKm6UVw3+wLi14zwF2tzn35
zCopLJE/bkFsqyNwwdKyAuUaJh1eeEU5+DRjJk3iM4ZqkMaEZb8JyaidYyfQU8Ay
AVC6LUEmb90uSFtvA6t7j9LLawZZ7/1rHrRgjZ6/MkoSr5qxW44w6qmZFXhEAxU0
xJkT06237ycxD94CrNH0/KoKssgi+MueFsDIf1Af4jBXtOKrgV+VZfT1C99Pf3M=
=dyuG
-----END PGP SIGNATURE-----

--Qa0ccP92Gc0Ko3P8--
