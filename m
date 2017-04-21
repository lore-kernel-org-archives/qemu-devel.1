Received: from eggs.gnu.org ([2001:4830:134:3::10]:41081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d1ZtG-0005d8-Ly
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d1ZtF-0004Ob-RJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:50:30 -0400
References: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
	<98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <88259101-7040-f057-5ed4-76bd36f2b1a0@virtuozzo.com>
Date: Fri, 21 Apr 2017 15:19:24 +0300
MIME-Version: 1.0
In-Reply-To: <98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
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

On 04/21/2017 01:44 PM, Peter Lieven wrote:
> Am 21.04.2017 um 12:04 schrieb Anton Nefedov:
>> On error path (like i/o error in one of the coroutines), it's required to
>>   - wait for coroutines completion before cleaning the common structures
>>   - reenter dependent coroutines so they ever finish
>>
>> Introduced in 2d9187bc65.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>> [..]
>>
>
>
> And what if we error out in the read path? Wouldn't be something like this easier?
>
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 22f559a..4ff1085 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1903,6 +1903,16 @@ static int convert_do_copy(ImgConvertState *s)
>          main_loop_wait(false);
>      }
>
> +    /* on error path we need to enter all coroutines that are still
> +     * running before cleaning up common structures */
> +    if (s->ret) {
> +        for (i = 0; i < s->num_coroutines; i++) {
> +             if (s->co[i]) {
> +                 qemu_coroutine_enter(s->co[i]);
> +             }
> +        }
> +    }
> +
>      if (s->compressed && !s->ret) {
>          /* signal EOF to align */
>          ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
>
>
> Peter
>

seemed a bit too daring to me to re-enter every coroutine potentially 
including the ones that yielded waiting for I/O completion.
If that's ok - that is for sure easier :)

Or maybe some intermediate variant, as you suggest but only enter the 
"wait_sector" coroutines (and main_loop_wait for the rest)?
Or do not even re-enter them, like just

-    while (s->ret == -EINPROGRESS) {
+    while (s->running_coroutines != s->waiting_coroutines) {
          main_loop_wait(false);
      }


/Anton
