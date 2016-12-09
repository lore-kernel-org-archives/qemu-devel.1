Received: from eggs.gnu.org ([2001:4830:134:3::10]:43391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFPOv-00057O-H7
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFPOu-00030A-Ff
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:56:05 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-18-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c55f093-99d3-0fe1-4ceb-c7b6c3242902@redhat.com>
Date: Fri, 9 Dec 2016 18:55:54 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-18-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Smo46OTmBsp3WvDg2V4NvVsCXD28MrU7s"
Subject: Re: [Qemu-devel] [PATCH 17/21] qmp: add autoload parameter to
 block-dirty-bitmap-add
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
--Smo46OTmBsp3WvDg2V4NvVsCXD28MrU7s
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <3c55f093-99d3-0fe1-4ceb-c7b6c3242902@redhat.com>
Subject: Re: [PATCH 17/21] qmp: add autoload parameter to
 block-dirty-bitmap-add
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-18-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-18-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Optional. Default is false.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  blockdev.c            | 18 ++++++++++++++++--
>  docs/qmp-commands.txt |  4 ++++
>  qapi/block-core.json  |  6 +++++-
>  3 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 3876d1d..3891d86 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1968,6 +1968,7 @@ static void block_dirty_bitmap_add_prepare(BlkAct=
ionState *common,
>      qmp_block_dirty_bitmap_add(action->node, action->name,
>                                 action->has_granularity, action->granul=
arity,
>                                 action->has_persistent, action->persist=
ent,
> +                               action->has_autoload, action->autoload,=

>                                 &local_err);
> =20
>      if (!local_err) {
> @@ -2698,6 +2699,7 @@ out:
>  void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>                                  bool has_granularity, uint32_t granula=
rity,
>                                  bool has_persistent, bool persistent,
> +                                bool has_autoload, bool autoload,
>                                  Error **errp)
>  {
>      AioContext *aio_context;
> @@ -2731,6 +2733,15 @@ void qmp_block_dirty_bitmap_add(const char *node=
, const char *name,
>      if (!has_persistent) {
>          persistent =3D false;
>      }
> +    if (!has_autoload) {
> +        autoload =3D false;
> +    }
> +
> +    if (has_autoload && !persistent) {
> +        error_setg(errp, "Autoload flag must be used only for persiste=
nt "
> +                         "bitmaps");
> +        goto out;
> +    }
> =20
>      if (persistent &&
>              !bdrv_can_store_dirty_bitmap(bs, name, granularity, errp))=
 {
> @@ -2738,10 +2749,13 @@ void qmp_block_dirty_bitmap_add(const char *nod=
e, const char *name,
>      }
> =20
>      bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> -    if (bitmap !=3D NULL) {
> -        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    if (bitmap =3D=3D NULL) {
> +        goto out;
>      }
> =20
> +    bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
> +
>   out:
>      aio_context_release(aio_context);
>  }
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index c4ad1e4..dda2911 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -1018,6 +1018,10 @@ Arguments:
>  - "persistent": bitmap will be saved to the corresponding block device=
 image
>                  file on its close. For now only Qcow2 disks support pe=
rsistent
>                  bitmaps. (json-bool, optional, default false) (Since 2=
=2E8)
> +- "autoload": the bitmap will be automatically loaded when the image i=
t is
> +              stored in is opened. This flag may only be specified for=

> +              persistent bitmaps (json-bool, optional, default false)
> +              (Since 2.8)

*2.9

> =20
>  Example:
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index cec312c..648f94a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1235,11 +1235,15 @@
>  #              corresponding block device image file on its close. Def=
ault is
>  #              false. (Since 2.8)
>  #
> +# @autoload: #optional the bitmap will be automatically loaded when th=
e image
> +#            it is stored in is opened. This flag may only be specifie=
d for
> +#            persistent bitmaps. Default is false. (Since 2.8)

*2.9

With both fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +#
>  # Since 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> -            '*persistent': 'bool' } }
> +            '*persistent': 'bool', '*autoload': 'bool' } }
> =20
>  ##
>  # @block-dirty-bitmap-add
>=20



--Smo46OTmBsp3WvDg2V4NvVsCXD28MrU7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhK8CoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AY1gIAL9QXGkUL5892QTKYHftWE3dUZrOlFLb
up4ypkoHPpEuVrHEb5R4k/mgLcFvZDBu123iBH/9/VcsxH4WPpfbVdSTvdmGmraK
/C0HtcauvgmbFhu8jzstRTgS+cw6hRHQCSAATtlJbcsYUGExRGT2US5XaelSy5EW
Tk16mr9lI8xMd+2+bXGybf4w/7BNvgfgmSjM1bcwxVmBrX0Q9c46pQnD+HF5CYR0
VYoNuyZ5JHGkvwyjzINHyKqnCHya8YRSF8aij25+Zo7tA+pdYrzQY4+u4fhRNgzh
uj/ip+OxaryewoOoKGGO2k3MGw2TB0IuPTsTBVOA+Ux7fI8TVO/79Uo=
=R28h
-----END PGP SIGNATURE-----

--Smo46OTmBsp3WvDg2V4NvVsCXD28MrU7s--
