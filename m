Received: from eggs.gnu.org ([2001:4830:134:3::10]:34936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctFyQ-0001hL-SU
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctFyP-0003wa-TA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:57:26 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAOGPPbeRrYfU71ezGB6cYkn8W9mwrSRgvmoj99Q4_q1Km67+gQ@mail.gmail.com>
	(858585 jemmy's message of "Wed, 29 Mar 2017 21:21:55 +0800")
References: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
	<87efxhspgi.fsf@secure.mitica>
	<CAOGPPbeRrYfU71ezGB6cYkn8W9mwrSRgvmoj99Q4_q1Km67+gQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 29 Mar 2017 17:57:11 +0200
Message-ID: <8737dwnkiw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Fam Zheng <famz@redhat.com>, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

858585 jemmy <jemmy858585@gmail.com> wrote:
> On Tue, Mar 28, 2017 at 5:47 PM, Juan Quintela <quintela@redhat.com> wrote:
>> Lidong Chen <jemmy858585@gmail.com> wrote:
>>> when migration with quick speed, mig_save_device_bulk invoke
>>> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
>>> this patch limit the time used for bdrv_is_allocated.
>>>
>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>> ---
>>>  migration/block.c | 39 +++++++++++++++++++++++++++++++--------
>>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 7734ff7..d3e81ca 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -110,6 +110,7 @@ typedef struct BlkMigState {
>>>      int transferred;
>>>      int prev_progress;
>>>      int bulk_completed;
>>> +    int time_ns_used;
>>
>> An int that can only take values 0/1 is called a bool O:-)
> time_ns_used is used to store how many ns used by bdrv_is_allocated.

Oops, I really mean timeout_flag, sorry :-(

>> Do we really want to call clock_gettime each time that
>> bdrv_is_allocated() is called?  My understanding is that clock_gettime
>> is expensive, but I don't know how expensive is brdrv_is_allocated()
>
> i write this code to measure the time used by  brdrv_is_allocated()
>
>  279     static int max_time = 0;
>  280     int tmp;
>
>  288             clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
>  289             ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
>  290                                     MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
>  291             clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
>  292
>  293
>  294             tmp =  (ts2.tv_sec - ts1.tv_sec)*1000000000L
>  295                            + (ts2.tv_nsec - ts1.tv_nsec);
>  296             if (tmp > max_time) {
>  297                max_time=tmp;
>  298                fprintf(stderr, "max_time is %d\n", max_time);
>  299             }
>
> the test result is below:
>
>  max_time is 37014
>  max_time is 1075534
>  max_time is 17180913
>  max_time is 28586762
>  max_time is 49563584
>  max_time is 103085447
>  max_time is 110836833
>  max_time is 120331438

this is around 120ms, no?  It is quite a lot, really :-(

> so i think it's necessary to clock_gettime each time.
> but clock_gettime only available on linux. maybe clock() is better.

Thanks, Juan.
