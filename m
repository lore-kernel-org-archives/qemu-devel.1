Received: from eggs.gnu.org ([2001:4830:134:3::10]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1a2v-0008W3-QP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1a2u-0004dh-G1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:05:01 -0400
References: <20180329120745.11154-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d129f458-63bb-e63a-306f-7f4dbe482a8e@redhat.com>
Date: Thu, 29 Mar 2018 18:04:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180329120745.11154-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oghc2drzSYhd7m8zsesz1igOaxVNXzfpt"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v5] iotests: Test abnormally large
 size in compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oghc2drzSYhd7m8zsesz1igOaxVNXzfpt
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <d129f458-63bb-e63a-306f-7f4dbe482a8e@redhat.com>
Subject: Re: [PATCH for-2.12 v5] iotests: Test abnormally large size in
 compressed cluster descriptor
References: <20180329120745.11154-1-berto@igalia.com>
In-Reply-To: <20180329120745.11154-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-29 14:07, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
>=20
> That's however not the size of the compressed data itself, just the
> number of sectors where that data is located. The actual data size is
> usually not a multiple of the sector size, and therefore cannot be
> represented with this field.
>=20
> The way it works is that QEMU reads all the specified sectors and
> starts decompressing the data until there's enough to recover the
> original uncompressed cluster. If there are any bytes left that
> haven't been decompressed they are simply ignored.
>=20
> One consequence of this is that even if the size field is larger than
> it needs to be QEMU can handle it just fine: it will read more data
> from disk but it will ignore the extra bytes.
>=20
> This test creates an image with two compressed clusters that use 5
> sectors (2.5 KB) each, increases the size field to the maximum (8192
> sectors, or 4 MB) and verifies that the data can be read without
> problems.
>=20
> This test is important because while the decompressed data takes
> exactly one cluster, the maximum value allowed in the compressed size
> field is twice the cluster size. So although QEMU won't produce images
> with such large values we need to make sure that it can handle them.
>=20
> Another effect of increasing the size field is that it can make
> it include data from the following host cluster(s). In this case
> 'qemu-img check' will detect that the refcounts are not correct, and
> we'll need to rebuild them.
>=20
> Additionally, this patch also tests that decreasing the size corrupts
> the image since the original data can no longer be recovered. In this
> case QEMU returns an error when trying to read the compressed data,
> but 'qemu-img check' doesn't see anything wrong if the refcounts are
> consistent.
>=20
> One possible task for the future is to make 'qemu-img check' verify
> the sizes of the compressed clusters, by trying to decompress the data
> and checking that the size stored in the L2 entry is correct.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> v5: Use 'write -c' instead of 'write' followed by 'convert' [Max]
>     Add TODO comment explaining that the size of compressed clusters
>     should also be corrected when it's too large in order to avoid
>     referencing other unrelated clusters.
>=20
> v4: Resend for 2.12
>=20
> v3: Add TODO comment, as suggested by Eric.
>=20
>     Corrupt the length of the second compressed cluster as well so the
>     uncompressed data would span three host clusters.
>=20
> v2: We now have two scenarios where we make QEMU read data from the
>     next host cluster and from beyond the end of the image. This
>     version also runs qemu-img check on the corrupted image.
>=20
>     If the size field is too small, reading fails but qemu-img check
>     succeeds.
>=20
>     If the size field is too large, reading succeeds but qemu-img
>     check fails (this can be repaired, though).
> ---
>  tests/qemu-iotests/122     | 47 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/122.out | 33 ++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

Now without any convert I have no idea what this test case is doing in
122, but, oh well.  Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--oghc2drzSYhd7m8zsesz1igOaxVNXzfpt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq9DpoACgkQ9AfbAGHV
z0BN3wf/VubT/MuU6//NJjfn1MdJP9jFL4v0SooQrN39vwQu1BDMmnM9NwRyR9UV
GcNcMRKZUxhJfVF7rpYcpllfI0RPX5bTDNXJGYCsG3MVk38HKbLSWaI3yYoUbhEg
m+PBEftcH+wxZ2vzqxG9sC0S2VB/DUtZk6aq/j/SQKXlu1ExraX2LN5D7EeAHT99
Jig4/pg2vOwNrdwE8CwTInVs+hm5ds3KeV/GdupsnxMSrNtzWs8LKu8uFbeJ47K0
KGTpJ7waghnexi03XAHwsPnbIUCl7AQh9A6wxi12A2pe4H7kuivxHNOpl1tWbAre
yPViRm3CFKBABi3E14qPfL7nT/NSrA==
=hsQp
-----END PGP SIGNATURE-----

--oghc2drzSYhd7m8zsesz1igOaxVNXzfpt--
