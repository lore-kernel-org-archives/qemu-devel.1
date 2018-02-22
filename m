Received: from eggs.gnu.org ([2001:4830:134:3::10]:53642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0fT-0003iF-71
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0fH-0005LP-Md
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:52:51 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-29-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <82dbdf97-0316-5287-47b0-ba7f5f03c88e@redhat.com>
Date: Fri, 23 Feb 2018 00:51:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-29-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fDfT6pPqPfkIgoJGWuQLf6MHZaE1vSeDh"
Subject: Re: [Qemu-devel] [PATCH v2 28/36] sheepdog: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fDfT6pPqPfkIgoJGWuQLf6MHZaE1vSeDh
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <82dbdf97-0316-5287-47b0-ba7f5f03c88e@redhat.com>
Subject: Re: [PATCH v2 28/36] sheepdog: Support .bdrv_co_create
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-29-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-29-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to sheepdog, which enable=
s
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  24 +++++-
>  block/sheepdog.c     | 240 +++++++++++++++++++++++++++++++++++--------=
--------
>  2 files changed, 189 insertions(+), 75 deletions(-)

[...]

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 22df2ba9d0..d45cf68ff2 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c

[...]

> @@ -1882,6 +1866,42 @@ out_with_err_set:
>      return ret;
>  }
> =20
> +static int sd_create_prealloc(BlockdevOptionsSheepdog *location, int64=
_t size,
> +                              Error **errp)
> +{
> +    BlockDriverState *bs;
> +    Visitor *v;
> +    QObject *obj =3D NULL;
> +    QDict *qdict;
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +    v =3D qobject_output_visitor_new(&obj);
> +    visit_type_BlockdevOptionsSheepdog(v, NULL, &location, &local_err)=
;
> +    visit_free(v);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        qobject_decref(obj);
> +        return -EINVAL;
> +    }
> +
> +    qdict =3D qobject_to_qdict(obj);
> +    qdict_flatten(qdict);
> +
> +    bs =3D bdrv_open(NULL, NULL, qdict, BDRV_O_PROTOCOL | BDRV_O_RDWR,=
 errp);

Hu, nice, we can even get rid of the filename again.

But I am wondering where "driver": "sheepdog" comes into qdict...

Max

> +    if (bs =3D=3D NULL) {
> +        ret =3D -EIO;
> +        goto fail;
> +    }
> +
> +    ret =3D sd_prealloc(bs, 0, size, errp);
> +fail:
> +    bdrv_unref(bs);
> +    QDECREF(qdict);
> +    return ret;
> +}
> +
>  static int parse_redundancy(BDRVSheepdogState *s, SheepdogRedundancy *=
opt)
>  {
>      struct SheepdogInode *inode =3D &s->inode;


--fDfT6pPqPfkIgoJGWuQLf6MHZaE1vSeDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPV50SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXhoIAJY5lK6+kyGY3vAfGQC7EFSeAj/nepgr
gQAzfVigPrhMpKRSWe5sMPMQZNtAPikkQJZJUm0TEiUWOhf7imdNTpncp8zI2b+0
puFoBGEVUlhgLAkHN03kx1NLAccgTHCPmgW+3nfZIYw6IhJhcrM+MU5UxfYdJXzP
e5gidT3pN+2FQ3sUF1KPp9CGpAQO3RbZeHWNremCCre/itH9L4N/oEyC8JzgePz9
cqqyb1iilULlitBv0l6VPSQgD262of8wOZQ/EdhN6BE5u/VmUqe+MQkM9+Is980x
OnywVYVeZ/+HGTe60eV2cEKE6z/O+Ai4mLsxPiH0aq11NJ9L65NGJrE=
=Eg7I
-----END PGP SIGNATURE-----

--fDfT6pPqPfkIgoJGWuQLf6MHZaE1vSeDh--
