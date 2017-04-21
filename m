Received: from eggs.gnu.org ([2001:4830:134:3::10]:56950)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1Xp5-00032A-Gy
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1Xp2-0004JU-Ec
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:38:03 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:56955 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1Xp2-0004Io-5y
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:38:00 -0400
References: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
	<98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
	<88259101-7040-f057-5ed4-76bd36f2b1a0@virtuozzo.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <c9b0f997-efbd-92f2-2fba-57d6daad2ee7@kamp.de>
Date: Fri, 21 Apr 2017 14:37:55 +0200
MIME-Version: 1.0
In-Reply-To: <88259101-7040-f057-5ed4-76bd36f2b1a0@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Am 21.04.2017 um 14:19 schrieb Anton Nefedov:
> On 04/21/2017 01:44 PM, Peter Lieven wrote:
>> Am 21.04.2017 um 12:04 schrieb Anton Nefedov:
>>> On error path (like i/o error in one of the coroutines), it's required to
>>>   - wait for coroutines completion before cleaning the common structures
>>>   - reenter dependent coroutines so they ever finish
>>>
>>> Introduced in 2d9187bc65.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>> [..]
>>>
>>
>>
>> And what if we error out in the read path? Wouldn't be something like this easier?
>>
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 22f559a..4ff1085 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1903,6 +1903,16 @@ static int convert_do_copy(ImgConvertState *s)
>>          main_loop_wait(false);
>>      }
>>
>> +    /* on error path we need to enter all coroutines that are still
>> +     * running before cleaning up common structures */
>> +    if (s->ret) {
>> +        for (i = 0; i < s->num_coroutines; i++) {
>> +             if (s->co[i]) {
>> +                 qemu_coroutine_enter(s->co[i]);
>> +             }
>> +        }
>> +    }
>> +
>>      if (s->compressed && !s->ret) {
>>          /* signal EOF to align */
>>          ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
>>
>>
>> Peter
>>
>
> seemed a bit too daring to me to re-enter every coroutine potentially including the ones that yielded waiting for I/O completion.
> If that's ok - that is for sure easier :)

I think we should enter every coroutine that is still running and have it terminate correctly. It was my mistake that I have not
done this in the original patch. Can you check if the above fixes your test cases that triggered the bug?

Peter
