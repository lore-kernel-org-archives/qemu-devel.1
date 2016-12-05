Received: from eggs.gnu.org ([2001:4830:134:3::10]:44435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDvQr-0002eb-TZ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDvQq-0003Ls-VF
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:43:57 -0500
References: <20161203173402.12537-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08ed9fee-e8fe-5c9e-f0f6-d203c870b105@redhat.com>
Date: Mon, 5 Dec 2016 09:43:44 -0600
MIME-Version: 1.0
In-Reply-To: <20161203173402.12537-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0eTcETSqOcl69mCJallfu5fGi7GA3B9IR"
Subject: Re: [Qemu-devel] [PATCH for-2.8] qcow2: Don't strand clusters near
 2G intervals during commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0eTcETSqOcl69mCJallfu5fGi7GA3B9IR
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <08ed9fee-e8fe-5c9e-f0f6-d203c870b105@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qcow2: Don't strand clusters near 2G
 intervals during commit
References: <20161203173402.12537-1-eblake@redhat.com>
In-Reply-To: <20161203173402.12537-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2016 11:34 AM, Eric Blake wrote:
> The qcow2_make_empty() function is reached during 'qemu-img commit',
> in order to clear out ALL clusters of an image.  However, if the
> image cannot use the fast code path (true if the image is format
> 0.10, or if the image contains a snapshot), the cluster size is
> larger than 512, and the image is larger than 2G in size, then our
> choice of sector_step causes problems.  Since it is not cluster
> aligned, but qcow2_discard_clusters() silently ignores an unaligned
> head or tail, we are leaving clusters allocated.
>=20
> Enhance the testsuite to expose the flaw, and patch the problem by
> ensuring our step size is aligned.
>=20
> [qcow2_discard_clusters() is a GROSS interface: it takes a mix of
> byte offset and sector count to perform cluster operations. But
> fixing it to use a saner byte/byte rather than byte/sector interface,
> and/or asserting that the counts are now aligned thanks to both
> this patch and commit 3482b9b, is material for another day.]
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c              |   3 +-
>  tests/qemu-iotests/097     |  41 +++++---
>  tests/qemu-iotests/097.out | 249 +++++++++++++++++++++++++++++++++----=
--------
>  3 files changed, 210 insertions(+), 83 deletions(-)

> +++ b/block/qcow2.c
> @@ -2808,7 +2808,8 @@ static int qcow2_make_empty(BlockDriverState *bs)=

>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t start_sector;
> -    int sector_step =3D INT_MAX / BDRV_SECTOR_SIZE;
> +    int sector_step =3D QEMU_ALIGN_DOWN(INT_MAX / BDRV_SECTOR_SIZE,
> +                                      s->cluster_size);

Oh shoot. I got the units wrong, and made the slow path do more loop
iterations than necessary (rounding sectors to cluster size in bytes is
inappropriate - either the rounding has to occur before division, or the
rounding needs to be by secotrs instead of bytes).  I'll send a v2 that
gets the math right.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0eTcETSqOcl69mCJallfu5fGi7GA3B9IR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRYswAAoJEKeha0olJ0NqqugH/1jz7u4rt9B9SBrEf5gavLlm
hK2y65qhccwnxw20g1h6bwdKyVOb95cSgFgwvhAULjQjMqgLdVAx7OwqMLMkM90P
16gSbP9FE1Dax9Fg2zDtoa5Kani8lDv5GyVM/qf+GtRtwGPbjEeBoyKtR0zXxDJY
67MJ3f5Di/d0Ea7SJpIRNVqY1QI/+k6oGaKFzna1g7bru9aKZnbDTostCrXaNgaK
ql+lPqmdjSPDn/ouqIjrueyWYjlXpVM5RdrrF3VLABbSMOSRNn31s0dkbMj/jhen
4JYsmQ06mNfsvq6n6GSdQQWYhAYlXP2MTZTUk0TgKXRo3qFd3yUw4ZSNYwIh+ag=
=wuTe
-----END PGP SIGNATURE-----

--0eTcETSqOcl69mCJallfu5fGi7GA3B9IR--
