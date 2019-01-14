Received: from eggs.gnu.org ([209.51.188.92]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gj036-0006F9-5W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gj035-0006N3-8s
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:56 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:43165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gj034-0006Js-Vk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:55 -0500
References: <20181219042113.7364-1-richard.henderson@linaro.org>
	<20181219042113.7364-5-richard.henderson@linaro.org>
	<4e89a2dd-47fb-29ac-aff2-5d506e3deebb@vivier.eu>
	<a03894da-d5cd-d82b-1c48-bd5059389c89@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2bae1f2b-7268-c1e5-a85e-25731397da75@vivier.eu>
Date: Mon, 14 Jan 2019 12:04:51 +0100
MIME-Version: 1.0
In-Reply-To: <a03894da-d5cd-d82b-1c48-bd5059389c89@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/8] linux-user: Split out preadv,
 pwritev, readv, writev, pread64, pwrite64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 11/01/2019 22:31, Richard Henderson wrote:
> On 1/11/19 2:17 AM, Laurent Vivier wrote:
>> On 19/12/2018 05:21, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   linux-user/syscall-defs.h     |  14 ++++
>>>   linux-user/syscall-file.inc.c | 124 ++++++++++++++++++++++++++++++++++
>>>   linux-user/syscall.c          |  93 -------------------------
>>>   linux-user/strace.list        |  18 -----
>>>   4 files changed, 138 insertions(+), 111 deletions(-)
>>>
>> ...
>>> diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
>>> index 11e75044c1..410a763eee 100644
>>> --- a/linux-user/syscall-file.inc.c
>>> +++ b/linux-user/syscall-file.inc.c
>>> @@ -315,6 +315,104 @@ SYSCALL_IMPL(openat)
>> ...
>>> +
>>> +/*
>>> + * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
>>> + * Moreover, the parts are *always* in little-endian order.
>>> + */
>>> +#if TARGET_ABI_BITS == 32
>>> +SYSCALL_ARGS(preadv_pwritev)
>>> +{
>>> +    /* We have already assigned out[0-2].  */
>>> +    abi_ulong lo = in[3], hi = in[4];
>>> +    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
>>> +    return def;
>>> +}
>>> +#else
>>> +#define args_preadv_pwritev NULL
>>> +#endif
>>> +
>>> +/* Perform the inverse operation for the host.  */
>>> +static inline void host_offset64_low_high(unsigned long *l, unsigned long *h,
>>> +                                          uint64_t off)
>>> +{
>>> +    *l = off;
>>> +    *h = (off >> (HOST_LONG_BITS - 1)) >> 1;
>>> +}
>>
>>
>> I have an error with preadv() on a 32bit target (powerpc, LTP test preadv02).
>>
>> It works if I use:
>>
>> static inline void host_offset64_low_high(unsigned long *hlow,
>>                                            unsigned long *hhigh,
>>                                            abi_ulong tlow,
>>                                            abi_ulong thigh)
>> {
>>      uint64_t off = tlow |
>>                     ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
>>                     TARGET_LONG_BITS / 2;
>>      
>>      *hlow = off;
>>      *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
>> }
> 
> This doesn't make any sense.  Where are "tlow" and "thigh" coming from?
> 
> I think the bug will be
> 
>   SYSCALL_ARGS(preadv_pwritev)
>   {
>       /* We have already assigned out[0-2].  */
>       abi_ulong lo = in[3], hi = in[4];
> -    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
> +    out[3] = (((uint64_t)hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
>       return def;
>   }

Yes, this change fixes the problem.

Thanks,
Laurent
