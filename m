Received: from eggs.gnu.org ([209.51.188.92]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZ7w-00041H-Vw
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZ7v-0005Mu-UZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:36:56 -0400
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0eaf7740-a524-1ef4-27f7-7a0bf0be3222@redhat.com>
Date: Mon, 22 Apr 2019 08:36:37 -0500
MIME-Version: 1.0
In-Reply-To: <20190419140557.102725-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block/qcow2-refcount: add
 trace-point to qcow2_process_discards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 den@virtuozzo.com
Message-ID: <0eaf7740-a524-1ef4-27f7-7a0bf0be3222@redhat.com>
Subject: Re: [PATCH v3 1/3] block/qcow2-refcount: add trace-point to
 qcow2_process_discards
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
 <20190419140557.102725-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190419140557.102725-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> Let's at least trace ignored failure.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 7 ++++++-
>  block/trace-events     | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index e0fe322500..60284bcaac 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -30,6 +30,7 @@
>  #include "qemu/range.h"
>  #include "qemu/bswap.h"
>  #include "qemu/cutils.h"
> +#include "trace.h"
> =20
>  static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e,
>                                      uint64_t max);
> @@ -738,7 +739,11 @@ void qcow2_process_discards(BlockDriverState *bs, =
int ret)
> =20
>          /* Discard is optional, ignore the return value */
>          if (ret >=3D 0) {
> -            bdrv_pdiscard(bs->file, d->offset, d->bytes);
> +            int r2 =3D bdrv_pdiscard(bs->file, d->offset, d->bytes);
> +            if (r2 < 0) {
> +                trace_qcow2_process_discards_failed_region(d->offset, =
d->bytes,
> +                                                           r2);
> +            }
>          }
> =20
>          g_free(d);
> diff --git a/block/trace-events b/block/trace-events
> index 7335a42540..ea508f637e 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -91,6 +91,9 @@ qcow2_cache_get_done(void *co, int c, int i) "co %p i=
s_l2_cache %d index %d"
>  qcow2_cache_flush(void *co, int c) "co %p is_l2_cache %d"
>  qcow2_cache_entry_flush(void *co, int c, int i) "co %p is_l2_cache %d =
index %d"
> =20
> +# qcow2-refcount.c
> +qcow2_process_discards_failed_region(uint64_t offset, uint64_t bytes, =
int ret) "offset 0x%" PRIx64 " bytes 0x%" PRIx64 " ret %d"
> +
>  # qed-l2-cache.c
>  qed_alloc_l2_cache_entry(void *l2_cache, void *entry) "l2_cache %p ent=
ry %p"
>  qed_unref_l2_cache_entry(void *entry, int ref) "entry %p ref %d"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly9w2UACgkQp6FrSiUn
Q2q7Iwf/fWLturOvOTdkP+eLJV/SyPQbpiXUfVtBltkOIyZDadNpwCue4RNO838i
OlCsvNjXpZhaMaJjBdVdnleQ+c1n+NVQnUEPfnOyd0+VW8paxaKkmjoXsZ4j1DAe
vTo6vsVmSB9Xiw9ZdzIra/BH1HWsD1C1fb6r8NP/iLzkgZYX9Xs2LJeR8acP+Una
nx/SuvOhyWV8baOiYsPyet88E7xTVu+8YTqXxCwCBPRXdBr/L3Y54usCgwZ5tdzR
jVAGblbPGbtVXH4R7b5btJBsBwm475eZlwtZ32ONwNJPUwB3SI2Qf5atOEfV12xy
+os7K3aKkVspuMVyt10Fi0XmMLk80w==
=FUdT
-----END PGP SIGNATURE-----

--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv--
