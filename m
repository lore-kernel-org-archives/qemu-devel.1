Received: from eggs.gnu.org ([2001:4830:134:3::10]:35934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3Ow-0005OQ-8t
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3Ov-0004ah-9P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:28:30 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d64c9cdd-098b-bb41-cf80-de51c569288b@redhat.com>
Date: Thu, 21 Sep 2017 17:28:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170920135833.20472-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gfrM87qRwCsCj946QDBplaDW8TbQfn0NC"
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: truncate the tail of the image
 file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gfrM87qRwCsCj946QDBplaDW8TbQfn0NC
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <d64c9cdd-098b-bb41-cf80-de51c569288b@redhat.com>
Subject: Re: [PATCH 2/2] qcow2: truncate the tail of the image file after
 shrinking the image
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
 <20170920135833.20472-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170920135833.20472-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-20 15:58, Pavel Butsykin wrote:
> Now after shrinking the image, at the end of the image file, there migh=
t be a
> tail that probably will never be used. So we can find the last used clu=
ster and
> cut the tail.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 21 +++++++++++++++++++++
>  block/qcow2.c          | 19 +++++++++++++++++++
>  block/qcow2.h          |  1 +
>  3 files changed, 41 insertions(+)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 88d5a3f1ad..5e221a166c 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -3181,3 +3181,24 @@ out:
>      g_free(reftable_tmp);
>      return ret;
>  }
> +
> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int64_t i, last_cluster, nb_clusters =3D size_to_clusters(s, size)=
;
> +    uint64_t refcount;
> +
> +    for (i =3D 0, last_cluster =3D 0; i < nb_clusters; i++) {
> +        int ret =3D qcow2_get_refcount(bs, i, &refcount);
> +        if (ret < 0) {
> +            fprintf(stderr, "Can't get refcount for cluster %" PRId64 =
": %s\n",
> +                    i, strerror(-ret));
> +            continue;
> +        }
> +
> +        if (refcount > 0) {
> +            last_cluster =3D i;
> +        }
> +    }
> +    return last_cluster;
> +}

Wouldn't it make more sense to start from the end of the image?

Max


--gfrM87qRwCsCj946QDBplaDW8TbQfn0NC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnD2pMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ap3wIAJk8YenqPz1rQcbqa7ojwU0MDg7yR40/
KAunWTdDAhFcDEgmuTCZnR9h8PQeCflzEiH6/g16FJC3/7D8VDLN3Dnn18e/swIV
U9TLh9hDZwmPc/5YRXs5JL/WgNFijH4IxHk4N32pZRUGmwu4+KoPdmLHbkwVo9xr
DrvYjUOkWzKgwuamPZr1w7qty+Muq6LdEt/sUFB5owtZcHhBwy5ZehvJjjnIQOnQ
cw6AGRzanlVgeHsP8mP+Z31q8+J5TtPfU78ltC0c0BZY3hAw5zn7hvvlH1DlpAkm
JmNoo4cvEnRrYQEAu486JQ5ZCtJPSdHZmb6dH75pffQJh7paP25avkI=
=dcRP
-----END PGP SIGNATURE-----

--gfrM87qRwCsCj946QDBplaDW8TbQfn0NC--
