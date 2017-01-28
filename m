Received: from eggs.gnu.org ([2001:4830:134:3::10]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZVS-0008GV-7E
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZVN-0005uX-87
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:21:54 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
Date: Sat, 28 Jan 2017 21:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1GNA92UNsBlBnxKRqGSOqWrpujLKKN3jC"
Subject: Re: [Qemu-devel] [PATCH v4 2/7] qcow2: Discard/zero clusters by
 byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GNA92UNsBlBnxKRqGSOqWrpujLKKN3jC
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
Subject: Re: [PATCH v4 2/7] qcow2: Discard/zero clusters by byte count
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-3-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-3-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
> Passing a byte offset, but sector count, when we ultimately
> want to operate on cluster granularity, is madness.  Clean up
> the interfaces to take both offset and count as bytes, while
> still keeping the assertion added previously that the caller
> must align the values to a cluster.  Then rename things to
> make sure backports don't get confused by changed units:
> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
> we now have qcow2_cluster_discard and qcow2_cluster_zeroize().
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: improve function names, split assertion additions into earlier patc=
h
> [no v3 or v2]
> v1: https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00339.html=

> ---
>  block/qcow2.h          |  9 +++++----
>  block/qcow2-cluster.c  | 17 ++++++++---------
>  block/qcow2-snapshot.c |  7 +++----
>  block/qcow2.c          | 21 +++++++++------------
>  4 files changed, 25 insertions(+), 29 deletions(-)

Nothing functionally bad, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


Some notes, though:

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1823414..a131b72 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -543,10 +543,11 @@ uint64_t qcow2_alloc_compressed_cluster_offset(Bl=
ockDriverState *bs,
>                                           int compressed_size);
>=20
>  int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard);
> -int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_=
sectors,
> -                        int flags);
> +int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t count, enum qcow2_discard_type type=
,
> +                          bool full_discard);
> +int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t count, int flags);

I know byte count parameters are often called "count", but I find it a
bit problematic if the function name contains a word that can be a unit.
In these cases, it's not entirely clear whether "count" refers to bytes
or clusters. Maybe "length" or "size" would be better?

Purely subjective and thus optional, of course.

Another thing: I'm not quite positive whether qcow2_cluster_zeroize()
can actually handle a byte count greater than INT_MAX. If you could pass
such a number to it, the multiplication "ret * s->cluster_size" might
overflow. It's only caller qcow2_co_pwrite_zeroes() will never exceed
that limit, but maybe this should be made clear somewhere -- either by
making the parameter an int instead of a uint64_t or by asserting it in
the function.

>=20
>  int qcow2_expand_zero_clusters(BlockDriverState *bs,
>                                 BlockDriverAmendStatusCB *status_cb,
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 3304a15..aad5183 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1511,16 +1511,15 @@ static int discard_single_l2(BlockDriverState *=
bs, uint64_t offset,
>      return nb_clusters;
>  }
>=20
> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
> +int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t count, enum qcow2_discard_type type=
,
> +                          bool full_discard)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    uint64_t end_offset;
> +    uint64_t end_offset =3D offset + count;
>      uint64_t nb_clusters;
>      int ret;
>=20
> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
> -
>      /* Caller must pass aligned values */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));

Directly below this we have "offset - end_offset" which could be
shortened to "count" (or "length" or "size" or...).

Max


--1GNA92UNsBlBnxKRqGSOqWrpujLKKN3jC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliM/UYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeRAIAKKs06lgcE2uvANz9L5LWJYrZoyJsZHj
e4EQhuRfkCFCnONT1QJcne4f8yUlDlKVnqGGwVMXIGRRdbquInB6n5LGR/ALMuqb
e/I7YLPyfXT9ZDvMfLP4NvptlY14aNqYmU9w3t+gJVhpQ6RmR3XUUtWe3+R1oTRG
D5JttpsPohPoVg9rieu+QNzBlsr2ZybJ6uPpvvRFcJvWIsCgx5YJm8qksIU7PVI6
4RmeEqXndWysoGh1dmDwKCFVsGkKm+2I9bkcf3UffSyBbtFe8el1X8xAEuL6vs7z
8tQQMy32fMNV+FmKbPuyA093enLOYqkh/uQzQhC/SJNLt5C8KPef1b4=
=R+la
-----END PGP SIGNATURE-----

--1GNA92UNsBlBnxKRqGSOqWrpujLKKN3jC--
