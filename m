Received: from eggs.gnu.org ([2001:4830:134:3::10]:56172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d2gpg-00034h-RU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d2gpf-0000zX-Ob
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:27:24 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
	<98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
	<88259101-7040-f057-5ed4-76bd36f2b1a0@virtuozzo.com>
	<c9b0f997-efbd-92f2-2fba-57d6daad2ee7@kamp.de>
Message-ID: <15b32f67-fbce-fe9e-5a5f-ed25eae49941@virtuozzo.com>
Date: Mon, 24 Apr 2017 19:27:04 +0300
MIME-Version: 1.0
In-Reply-To: <c9b0f997-efbd-92f2-2fba-57d6daad2ee7@kamp.de>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-img: wait for convert
 coroutines to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On 04/21/2017 03:37 PM, Peter Lieven wrote:
> Am 21.04.2017 um 14:19 schrieb Anton Nefedov:
>> On 04/21/2017 01:44 PM, Peter Lieven wrote:
>>> Am 21.04.2017 um 12:04 schrieb Anton Nefedov:
>>>> On error path (like i/o error in one of the coroutines), it's required to
>>>>   - wait for coroutines completion before cleaning the common structures
>>>>   - reenter dependent coroutines so they ever finish
>>>>
>>>> Introduced in 2d9187bc65.
>>>>
>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>> ---
>>>> [..]
>>>>
>>>
>>>
>>> And what if we error out in the read path? Wouldn't be something like this easier?
>>>
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index 22f559a..4ff1085 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -1903,6 +1903,16 @@ static int convert_do_copy(ImgConvertState *s)
>>>          main_loop_wait(false);
>>>      }
>>>
>>> +    /* on error path we need to enter all coroutines that are still
>>> +     * running before cleaning up common structures */
>>> +    if (s->ret) {
>>> +        for (i = 0; i < s->num_coroutines; i++) {
>>> +             if (s->co[i]) {
>>> +                 qemu_coroutine_enter(s->co[i]);
>>> +             }
>>> +        }
>>> +    }
>>> +
>>>      if (s->compressed && !s->ret) {
>>>          /* signal EOF to align */
>>>          ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
>>>
>>>
>>> Peter
>>>
>>
>> seemed a bit too daring to me to re-enter every coroutine potentially including the ones that yielded waiting for I/O completion.
>> If that's ok - that is for sure easier :)
>
> I think we should enter every coroutine that is still running and have it terminate correctly. It was my mistake that I have not
> done this in the original patch. Can you check if the above fixes your test cases that triggered the bug?
>

hi, sorry I'm late with the answer

this segfaults in bdrv_close(). Looks like it tries to finish some i/o 
which coroutine we have already entered and terminated?

(gdb) run
Starting program: /vz/anefedov/qemu-build/us/./qemu-img convert -O qcow2 
./harddisk.hdd.c ./harddisk.hdd
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7fffeac2d700 (LWP 436020)]
[New Thread 0x7fffe4ed6700 (LWP 436021)]
qemu-img: error while reading sector 20480: Input/output error
qemu-img: error while writing sector 19712: Operation now in progress

Program received signal SIGSEGV, Segmentation fault.
aio_co_wake (co=0x0) at /mnt/code/us-qemu/util/async.c:454
454         ctx = atomic_read(&co->ctx);
(gdb) bt
#0  aio_co_wake (co=0x0) at /mnt/code/us-qemu/util/async.c:454
/* [Anton]: thread_pool_co_cb () here */
#1  0x0000555555634629 in thread_pool_completion_bh 
(opaque=0x555555cfe020) at /mnt/code/us-qemu/util/thread-pool.c:189
#2  0x0000555555633b31 in aio_bh_call (bh=0x555555cfe0f0) at 
/mnt/code/us-qemu/util/async.c:90
#3  aio_bh_poll (ctx=ctx@entry=0x555555cee6d0) at 
/mnt/code/us-qemu/util/async.c:118
#4  0x0000555555636f14 in aio_poll (ctx=ctx@entry=0x555555cee6d0, 
blocking=<optimized out>) at /mnt/code/us-qemu/util/aio-posix.c:682
#5  0x00005555555c52d4 in bdrv_drain_recurse 
(bs=bs@entry=0x555555d22560) at /mnt/code/us-qemu/block/io.c:164
#6  0x00005555555c5aed in bdrv_drained_begin 
(bs=bs@entry=0x555555d22560) at /mnt/code/us-qemu/block/io.c:248
#7  0x0000555555581443 in bdrv_close (bs=0x555555d22560) at 
/mnt/code/us-qemu/block.c:2909
#8  bdrv_delete (bs=0x555555d22560) at /mnt/code/us-qemu/block.c:3100
#9  bdrv_unref (bs=0x555555d22560) at /mnt/code/us-qemu/block.c:4087
#10 0x00005555555baf44 in blk_remove_bs (blk=blk@entry=0x555555d22380) 
at /mnt/code/us-qemu/block/block-backend.c:552
#11 0x00005555555bb173 in blk_delete (blk=0x555555d22380) at 
/mnt/code/us-qemu/block/block-backend.c:238
#12 blk_unref (blk=blk@entry=0x555555d22380) at 
/mnt/code/us-qemu/block/block-backend.c:282
#13 0x000055555557a22c in img_convert (argc=<optimized out>, 
argv=<optimized out>) at /mnt/code/us-qemu/qemu-img.c:2359
#14 0x0000555555574189 in main (argc=5, argv=0x7fffffffe4a0) at 
/mnt/code/us-qemu/qemu-img.c:4464


> Peter
>

/Anton
