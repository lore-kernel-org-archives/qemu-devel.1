Received: from eggs.gnu.org ([2001:4830:134:3::10]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kCF-0007X0-1e
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kCD-0004Xc-Ry
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:51:27 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
Date: Fri, 5 May 2017 22:51:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Au36FqKRilArdRAHQkUe3ENw6pDVuCkL"
Subject: Re: [Qemu-devel] [PATCH v12 04/10] qcow2: Make distinction between
 zero cluster types obvious
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
--3Au36FqKRilArdRAHQkUe3ENw6pDVuCkL
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
Subject: Re: [PATCH v12 04/10] qcow2: Make distinction between zero cluster
 types obvious
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-5-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> Treat plain zero clusters differently from allocated ones, so that
> we can simplify the logic of checking whether an offset is present.
> Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
> QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.
>=20
> I tried to arrange the enum so that we could use
> 'ret <=3D QCOW2_CLUSTER_ZERO_PLAIN' for all unallocated types, and
> 'ret >=3D QCOW2_CLUSTER_ZERO_ALLOC' for allocated types, although
> I didn't actually end up taking advantage of the layout.
>=20
> In many cases, this leads to simpler code, by properly combining
> cases (sometimes, both zero types pair together, other times,
> plain zero is more like unallocated while allocated zero is more
> like normal).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: new patch
> ---
>  block/qcow2.h          |  8 +++++--
>  block/qcow2-cluster.c  | 65 ++++++++++++++++++------------------------=
--------
>  block/qcow2-refcount.c | 40 +++++++++++++------------------
>  block/qcow2.c          |  9 ++++---
>  4 files changed, 51 insertions(+), 71 deletions(-)

I have to admit I was rather skeptic of this idea at first (because I
thought we would have more places which treat both ZERO types the same
than those that separate it), but you have comprehensively proven me wron=
g.

Some nit picks below, I'll leave it completely up to you whether you
want to address them:

Reviewed-by: Max Reitz <mreitz@redhat.com>

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f3bfce6..14e2086 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

[...]

> @@ -558,52 +557,32 @@ int qcow2_get_cluster_offset(BlockDriverState *bs=
, uint64_t offset,
>      assert(nb_clusters <=3D INT_MAX);
>=20
>      ret =3D qcow2_get_cluster_type(*cluster_offset);
> +    if (s->qcow_version < 3 && (ret =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||=

> +                                ret =3D=3D QCOW2_CLUSTER_ZERO_ALLOC)) =
{
> +        qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry =
found"
> +                                " in pre-v3 image (L2 offset: %#" PRIx=
64
> +                                ", L2 index: %#x)", l2_offset, l2_inde=
x);
> +        ret =3D -EIO;
> +        goto fail;
> +    }
>      switch (ret) {
>      case QCOW2_CLUSTER_COMPRESSED:
>          /* Compressed clusters can only be processed one by one */
>          c =3D 1;
>          *cluster_offset &=3D L2E_COMPRESSED_OFFSET_SIZE_MASK;
>          break;
> -    case QCOW2_CLUSTER_ZERO:
> -        if (s->qcow_version < 3) {
> -            qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster en=
try found"
> -                                    " in pre-v3 image (L2 offset: %#" =
PRIx64
> -                                    ", L2 index: %#x)", l2_offset, l2_=
index);
> -            ret =3D -EIO;
> -            goto fail;
> -        }
> -        /* Distinguish between pure zero clusters and pre-allocated on=
es */
> -        if (*cluster_offset & L2E_OFFSET_MASK) {
> -            c =3D count_contiguous_clusters(nb_clusters, s->cluster_si=
ze,
> -                                          &l2_table[l2_index], QCOW_OF=
LAG_ZERO);
> -            *cluster_offset &=3D L2E_OFFSET_MASK;
> -            if (offset_into_cluster(s, *cluster_offset)) {
> -                qcow2_signal_corruption(bs, true, -1, -1,
> -                                        "Preallocated zero cluster off=
set %#"
> -                                        PRIx64 " unaligned (L2 offset:=
 %#"
> -                                        PRIx64 ", L2 index: %#x)",
> -                                        *cluster_offset, l2_offset, l2=
_index);
> -                ret =3D -EIO;
> -                goto fail;
> -            }
> -        } else {
> -            c =3D count_contiguous_clusters_unallocated(nb_clusters,
> -                                                      &l2_table[l2_ind=
ex],
> -                                                      QCOW2_CLUSTER_ZE=
RO);
> -            *cluster_offset =3D 0;
> -        }
> -        break;
> +    case QCOW2_CLUSTER_ZERO_PLAIN:
>      case QCOW2_CLUSTER_UNALLOCATED:
>          /* how many empty clusters ? */
>          c =3D count_contiguous_clusters_unallocated(nb_clusters,
> -                                                  &l2_table[l2_index],=

> -                                                  QCOW2_CLUSTER_UNALLO=
CATED);
> +                                                  &l2_table[l2_index],=
 ret);

