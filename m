Received: from eggs.gnu.org ([2001:4830:134:3::10]:46715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfn2M-00008w-1y
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfn2L-0004IG-6f
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:25:50 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-20-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8592787-34e5-1ab3-7e33-596f97520cd3@redhat.com>
Date: Mon, 20 Feb 2017 13:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-20-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RqIee2TQfK3wBAgIgWKJNm9Cc8AvIIQWx"
Subject: Re: [Qemu-devel] [RFC PATCH 19/41] hw/block: Request permissions
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
--RqIee2TQfK3wBAgIgWKJNm9Cc8AvIIQWx
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <c8592787-34e5-1ab3-7e33-596f97520cd3@redhat.com>
Subject: Re: [RFC PATCH 19/41] hw/block: Request permissions
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-20-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> This makes all device emulations with a qdev drive property request
> permissions on their BlockBackend. We don't block anything yet.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/block/block.c                 | 19 ++++++++++++++++++-
>  hw/block/fdc.c                   | 25 +++++++++++++++++++++++--
>  hw/block/m25p80.c                |  8 ++++++++
>  hw/block/nand.c                  |  7 +++++++
>  hw/block/nvme.c                  |  8 +++++++-
>  hw/block/onenand.c               |  7 +++++++
>  hw/block/pflash_cfi01.c          | 18 ++++++++++++------
>  hw/block/pflash_cfi02.c          | 19 +++++++++++++------
>  hw/block/virtio-blk.c            |  8 +++++++-
>  hw/core/qdev-properties-system.c |  1 -
>  hw/ide/qdev.c                    |  7 +++++--
>  hw/nvram/spapr_nvram.c           |  8 ++++++++
>  hw/scsi/scsi-disk.c              |  8 ++++++--

Since I have no idea how scsi-generic and all of that works, just an
innocent question: Do we need to set permissions there, too?

>  hw/sd/sd.c                       |  6 ++++++
>  hw/usb/dev-storage.c             |  6 +++++-
>  include/hw/block/block.h         |  3 ++-
>  tests/qemu-iotests/051.pc.out    |  6 +++---
>  17 files changed, 137 insertions(+), 27 deletions(-)

[...]

> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 2d6eb46..190573c 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1215,6 +1215,7 @@ static void m25p80_realize(SSISlave *ss, Error **=
errp)
>  {
>      Flash *s =3D M25P80(ss);
>      M25P80Class *mc =3D M25P80_GET_CLASS(s);
> +    int ret;
> =20
>      s->pi =3D mc->pi;
> =20
> @@ -1222,6 +1223,13 @@ static void m25p80_realize(SSISlave *ss, Error *=
*errp)
>      s->dirty_page =3D -1;
> =20
>      if (s->blk) {
> +        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
> +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE=
);
> +        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);

Not sure whether it should be changed in this patch, but I don't know
whether BLK_PERM_ALL is right here; and from a quick glance it doesn't
look like any of the following patches change it.

(Same for all of the block device emulation code that invokes
blk_set_perm() directly.)

Max

> +        if (ret < 0) {
> +            return;
> +        }
> +
>          DB_PRINT_L(0, "Binding to IF_MTD drive\n");
>          s->storage =3D blk_blockalign(s->blk, s->size);
> =20

[...]


--RqIee2TQfK3wBAgIgWKJNm9Cc8AvIIQWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq4EESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Af2IH/i13c0xUXpYL4jn3jecObYRaY0m86q4d
KiTQz4EYpYLoIC4Lf4D52hMoQ8Zqvv4BYnQjTtMjTLOIW2MXiOy+s+XUpkbs09IE
o0kvhgZZzQqoXn27DOTMvHUa0ZYCUJMRmKZmmVRBe7kOCYF75iALeMm5oiHETZhk
kPfDy8nm0U5PzP8V73nDPKK4CWjJk2S/JCNStofk5PdRhrXLahHYP18+60Iev9vm
Ld+YkSmNm1mbXCNi0MF1uakJ83PlmYMkxJe5C2xSfNmK8bm/V/g6ykxkuYcbxYJV
jqTi7T4WlVnLWKiLfHk5oszRYJ5XMgir7otMkbOtLb6UQY2o6iQxwBM=
=VOKf
-----END PGP SIGNATURE-----

--RqIee2TQfK3wBAgIgWKJNm9Cc8AvIIQWx--
