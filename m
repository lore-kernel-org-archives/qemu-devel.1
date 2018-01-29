Received: from eggs.gnu.org ([2001:4830:134:3::10]:33705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egBS2-0000eL-3A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egBRx-0007SW-7b
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:34:30 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8073fbad-e209-f7c7-d788-4f9eed529b56@redhat.com>
Date: Mon, 29 Jan 2018 16:34:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171130164750.47320-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RIHPg1FNDh3My2c5tWIVUp059qXhlOdvJ"
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RIHPg1FNDh3My2c5tWIVUp059qXhlOdvJ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <8073fbad-e209-f7c7-d788-4f9eed529b56@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: add overlap check for bitmap directory
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
 <20171130164750.47320-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171130164750.47320-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-30 17:47, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h          |  7 +++++--
>  block/qcow2-refcount.c | 12 ++++++++++++
>  block/qcow2.c          |  6 ++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6f0ff15dd0..8f226a3609 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -98,6 +98,7 @@
>  #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE "overlap-check.snapshot-table=
"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-l1"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-direc=
tory"
>  #define QCOW2_OPT_CACHE_SIZE "cache-size"
>  #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
> @@ -406,8 +407,9 @@ typedef enum QCow2MetadataOverlap {
>      QCOW2_OL_SNAPSHOT_TABLE_BITNR =3D 5,
>      QCOW2_OL_INACTIVE_L1_BITNR    =3D 6,
>      QCOW2_OL_INACTIVE_L2_BITNR    =3D 7,
> +    QCOW2_OL_BITMAP_DIRECTORY_BITNR =3D 8,
> =20
> -    QCOW2_OL_MAX_BITNR            =3D 8,
> +    QCOW2_OL_MAX_BITNR              =3D 9,
> =20
>      QCOW2_OL_NONE           =3D 0,
>      QCOW2_OL_MAIN_HEADER    =3D (1 << QCOW2_OL_MAIN_HEADER_BITNR),
> @@ -420,12 +422,13 @@ typedef enum QCow2MetadataOverlap {
>      /* NOTE: Checking overlaps with inactive L2 tables will result in =
bdrv
>       * reads. */
>      QCOW2_OL_INACTIVE_L2    =3D (1 << QCOW2_OL_INACTIVE_L2_BITNR),
> +    QCOW2_OL_BITMAP_DIRECTORY =3D (1 << QCOW2_OL_BITMAP_DIRECTORY_BITN=
R),
>  } QCow2MetadataOverlap;
> =20
>  /* Perform all overlap checks which can be done in constant time */
>  #define QCOW2_OL_CONSTANT \
>      (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIVE_L1 | QCOW2_OL_REFCOUNT_TAB=
LE | \
> -     QCOW2_OL_SNAPSHOT_TABLE)
> +     QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_DIRECTORY)
> =20
>  /* Perform all overlap checks which don't require disk access */
>  #define QCOW2_OL_CACHED \
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3de1ab51ba..a7a2703f26 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2585,6 +2585,18 @@ int qcow2_check_metadata_overlap(BlockDriverStat=
e *bs, int ign, int64_t offset,
>          }
>      }
> =20
> +    if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
> +        (s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS))
> +    {
> +        /* update_ext_header_and_dir_in_place firstly drop autoclear f=
lag,
> +         * so it will not fail */

That's really not an argument.  bitmap_list_store() has to pass
QCOW2_OL_BITMAP_DIRECTORY to @ign anyway.  (Because there is no reason
not to.)

Max

> +        if (overlaps_with(s->bitmap_directory_offset,
> +                          s->bitmap_directory_size))
> +        {
> +            return QCOW2_OL_BITMAP_DIRECTORY;
> +        }
> +    }
> +
>      return 0;
>  }
> =20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1914a940e5..8278c0e124 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -655,6 +655,11 @@ static QemuOptsList qcow2_runtime_opts =3D {
>              .help =3D "Check for unintended writes into an inactive L2=
 table",
>          },
>          {
> +            .name =3D QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
> +            .type =3D QEMU_OPT_BOOL,
> +            .help =3D "Check for unintended writes into the bitmap dir=
ectory",
> +        },
> +        {
>              .name =3D QCOW2_OPT_CACHE_SIZE,
>              .type =3D QEMU_OPT_SIZE,
>              .help =3D "Maximum combined metadata (L2 tables and refcou=
nt blocks) "
> @@ -690,6 +695,7 @@ static const char *overlap_bool_option_names[QCOW2_=
OL_MAX_BITNR] =3D {
>      [QCOW2_OL_SNAPSHOT_TABLE_BITNR] =3D QCOW2_OPT_OVERLAP_SNAPSHOT_TAB=
LE,
>      [QCOW2_OL_INACTIVE_L1_BITNR]    =3D QCOW2_OPT_OVERLAP_INACTIVE_L1,=

>      [QCOW2_OL_INACTIVE_L2_BITNR]    =3D QCOW2_OPT_OVERLAP_INACTIVE_L2,=

> +    [QCOW2_OL_BITMAP_DIRECTORY_BITNR] =3D QCOW2_OPT_OVERLAP_BITMAP_DIR=
ECTORY,
>  };
> =20
>  static void cache_clean_timer_cb(void *opaque)
>=20



--RIHPg1FNDh3My2c5tWIVUp059qXhlOdvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvPvISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4vAIAKhgKM1OfZEZSGchkb42DIIMzDksa5Ws
qjKHqyuDYGJs4iskprZPtCmY1+oYDt50oGDHu+7jZEAGJlYTO1vJjz3BT3PVILPz
8TtITt7zD7j5SU//mti/389VP5fKVlMjZVppHSAvX13FKaDEa9+wMMfj/Zgj2uk4
IYnoXO2e46xGZVHsbzlb0T8lm5rSWjiJM1tqxKyUX1jfpK33peplUpHl6oaDqJOd
tns6k053p23nWmG+xoZQpuNqRkQN0IJ1VZ7e5MhEioII5iXW6RnhJdRTwh/8Pzm0
VmNJ5vji31vpYscA33hWi6/PZIb+Zya9nWFmfdNlmMZTHLZvDkuWnkw=
=FHWb
-----END PGP SIGNATURE-----

--RIHPg1FNDh3My2c5tWIVUp059qXhlOdvJ--
