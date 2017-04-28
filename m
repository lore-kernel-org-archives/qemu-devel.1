Received: from eggs.gnu.org ([2001:4830:134:3::10]:43898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49nw-0002Ey-NT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49nv-0007NH-Oa
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:35:40 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
Date: Fri, 28 Apr 2017 19:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ABfq2FRFBIfQOEWUO2LVjBTpTm2mordu"
Subject: Re: [Qemu-devel] [PATCH v10 02/17] qcow2: Correctly report status
 of preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ABfq2FRFBIfQOEWUO2LVjBTpTm2mordu
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
Subject: Re: [PATCH v10 02/17] qcow2: Correctly report status of preallocated
 zero clusters
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-3-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> We were throwing away the preallocation information associated with
> zero clusters.  But we should be matching the well-defined semantics
> in bdrv_get_block_status(), where (BDRV_BLOCK_ZERO |
> BDRV_BLOCK_OFFSET_VALID) informs the user which offset is reserved,
> while still reminding the user that reading from that offset is
> likely to read garbage.
>=20
> Making this change lets us see which portions of an image are zero
> but preallocated, when using qemu-img map --output=3Djson.  The
> --output=3Dhuman side intentionally ignores all zero clusters, whether
> or not they are preallocated.
>=20
> The fact that there is no change to qemu-iotests './check -qcow2'
> merely means that we aren't yet testing this aspect of qemu-img;
> a later patch will add a test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: new patch
> ---
>  block/qcow2-cluster.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)

I'd propose you split the qcow2 changes off of this series.

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 100398c..d1063df 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -328,6 +328,10 @@ static int count_contiguous_clusters(int nb_cluste=
rs, int cluster_size,
>  	return i;
>  }
>=20
> +/*
> + * Checks how many consecutive clusters in a given L2 table have the s=
ame
> + * cluster type with no corresponding allocation.
> + */
>  static int count_contiguous_clusters_by_type(int nb_clusters,
>                                               uint64_t *l2_table,
>                                               int wanted_type)
> @@ -335,9 +339,10 @@ static int count_contiguous_clusters_by_type(int n=
b_clusters,
>      int i;
>=20
>      for (i =3D 0; i < nb_clusters; i++) {
> -        int type =3D qcow2_get_cluster_type(be64_to_cpu(l2_table[i]));=

> +        uint64_t entry =3D be64_to_cpu(l2_table[i]);
> +        int type =3D qcow2_get_cluster_type(entry);
>=20
> -        if (type !=3D wanted_type) {
> +        if (type !=3D wanted_type || entry & L2E_OFFSET_MASK) {

This works only for wanted_type \in \{ ZERO, UNALLOCATED \} -- which is
what the comment you added describes, but this may still warrant a
renaming of this function (count_contiguous_unallocated_clusters?) and
probably an assertion that wanted_type is ZERO or UNALLOCATED.

>              break;
>          }
>      }
> @@ -559,9 +564,26 @@ int qcow2_get_cluster_offset(BlockDriverState *bs,=
 uint64_t offset,
>              ret =3D -EIO;
>              goto fail;
>          }
> -        c =3D count_contiguous_clusters_by_type(nb_clusters, &l2_table=
[l2_index],
> -                                              QCOW2_CLUSTER_ZERO);
> -        *cluster_offset =3D 0;
> +        /* Distinguish between pure zero clusters and pre-allocated on=
es */
> +        if (*cluster_offset & L2E_OFFSET_MASK) {
> +            c =3D count_contiguous_clusters(nb_clusters, s->cluster_si=
ze,
> +                                          &l2_table[l2_index], QCOW_OF=
LAG_ZERO);

You should probably switch this patch and the next one -- or I just send
my patches myself and you base your series on top of it...

Because before the next patch, this happens:

$ ./qemu-img create -f qcow2 foo.qcow2 64M
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-io -c 'write 0 64M' -c 'write -z 0 64M' foo.qcow2
wrote 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 0.1846 sec (346.590 MiB/sec and 5.4155 ops/sec)
wrote 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 0.0004 sec (127.551 GiB/sec and 2040.8163 ops/sec)
$ ./qemu-img map foo.qcow2
Offset          Length          Mapped to       File
qemu-img: block/qcow2-cluster.c:319: count_contiguous_clusters:
Assertion `qcow2_get_cluster_type(first_entry) =3D=3D QCOW2_CLUSTER_NORMA=
L'
failed.
[1]    4970 abort (core dumped)  ./qemu-img map foo.qcow2

Max

> +            *cluster_offset &=3D L2E_OFFSET_MASK;
> +            if (offset_into_cluster(s, *cluster_offset)) {
> +                qcow2_signal_corruption(bs, true, -1, -1,
> +                                        "Preallocated zero cluster off=
set %#"
> +                                        PRIx64 " unaligned (L2 offset:=
 %#"
> +                                        PRIx64 ", L2 index: %#x)",
> +                                        *cluster_offset, l2_offset, l2=
_index);
> +                ret =3D -EIO;
> +                goto fail;
> +            }
> +        } else {
> +            c =3D count_contiguous_clusters_by_type(nb_clusters,
> +                                                  &l2_table[l2_index],=

> +                                                  QCOW2_CLUSTER_ZERO);=

> +            *cluster_offset =3D 0;
> +        }
>          break;
>      case QCOW2_CLUSTER_UNALLOCATED:
>          /* how many empty clusters ? */
>=20



--7ABfq2FRFBIfQOEWUO2LVjBTpTm2mordu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDfWISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzMcH/j80LAeZfJtwuO40jsJEBoI/qtmuxQ4f
5Uxv8J3S0eEkgB8JxJ2u1SOkFiu33MxTjho8B1ZAzvpkwRuGiAIg1TawVdY/dOmg
bzecBjXorbJ9ENeZN9FOYjyInyv1WAZc6FbQ7ZwPYMQpsGMcr7mJ3XAROODi7pa6
iccSgYZ5lFixuRKabmOjJ7jBQyqDFSBNiIrC3prRDBBCcQbcnmKkSy07o6TkKzDy
rXHpaIDbGoeVKIw0Rw281gV8XlwfXvrX5OyvHhDc/WpjC5jGfpNv/Nk2iMthOhIf
dQEAXOa+6yaIEFR1q0mVI4I5ABFkWRX02lGEC+7xPnnKGvoKO+w0TYY=
=qYZI
-----END PGP SIGNATURE-----

--7ABfq2FRFBIfQOEWUO2LVjBTpTm2mordu--
