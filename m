Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d32um-0002Ou-Ik
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d32ug-0003Pi-9C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:02:08 -0400
References: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
	<98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
	<88259101-7040-f057-5ed4-76bd36f2b1a0@virtuozzo.com>
	<c9b0f997-efbd-92f2-2fba-57d6daad2ee7@kamp.de>
	<15b32f67-fbce-fe9e-5a5f-ed25eae49941@virtuozzo.com>
	<F7BA9764-937B-438A-B606-677DBF7379A6@kamp.de>
	<59ebc5d3-5921-9d3c-1436-caecd1e23a60@virtuozzo.com>
	<b5c4060a-45cc-d83a-d552-89db3283d394@kamp.de>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <705993c5-a7e5-17f0-154b-2b9de8c83d12@virtuozzo.com>
Date: Tue, 25 Apr 2017 16:27:46 +0300
MIME-Version: 1.0
In-Reply-To: <b5c4060a-45cc-d83a-d552-89db3283d394@kamp.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2 1/1] qemu-img: wait for
 convert coroutines to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org



On 04/25/2017 12:55 PM, Peter Lieven wrote:
> Am 24.04.2017 um 22:13 schrieb Anton Nefedov:
>>
>> On 24/04/2017 21:16, Peter Lieven wrote:
>>>
>>>
>>>> Am 24.04.2017 um 18:27 schrieb Anton Nefedov
>>>> <anton.nefedov@virtuozzo.com>:
>>>>
>>>>> On 04/21/2017 03:37 PM, Peter Lieven wrote:
>>>>>> Am 21.04.2017 um 14:19 schrieb Anton Nefedov:
>>>>>>> On 04/21/2017 01:44 PM, Peter Lieven wrote:
>>>>>>>> Am 21.04.2017 um 12:04 schrieb Anton Nefedov:
>>>>>>>> On error path (like i/o error in one of the coroutines), it's
>>>>>>>> required to
>>>>>>>>  - wait for coroutines completion before cleaning the common
>>>>>>>> structures
>>>>>>>>  - reenter dependent coroutines so they ever finish
>>>>>>>>
>>>>>>>> Introduced in 2d9187bc65.
>>>>>>>>
>>>>>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>>>>>> ---
>>>>>>>> [..]
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> And what if we error out in the read path? Wouldn't be something
>>>>>>> like this easier?
>>>>>>>
>>>>>>>
>>>>>>> diff --git a/qemu-img.c b/qemu-img.c
>>>>>>> index 22f559a..4ff1085 100644
>>>>>>> --- a/qemu-img.c
>>>>>>> +++ b/qemu-img.c
>>>>>>> @@ -1903,6 +1903,16 @@ static int convert_do_copy(ImgConvertState
>>>>>>> *s)
>>>>>>>         main_loop_wait(false);
>>>>>>>     }
>>>>>>>
>>>>>>> +    /* on error path we need to enter all coroutines that are still
>>>>>>> +     * running before cleaning up common structures */
>>>>>>> +    if (s->ret) {
>>>>>>> +        for (i = 0; i < s->num_coroutines; i++) {
>>>>>>> +             if (s->co[i]) {
>>>>>>> +                 qemu_coroutine_enter(s->co[i]);
>>>>>>> +             }
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>>     if (s->compressed && !s->ret) {
>>>>>>>         /* signal EOF to align */
>>>>>>>         ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
>>>>>>>
>>>>>>>
>>>>>>> Peter
>>>>>>>
>>>>>>
>>>>>> seemed a bit too daring to me to re-enter every coroutine
>>>>>> potentially including the ones that yielded waiting for I/O
>>>>>> completion.
>>>>>> If that's ok - that is for sure easier :)
>>>>>
>>>>> I think we should enter every coroutine that is still running and
>>>>> have it terminate correctly. It was my mistake that I have not
>>>>> done this in the original patch. Can you check if the above fixes
>>>>> your test cases that triggered the bug?
>>>>>
>>>>
>>>> hi, sorry I'm late with the answer
>>>>
>>>> this segfaults in bdrv_close(). Looks like it tries to finish some
>>>> i/o which coroutine we have already entered and terminated?
>>>>
>>>> (gdb) run
>>>> Starting program: /vz/anefedov/qemu-build/us/./qemu-img convert -O
>>>> [..]
>>>>
>>>>
>>>>> Peter
>>>>>
>>>>
>>>> /Anton
>>>>
>>>
>>> it seems that this is a bit tricky, can you share how your test case
>>> works?
>>>
>>> thanks,
>>> peter
>>>
>>
>> how I tested today was basically
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 4425aaa..3d2d506 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1788,6 +1788,10 @@ static void coroutine_fn
>> convert_co_do_copy(void *opaque)
>>
>>          if (status == BLK_DATA) {
>>              ret = convert_co_read(s, sector_num, n, buf);
>> +            const uint64_t fsector = 10*1024*1024/512;
>> +            if (sector_num <= fsector && fsector < sector_num+n) {
>> +                ret = -EIO;
>> +            }
>>              if (ret < 0) {
>>                  error_report("error while reading sector %" PRId64
>>                               ": %s", sector_num, strerror(-ret));
>>
>
> I ended up with sth similar to your approach. Can you check this?
>
>
> Thanks,
>
> Peter
>
>
> diff --git a/qemu-img.c b/qemu-img.c
> index b94fc11..ed9ce9e 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1761,13 +1761,13 @@ static void coroutine_fn convert_co_do_copy(void
> *opaque)
>          qemu_co_mutex_lock(&s->lock);
>          if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
>              qemu_co_mutex_unlock(&s->lock);
> -            goto out;
> +            break;
>          }
>          n = convert_iteration_sectors(s, s->sector_num);
>          if (n < 0) {
>              qemu_co_mutex_unlock(&s->lock);
>              s->ret = n;
> -            goto out;
> +            break;
>          }
>          /* save current sector and allocation status to local variables */
>          sector_num = s->sector_num;
> @@ -1792,7 +1792,6 @@ static void coroutine_fn convert_co_do_copy(void
> *opaque)
>                  error_report("error while reading sector %" PRId64
>                               ": %s", sector_num, strerror(-ret));
>                  s->ret = ret;
> -                goto out;
>              }
>          } else if (!s->min_sparse && status == BLK_ZERO) {
>              status = BLK_DATA;
> @@ -1801,22 +1800,20 @@ static void coroutine_fn convert_co_do_copy(void
> *opaque)
>
>          if (s->wr_in_order) {
>              /* keep writes in order */
> -            while (s->wr_offs != sector_num) {
> -                if (s->ret != -EINPROGRESS) {
> -                    goto out;
> -                }
> +            while (s->wr_offs != sector_num && s->ret == -EINPROGRESS) {
>                  s->wait_sector_num[index] = sector_num;
>                  qemu_coroutine_yield();
>              }
>              s->wait_sector_num[index] = -1;
>          }
>
> -        ret = convert_co_write(s, sector_num, n, buf, status);
> -        if (ret < 0) {
> -            error_report("error while writing sector %" PRId64
> -                         ": %s", sector_num, strerror(-ret));
> -            s->ret = ret;
> -            goto out;
> +        if (s->ret == -EINPROGRESS) {
> +            ret = convert_co_write(s, sector_num, n, buf, status);
> +            if (ret < 0) {
> +                error_report("error while writing sector %" PRId64
> +                             ": %s", sector_num, strerror(-ret));
> +                s->ret = ret;
> +            }
>          }
>
>          if (s->wr_in_order) {
> @@ -1837,7 +1834,6 @@ static void coroutine_fn convert_co_do_copy(void
> *opaque)
>          }
>      }
>
> -out:
>      qemu_vfree(buf);
>      s->co[index] = NULL;
>      s->running_coroutines--;
> @@ -1899,7 +1895,7 @@ static int convert_do_copy(ImgConvertState *s)
>          qemu_coroutine_enter(s->co[i]);
>      }
>
> -    while (s->ret == -EINPROGRESS) {
> +    while (s->running_coroutines) {
>          main_loop_wait(false);
>      }
>
>

This one seems to work; I've been running for several hours qemu-img 
convert from nbd which spontaneously fails in ~ every 2nd convert; and 
yet qemu-img keeps terminating smoothly

/Anton
