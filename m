Received: from eggs.gnu.org ([209.51.188.92]:35455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gte5d-00040r-Rv
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdrF-0002cH-Gt
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:36:44 -0500
References: <20190206170205.13061-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ddc2f850-e7b9-e8f8-4fc1-a3b62a5164e5@redhat.com>
Date: Tue, 12 Feb 2019 13:36:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190206170205.13061-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MdvmcsllTQhZN0vIbkwsN7qrplcWvddaf"
Subject: Re: [Qemu-devel] [PATCH] blockdev: acquire aio_context for bitmap
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MdvmcsllTQhZN0vIbkwsN7qrplcWvddaf
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com
Message-ID: <ddc2f850-e7b9-e8f8-4fc1-a3b62a5164e5@redhat.com>
Subject: Re: [PATCH] blockdev: acquire aio_context for bitmap add/remove
References: <20190206170205.13061-1-jsnow@redhat.com>
In-Reply-To: <20190206170205.13061-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 11:02 AM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when b=
itmaps
> are added or removed. For configurations like virtio-dataplane, failing=
 to
> acquire this lock will abort QEMU when disk IO occurs.
>=20
> We used to acquire aio_context as part of the bitmap lookup, so re-intr=
oduce
> the lock for just the cases that have an IO penalty.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index fb18e9c975..ce458de037 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2820,6 +2820,7 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
>  {
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> +    AioContext *aio_context =3D NULL;
> =20
>      if (!name || name[0] =3D=3D '\0') {
>          error_setg(errp, "Bitmap name cannot be empty");
> @@ -2854,10 +2855,12 @@ void qmp_block_dirty_bitmap_add(const char *nod=
e, const char *name,
>          disabled =3D false;
>      }
> =20
> -    if (persistent &&
> -        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))=

> -    {
> -        return;
> +    if (persistent) {
> +        aio_context =3D bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
> +        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, er=
rp)) {
> +            goto out;
> +        }
>      }
> =20
>      bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
    if (bitmap =3D=3D NULL) {
        return;
    }

Oops - this early return fails to release the aio context.

> @@ -2870,6 +2873,10 @@ void qmp_block_dirty_bitmap_add(const char *node=
, const char *name,
>      }
> =20
>      bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> + out:
> +    if (aio_context) {
> +        aio_context_release(aio_context);
> +    }
>  }
> =20
>  void qmp_block_dirty_bitmap_remove(const char *node, const char *name,=

> @@ -2878,6 +2885,7 @@ void qmp_block_dirty_bitmap_remove(const char *no=
de, const char *name,
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
>      Error *local_err =3D NULL;
> +    AioContext *aio_context =3D NULL;
> =20
>      bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
>      if (!bitmap || !bs) {
> @@ -2892,14 +2900,20 @@ void qmp_block_dirty_bitmap_remove(const char *=
node, const char *name,
>      }
> =20
>      if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +        aio_context =3D bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
>          bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
> -            return;
> +            goto out;
>          }
>      }
> =20
>      bdrv_release_dirty_bitmap(bs, bitmap);
> + out:
> +    if (aio_context) {
> +        aio_context_release(aio_context);
> +    }
>  }
> =20
>  /**
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MdvmcsllTQhZN0vIbkwsN7qrplcWvddaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjIDIACgkQp6FrSiUn
Q2qVZQf+OAhJwDx0RiV4IflpMJMbxhSQBC+E07XQrVmiJkQ/yWwZBertUvLxClPF
0d6ivth44lliHNkcvWVxyd/q/Fh4ZNRiffM5tORqI9/gX0zpXHGXMwZtuDOxGA6w
hviNDedfaq+tSuhgi5HkDWQGtqbe1ymzXe+5KZuJAH4mIJCE0Do+ah92JlmS9EWm
duHESg+I23fnG3ye3oYONH2H7zPqbNBbyLQyDNKFSWyEnm7o4eSw3yjamG/ZIZRn
2GcT1HEKwHsk1DHXpJVw8MbwvAH6pGfL20CT9ACnWB2oK8GScRPm4mH0VxOQ8ypf
U6pbUoWHsXRfvuKNe/yPcQO9Fz5XOQ==
=bMnn
-----END PGP SIGNATURE-----

--MdvmcsllTQhZN0vIbkwsN7qrplcWvddaf--
