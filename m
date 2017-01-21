Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1oO-0004BV-Hc
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1oN-0002Z3-Q2
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:58:56 -0500
References: <1484843730-23848-1-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a9fa5294-acbe-a034-febb-a149dfe320f8@redhat.com>
Date: Sat, 21 Jan 2017 20:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <1484843730-23848-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="upArhxpTnXG7iwXi4h1rQ3jlF3nafb7gw"
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: optimize
 is_allocated_sectors_min
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--upArhxpTnXG7iwXi4h1rQ3jlF3nafb7gw
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a9fa5294-acbe-a034-febb-a149dfe320f8@redhat.com>
Subject: Re: [PATCH V2] qemu-img: optimize is_allocated_sectors_min
References: <1484843730-23848-1-git-send-email-pl@kamp.de>
In-Reply-To: <1484843730-23848-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 19.01.2017 17:35, Peter Lieven wrote:
> the current implementation always splits requests if a buffer
> begins or ends with zeroes independent of the length of the
> zero area. Change this to really only split off zero areas
> that have at least a length of 'min' bytes.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)

That is because the idea is that you should delay the write operation as
much as possible. Say you have some empty space at the beginning of the
buffer and then some used space. Of course you should then only start
writing at the point where you actually have to write something. The
same goes for the end of the buffer. Why write zeroes when you can just
not do it?

On the other hand, it makes sense to not split a single write operation
into two just because there is some empty space in the middle. This is
because just writing that empty space may take less time than issuing
two operations, especially if that empty space is e.g. in the middle of
a qcow2 cluster anyway.

This is why empty space in the middle is treated differently than empty
space at the beginning or the end of the buffer.

Do you have a reason for changing this other than because it simplifies
the code? Which it does, admittedly, but I think the code does have a
reason for being how it is.

Max


--upArhxpTnXG7iwXi4h1rQ3jlF3nafb7gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDvXYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYAcH/2j2Z7/3qHeRhIDEZv3bt+dnXzUcPWxX
LzVOIti3DHNRvuRmRljtpL4/H6Shz2SENTnUiV1hXmlxue1db9lfhms9h0sxTtSx
NzMqmIjFmnr7gkUoq1D6qLC8Ii3hQbTYQFDmhsvi3/s6mpadsBPdzjX3htpf3Hr9
+/MmksRjsgEKfMT8j4iWtwM3BKwvKw+hKpla9YMotN2prMXtd74KNXLZXKeJUXkb
KHulIZHBwqY5JcigU32ZTI22ABT3v/eWQfxoWtRhiQPxUagEZdV1OVQehuRgcBUX
09HD7txQsrm0Houoew57tpY3HagRgT3oSsIhzmhmNmWIHNpGeuGlLio=
=gzFS
-----END PGP SIGNATURE-----

--upArhxpTnXG7iwXi4h1rQ3jlF3nafb7gw--
