Received: from eggs.gnu.org ([2001:4830:134:3::10]:32865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUxNc-0004YA-N8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUxNX-0003xO-Nr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:24:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUxNX-0003ww-E8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:23:59 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so1155550otk.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:23:59 -0800 (PST)
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-6-richard.henderson@linaro.org>
	<CAFEAcA973PazwfLxUpAbbLUkYoGcTq=QrWCUDmmx7VgK8C2LJQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b974bade-cfb2-7740-757a-8781a61c1f8b@linaro.org>
Date: Thu, 6 Dec 2018 11:23:54 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA973PazwfLxUpAbbLUkYoGcTq=QrWCUDmmx7VgK8C2LJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/10] target/arm: Introduce
 arm_hcr_el2_eff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/6/18 6:09 AM, Peter Maydell wrote:
> On Mon, 3 Dec 2018 at 20:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Replace arm_hcr_el2_{fmo,imo,amo} with a more general routine
>> that also takes SCR_EL3.NS (aka arm_is_secure_below_el3) into
>> account, as documented for the plethora of bits in HCR_EL2.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h          | 67 +++++++++------------------------------
>>  hw/intc/arm_gicv3_cpuif.c | 21 ++++++------
>>  target/arm/helper.c       | 65 +++++++++++++++++++++++++++++++------
>>  3 files changed, 82 insertions(+), 71 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 20d97b66de..e871b946c8 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1722,6 +1722,14 @@ static inline bool arm_is_secure(CPUARMState *env)
>>  }
>>  #endif
>>
>> +/**
>> + * arm_hcr_el2_eff(): Return the effective value of HCR_EL2.
>> + * E.g. when in secure state, fields in HCR_EL2 are suppressed,
>> + * "for all purposes other than a direct read or write access of HCR_EL2."
>> + * Not included here are RW, VI, VF.
>> + */
>> +uint64_t arm_hcr_el2_eff(CPUARMState *env);
> 
> This comment says the not-included bits are RW, VI, VF...
> 
>> +/*
>> + * Return the effective value of HCR_EL2.
>> + * Bits that are not included here:
>> + * RW       (read from SCR_EL3.RW as needed)
>> + */
> 
> ...but this comment only lists RW. Which is correct ?
> 
> Also, if VI, VF are in the list shouldn't VSE be too ?

VI and VF were on the list when I first wrote the patch, then one of the
target-arm.next patches rearranged how those bits are handled.

So correct is that they are *not* excluded.

>> +    } else if (ret & HCR_TGE) {
>> +        if (ret & HCR_E2H) {
>> +            ret &= ~(HCR_TTLBOS | HCR_TTLBIS | HCR_TOCU | HCR_TICAB |
>> +                     HCR_TID4 | HCR_ID | HCR_CD | HCR_TDZ | HCR_TPU |
>> +                     HCR_TPCP | HCR_TID2 | HCR_TID1 | HCR_TID0 | HCR_TWE |
>> +                     HCR_TWI | HCR_DC | HCR_BSU_MASK | HCR_FB | HCR_AMO |
>> +                     HCR_IMO | HCR_FMO | HCR_VM);
> 
> 
> This list should also in theory include HCR_MIOCNCE, but the
> QEMU implementation of that bit is going to be RAZ/WI anyway.

Even if we do RAZ/WI, it's probably better to match the docs and exclude it
here.  Fixed.

> 
> HCR_TID1 is in the "ignore if TGE==1" group, not the "ignore if
> {E2H, TGE} == {1,1}" group.

Fixed.

> 
> Maybe we should be also setting HCR_ATA here ? We could perhaps
> leave that til we implement ARMv8.5-MemTag and understand it better.

This list was created with the ARMv8.4 document.
Perhaps a comment to that effect while v8.5 is still in flight?

> 
>> +        } else {
>> +            ret &= ~(HCR_PTW | HCR_FB | HCR_TID1 | HCR_TID3 | HCR_TSC |
>> +                     HCR_TACR | HCR_TSW | HCR_TTLB | HCR_TVM | HCR_HCD |
>> +                     HCR_TRVM | HCR_TLOR);
> 
> Shouldn't these bits be being cleared regardless of E2H, rather
> than only in the TGE==1 E2H==0 case ?

Fixed.

> Missing HCR_SWIO ?

Fixed.

> The list of bits cleared if TGE && E2H is highest-first, but this
> list is lowest-first...

Both lists now lowest first.


r~
