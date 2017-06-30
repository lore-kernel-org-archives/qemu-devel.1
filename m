Received: from eggs.gnu.org ([2001:4830:134:3::10]:43249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQl9x-0002py-V7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQl9w-0007Iu-Iq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:55:49 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
Date: Thu, 29 Jun 2017 20:55:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4JbDtqFfmnPJD5Htac8LFx12eWKhTBRJv"
Subject: Re: [Qemu-devel] [PATCH v22 06/30] block/dirty-bitmap: add
 deserialize_ones func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4JbDtqFfmnPJD5Htac8LFx12eWKhTBRJv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
Subject: Re: [PATCH v22 06/30] block/dirty-bitmap: add deserialize_ones func
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add bdrv_dirty_bitmap_deserialize_ones() function, which is needed for
> qcow2 bitmap loading, to handle unallocated bitmap parts, marked as
> all-ones.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c         |  7 +++++++
>  include/block/dirty-bitmap.h |  3 +++
>  include/qemu/hbitmap.h       | 15 +++++++++++++++
>  util/hbitmap.c               | 17 +++++++++++++++++
>  4 files changed, 42 insertions(+)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index df0110cf9f..f502c45a70 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -586,6 +586,13 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirt=
yBitmap *bitmap,
>      hbitmap_deserialize_zeroes(bitmap->bitmap, start, count, finish);
>  }
> =20
> +void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
> +                                        uint64_t start, uint64_t count=
,
> +                                        bool finish)
> +{
> +    hbitmap_deserialize_ones(bitmap->bitmap, start, count, finish);
> +}

What unit is 'count' in?

/me reads the code, finding serialization_chunk()

Oh, it's in terms of the underlying bitmap->bitmap->granularity
(currently the number of sectors).  Eww - I'd rather we name the
parameter 'bytes' rather than 'count', and then scale it appropriately
when passing to the underlying bitmap->bitmap, rather than making the
user guess what scale to use.

But as you are just copying from the existing deserialize_zeroes right
above, I'd rather keep the semantics the same between the two, so my
series will take care of fixing that up, and your series can go in as-is
for this patch.

> +++ b/include/qemu/hbitmap.h
> @@ -229,6 +229,21 @@ void hbitmap_deserialize_zeroes(HBitmap *hb, uint6=
4_t start, uint64_t count,
>                                  bool finish);
> =20
>  /**
> + * hbitmap_deserialize_ones
> + * @hb: HBitmap to operate on.
> + * @start: First bit to restore.
> + * @count: Number of bits to restore.

This part is accurate (the dirty-bitmap is using an underlying bitmap
with "one bit per sector" before my series, afterwards it will be "one
bit per byte", remembering that hbitmap really stores only one bit per
granularity multiple of the underlying unit), if incomplete (the code
asserts that things are aligned, but doesn't document that the caller
must pass in aligned values); but again, that's matching the
pre-existing deserialize_zeroes code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4JbDtqFfmnPJD5Htac8LFx12eWKhTBRJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVa+TAAoJEKeha0olJ0NqBcAH/0P6vp65ucc8UUefCydAAO7k
Gyd77JF9L1IXFkb6ktjZFAwIrhXT47NsfY8bjLrZkDNYMClo9xpCYzHPKOI+6a6x
LBA96f/Ye2SZzMwoaNhvhib+QNGvfZAz08kK7wzqGqW5J3DPUtteoBX0x66gKm5R
6022PHHdvKFyuJQAULZ7BQeEYdhQOQNpTr/sUnZUzXGyMyzWFPYBMHnVnQRyMdTe
y0eWxEUvBUAxyaFbsiuXOfJD6TnfOp3slMJms24ntB2NIff6+LDeqTcr9/6x2oIh
cupKtM1vB1dRHc2UGYmXu8gd3UYnH59HCMho/EZleFgBnJ4dcUNL8TA/7O99GpA=
=78wY
-----END PGP SIGNATURE-----

--4JbDtqFfmnPJD5Htac8LFx12eWKhTBRJv--
