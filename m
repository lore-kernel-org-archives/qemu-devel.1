Received: from eggs.gnu.org ([209.51.188.92]:43427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvsJx-00047s-I5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvs6E-00038s-JZ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:13:24 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
Date: Tue, 19 Feb 2019 00:13:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rzRzRyyvvTY0IelUB9srbk0eLr3UrVmpD"
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] qcow2: Don't assume 0 is an
 invalid cluster offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rzRzRyyvvTY0IelUB9srbk0eLr3UrVmpD
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
Subject: Re: [RFC PATCH 06/11] qcow2: Don't assume 0 is an invalid cluster
 offset
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-7-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> The cluster allocation code uses 0 as an invalid offset that is used in=

> case of errors or as "offset not yet determined". With external data
> files, a host cluster offset of 0 becomes valid, though.
>=20
> Define a constant INV_OFFSET (which is not cluster aligned and will
> therefore never be a valid offset) that can be used for such purposes.
>=20
> This removes the additional host_offset =3D=3D 0 check that commit
> ff52aab2df5 introduced; the confusion between an invalid offset and
> (erroneous) allocation at offset 0 is removed with this change.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.h         |  2 ++
>  block/qcow2-cluster.c | 59 ++++++++++++++++++++-----------------------=

>  2 files changed, 29 insertions(+), 32 deletions(-)

qcow2_get_cluster_offset() still returns 0 for unallocated clusters.
(And qcow2_co_block_status() tests for that, so it would never report a
valid offset for the first cluster in an externally allocated qcow2 file.=
)

qcow2_alloc_compressed_cluster_offset() should return INV_OFFSET on
error (yeah, there are no compressed clusters in external files, but
this seems like the right thing to do still).

(And there are cases like qcow2_co_preadv(), where cluster_offset is
initialized to 0 -- it doesn't make a difference what it's initialized
to (it's just to silence the compiler, I suppose), but it should still
use this new constant now.  I think.)

Now bikeshedding begins: Also, s->free_byte_offset is initialized to 0
and that is the expected value for "nothing allocated yet".  I think I'd
prefer all of the qocw2 code to use a common invalidity constant, even
thought it would make things like that more complicated.  But then we
might get into the metadata territory (how bad is it that
s->bitmap_directory_offset too is 0 when there is no directory?),
because compressed clusters are not allowed in external files, just like
metadata is not...
So my bikeshedding result is "I think it would be nice if all of the
qcow2 code made use of this constant, but it may also be pretty stupid
to enforce that now."

Max


--rzRzRyyvvTY0IelUB9srbk0eLr3UrVmpD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrPAkACgkQ9AfbAGHV
z0DydQf/ZEB2AoJYG35qqmCixLXBXi1Ah+cYgn9SgYXpY/jWi5MwTtnhkeSfNLJb
gjnf3T/2uFEcuzNSslU/zi+wvEPgd+jnrLgwkj/fSso9lEbXR0aEoVLR2W7211m9
bZg4JJhkGnQbmolcVKxho39qMDYcWvSSZxL9vOMvkbpZ44P8rduZ5Ptnq3ZHyCS2
1dpNFJ0NO3cnm8fbWn8hoHn0NJt+acjEzgpjeLtsTcDlLR2YiDI6382HlUFCxyOp
/GGYS71YEsCgHqyY0LTxEKwkvpBSxM1g0ZIrCQ06ZlsLeXU/y9fBxc4QcT6NDxWk
SY01sTES9K1akEnfsT8qbfIDnJ3XEw==
=tm7w
-----END PGP SIGNATURE-----

--rzRzRyyvvTY0IelUB9srbk0eLr3UrVmpD--
