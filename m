Received: from eggs.gnu.org ([2001:4830:134:3::10]:38315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3Rk-00075q-RP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3Re-0007t8-NY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:31:24 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <129077ca-af54-fe7c-40ee-850547f63cff@redhat.com>
Date: Thu, 21 Sep 2017 17:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170920135833.20472-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CiwGHoVTMa0hdqTqjokl2ooBqdH8x5L5t"
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
--CiwGHoVTMa0hdqTqjokl2ooBqdH8x5L5t
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <129077ca-af54-fe7c-40ee-850547f63cff@redhat.com>
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

Oh, and another thing: If you decide to ignore errors here, I'd at least
consider the cluster allocated.

Of course it would also be possible not to ignore errors, and instead
return them to the caller which would then just not truncate the file.

Max

> +        }
> +
> +        if (refcount > 0) {
> +            last_cluster =3D i;
> +        }
> +    }
> +    return last_cluster;
> +}


--CiwGHoVTMa0hdqTqjokl2ooBqdH8x5L5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnD2x4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzNIH/iiSmqBtmb2lwulmOjyHA4AiSFJB4Gyn
wZdCkzqHIOyajRg7I0FUa1ZFImVGTVxY9x3xpX1t9gD5SEElDar0LvWrltRLdmn5
VRs1W2HQ1DwewP+wsy7OAl9Co5UTYsbTubzSMuZ85eFaVfyuHgd3zEG/uy/TMdw+
kyKXRCdwZupOrVTV7TG8xBt8qx59gqk0nNoxMoJs1N0BWJOkRQvZCalKYTLnHgcw
CrRZspdICVPwjr78s3eV77LXtzywzcHsYmouvqJ4eDBMiWw3mccjSYu95KGx8qvr
27Fr3jCfm/LookQ4jjfdfVKdwUHS2pHwr0PO2yDhxe5MWlumO8Kbf8o=
=oSEB
-----END PGP SIGNATURE-----

--CiwGHoVTMa0hdqTqjokl2ooBqdH8x5L5t--
