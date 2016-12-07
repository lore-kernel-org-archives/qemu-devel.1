Received: from eggs.gnu.org ([2001:4830:134:3::10]:52391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEguW-0004yQ-Ky
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEguV-0001sZ-JJ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:44 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
Date: Wed, 7 Dec 2016 19:25:31 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hHbfnVii8bh5LSbSwVK6gwaT0XDIifnLt"
Subject: Re: [Qemu-devel] [PATCH 07/21] qcow2: add bitmaps extension
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
--hHbfnVii8bh5LSbSwVK6gwaT0XDIifnLt
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
Subject: Re: [PATCH 07/21] qcow2: add bitmaps extension
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints.
>=20
> For now, disable image resize if it has bitmaps. It will be fixed later=
=2E
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  block/qcow2.h |  24 +++++++++++++
>  2 files changed, 129 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6d5689a..7908657 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -63,6 +63,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_END 0
>  #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> +#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> =20
>  static int qcow2_probe(const uint8_t *buf, int buf_size, const char *f=
ilename)
>  {
> @@ -92,6 +93,7 @@ static int qcow2_read_extensions(BlockDriverState *bs=
, uint64_t start_offset,
>      QCowExtension ext;
>      uint64_t offset;
>      int ret;
> +    Qcow2BitmapHeaderExt bitmaps_ext;
> =20
>  #ifdef DEBUG_EXT
>      printf("qcow2_read_extensions: start=3D%ld end=3D%ld\n", start_off=
set, end_offset);
> @@ -162,6 +164,81 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
>              }
>              break;
> =20
> +        case QCOW2_EXT_MAGIC_BITMAPS:
> +            if (ext.len !=3D sizeof(bitmaps_ext)) {
> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
> +                                 "Invalid extension length");
> +                return -EINVAL;
> +            }
> +
> +            if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
> +                fprintf(stderr,
> +                        "WARNING: a program lacking bitmap support mod=
ified "
> +                        "this file, so all bitmaps are now considered =
"
> +                        "inconsistent");
> +                break;
> +            }

I think It would be nice if qemu-img check could remove all bitmaps and
related data if this bit is not set. Otherwise, we're practically
leaking data.

(But this can be added in a later patch.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hHbfnVii8bh5LSbSwVK6gwaT0XDIifnLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhIVBsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A95oH/iKqXEId6Nhp4DQsWAEQK3deMBcKklLg
5DluAim51kJsUV711D66yN0ozOYUbzFuzPzMlSnlNmMNhK2rHXSbSoj28AW5GpXr
u4qGQMzDLGQ/wWZxaO9pGOxN1XSPPYcFFbrpxzV4PyvBR7SHiOHJsdSdue3pjvQk
uIHXzlnAMGtHh9Rye3Cx1R7wJa0FPeOTfirxBRAwt9L7GKdPPSW6UBLIhyUyAWvb
ti5byPZHKyHGG7WR4E4LUXE3DAPZr4Bhc8rYI5ATrc2RniniMeFRsPqYObmWio8/
bc1KKYwAfc99vRg+IUA5Q5CABKbcKgYH6H9NmoDJ3gG++FL7cbwSPfc=
=IVK0
-----END PGP SIGNATURE-----

--hHbfnVii8bh5LSbSwVK6gwaT0XDIifnLt--
