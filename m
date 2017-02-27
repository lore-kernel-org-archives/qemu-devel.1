Received: from eggs.gnu.org ([2001:4830:134:3::10]:37189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKlI-0000Dk-O3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKlH-0001yv-JK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:50:44 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <15df3d2b-17e9-a229-154e-dfdb502216ad@redhat.com>
Date: Mon, 27 Feb 2017 13:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170225170758.427066-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g7Q5ATFmxj1nHMkNM5fWFkxRuETkcKnF0"
Subject: Re: [Qemu-devel] [PATCH v16 09/22] qcow2: autoloading dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g7Q5ATFmxj1nHMkNM5fWFkxRuETkcKnF0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <15df3d2b-17e9-a229-154e-dfdb502216ad@redhat.com>
Subject: Re: [PATCH v16 09/22] qcow2: autoloading dirty bitmaps
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
 <20170225170758.427066-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 367 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   7 +
>  block/qcow2.h        |   2 +
>  3 files changed, 376 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b8e472b3e8..73a6e87038 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c

[...]

> +static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
> +                                              Qcow2BitmapList *bm_list=
)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS) ||
> +        bm_list =3D=3D NULL || QSIMPLEQ_EMPTY(bm_list) ||
> +        bitmap_list_count(bm_list) !=3D s->nb_bitmaps)
> +    {
> +        return -EINVAL;
> +    }
> +
> +    s->autoclear_features &=3D ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
> +    ret =3D update_header_sync(bs);
> +    if (ret < 0) {
> +        /* Two variants are possible here:
> +         * 1. Autoclear flag is dropped, all bitmaps will be lost.
> +         * 2. Autoclear flag is not dropped, old state is left.
> +         */
> +        return ret;
> +    }
> +
> +    /* autoclear bit is not set, so we can safely update bitmap direct=
ory */
> +
> +    ret =3D bitmap_list_store(bs, bm_list, &s->bitmap_directory_offset=
,
> +                            &s->bitmap_directory_size, true);
> +    if (ret < 0) {
> +        /* autoclear bit is cleared, so all leaked clusters would be r=
emoved on
> +         * qemu-img check */
> +        return ret;
> +    }
> +
> +    ret =3D update_header_sync(bs);
> +    if (ret < 0) {
> +        /* autoclear bit is cleared, so all leaked clusters would be r=
emoved on
> +         * qemu-img check */
> +        return ret;
> +    }
> +
> +    s->autoclear_features |=3D QCOW2_AUTOCLEAR_BITMAPS;
> +    return update_header_sync(bs);
> +    /* If final update_header_sync() fails, two variants are possible:=

> +     * 1. Autoclear flag is not set, all bitmaps will be lost.
> +     * 2. Autoclear flag is set, header and directory are successfully=
 updated.
> +     */

Oh, nice. Thanks for the explanations, too. This way I'm very much fine
with update_header_sync() failing if bdrv_flush() fails.

> +}
> +
> +/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
> +static void release_dirty_bitmap_helper(gpointer bitmap,
> +                                        gpointer bs)
> +{
> +    bdrv_release_dirty_bitmap(bs, bitmap);
> +}

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6cd411f9c5..f4bb9d46de 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1237,6 +1237,13 @@ static int qcow2_open(BlockDriverState *bs, QDic=
t *options, int flags,
>          goto fail;
>      }
> =20
> +    qcow2_load_autoloading_dirty_bitmaps(bs, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
>      /* Clear unknown autoclear feature bits */
>      need_update_header |=3D s->autoclear_features & ~QCOW2_AUTOCLEAR_M=
ASK;
> =20

I think it would be better to load the dirty bitmaps after clearing
unknown autoclear bits, because loading the bitmaps may result in
modifications of the image file.

Max


--g7Q5ATFmxj1nHMkNM5fWFkxRuETkcKnF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0IJgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AT/IH/1jQ8Z0zmeTgkUqNAjD79nBhD0Iduov4
ZllvaujeIMFCXVmJSrJbzJg7NJ9c5kzExD9b5mdAan8DvKJeh2GdzRKTDa2/Lg12
18PusveVUmVwJ0aFpJLgWapkr+M2EOPx+CM51u9vKhf5vr34ik4lRbz5DUbdO0cy
7nIL9sC9GrgHL3LB6wyv61kSm2KBUU3iXv81uEk+XfJK+B/pg1KfyhrFl8I3bu0X
M6AY1VhseCzoQmardI55CWUgweuQSf+fJB7Kuvr4mk6ZgXoI49muH+5Gm/KsFQN6
ImPJeDCr8bvy85DlmzfB79UIr0uVVPvacCP4HfUxVJ9pNnMgjVc7xtg=
=mjDe
-----END PGP SIGNATURE-----

--g7Q5ATFmxj1nHMkNM5fWFkxRuETkcKnF0--
