Received: from eggs.gnu.org ([2001:4830:134:3::10]:50552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXaoy-0006A3-LQ
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXaou-00016r-39
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:46:08 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4fd2fb2b-d5cb-2818-26f9-a9a15c32c22b@redhat.com>
Date: Sat, 28 Jan 2017 22:45:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PoEbHDdHi4Q7dKxHT09h6mb2sAxtxKRc4"
Subject: Re: [Qemu-devel] [PATCH 09/24] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
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
--PoEbHDdHi4Q7dKxHT09h6mb2sAxtxKRc4
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <4fd2fb2b-d5cb-2818-26f9-a9a15c32c22b@redhat.com>
Subject: Re: [PATCH 09/24] qcow2: add .bdrv_load_autoloading_dirty_bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/Makefile.objs  |   2 +-
>  block/qcow2-bitmap.c | 712 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   2 +
>  block/qcow2.h        |   3 +
>  4 files changed, 718 insertions(+), 1 deletion(-)
>  create mode 100644 block/qcow2-bitmap.c
>=20
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 67a036a1df..b8b6cf38a0 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -1,5 +1,5 @@
>  block-obj-y +=3D raw_bsd.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o v=
vfat.o dmg.o

s/raw_bsd/raw-format/

(yes, just contextual, but prevents git from taking the patch as-is)

> -block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapsh=
ot.o qcow2-cache.o
> +block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapsh=
ot.o qcow2-cache.o qcow2-bitmap.o
>  block-obj-y +=3D qed.o qed-gencb.o qed-l2-cache.o qed-table.o qed-clus=
ter.o
>  block-obj-y +=3D qed-check.o
>  block-obj-y +=3D vhdx.o vhdx-endian.o vhdx-log.o
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> new file mode 100644
> index 0000000000..758622dcfc
> --- /dev/null
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

OK, so then all the bitmaps are gone... Well, if you say that's OK, I'll
trust you. O:-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        return ret;
> +    }
> +
> +    s->autoclear_features |=3D QCOW2_AUTOCLEAR_BITMAPS;
> +    return update_header_sync(bs);
> +}


--PoEbHDdHi4Q7dKxHT09h6mb2sAxtxKRc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNEQsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArTEH/3C+Wb2joeyP49vs0YWiijqqxYq9cZ5B
KiDN4XA3Mk1W7cAjuUiJbSbOpG1VmNdhpdvNRxWgigI/O4uhXnvvBsoZlkx+zJIm
jAkHl+hglDzkb/Qn4h4CvuSEMSoifyEvJ42HmbMumSKiQyS4r4/+tdAQojsjqV8I
v8QtVsHVZ7kNdxkPU5Bn4ib7iM48NyGhxPIhC/3xjxYryKYkr2XRFhdEfFapo4Bg
SFDUfG97Qyasq+88m1oyvllji4wgOv8CdjM+Xywic8/LBuK2zfhTR2CtKGL+9vOc
QxU0/hdnPrtYEDmXm0Ss1kWLU9olFfWBWGCtSBdV2ygOze55GVPTQmI=
=C1Du
-----END PGP SIGNATURE-----

--PoEbHDdHi4Q7dKxHT09h6mb2sAxtxKRc4--
