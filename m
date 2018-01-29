Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egDz0-0000s1-D6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egDyx-0000xW-6h
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:16:42 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1egDyx-0000wz-0b
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:16:39 -0500
Received: by mail-pf0-x244.google.com with SMTP id p1so6075484pfh.4
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 10:16:38 -0800 (PST)
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-6-richard.henderson@linaro.org>
	<CAFEAcA_HKrxOc9rwiZfbVBW4r14F5u-+y-AATH1yvs6bELZnVg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a96a461-5dd7-65e6-dade-cda57a7ee79b@linaro.org>
Date: Mon, 29 Jan 2018 10:16:35 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HKrxOc9rwiZfbVBW4r14F5u-+y-AATH1yvs6bELZnVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/arm: Add SVE state to
 TB->FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/29/2018 10:01 AM, Peter Maydell wrote:
> On 23 January 2018 at 03:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Add both SVE exception state and vector length.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 10eef870fe..4c1eca7062 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -11263,6 +11263,8 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>>      dc->user = (dc->current_el == 0);
>>  #endif
>>      dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
>> +    dc->sve_excp_el = ARM_TBFLAG_SVEEXC_EL(dc->base.tb->flags);
>> +    dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;
> 
> You've carefully arranged that the sve_excp checks are a superset
> of the fp_excp checks, which means that we get the correct
> exception prioritization by always doing the sve_excp check first
> and then the fp_excp check second, without having to look at
> whether fp_excp_el or sve_excp_el is larger to see which should
> take precedence. We could
>   assert(dc->sve_excp_el <= dc->fp_excp_el);
> and perhaps have a comment noting why this is useful...

Sort of, I suppose.  Modulo the fact that "enabled" is zero,
so sve disabled &  fp enabled means sve_el > fp_el.

But you're right that to some extent I'm doing too much work
replicating the fp exception check.


r~
