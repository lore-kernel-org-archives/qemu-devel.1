Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccjYQ-0005VJ-2t
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccjYO-0004ej-Ns
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:06:18 -0500
References: <1486051604-32310-1-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
Date: Sun, 12 Feb 2017 03:06:05 +0100
MIME-Version: 1.0
In-Reply-To: <1486051604-32310-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2gOTXcbH03Q1eaORGa9qMFgvwvALmrlw9"
Subject: Re: [Qemu-devel] [RFC][PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2gOTXcbH03Q1eaORGa9qMFgvwvALmrlw9
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
Subject: Re: [RFC][PATCH] qemu-img: make convert async
References: <1486051604-32310-1-git-send-email-pl@kamp.de>
In-Reply-To: <1486051604-32310-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.02.2017 17:06, Peter Lieven wrote:
> this is something I have been thinking about for almost 2 years now.
> we heavily have the following two use cases when using qemu-img convert=
=2E
>=20
> a) reading from NFS and writing to iSCSI for deploying templates
> b) reading from iSCSI and writing to NFS for backups
>=20
> In both processes we use libiscsi and libnfs so we have no kernel pagec=
ache.
> As qemu-img convert is implemented with sync operations that means we
> read one buffer and then write it. No parallelism and each sync request=

> takes as long as it takes until it is completed.
>=20
> What I put together is an approach to use aio routines for the conversi=
on
> process to have ideally read and write happening in parallel.
>=20
> The code is far from clean or complete, but I would appreaciate comment=
s
> and thoughts from you.
>=20
> So far I have the following runtimes when reading an uncompressed QCOW2=
 from
> NFS and writing it to iSCSI (raw):
>=20
> qemu-img (master)
>  nfs -> iscsi 33 secs
>  nfs -> ram   19 secs
>  ram -> iscsi 14 secs
>=20
> qemu-img-async
>  nfs -> iscsi 23 secs
>  nfs -> ram   17 secs
>  ram -> iscsi 14 secs
>=20
> Its visible that on master the runtimes add up as expected. The async b=
ranch
> is faster, but not as fast as I would have expected. I would expect the=
 runtime
> to be as slow as the slowest of the two involved transfers.
>=20
> Thank you,
> Peter
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 271 +++++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 199 insertions(+), 72 deletions(-)

Asynchronous convert sounds good. But your implementation looks a bit
weird to me.

Your implementation has four "slots" which receive work from a central
work queue that they then process. You can do that, but it looks
counter-intuitive to me. (Or if you do that, I would do it using
coroutines: Start up four coroutines that simply submit blk_co_* requests=
=2E)

What I would have done (if using AIO) is the following: Seek through the
image, finding the next bit of work to do (without having a central work
queue). Then submit an AIO request with a newly allocated piece of data
(not using fixed slots). Continue until four requests are in flight,
then wait until one is settled.

I think this would simplify the design. Also, it's basically what the
mirror block job does.

Which brings me to a totally different point: At some point we intended
to convert as many qemu-img functions to block jobs as possible.
Unfortunately, we only ever did one and that's commit. If we were to
convert convert to mirror, then we'd get async for free.

But the effort of converting convert to mirror is probably much larger
than adding async to convert...

Max


--2gOTXcbH03Q1eaORGa9qMFgvwvALmrlw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifww0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABzsIAKIH13f7iyuaG+AhAw3qIOD30z8eGcie
R6rTMxxH/Mpd4JoxsSDefhUZcZr3aM3EtXh+2erznUHYrzbWOQXJpLic6bGvXBxy
WjQY3SHPdwKVQCaxhXSjMSAEYqFR3YEj87P4W2qB1SoajjhAh70cTxhJiczrsIEr
0rm/rbu3xWR3lHlc9zSYjRCaNtXpSDVAo7XgdGObO6qRkxera7rzNqvWHtSdBDLf
UdaWQbQp22pJDQvoxn4XQlWCTCo9SrjL6oidLjUbv/7FyGt6A9VdsrbkkKoNTC5c
PvMIdNYSUz1rUhdfhdd7GbvaQg1q2hKEskomlHWhWXytFVVjbK8ZRm0=
=h0Oa
-----END PGP SIGNATURE-----

--2gOTXcbH03Q1eaORGa9qMFgvwvALmrlw9--
