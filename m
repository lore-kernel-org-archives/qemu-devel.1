Received: from eggs.gnu.org ([2001:4830:134:3::10]:58339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fiklA-0005VD-El
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fikl5-0001W5-Ig
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:13:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fikl5-0001VK-6e
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:13:03 -0400
References: <20180726132947.28538-1-alex.bennee@linaro.org>
	<20180726132947.28538-2-alex.bennee@linaro.org>
	<a2dd4939-3fd3-31dd-7763-c96b1b627c21@vivier.eu>
	<87va91swu1.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a77ed37b-e8b0-6c39-8975-75ae5353db78@vivier.eu>
Date: Thu, 26 Jul 2018 20:12:16 +0200
MIME-Version: 1.0
In-Reply-To: <87va91swu1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 for 3.0 1/2] linux-user/mmap.c: handle
 len = 0 maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, umarcor <1783362@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>

Le 26/07/2018 à 19:58, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 26/07/2018 à 15:29, Alex Bennée a écrit:
>>> I've slightly re-organised the check to more closely match the
>>> sequence that the kernel uses in do_mmap().
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: umarcor <1783362@bugs.launchpad.net>
>>> ---
>>>  linux-user/mmap.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>> index d0c50e4888..3ef69fa2d0 100644
>>> --- a/linux-user/mmap.c
>>> +++ b/linux-user/mmap.c
>>> @@ -391,14 +391,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>>>      }
>>>  #endif
>>>
>>> -    if (offset & ~TARGET_PAGE_MASK) {
>>> +    if (!len) {
>>>          errno = EINVAL;
>>>          goto fail;
>>>      }
>>>
>>>      len = TARGET_PAGE_ALIGN(len);
>>> -    if (len == 0)
>>> -        goto the_end;
>>> +    if (!len) {
>>> +        errno = EINVAL;
>>> +        goto fail;
>>> +    }
>>
>> Why do you check twice len?
>> TARGET_PAGE_ALIGN() rounds up the value, so if it was not 0, it cannot
>> be now.
> 
> I was trying to follow the kernel style but I realise TARGET_PAGE_ALIGN
> might be a different test compared to the kernel's PAGE_ALIGN(len) for
> overflows:
...
> 	/* Careful about overflows.. */
> 	len = PAGE_ALIGN(len);
> 	if (!len)
> 		return -ENOMEM;
> 


OK, so keep it but you should use ENOMEM, not EINVAL (and add a comment :) )

Thanks,
Laurent
