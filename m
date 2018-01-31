Received: from eggs.gnu.org ([2001:4830:134:3::10]:57325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyfn-0007Lh-DP
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyfm-00061c-9c
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:07:59 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
Date: Wed, 31 Jan 2018 21:07:48 +0100
MIME-Version: 1.0
In-Reply-To: <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yXThupYNgs0uPvA3EVRXVkfUDgoYTnRqJ"
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yXThupYNgs0uPvA3EVRXVkfUDgoYTnRqJ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
Subject: Re: [PATCH v3 17/39] qcow2: Update l2_allocate() to support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
In-Reply-To: <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This patch updates l2_allocate() to support the qcow2 cache returning
> L2 slices instead of full L2 tables.
>=20
> The old code simply gets an L2 table from the cache and initializes it
> with zeroes or with the contents of an existing table. With a cache
> that returns slices instead of tables the idea remains the same, but
> the code must now iterate over all the slices that are contained in an
> L2 table.
>=20
> Since now we're operating with slices the function can no longer
> return the newly-allocated table, so it's up to the caller to retrieve
> the appropriate L2 slice after calling l2_allocate() (note that with
> this patch the caller is still loading full L2 tables, but we'll deal
> with that in a separate patch).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 56 +++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 57349928a9..2a53c1dc5f 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -264,11 +264,12 @@ int qcow2_write_l1_entry(BlockDriverState *bs, in=
t l1_index)
>   *
>   */
> =20
> -static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **=
table)
> +static int l2_allocate(BlockDriverState *bs, int l1_index)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t old_l2_offset;
> -    uint64_t *l2_table =3D NULL;
> +    uint64_t *l2_slice =3D NULL;
> +    unsigned slice, slice_size2, n_slices;

I'd personally prefer size_t, but oh well.

(And also maybe slice_size_bytes or slice_bytes instead of the
not-so-intuitive slice_size2.  I know we're using *_size2 in other
places, but that's bad enough as it is.)

Overall (with that fixed or not, and with the spelling fixed as pointed
out by Eric);

Reviewed-by: Max Reitz <mreitz@redhat.com>

However, I'm wondering whether this is the best approach.  The old L2
table is probably not going to be used after this function, so we're
basically polluting the cache here.  That was bad enough so far, but now
that actually means wasting multiple cache entries on it.

Sure, the code is simpler this way.  But maybe it would still be better
to manually copy the data over from the old offset...  (As long as it's
not much more complicated.)

Max

>      int64_t l2_offset;
>      int ret;
> =20


--yXThupYNgs0uPvA3EVRXVkfUDgoYTnRqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyIhQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkhkH/0uf5Q9yYMl07IReGMUl8wiXBgl9jbhM
+QjTzMLDV46NlvQc9FrF+hhN2q/VVnNidZTKFGdv852OaowBQ71JbvkpRBddrFYQ
6nasTiOlUBfiDz18e6AykEIBDWaG3dxxnNtVVZlzXd2hwRNYRHJ94yu1NSdMOp3K
K4vC/mg+nb+emWUBfGsIUKaVgrXJQAxqY5Cx6xOcJimjHIj/w876IhkLaAWA7z/c
8YK77thGiNl1Q48G5Sf8WQSttPjPJ/DC4MRG/tBBWzVg/zTBtVcdm+sKsnvmavI2
JIlJw4lDUz9jrXSKDp8KVvvJ0cBNU33uUZO//cUbs/Gd3bNwHTMmfsA=
=E25f
-----END PGP SIGNATURE-----

--yXThupYNgs0uPvA3EVRXVkfUDgoYTnRqJ--
