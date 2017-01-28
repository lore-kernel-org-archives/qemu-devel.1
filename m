Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbW7-0002c0-A1
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbW5-0004Dv-US
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:30:43 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-14-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c07969f2-a470-4f18-7cfa-3090568cb026@redhat.com>
Date: Sat, 28 Jan 2017 23:30:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="deV2v9OdexL4kirODuHrfUv47mXCE2bOx"
Subject: Re: [Qemu-devel] [PATCH 13/24] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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
--deV2v9OdexL4kirODuHrfUv47mXCE2bOx
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <c07969f2-a470-4f18-7cfa-3090568cb026@redhat.com>
Subject: Re: [PATCH 13/24] qcow2: add .bdrv_store_persistent_dirty_bitmaps()
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Realize block bitmap storing interface, to allow qcow2 images store
> persistent bitmaps.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 509 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  block/qcow2.c        |   1 +
>  block/qcow2.h        |   1 +
>  3 files changed, 496 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 3e8fd030d9..a2b857ea72 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -28,6 +28,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "exec/log.h"
> +#include "qemu/cutils.h"
> =20
>  #include "block/block_int.h"
>  #include "block/qcow2.h"
> @@ -43,6 +44,10 @@
>  #define BME_MIN_GRANULARITY_BITS 9
>  #define BME_MAX_NAME_SIZE 1023
> =20
> +#if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
> +#error In the code bitmap table physical size assumed to fit into int
> +#endif
> +
>  /* Bitmap directory entry flags */
>  #define BME_RESERVED_FLAGS 0xfffffffcU
>  #define BME_FLAG_IN_USE 1
> @@ -67,13 +72,21 @@ typedef struct QEMU_PACKED Qcow2BitmapDirEntry {
>      /* name follows  */
>  } Qcow2BitmapDirEntry;
> =20
> +typedef struct Qcow2BitmapTable {
> +    uint64_t offset;
> +    uint32_t size; /* number of 64bit entries */
> +    QSIMPLEQ_ENTRY(Qcow2BitmapTable) entry;
> +} Qcow2BitmapTable;
> +typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable) Qcow2Bit=
mapTableList;
> +
>  typedef struct Qcow2Bitmap {
> -    uint64_t table_offset;
> -    uint32_t table_size;
> +    Qcow2BitmapTable table;

This doesn't hurt my reviewing too much, but it wouldn't make sense to
new reviewers. This should have been structured like this from the
beginning (i.e. patch 8).

Anyway, I don't mind and as long as nobody other starts reviewing, it's
fine. In the end, it'll be the same code anyway.

Reviewed-by: Max Reitz <mreitz@redhat.com>



--deV2v9OdexL4kirODuHrfUv47mXCE2bOx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNG4USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7xYH/1FU8saLjORHPKP9OMuHE8BzAF9iqR0M
+r0YELZlb79WrKd1xbZIaoVOHyf2Jecd7MEFaAFZZmHdZ1RBUi5okmhd1KPrmHYD
HCiB19+SPQ6P/HhtwmmrFtsSF6HvUBQKpT6l9BHWQUvjioa2tI2myZxLmntefb3s
YlTdGRJDu3WbY1Xi/WaWBm4hMKu/xR7pAcbwCrHTuvXkEBLBD6E0/0gzC32SfFDj
baiT5Vz3sLZk1eIvf3ghfeQOtnWIa+70MfWZk3I462/qmWNviVQXe0FmZVC65waX
B8e96Aq3TDGLLtobeTtxjdoan5YOUH1YZ7UR4GROtCqAU6GRx+8oVpM=
=PFYh
-----END PGP SIGNATURE-----

--deV2v9OdexL4kirODuHrfUv47mXCE2bOx--
