Received: from eggs.gnu.org ([2001:4830:134:3::10]:42983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ctDXy-0006fu-N6
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ctDXx-0003wn-A9
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:21:58 -0400
MIME-Version: 1.0
In-Reply-To: <87efxhspgi.fsf@secure.mitica>
References: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
	<87efxhspgi.fsf@secure.mitica>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 29 Mar 2017 21:21:55 +0800
Message-ID: <CAOGPPbeRrYfU71ezGB6cYkn8W9mwrSRgvmoj99Q4_q1Km67+gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Fam Zheng <famz@redhat.com>, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Tue, Mar 28, 2017 at 5:47 PM, Juan Quintela <quintela@redhat.com> wrote:
> Lidong Chen <jemmy858585@gmail.com> wrote:
>> when migration with quick speed, mig_save_device_bulk invoke
>> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
>> this patch limit the time used for bdrv_is_allocated.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  migration/block.c | 39 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 7734ff7..d3e81ca 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -110,6 +110,7 @@ typedef struct BlkMigState {
>>      int transferred;
>>      int prev_progress;
>>      int bulk_completed;
>> +    int time_ns_used;
>
> An int that can only take values 0/1 is called a bool O:-)
time_ns_used is used to store how many ns used by bdrv_is_allocated.

>
>
>>      if (bmds->shared_base) {
>>          qemu_mutex_lock_iothread();
>>          aio_context_acquire(blk_get_aio_context(bb));
>>          /* Skip unallocated sectors; intentionally treats failure as
>>           * an allocated sector */
>> -        while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>> -            cur_sector += nr_sectors;
>> +        while (cur_sector < total_sectors) {
>> +            clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
>> +            ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
>> +                                    MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
>> +            clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
>
> Do we really want to call clock_gettime each time that
> bdrv_is_allocated() is called?  My understanding is that clock_gettime
> is expensive, but I don't know how expensive is brdrv_is_allocated()

i write this code to measure the time used by  brdrv_is_allocated()

 279     static int max_time = 0;
 280     int tmp;

 288             clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
 289             ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
 290                                     MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
 291             clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
 292
 293
 294             tmp =  (ts2.tv_sec - ts1.tv_sec)*1000000000L
 295                            + (ts2.tv_nsec - ts1.tv_nsec);
 296             if (tmp > max_time) {
 297                max_time=tmp;
 298                fprintf(stderr, "max_time is %d\n", max_time);
 299             }

the test result is below:

 max_time is 37014
 max_time is 1075534
 max_time is 17180913
 max_time is 28586762
 max_time is 49563584
 max_time is 103085447
 max_time is 110836833
 max_time is 120331438

so i think it's necessary to clock_gettime each time.
but clock_gettime only available on linux. maybe clock() is better.

>
> And while we are at it, .... shouldn't we check since before the while?
i also check it in block_save_iterate.
+           MAX_INFLIGHT_IO &&
+           block_mig_state.time_ns_used <= 100000) {

>
>
>> +
>> +            block_mig_state.time_ns_used += (ts2.tv_sec - ts1.tv_sec) * BILLION
>> +                          + (ts2.tv_nsec - ts1.tv_nsec);
>> +
>> +            if (!ret) {
>> +                cur_sector += nr_sectors;
>> +                if (block_mig_state.time_ns_used > 100000) {
>> +                    timeout_flag = 1;
>> +                    break;
>> +                }
>> +            } else {
>> +                break;
>> +            }
>>          }
>>          aio_context_release(blk_get_aio_context(bb));
>>          qemu_mutex_unlock_iothread();
>> @@ -292,6 +311,11 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>>          return 1;
>>      }
>>
>> +    if (timeout_flag == 1) {
>> +        bmds->cur_sector = bmds->completed_sectors = cur_sector;
>> +        return 0;
>> +    }
>> +
>>      bmds->completed_sectors = cur_sector;
>>
>>      cur_sector &= ~((int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK - 1);
>> @@ -576,9 +600,6 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
>>              }
>>
>>              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
>> -            sector += nr_sectors;
>> -            bmds->cur_dirty = sector;
>> -
>>              break;
>>          }
>>          sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
>> @@ -756,6 +777,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>>      }
>>
>>      blk_mig_reset_dirty_cursor();
>> +    block_mig_state.time_ns_used = 0;
>>
>>      /* control the rate of transfer */
>>      blk_mig_lock();
>> @@ -764,7 +786,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>>             qemu_file_get_rate_limit(f) &&
>>             (block_mig_state.submitted +
>>              block_mig_state.read_done) <
>> -           MAX_INFLIGHT_IO) {
>> +           MAX_INFLIGHT_IO &&
>> +           block_mig_state.time_ns_used <= 100000) {
>
> changed this 10.000 (and the one used previously) to one constant that
> says BIG_DELAY, 100MS or whatever you fancy.
ok,i will change to BIG_DELAY.

>
> Thanks, Juan.
