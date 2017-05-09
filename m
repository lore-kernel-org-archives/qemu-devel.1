Received: from eggs.gnu.org ([2001:4830:134:3::10]:50524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d84jl-0005XY-RE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d84jk-0005VW-GY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:59:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170508205401.GA23989@stefanha-x1.localdomain>
References: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
	<20170508205401.GA23989@stefanha-x1.localdomain>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 9 May 2017 20:59:30 +0800
Message-ID: <CAOGPPbfukP450k2CaC6sEiFfca2DQ1OqMGSvZgwOvXr9WUGXaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Tue, May 9, 2017 at 4:54 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
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
>>  migration/block.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 39 insertions(+), 9 deletions(-)
>
> Added Paolo because he's been reworking AioContext and locking.
>
> The goal of this patch is to avoid waiting for bdrv_is_allocated() to
> complete while holding locks.  Do bdrv_is_allocated() in the AioContext
> so event processing continues after yield.

Hi Paolo:
    Some information about the problem.
    https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01423.html

    why bdrv_inc_in_flight() is needed.
    blk_set_aio_context maybe invoked by vcpu thread. like this:
              blk_set_aio_context
                   virtio_blk_data_plane_stop
                            virtio_pci_stop_ioeventfd
                                  virtio_pci_common_write
    so bs->aio_context maybe change before mig_next_allocated_cluster().

    I use this method to verify this patch:
    run this command in guest os:
          while [ 1 ]; do rmmod virtio_blk; modprobe virtio_blk; done

   Thanks.

>
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 060087f..c871361 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -263,6 +263,30 @@ static void blk_mig_read_cb(void *opaque, int ret)
>>      blk_mig_unlock();
>>  }
>>
>> +typedef struct {
>> +    int64_t *total_sectors;
>> +    int64_t *cur_sector;
>> +    BlockBackend *bb;
>> +    QemuEvent event;
>> +} MigNextAllocatedClusterData;
>> +
>> +static void coroutine_fn mig_next_allocated_cluster(void *opaque)
>> +{
>> +    MigNextAllocatedClusterData *data = opaque;
>> +    int nr_sectors;
>> +
>> +    /* Skip unallocated sectors; intentionally treats failure as
>> +     * an allocated sector */
>> +    while (*data->cur_sector < *data->total_sectors &&
>> +           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
>> +                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>> +        *data->cur_sector += nr_sectors;
>> +    }
>> +
>> +    bdrv_dec_in_flight(blk_bs(data->bb));
>> +    qemu_event_set(&data->event);
>> +}
>> +
>>  /* Called with no lock taken.  */
>>
>>  static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>> @@ -274,17 +298,23 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>>      int nr_sectors;
>>
>>      if (bmds->shared_base) {
>> +        AioContext *bb_ctx;
>> +        Coroutine *co;
>> +        MigNextAllocatedClusterData data = {
>> +            .cur_sector = &cur_sector,
>> +            .total_sectors = &total_sectors,
>> +            .bb = bb,
>> +        };
>> +        qemu_event_init(&data.event, false);
>> +
>>          qemu_mutex_lock_iothread();
>> -        aio_context_acquire(blk_get_aio_context(bb));
>> -        /* Skip unallocated sectors; intentionally treats failure as
>> -         * an allocated sector */
>> -        while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>> -            cur_sector += nr_sectors;
>> -        }
>> -        aio_context_release(blk_get_aio_context(bb));
>> +        bdrv_inc_in_flight(blk_bs(bb));
>
> Please add a comment explaining why bdrv_inc_in_flight() is invoked.
>
>> +        bb_ctx = blk_get_aio_context(bb);
>> +        co = qemu_coroutine_create(mig_next_allocated_cluster, &data);
>> +        aio_co_schedule(bb_ctx, co);
>>          qemu_mutex_unlock_iothread();
>> +
>> +        qemu_event_wait(&data.event);
>>      }
>>
>>      if (cur_sector >= total_sectors) {
>> --
>> 1.8.3.1
>>
>>