Nit pick: Using ret here is a bit weird (because it's such a meaningless
name). It would be good if we had a separate cluster_type variable.

>          *cluster_offset =3D 0;
>          break;
> +    case QCOW2_CLUSTER_ZERO_ALLOC:
>      case QCOW2_CLUSTER_NORMAL:
>          /* how many allocated clusters ? */
>          c =3D count_contiguous_clusters(nb_clusters, s->cluster_size,
> -                &l2_table[l2_index], QCOW_OFLAG_ZERO);
> +                                      &l2_table[l2_index], QCOW_OFLAG_=
ZERO);
>          *cluster_offset &=3D L2E_OFFSET_MASK;
>          if (offset_into_cluster(s, *cluster_offset)) {
>              qcow2_signal_corruption(bs, true, -1, -1, "Data cluster of=
fset %#"

Well, preallocated zero clusters are not exactly data clusters... Not
that any user cared, but s/Data cluster/Cluster allocation/ would be
more correct.

By the way, allow me to state just how much I love this hunk: Very much.
Looks great! It gets a place on my list of favorite hunks of this year
at least.

[...]

> @@ -1760,7 +1740,8 @@ static int expand_zero_clusters_in_l1(BlockDriver=
State *bs, uint64_t *l1_table,
>              int cluster_type =3D qcow2_get_cluster_type(l2_entry);>   =
           bool preallocated =3D offset !=3D 0;

I could get behind removing this variable and replacing all
"if (!preallocated)" instances by
"if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN)". Up to you, though.

Max

>=20
> -            if (cluster_type !=3D QCOW2_CLUSTER_ZERO) {
> +            if (cluster_type !=3D QCOW2_CLUSTER_ZERO_PLAIN &&
> +                cluster_type !=3D QCOW2_CLUSTER_ZERO_ALLOC) {
>                  continue;
>              }
>


--3Au36FqKRilArdRAHQkUe3ENw6pDVuCkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM5cQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUkwH/jE5SDLTbPstEo0Ak455W5vnbwL8TgCN
nbuWstk4JVTnWALfVNXXDq4DSfhMJUQTLn/vb6YQQsKxLv4VdOoAF/5d1KKq2XCw
Qb32eBnCBV/J4gxP+nMcsLkhTW0x3ijCh6xfysQcKRQ352f7oHn18Tys8CQK17dj
AI8viPd//xpDRhDsBkgjFl810fkTJMrAVO1AksrArF1W3ii0fkMNzaGBjaYIwq6u
hL2HRMh/AH2+vbIgXP1DoCyWrJGOqkiGFxTAYiha8p7L+dqOf+EzhKeTTYsS87ml
vU/V0mk2IwGVOTSKLJJl7TY9Y/7A92h7JeH0rk6EFDYcuY2hIXRE//U=
=WPCe
-----END PGP SIGNATURE-----

--3Au36FqKRilArdRAHQkUe3ENw6pDVuCkL--
