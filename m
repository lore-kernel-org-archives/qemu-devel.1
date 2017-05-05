Received: from eggs.gnu.org ([2001:4830:134:3::10]:42556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6j7g-000052-CJ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6j7f-0005Hp-7A
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:42:40 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1b59906d-4d5f-c5d7-57db-8752685df262@redhat.com>
Date: Fri, 5 May 2017 21:42:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n8HWtWB8XIcTbik2Ctb9uwoTi26UeRRiu"
Subject: Re: [Qemu-devel] [PATCH v12 01/10] qcow2: Use consistent switch
 indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8HWtWB8XIcTbik2Ctb9uwoTi26UeRRiu
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <1b59906d-4d5f-c5d7-57db-8752685df262@redhat.com>
Subject: Re: [PATCH v12 01/10] qcow2: Use consistent switch indentation
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-2-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> Fix a couple of inconsistent indentations, before an upcoming
> patch further tweaks the switch statements.  While at it, make
> some tweaks for shorter lines to keep checkpatch happy (best
> viewed with 'git diff -b').
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: new patch
> ---
>  block/qcow2-cluster.c  | 32 ++++++++---------
>  block/qcow2-refcount.c | 96 ++++++++++++++++++++++++++----------------=
--------
>  2 files changed, 65 insertions(+), 63 deletions(-)

[...]

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 4efca7e..a5a0076 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1117,70 +1117,72 @@ int qcow2_update_snapshot_refcount(BlockDriverS=
tate *bs,
>                  goto fail;
>              }
>=20
> -            for(j =3D 0; j < s->l2_size; j++) {
> +            for (j =3D 0; j < s->l2_size; j++) {
>                  uint64_t cluster_index;
> +                uint64_t offset_masked;
>=20
>                  offset =3D be64_to_cpu(l2_table[j]);
>                  old_offset =3D offset;
> +                offset_masked =3D offset & L2E_OFFSET_MASK;

I'd rather rename "offset" to "entry" (or "l2_entry") and name this just
"offset". Much less confusing.

Also, I really wouldn't mind splitting the non-indentation changes off
into their own patch.

Tentative

Reviewed-by: Max Reitz <mreitz@redhat.com>

>                  offset &=3D ~QCOW_OFLAG_COPIED;
>=20
>                  switch (qcow2_get_cluster_type(offset)) {
> -                    case QCOW2_CLUSTER_COMPRESSED:
> -                        nb_csectors =3D ((offset >> s->csize_shift) &
> -                                       s->csize_mask) + 1;
> -                        if (addend !=3D 0) {
> -                            ret =3D update_refcount(bs,
> -                                (offset & s->cluster_offset_mask) & ~5=
11,
> -                                nb_csectors * 512, abs(addend), addend=
 < 0,
> -                                QCOW2_DISCARD_SNAPSHOT);
> -                            if (ret < 0) {
> -                                goto fail;
> -                            }
> -                        }
> -                        /* compressed clusters are never modified */
> -                        refcount =3D 2;
> -                        break;
> -
> -                    case QCOW2_CLUSTER_NORMAL:
> -                    case QCOW2_CLUSTER_ZERO:
> -                        if (offset_into_cluster(s, offset & L2E_OFFSET=
_MASK)) {
> -                            qcow2_signal_corruption(bs, true, -1, -1, =
"Data "
> -                                                    "cluster offset %#=
llx "
> -                                                    "unaligned (L2 off=
set: %#"
> -                                                    PRIx64 ", L2 index=
: %#x)",
> -                                                    offset & L2E_OFFSE=
T_MASK,
> -                                                    l2_offset, j);
> -                            ret =3D -EIO;
> +                case QCOW2_CLUSTER_COMPRESSED:
> +                    nb_csectors =3D ((offset >> s->csize_shift) &
> +                                   s->csize_mask) + 1;
> +                    if (addend !=3D 0) {
> +                        ret =3D update_refcount(bs,
> +                            (offset & s->cluster_offset_mask) & ~511,
> +                            nb_csectors * 512, abs(addend), addend < 0=
,
> +                            QCOW2_DISCARD_SNAPSHOT);
> +                        if (ret < 0) {
>                              goto fail;
>                          }
> +                    }
> +                    /* compressed clusters are never modified */
> +                    refcount =3D 2;
> +                    break;
>=20
> -                        cluster_index =3D (offset & L2E_OFFSET_MASK) >=
> s->cluster_bits;
> -                        if (!cluster_index) {
> -                            /* unallocated */
> -                            refcount =3D 0;
> -                            break;
> -                        }
> -                        if (addend !=3D 0) {
> -                            ret =3D qcow2_update_cluster_refcount(bs,
> +                case QCOW2_CLUSTER_NORMAL:
> +                case QCOW2_CLUSTER_ZERO:
> +                    if (offset_into_cluster(s, offset_masked)) {
> +                        qcow2_signal_corruption(bs, true, -1, -1, "Dat=
a "
> +                                                "cluster offset %#" PR=
Ix64
> +                                                " unaligned (L2 offset=
: %#"
> +                                                PRIx64 ", L2 index: %#=
x)",
> +                                                offset_masked,
> +                                                l2_offset, j);
> +                        ret =3D -EIO;
> +                        goto fail;
> +                    }
> +
> +                    cluster_index =3D offset_masked >> s->cluster_bits=
;
> +                    if (!cluster_index) {
> +                        /* unallocated */
> +                        refcount =3D 0;
> +                        break;
> +                    }
> +                    if (addend !=3D 0) {
> +                        ret =3D qcow2_update_cluster_refcount(bs,
>                                      cluster_index, abs(addend), addend=
 < 0,
>                                      QCOW2_DISCARD_SNAPSHOT);
> -                            if (ret < 0) {
> -                                goto fail;
> -                            }
> -                        }
> -
> -                        ret =3D qcow2_get_refcount(bs, cluster_index, =
&refcount);
>                          if (ret < 0) {
>                              goto fail;
>                          }
> -                        break;
> +                    }
>=20
> -                    case QCOW2_CLUSTER_UNALLOCATED:
> -                        refcount =3D 0;
> -                        break;
> +                    ret =3D qcow2_get_refcount(bs, cluster_index, &ref=
count);
> +                    if (ret < 0) {
> +                        goto fail;
> +                    }
> +                    break;
>=20
> -                    default:
> -                        abort();
> +                case QCOW2_CLUSTER_UNALLOCATED:
> +                    refcount =3D 0;
> +                    break;
> +
> +                default:
> +                    abort();
>                  }
>=20
>                  if (refcount =3D=3D 1) {
>=20



--n8HWtWB8XIcTbik2Ctb9uwoTi26UeRRiu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM1aYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoSEIAKgZYlb3xZ5YgcqVzJYW26In2Z4gfWoV
YxSl9qJecZALXqbRYFy9Xzc8kXTsXk4aoQ6NgXDGUBZMkXnYMaVI9KZUOUyjTLAc
pda8I6Sq4TxS6nuEjFATqRusm3nK+o0G5sV0Vs/JDJF8qmlqAHbyMFreB9kKNEE1
+unEBQnrdd8KmYVxlOKVhIpmVZH+beB9b5lVbVVq3F/c+7oq+oNzgFUTvqSz0P2o
wUVANr8CGd2h4EC2/lN2wGjCEe2RVQo21k4nh14DXVYOIcnV4JcK6eaGJfj34xnz
H/V4gMUpXd/p/J8WKj2VCPtD0lzBomguJqOZDbDAcA/YRqOvY3KV68w=
=3IFe
-----END PGP SIGNATURE-----

--n8HWtWB8XIcTbik2Ctb9uwoTi26UeRRiu--
