Received: from eggs.gnu.org ([2001:4830:134:3::10]:42022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXIoA-0001dk-RE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXIo7-0003aV-Nl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:04:22 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXIo7-0003Zw-Gg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:04:19 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so1016513pfh.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:04:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170714001819.1660-1-rth@twiddle.net>
	<20170714001819.1660-4-rth@twiddle.net>
	<20170718015303.GA20247@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e77606fb-0303-beb4-f4e7-3c0120e938c3@twiddle.net>
Date: Mon, 17 Jul 2017 17:04:11 -1000
MIME-Version: 1.0
In-Reply-To: <20170718015303.GA20247@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] target/alpha: Merge several flag bytes
 into ENV->FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/17/2017 03:53 PM, Emilio G. Cota wrote:
> On Thu, Jul 13, 2017 at 14:18:14 -1000, Richard Henderson wrote:
>> The flags are arranged such that we can manipulate them either
>> a whole, or as individual bytes.  The computation within
>> cpu_get_tb_cpu_state is now reduced to a single load and mask.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/alpha/cpu.h       | 70 +++++++++++++++++--------------------
>>   hw/alpha/dp264.c         |  1 -
>>   linux-user/main.c        | 25 +++++++------
>>   target/alpha/cpu.c       |  7 ++--
>>   target/alpha/helper.c    | 12 +++----
>>   target/alpha/machine.c   | 10 ++----
>>   target/alpha/translate.c | 91 +++++++++++++++++++++++++++++++-----------------
>>   7 files changed, 117 insertions(+), 99 deletions(-)
>>
>> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
>> index aa83417..e95be2b 100644
>> --- a/target/alpha/cpu.h
>> +++ b/target/alpha/cpu.h
>> @@ -242,13 +242,11 @@ struct CPUAlphaState {
>>       uint8_t fpcr_dyn_round;
>>       uint8_t fpcr_flush_to_zero;
>>   
>> -    /* The Internal Processor Registers.  Some of these we assume always
>> -       exist for use in user-mode.  */
>> -    uint8_t ps;
>> -    uint8_t intr_flag;
>> -    uint8_t pal_mode;
>> -    uint8_t fen;
>> +    /* Mask of PALmode, Processor State et al.  Most of this gets copied
>> +       into the TranslatorBlock flags and controls code generation.  */
>> +    uint32_t flags;
> 
> Did you consider doing something like the appended? I don't like it
> because it messes with endianness, which is always a pain. But it
> lets you preserve the code that only touches the u8's as-is; this
> comes at the price of requiring a fast-path swap in big-endian hosts.
> 
> An alternative would be to store the u8's in an order dependent on
> the endianness of the host -- but that would break vmstate saving,
> I guess.
> 
> 		Emilio
> 
> ---8<---
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index aa83417..22c52ac 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -244,10 +244,15 @@ struct CPUAlphaState {
>   
>       /* The Internal Processor Registers.  Some of these we assume always
>          exist for use in user-mode.  */
> -    uint8_t ps;
> -    uint8_t intr_flag;
> -    uint8_t pal_mode;
> -    uint8_t fen;
> +    union {
> +        struct {
> +            uint8_t pal_mode;
> +            uint8_t ps;
> +            uint8_t intr_flag;
> +            uint8_t fen;
> +        };
> +        uint32_t flags;
> +    };

I did consider this.

Doing things this way requires that I consider host endianness when forming the 
bit masks.  As opposed to only needing to consider host endianness while 
computing byte offsets within the translator.


r~
