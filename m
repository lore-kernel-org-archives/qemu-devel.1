Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXaYo-0007hm-SH
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXaYj-0005MS-Uw
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:29:26 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
Date: Sat, 28 Jan 2017 22:29:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wp9QUEodC9VRoLVqQCbUj68IqSmsoIouo"
Subject: Re: [Qemu-devel] [PATCH 07/24] qcow2: add bitmaps extension
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
--wp9QUEodC9VRoLVqQCbUj68IqSmsoIouo
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
Subject: Re: [PATCH 07/24] qcow2: add bitmaps extension
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints.
>=20
> For now, disable image resize if it has bitmaps. It will be fixed later=
=2E
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  block/qcow2.h |  24 ++++++++++++
>  2 files changed, 141 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..a8835988c7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -185,6 +265,15 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
>          offset +=3D ((ext.len + 7) & ~7);
>      }
> =20
> +    if (need_update && !bdrv_is_root_node(bs) &&
> +        !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
> +    {
> +        ret =3D qcow2_update_header(bs);

Good idea, but qcow2_read_extensions() can be called pretty early in
qcow2_open(). Therefore, some fields in the BDRVQcow2State are not
necessarily set already.

For instance, it is always called before s->snapshots_offset and
s->nb_snapshots are set. Thus, this will effectively always discard all
snapshots.

Max


--wp9QUEodC9VRoLVqQCbUj68IqSmsoIouo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNDSISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbtMIAIDZ6zUUe1JUl01ArwVgdwNmF5T2LvOf
WgvWulApB/ZUKOhdZKYENynJGhGf0Qu/ILuKrIyDvq+j1nxSDCGvSiX/tE0I8tH0
LlWQm2ounWMlJImlpqDSm58RMG+9KLsk8+QHKiZfG/awn3afrkoRcJbueFRW88oM
4nfT8TYTK8uEasos7cpsI2ffEVvtrrTp7U0uHvxcS+mGAM+O4Ee5HFCiHvJlILJd
YlF+/M2/E6VzPk0dKjl+m3EizdGnEySc9kde2qY46FnQ1Jy/edKG4UeEG6Xm8l8E
cx/l5SJqZfbWhoY3WQzi7QtEpOufrtbemwvxeeLIGlT+bNM89YAcf3s=
=3dov
-----END PGP SIGNATURE-----

--wp9QUEodC9VRoLVqQCbUj68IqSmsoIouo--
