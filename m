Received: from eggs.gnu.org ([2001:4830:134:3::10]:38747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwV9s-000145-Sy
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwV9r-0000xe-Ot
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:46:40 -0400
References: <20170407013709.18440-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66d900f0-71ae-532e-c9fc-725647d69b99@redhat.com>
Date: Fri, 7 Apr 2017 16:46:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170407013709.18440-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qNjsiVtbpEnWxFnB7KBkKlS8liSiKXldP"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] qcow2: Allow discard of final
 unaligned cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qNjsiVtbpEnWxFnB7KBkKlS8liSiKXldP
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <66d900f0-71ae-532e-c9fc-725647d69b99@redhat.com>
Subject: Re: [PATCH for-2.9?] qcow2: Allow discard of final unaligned cluster
References: <20170407013709.18440-1-eblake@redhat.com>
In-Reply-To: <20170407013709.18440-1-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 07.04.2017 03:37, Eric Blake wrote:
> As mentioned in commit 0c1bd46, we ignored requests to
> discard the trailing cluster of an unaligned image.  While
> discard is an advisory operation from the guest standpoint,
> (and we are therefore free to ignore any request), our
> qcow2 implementation exploits the fact that a discarded
> cluster reads back as 0.  As long as we discard on cluster
> boundaries, we are fine; but that means we could observe
> non-zero data leaked at the tail of an unaligned image.
>=20
> Enhance iotest 66 to cover this case, and fix the implementation
> to honor a discard request on the final partial cluster.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

Thanks!

> I can't convince myself whether we strongly rely on aligned discards
> to guarantee that we read back zeroes on qcow2

No, we don't.

>                                                (it would be a
> stronger contract than what the block layer requires of pdiscard,
> since the guest cannot guarantee that a discard does anything). If
> we do, then this is a bug fix worthy of 2.9.

I'm not sure it would be, even if we "relied" on it. For instance,
intra-cluster discarding will be silently ignored (in contrast to
intra-cluster zero writes).

(Obviously one might argue that the desired behavior is to read back
zeroes because for compat=3D1.1 images we actually write zero clusters
instead of just completely discarding clusters, but...)

>                                              If we don't, then the
> changes to test 66 rely on internal implementation (but the test is
> already specific to qcow2), and the patch can wait for 2.10.

If you want to write zeroes, use zero writing.

Note that discarding on compat=3D0.10 images will actually really discard=

the clusters instead of creating zero clusters (because those don't
exist in compat=3D0.10). So if you have a backing file, afterwards you'll=

see its contents in the discarded areas.

(I personally actually really like that discard behavior. If I had to
decide, I would like that behavior for compat=3D1.1 images, too, but I
don't, so it reads back as zero there.)

> At any rate, I do know that we don't want to make discard work on
> sub-cluster boundaries anywhere except at the tail of the image
> (that's what write-zeroes is for, and it may be slower when it
> has to do COW or read-modify-write).  Any reliance that we (might)
> have on whole-cluster discards reading back as 0 is also relying
> on using aligned operations.

No, we don't, because discard doesn't give you guarantees about what
kind of data you'll read back.

Therefore: Applied to my block-next branch for 2.10:

https://github.com/XanClic/qemu/commits/block-next

Max


--qNjsiVtbpEnWxFnB7KBkKlS8liSiKXldP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljnpkUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQbcH/0utasi8ptR6FMjdEjIOc2f3XNXGhGIG
rP8OknbQlcYgynOulhhRh6uztvRuinKUSW6bbuGj8XVZ7pPBJd8EPjUjRlkvn4k6
rfChhCCpGlkIwY4CdDFLy6HOpIqhLWuXojyigpWELui2pW/pWxslB3ArKN6lXsMG
342q462FSHHnEz44p+hnqpYSicxvfDm++E3x/q8xusrdto59M11qhxSgv/wyNkki
F299+02BlxFn0+OQa+ntS4ymk1M1BzvnqyhyeiIuvcsP9yd3Iq/n1Afibr+XkCMk
CGrBaXWN/0soVKNCkg0WHJjGZ1Eiwv+1ex/h736UziuW8bmCUhXqKyo=
=0ik1
-----END PGP SIGNATURE-----

--qNjsiVtbpEnWxFnB7KBkKlS8liSiKXldP--
