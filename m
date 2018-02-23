Received: from eggs.gnu.org ([2001:4830:134:3::10]:49335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKP2-0001s8-PJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKOz-0006NJ-P1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:57:12 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKOz-0006MZ-Gu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:57:09 -0500
Received: by mail-pl0-x241.google.com with SMTP id bb3so5567729plb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:57:09 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-37-richard.henderson@linaro.org>
	<CAFEAcA8mvCXMEBv+dLwVfQcdEeyaqSfK9EX1HzQOKfQi8+Tk2g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b1ac6b7-096f-0e20-2d35-18f095efc56f@linaro.org>
Date: Fri, 23 Feb 2018 12:57:04 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8mvCXMEBv+dLwVfQcdEeyaqSfK9EX1HzQOKfQi8+Tk2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/67] target/arm: Implement SVE Integer
 Compare - Vectors Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 08:29 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index 86cd792cdf..ae433861f8 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -46,14 +46,14 @@
>>   *
>>   * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
>>   * and bit 0 set if C is set.
>> - *
>> - * This is an iterative function, called for each Pd and Pg word
>> - * moving forward.
>>   */
>>
>>  /* For no G bits set, NZCV = C.  */
>>  #define PREDTEST_INIT  1
>>
>> +/* This is an iterative function, called for each Pd and Pg word
>> + * moving forward.
>> + */
> 
> Why move this comment?

Meant to fold this to the first.  But moving so that I can separately document...

>> +/* This is an iterative function, called for each Pd and Pg word
>> + * moving backward.
>> + */
>> +static uint32_t iter_predtest_bwd(uint64_t d, uint64_t g, uint32_t flags)

... this.

>> +    do {                                                                     \
>> +        uint64_t out = 0, pg;                                                \
>> +        do {                                                                 \
>> +            i -= sizeof(TYPE), out <<= sizeof(TYPE);                         \
>> +            TYPE nn = *(TYPE *)(vn + H(i));                                  \
>> +            TYPE mm = *(TYPE *)(vm + H(i));                                  \
>> +            out |= nn OP mm;                                                 \
>> +        } while (i & 63);                                                    \
>> +        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                            \
>> +        out &= pg;                                                           \
>> +        *(uint64_t *)(vd + (i >> 3)) = out;                                  \
>> +        flags = iter_predtest_bwd(out, pg, flags);                           \
>> +    } while (i > 0);                                                         \
>> +    return flags;                                                            \
>> +}
> 
> Why do we iterate backwards through the vector? As far as I can
> see the pseudocode iterates forwards, and I don't think it
> makes a difference to the result which way we go.

You're right, it does not make a difference to the result which way we iterate.

Of the several different ways I've written loops over predicates, this is my
favorite.  It has several points in its favor:

  1) Operate on full uint64_t predicate units instead
     of uint8_t or uint16_t sub-units.  This means

     1a) No big-endian adjustment required,
     1b) Fewer memory loads.

  2) No separate loop tail; it is shared with the main loop body.

  3) A sub-point specific to predicate output, but the main loop
     gets to run un-predicated.  Here the governing predicate is
     applied at the end: out &= pg.


r~
