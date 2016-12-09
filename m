Received: from eggs.gnu.org ([2001:4830:134:3::10]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFP6a-00086X-Si
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFP6Z-0005oM-RY
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:37:08 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5e329dfb-03b3-94ce-e7e3-d87c74fe227b@redhat.com>
Date: Fri, 9 Dec 2016 18:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RNElR4hslMJQKkFxrdsuWMgJfujkQ1hGk"
Subject: Re: [Qemu-devel] [PATCH 16/21] qmp: add persistent flag to
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
--RNElR4hslMJQKkFxrdsuWMgJfujkQ1hGk
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <5e329dfb-03b3-94ce-e7e3-d87c74fe227b@redhat.com>
Subject: Re: [PATCH 16/21] qmp: add persistent flag to block-dirty-bitmap-add
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
> Default is false.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  blockdev.c            | 17 ++++++++++++++++-
>  docs/qmp-commands.txt |  3 +++
>  qapi/block-core.json  |  7 ++++++-
>  3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 245e1e1..3876d1d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1967,6 +1967,7 @@ static void block_dirty_bitmap_add_prepare(BlkAct=
ionState *common,
>      /* AIO context taken and released within qmp_block_dirty_bitmap_ad=
d */
>      qmp_block_dirty_bitmap_add(action->node, action->name,
>                                 action->has_granularity, action->granul=
arity,
> +                               action->has_persistent, action->persist=
ent,
>                                 &local_err);
> =20
>      if (!local_err) {
> @@ -2696,10 +2697,12 @@ out:
> =20
>  void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>                                  bool has_granularity, uint32_t granula=
rity,
> +                                bool has_persistent, bool persistent,
>                                  Error **errp)
>  {
>      AioContext *aio_context;
>      BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> =20
>      if (!name || name[0] =3D=3D '\0') {
>          error_setg(errp, "Bitmap name cannot be empty");
> @@ -2725,7 +2728,19 @@ void qmp_block_dirty_bitmap_add(const char *node=
, const char *name,
>          granularity =3D bdrv_get_default_bitmap_granularity(bs);
>      }
> =20
> -    bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> +    if (!has_persistent) {
> +        persistent =3D false;
> +    }
> +
> +    if (persistent &&
> +            !bdrv_can_store_dirty_bitmap(bs, name, granularity, errp))=
 {

Alignment to the opening parenthesis, please.

(Also, this may need a change depending on whether you want to rename it
to bdrv_can_store_new_dirty_bitmap().)

With that and the s/2\.8/2.9/ below fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        goto out;
> +    }
> +
> +    bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> +    if (bitmap !=3D NULL) {
> +        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    }
> =20
>   out:
>      aio_context_release(aio_context);
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index abf210a..c4ad1e4 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -1015,6 +1015,9 @@ Arguments:
>  - "node": device/node on which to create dirty bitmap (json-string)
>  - "name": name of the new dirty bitmap (json-string)
>  - "granularity": granularity to track writes with (int, optional)
> +- "persistent": bitmap will be saved to the corresponding block device=
 image
> +                file on its close. For now only Qcow2 disks support pe=
rsistent
> +                bitmaps. (json-bool, optional, default false) (Since 2=
=2E8)
> =20
>  Example:
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c29bef7..cec312c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1231,10 +1231,15 @@
>  # @granularity: #optional the bitmap granularity, default is 64k for
>  #               block-dirty-bitmap-add
>  #
> +# @persistent: #optional the bitmap is persistent, i.e. it will be sav=
ed to the
> +#              corresponding block device image file on its close. Def=
ault is
> +#              false. (Since 2.8)
> +#
>  # Since 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
> -  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }=

> +  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> +            '*persistent': 'bool' } }
> =20
>  ##
>  # @block-dirty-bitmap-add
>=20



--RNElR4hslMJQKkFxrdsuWMgJfujkQ1hGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhK67gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Adg0IAInokq1PyggpQyE1tyo/gJPy/hWraQON
ZAyX7HmwfXwEcIbIUg0biqjsbW+3vramw3mvYle+VxjxC6tlQ5fSuuIv068+l7XF
qhJtSO2AcsIZP886avOf5NUkkWFvvrW8X2HhMH4M4xNfWtpK7R2c40jscOQigmo/
xgm/Av7S0U3+UEILn23o0+VSYOLAlClEadOtwgLp6+EAUyABKDPZy8GgIbmUppF8
e4TR2z1XMEST5aOg1GiNBy5imE+avJFiUAexhXniw5pXNK4YZVBPX+D5Wsb/O0R4
j1lwbfPCyuKMKPeVouxfy000IZDyjzdO3rsH4Q7FohbDVqCXVYo8Rms=
=X3bu
-----END PGP SIGNATURE-----

--RNElR4hslMJQKkFxrdsuWMgJfujkQ1hGk--
