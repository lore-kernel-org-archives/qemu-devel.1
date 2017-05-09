Received: from eggs.gnu.org ([2001:4830:134:3::10]:44297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d87aX-0007BM-NH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d87aT-0001Eb-9L
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:02:13 -0400
References: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
	<20170508205401.GA23989@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43873fc6-5d32-c52e-5b37-4c77c9528d73@redhat.com>
Date: Tue, 9 May 2017 18:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170508205401.GA23989@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pLSraVl0wWxnBTVnKiUwWgsW1uqC562gG"
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
To: Stefan Hajnoczi <stefanha@gmail.com>, jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pLSraVl0wWxnBTVnKiUwWgsW1uqC562gG
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 Lidong Chen <lidongchen@tencent.com>
Message-ID: <43873fc6-5d32-c52e-5b37-4c77c9528d73@redhat.com>
Subject: Re: [Qemu-block] [PATCH v4] migration/block: move bdrv_is_allocated()
 into bb's AioContext
References: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
 <20170508205401.GA23989@stefanha-x1.localdomain>
In-Reply-To: <20170508205401.GA23989@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/05/2017 22:54, Stefan Hajnoczi wrote:
> On Fri, May 05, 2017 at 04:03:49PM +0800, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> when block migration with high-speed, mig_save_device_bulk hold the
>> BQL and invoke bdrv_is_allocated frequently. This patch moves
>> bdrv_is_allocated() into bb's AioContext. It will execute without
>> blocking other I/O activity.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>      v4 changelog:
>>           Use the prototype code written by Stefan and fix some bug.
>>           moves bdrv_is_allocated() into bb's AioContext.
>> ---
>>  migration/block.c | 48 +++++++++++++++++++++++++++++++++++++++-------=
--
>>  1 file changed, 39 insertions(+), 9 deletions(-)
>=20
> Added Paolo because he's been reworking AioContext and locking.
>=20
> The goal of this patch is to avoid waiting for bdrv_is_allocated() to
> complete while holding locks.  Do bdrv_is_allocated() in the AioContext=

> so event processing continues after yield.

Since raw_co_get_block_status is coroutine-based I think you should
instead use the thread pool (thread_pool_submit_co) in
block/file-posix.c.  This way the lseek is done in a separate thread.

The problem is that find_allocation() is not atomic, so you need either
a CoMutex around raw_co_get_block_status's call to
thread_pool_submit_co, or a QemuMutex in find_allocation itself.

Thanks,

Paolo

>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 060087f..c871361 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -263,6 +263,30 @@ static void blk_mig_read_cb(void *opaque, int ret=
)
>>      blk_mig_unlock();
>>  }
>> =20
>> +typedef struct {
>> +    int64_t *total_sectors;
>> +    int64_t *cur_sector;
>> +    BlockBackend *bb;
>> +    QemuEvent event;
>> +} MigNextAllocatedClusterData;
>> +
>> +static void coroutine_fn mig_next_allocated_cluster(void *opaque)
>> +{
>> +    MigNextAllocatedClusterData *data =3D opaque;
>> +    int nr_sectors;
>> +
>> +    /* Skip unallocated sectors; intentionally treats failure as
>> +     * an allocated sector */
>> +    while (*data->cur_sector < *data->total_sectors &&
>> +           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
>> +                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) =
{
>> +        *data->cur_sector +=3D nr_sectors;
>> +    }
>> +
>> +    bdrv_dec_in_flight(blk_bs(data->bb));
>> +    qemu_event_set(&data->event);
>> +}
>> +
>>  /* Called with no lock taken.  */
>> =20
>>  static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>> @@ -274,17 +298,23 @@ static int mig_save_device_bulk(QEMUFile *f, Blk=
MigDevState *bmds)
>>      int nr_sectors;
>> =20
>>      if (bmds->shared_base) {
>> +        AioContext *bb_ctx;
>> +        Coroutine *co;
>> +        MigNextAllocatedClusterData data =3D {
>> +            .cur_sector =3D &cur_sector,
>> +            .total_sectors =3D &total_sectors,
>> +            .bb =3D bb,
>> +        };
>> +        qemu_event_init(&data.event, false);
>> +
>>          qemu_mutex_lock_iothread();
>> -        aio_context_acquire(blk_get_aio_context(bb));
>> -        /* Skip unallocated sectors; intentionally treats failure as
>> -         * an allocated sector */
>> -        while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
>> -            cur_sector +=3D nr_sectors;
>> -        }
>> -        aio_context_release(blk_get_aio_context(bb));
>> +        bdrv_inc_in_flight(blk_bs(bb));
>=20
> Please add a comment explaining why bdrv_inc_in_flight() is invoked.
>=20
>> +        bb_ctx =3D blk_get_aio_context(bb);
>> +        co =3D qemu_coroutine_create(mig_next_allocated_cluster, &dat=
a);
>> +        aio_co_schedule(bb_ctx, co);
>>          qemu_mutex_unlock_iothread();
>> +
>> +        qemu_event_wait(&data.event);
>>      }
>> =20
>>      if (cur_sector >=3D total_sectors) {
>> --=20
>> 1.8.3.1
>>
>>


--pLSraVl0wWxnBTVnKiUwWgsW1uqC562gG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkR5+0ACgkQv/vSX3jH
roNDkAf7BdvoXJPTpPeZPRE0VPobxjiVE3I2d4YvDGRpTSYrLP6MeHTw3lulBmWi
uMMkEpOPgUeCrmWYSOsCABrvWO/OQBMbon710iiKPHJc3a/Bk6bO20+WbTBzTmEp
3CDQkqnat3IQQB5LBRBM7YqY1ts/JvK+cAgSU605VckrC2D/j6+6ny+6eAmw2aQp
w/Uff9GieADsMj4AnK+7X029O+wmncfDjA8/l7FwENYV5+spKW+EjGG6CJs8p5Ql
l7cUoNSJsIh6c4AeKu0GzuBs7CnrYFAlepL/q9dczza5djGsywlOhLDXhLloSWGN
dj6/1Tw4TyNPdhMvOnytA/onqoUGwg==
=Z39/
-----END PGP SIGNATURE-----

--pLSraVl0wWxnBTVnKiUwWgsW1uqC562gG--
