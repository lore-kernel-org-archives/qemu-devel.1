Received: from eggs.gnu.org ([2001:4830:134:3::10]:37080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce0sX-0007ZC-SF
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce0sW-00034y-S9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:48:21 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-4-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c464b4f-38ef-778c-637c-261a9691d814@redhat.com>
Date: Wed, 15 Feb 2017 15:48:10 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VuVjB84IBT0kSaGnRDFlnK4HJVH24FGaI"
Subject: Re: [Qemu-devel] [RFC PATCH 03/41] block: Add Error argument to
 bdrv_attach_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VuVjB84IBT0kSaGnRDFlnK4HJVH24FGaI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <6c464b4f-38ef-778c-637c-261a9691d814@redhat.com>
Subject: Re: [RFC PATCH 03/41] block: Add Error argument to
 bdrv_attach_child()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> It will have to return an error soon, so prepare the callers for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 13 ++++++++++---
>  block/quorum.c        |  8 +++++++-
>  include/block/block.h |  3 ++-
>  3 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 0618f4b..9895aaf 100644
> --- a/block.c
> +++ b/block.c
> @@ -1323,7 +1323,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
>  BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
>                               BlockDriverState *child_bs,
>                               const char *child_name,
> -                             const BdrvChildRole *child_role)
> +                             const BdrvChildRole *child_role,
> +                             Error **errp)
>  {
>      BdrvChild *child =3D bdrv_root_attach_child(child_bs, child_name, =
child_role,
>                                                parent_bs);
> @@ -1424,7 +1425,9 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bl=
ockDriverState *backing_hd)
>          bs->backing =3D NULL;
>          goto out;
>      }
> -    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &chil=
d_backing);
> +    /* FIXME Error handling */
> +    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &chil=
d_backing,
> +                                    &error_abort);

Not sure if this counts as "prepare the callers for it". ;-)

>      bs->open_flags &=3D ~BDRV_O_NO_BACKING;
>      pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_hd->fi=
lename);
>      pstrcpy(bs->backing_format, sizeof(bs->backing_format),
> @@ -1594,7 +1597,11 @@ BdrvChild *bdrv_open_child(const char *filename,=

>          goto done;
>      }
> =20
> -    c =3D bdrv_attach_child(parent, bs, bdref_key, child_role);
> +    c =3D bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
> +    if (!c) {
> +        bdrv_unref(bs);
> +        goto done;
> +    }
> =20
>  done:
>      qdict_del(options, bdref_key);
> diff --git a/block/quorum.c b/block/quorum.c
> index 86e2072..45bf010 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1032,10 +1032,16 @@ static void quorum_add_child(BlockDriverState *=
bs, BlockDriverState *child_bs,
> =20
>      /* We can safely add the child now */
>      bdrv_ref(child_bs);
> -    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format)=
;
> +
> +    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format,=
 errp);
> +    if (child =3D=3D NULL) {
> +        bdrv_unref(child_bs);
> +        goto out;

Might make sense to decrement next_child_index here, but it's not necessa=
ry.

(That means: Patch is fine, I'm just nagging because I like to nag.)

Max

> +    }
>      s->children =3D g_renew(BdrvChild *, s->children, s->num_children =
+ 1);
>      s->children[s->num_children++] =3D child;
> =20
> +out:
>      bdrv_drained_end(bs);
>  }
> =20
> diff --git a/include/block/block.h b/include/block/block.h
> index 4e81f20..93812df 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -482,7 +482,8 @@ void bdrv_unref_child(BlockDriverState *parent, Bdr=
vChild *child);
>  BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
>                               BlockDriverState *child_bs,
>                               const char *child_name,
> -                             const BdrvChildRole *child_role);
> +                             const BdrvChildRole *child_role,
> +                             Error **errp);
> =20
>  bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **=
errp);
>  void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason=
);
>=20



--VuVjB84IBT0kSaGnRDFlnK4HJVH24FGaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikaioSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9JIH/0Q1PuHVkbZ2BaDQlVrxt45rkKqPxrJT
U+zl8E3xrkmYFCScsSDAHaKbvHs83C36JHCLyyZkJcaO68Ovu+Buv01JdFGLbz1r
5Ql/4iCK2ofL9ekOLAGvaTCDQXR50dCHGCBfk4CEXTwYizBrmKt1VPqTutJyi0nx
03vNVNMPGjbKwpIQTUS0s9gg8NzzT2IddVv8NiD2lmAGUAcQ4+4ZX+bV9eq0KaMQ
aYEDFlk2oZhHQVJCfrcfn42DwujPmsnw4TidM7UrEMcRRIt8tRxlYIfBWbGTAScg
qy2ojbEBksdk+6nM2dGrxsCXzFkjRq9x4GZzrPykadBFyrZass/pegw=
=GTQj
-----END PGP SIGNATURE-----

--VuVjB84IBT0kSaGnRDFlnK4HJVH24FGaI--
