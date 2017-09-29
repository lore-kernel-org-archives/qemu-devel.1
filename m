Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxsx9-0005BR-UN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxsx9-00078I-2X
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:55:31 -0400
References: <20170928092750.24938-1-pbutsykin@virtuozzo.com>
	<20170928092750.24938-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d796c4a7-1fcd-3750-39d1-21d0af4a364a@redhat.com>
Date: Fri, 29 Sep 2017 12:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170928092750.24938-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KxnqoAow76sPjPfNX7aVKAPNEtGDuw8Fi"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qcow2: truncate the tail of the
 image file after shrinking the image
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KxnqoAow76sPjPfNX7aVKAPNEtGDuw8Fi
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <d796c4a7-1fcd-3750-39d1-21d0af4a364a@redhat.com>
Subject: Re: [PATCH v3 2/2] qcow2: truncate the tail of the image file after
 shrinking the image
References: <20170928092750.24938-1-pbutsykin@virtuozzo.com>
 <20170928092750.24938-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170928092750.24938-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-28 11:27, Pavel Butsykin wrote:
> Now after shrinking the image, at the end of the image file, there migh=
t be a
> tail that probably will never be used. So we can find the last used clu=
ster and
> cut the tail.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2-refcount.c | 22 ++++++++++++++++++++++
>  block/qcow2.c          | 23 +++++++++++++++++++++++
>  block/qcow2.h          |  1 +
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 88d5a3f1ad..aa3fd6cf17 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -3181,3 +3181,25 @@ out:
>      g_free(reftable_tmp);
>      return ret;
>  }
> +
> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int64_t i;
> +
> +    for (i =3D size_to_clusters(s, size) - 1; i >=3D 0; i--) {
> +        uint64_t refcount;
> +        int ret =3D qcow2_get_refcount(bs, i, &refcount);
> +        if (ret < 0) {
> +            fprintf(stderr, "Can't get refcount for cluster %" PRId64 =
": %s\n",
> +                    i, strerror(-ret));
> +            return ret;
> +        }
> +        if (refcount > 0) {
> +            return i;
> +        }
> +    }
> +    qcow2_signal_corruption(bs, true, -1, -1,
> +                            "There are no references in the refcount t=
able.");
> +    return -EIO;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8a4311d338..f08c69ccd9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3106,6 +3106,7 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset,
>      new_l1_size =3D size_to_l1(s, offset);
> =20
>      if (offset < old_length) {
> +        int64_t last_cluster, old_file_size;
>          if (prealloc !=3D PREALLOC_MODE_OFF) {
>              error_setg(errp,
>                         "Preallocation can't be used for shrinking an i=
mage");
> @@ -3134,6 +3135,28 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset,
>                               "Failed to discard unused refblocks");
>              return ret;
>          }
> +
> +        old_file_size =3D bdrv_getlength(bs->file->bs);
> +        if (old_file_size < 0) {
> +            error_setg_errno(errp, -old_file_size,
> +                             "Failed to inquire current file length");=

> +            return old_file_size;
> +        }
> +        last_cluster =3D qcow2_get_last_cluster(bs, old_file_size);
> +        if (last_cluster < 0) {
> +            error_setg_errno(errp, -last_cluster,
> +                             "Failed to find the last cluster");
> +            return last_cluster;
> +        }
> +        if ((last_cluster + 1) * s->cluster_size < old_file_size) {
> +            ret =3D bdrv_truncate(bs->file, (last_cluster + 1) * s->cl=
uster_size,
> +                                PREALLOC_MODE_OFF, NULL);
> +            if (ret < 0) {
> +                warn_report("Failed to truncate the tail of the image:=
 "
> +                            "ret =3D %d", ret);

How about using strerror(-ret) instead?

Max

> +                ret =3D 0;
> +            }
> +        }
>      } else {
>          ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
>          if (ret < 0) {
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 5a289a81e2..782a206ecb 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -597,6 +597,7 @@ int qcow2_change_refcount_order(BlockDriverState *b=
s, int refcount_order,
>                                  BlockDriverAmendStatusCB *status_cb,
>                                  void *cb_opaque, Error **errp);
>  int qcow2_shrink_reftable(BlockDriverState *bs);
> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
> =20
>  /* qcow2-cluster.c functions */
>  int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>=20



--KxnqoAow76sPjPfNX7aVKAPNEtGDuw8Fi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOJpQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABaEH/26U3OsLtyvcmwSnsyc+xDzfo/8LYYlh
/fqQ8PMIBp7FJjnuZbv/e7bG1CFEox7yMlkrMNZq6EWKrAkn42GpBhCcp5gZv/ap
wApaaLtk52Q/xSqMgr727vYx3cMT/FSEO4T+99KVfeNojmSSYFUxQtcbp/RRJpzj
5wYCDRJ5inaiboWPjY2MX+Z7xGvZU0E96CILwg0bACbjIZgugc4OXXSWDZNR+AfH
2EtNjkeiGSqEI3SjPnWJYQhEEfSQmBV+GZfa9iIS9/TMf2YRzcbFjyEuOx2nK2I3
zvUTdq1hqPtAHZaCQ4ex0lM2+2XsIv4TG+fbESOnb4GKkNX9+xAiiGE=
=wDzv
-----END PGP SIGNATURE-----

--KxnqoAow76sPjPfNX7aVKAPNEtGDuw8Fi--
