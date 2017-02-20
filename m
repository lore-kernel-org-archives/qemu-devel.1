Received: from eggs.gnu.org ([2001:4830:134:3::10]:34086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfmBW-0002oc-LY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfmBV-0000jY-JS
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:31:14 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-19-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95e36837-d39a-fecb-6a22-b9826b312fe0@redhat.com>
Date: Mon, 20 Feb 2017 12:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-19-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JJ7v1NvlXBIHXir7vIXALTQo24xpFW9BE"
Subject: Re: [Qemu-devel] [RFC PATCH 18/41] block: Allow error return in
 BlockDevOps.change_media_cb()
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
--JJ7v1NvlXBIHXir7vIXALTQo24xpFW9BE
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <95e36837-d39a-fecb-6a22-b9826b312fe0@redhat.com>
Subject: Re: [RFC PATCH 18/41] block: Allow error return in
 BlockDevOps.change_media_cb()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-19-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Some devices allow a media change between read-only and read-write
> media. They need to adapt the permissions in their .change_media_cb()
> implementation, which can fail. So add an Error parameter to the
> function.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 12 +++++++++---
>  blockdev.c                     | 19 +++++++++++++++----
>  hw/block/fdc.c                 |  2 +-
>  hw/ide/core.c                  |  2 +-
>  hw/scsi/scsi-disk.c            |  2 +-
>  hw/sd/sd.c                     |  2 +-
>  include/block/block_int.h      |  2 +-
>  include/sysemu/block-backend.h |  2 +-
>  8 files changed, 30 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index e10a278..0c23add 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -671,15 +671,21 @@ void blk_set_dev_ops(BlockBackend *blk, const Blo=
ckDevOps *ops,
>   * Else, notify of media eject.
>   * Also send DEVICE_TRAY_MOVED events as appropriate.
>   */
> -void blk_dev_change_media_cb(BlockBackend *blk, bool load)
> +void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **err=
p)

May deserve a comment that this function never fails with
load =3D=3D false. The assertion is not too hidden, but it's not extremel=
y
visible either.

Max

>  {
>      if (blk->dev_ops && blk->dev_ops->change_media_cb) {
>          bool tray_was_open, tray_is_open;
> +        Error *local_err =3D NULL;
> =20
>          assert(!blk->legacy_dev);
> =20
>          tray_was_open =3D blk_dev_is_tray_open(blk);
> -        blk->dev_ops->change_media_cb(blk->dev_opaque, load);
> +        blk->dev_ops->change_media_cb(blk->dev_opaque, load, &local_er=
r);
> +        if (local_err) {
> +            assert(load =3D=3D true);
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>          tray_is_open =3D blk_dev_is_tray_open(blk);
> =20
>          if (tray_was_open !=3D tray_is_open) {


--JJ7v1NvlXBIHXir7vIXALTQo24xpFW9BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq03gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXtUIALIfVr1WASutl55tk1YjNHBWqOh4Mixm
EhvWLYjLtVCd7xONc9xOy6STps4QMk3G5D1ZmRz8toarc/hYIdi26YTIIhshrG8O
rfrkXWe8rOMtMjQtFGCnyxhGzswljK4bsALxPtTbMCANs9TJ/1OUV0/U9IWwojkd
cXREUQGnd3IqOKvmCLBtT2gQqE+JgeS3DsJ7f2ZAz1JOe41v0o2jijkHaZNTgcCU
I4lQZ0EWabrD9J7OvF9c1gamS1Ep59Yqwb4gn2qKFHvJYO13wrjZ4aAIWzwxrkYI
Ci+4utfVa/UGYlQ6lL2jwB2unMVdqbL7zG7M6FnljtrAjAd4zemXz68=
=YGMf
-----END PGP SIGNATURE-----

--JJ7v1NvlXBIHXir7vIXALTQo24xpFW9BE--
