Received: from eggs.gnu.org ([2001:4830:134:3::10]:45264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7pfW-0005eK-9V
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7pfR-0000EC-Ep
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:54:10 -0400
Date: Mon, 8 May 2017 16:54:01 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508205401.GA23989@stefanha-x1.localdomain>
References: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] migration/block: move
 bdrv_is_allocated() into bb's AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 04:03:49PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> when block migration with high-speed, mig_save_device_bulk hold the
> BQL and invoke bdrv_is_allocated frequently. This patch moves
> bdrv_is_allocated() into bb's AioContext. It will execute without
> blocking other I/O activity.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>      v4 changelog:
>           Use the prototype code written by Stefan and fix some bug.
>           moves bdrv_is_allocated() into bb's AioContext.
> ---
>  migration/block.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)

Added Paolo because he's been reworking AioContext and locking.

The goal of this patch is to avoid waiting for bdrv_is_allocated() to
complete while holding locks.  Do bdrv_is_allocated() in the AioContext
so event processing continues after yield.

>=20
> diff --git a/migration/block.c b/migration/block.c
> index 060087f..c871361 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -263,6 +263,30 @@ static void blk_mig_read_cb(void *opaque, int ret)
>      blk_mig_unlock();
>  }
> =20
> +typedef struct {
> +    int64_t *total_sectors;
> +    int64_t *cur_sector;
> +    BlockBackend *bb;
> +    QemuEvent event;
> +} MigNextAllocatedClusterData;
> +
> +static void coroutine_fn mig_next_allocated_cluster(void *opaque)
> +{
> +    MigNextAllocatedClusterData *data =3D opaque;
> +    int nr_sectors;
> +
> +    /* Skip unallocated sectors; intentionally treats failure as
> +     * an allocated sector */
> +    while (*data->cur_sector < *data->total_sectors &&
> +           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
> +                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
> +        *data->cur_sector +=3D nr_sectors;
> +    }
> +
> +    bdrv_dec_in_flight(blk_bs(data->bb));
> +    qemu_event_set(&data->event);
> +}
> +
>  /* Called with no lock taken.  */
> =20
>  static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
> @@ -274,17 +298,23 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMig=
DevState *bmds)
>      int nr_sectors;
> =20
>      if (bmds->shared_base) {
> +        AioContext *bb_ctx;
> +        Coroutine *co;
> +        MigNextAllocatedClusterData data =3D {
> +            .cur_sector =3D &cur_sector,
> +            .total_sectors =3D &total_sectors,
> +            .bb =3D bb,
> +        };
> +        qemu_event_init(&data.event, false);
> +
>          qemu_mutex_lock_iothread();
> -        aio_context_acquire(blk_get_aio_context(bb));
> -        /* Skip unallocated sectors; intentionally treats failure as
> -         * an allocated sector */
> -        while (cur_sector < total_sectors &&
> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors))=
 {
> -            cur_sector +=3D nr_sectors;
> -        }
> -        aio_context_release(blk_get_aio_context(bb));
> +        bdrv_inc_in_flight(blk_bs(bb));

Please add a comment explaining why bdrv_inc_in_flight() is invoked.

> +        bb_ctx =3D blk_get_aio_context(bb);
> +        co =3D qemu_coroutine_create(mig_next_allocated_cluster, &data);
> +        aio_co_schedule(bb_ctx, co);
>          qemu_mutex_unlock_iothread();
> +
> +        qemu_event_wait(&data.event);
>      }
> =20
>      if (cur_sector >=3D total_sectors) {
> --=20
> 1.8.3.1
>=20
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZENrpAAoJEJykq7OBq3PISkgH/2vypskcAq/Q9STjrNmgqbGl
uUsHCnXgD+u8x3gcdc56i6FCvJRLm6EalB0MUyggtC+6xNzMRyRGSsN9In4OMSin
z5GUI9x3rAbqlHtVyF2NAcOytT3KDAhTd2peJFZQX65CBvV280OX9HFLAxAtWm1r
cm5qTQEdeUOgWh2Ui7bXNgIFINLsj+QRWykuoFxK3VsJyNS0g84zPqWdlSDA+qQc
PQkaSbbNATnQNboBTj8SoHJ6CPiPNRELn3/3c6KKmPXaNc0mtBxcN2zmwBgTjOvJ
8Qh46bmpci6uQwrk/6FKfaInEO1YosjaeIWufj0acz4xuN2easuuzHA/kqw+eUs=
=lrQc
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
