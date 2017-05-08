Received: from eggs.gnu.org ([2001:4830:134:3::10]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7pNy-0006xJ-Uw
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7pNv-0001Gm-J3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:36:02 -0400
Date: Mon, 8 May 2017 16:35:56 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508203556.GA22634@stefanha-x1.localdomain>
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20170504105444.8940-1-daniel.kucera@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] mirror: add sync mode incremental to
 drive-mirror and blockdev-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Kucera <daniel.kucera@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com, "Denis V. Lunev" <den@openvz.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 12:54:40PM +0200, Daniel Kucera wrote:

Seems like a logical extension along the same lines as the backup block
job's dirty bitmap sync mode.

> parameter bitmap chooses existing dirtymap instead of newly created
> in mirror_start_job
>=20
> Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com>
> ---
>  block/mirror.c            | 47 ++++++++++++++++++++++++++++++-----------=
------
>  blockdev.c                | 16 +++++++++++++++-
>  include/block/block_int.h |  4 +++-
>  qapi/block-core.json      | 12 ++++++++++--
>  4 files changed, 58 insertions(+), 21 deletions(-)

This patch modifies the user's bitmap in-place and does not
differentiate successful completion from failure.  I suggest following
the same bitmap lifecycle as the backup block job so that
cancellation/failure offers useful behavior.  (If the job fails due to
intermittent errors on the target it should be possible to start the job
again - the bitmap must not be lost!).

> diff --git a/block/mirror.c b/block/mirror.c
> index 9f5eb69..1bfbe2e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -49,7 +49,7 @@ typedef struct MirrorBlockJob {
>      BlockDriverState *to_replace;
>      /* Used to block operations on the drive-mirror-replace target */
>      Error *replace_blocker;
> -    bool is_none_mode;
> +    MirrorSyncMode sync_mode;
>      BlockMirrorBackingMode backing_mode;
>      BlockdevOnError on_source_error, on_target_error;
>      bool synced;
> @@ -523,7 +523,9 @@ static void mirror_exit(BlockJob *job, void *opaque)
>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>                              &error_abort);
>      if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
> -        BlockDriverState *backing =3D s->is_none_mode ? src : s->base;
> +        BlockDriverState *backing =3D
> +        (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) ||
> +        (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) ? src : s->base;

Please update the comment in include/block/block_int.h:typedef enum
BlockMirrorBackingMode.

> @@ -1213,9 +1217,21 @@ static void mirror_start_job(const char *job_id, B=
lockDriverState *bs,
>          s->should_complete =3D true;
>      }
> =20
> -    s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, NULL, =
errp);
> -    if (!s->dirty_bitmap) {
> -        goto fail;
> +    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
> +        if (bitmap =3D=3D NULL) {
> +            error_setg(errp, "Mode incremental requires parameter 'bitma=
p'");
> +            goto fail;
> +        }
> +        s->dirty_bitmap =3D bdrv_find_dirty_bitmap(bs, bitmap);
> +        if (!s->dirty_bitmap) {
> +            error_setg(errp, "Bitmap '%s' not found", bitmap);
> +            goto fail;
> +        }
> +    } else {
> +        s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, NU=
LL, errp);
> +        if (!s->dirty_bitmap) {
> +            goto fail;
> +        }
>      }

Do we need to check that granularity is compatible with the pre-existing
dirty bitmap's granularity when sync_mode is
MIRROR_SYNC_MODE_INCREMENTAL?

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZENasAAoJEJykq7OBq3PIqw4H/1lnNzA9TmOLL5yCe8jf47Lv
xQvPp1JBU+rh6gbDW0KxaOt36o9PArbL8MhkgS8ZtzCJtVy0Dsw1TtUrYSh9Onc2
eoDAFx2idpW5MxYaUDZFkBk6SKBTB80+rZirPh33BYQbtedgaandmgt8o9WyIaeN
6IVkMnOO6k4DVnP53wI77RCycTu0GYplNokvlel5ScCJ4JpWaYTlsKKCfh1IPLha
vgpABQStKZCaM9YzCkFbbKkEm70IND4mC7uV/LmCHMK8PXWJFDDkidT/bVLT58ZE
j/expQLuoV478m/LWLjD44PE9r6tF9QhN+URRo90diShvSuydIzqnYiME2V4E3k=
=yOaG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
