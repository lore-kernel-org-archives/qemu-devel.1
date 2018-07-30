Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fk9CD-0001Un-8m
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fk9C7-0001ov-Kr
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:30:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fk9C7-0001oh-4g
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:30:43 -0400
References: <20180730134321.19898-1-alex.bennee@linaro.org>
	<20180730134321.19898-2-alex.bennee@linaro.org>
	<bb23514b-741c-bda3-309b-6bcedc071ab5@vivier.eu>
	<87zhy8954d.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5b72e5b5-5bd6-9014-2cba-da3a0e9676cf@vivier.eu>
Date: Mon, 30 Jul 2018 16:30:29 +0200
MIME-Version: 1.0
In-Reply-To: <87zhy8954d.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 1/2] linux-user/mmap.c: handle
 invalid len maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, 1783362@bugs.launchpad.net, qemu-devel@nongnu.org

Le 30/07/2018 à 16:21, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 30/07/2018 à 15:43, Alex Bennée a écrit:
>>> I've slightly re-organised the check to more closely match the
>>> sequence that the kernel uses in do_mmap(). We check for both the zero
>>> case (EINVAL) and the overflow length case (ENOMEM).
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: umarcor <1783362@bugs.launchpad.net>
>>>
>>> ---
>>> v2
>>>   - add comment on overflow
>>> ---
>>>  linux-user/mmap.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>> index d0c50e4888..41e0983ce8 100644
>>> --- a/linux-user/mmap.c
>>> +++ b/linux-user/mmap.c
>>> @@ -391,14 +391,23 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>>>      }
>>>  #endif
>>>
>>> -    if (offset & ~TARGET_PAGE_MASK) {
>>> +    if (!len) {
>>>          errno = EINVAL;
>>>          goto fail;
>>>      }
>>>
>>> +    /* Also check for overflows... */
>>>      len = TARGET_PAGE_ALIGN(len);
>>> -    if (len == 0)
>>> -        goto the_end;
>>> +    if (!len) {
>>> +        errno = ENOMEM;
>>> +        goto fail;
>>> +    }
>>> +
>>> +    if (offset & ~TARGET_PAGE_MASK) {
>>> +        errno = EINVAL;
>>> +        goto fail;
>>> +    }
>>> +
>>>      real_start = start & qemu_host_page_mask;
>>>      host_offset = offset & qemu_host_page_mask;
>>>
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Are you going to take this via your queue or do you want me to re-post
> with the r-b?

I can take this via my queue.

Thanks,
Laurent
