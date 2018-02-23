Received: from eggs.gnu.org ([2001:4830:134:3::10]:34600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epJV5-0004If-KU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epJV0-0006on-Mq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:59:23 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epJV0-0006kS-FK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:59:18 -0500
Received: by mail-pg0-x22c.google.com with SMTP id m19so3757018pgn.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 11:59:18 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-29-richard.henderson@linaro.org>
	<CAFEAcA8BnNkgHNQd2xK8BrYzhtG4_fee3rWTKXqVxRNEf5FJNA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b67bcb61-6f0a-b565-2e56-2ab7c26d7b10@linaro.org>
Date: Fri, 23 Feb 2018 11:59:14 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8BnNkgHNQd2xK8BrYzhtG4_fee3rWTKXqVxRNEf5FJNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/67] target/arm: Implement SVE Permute
 - Predicates Group
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

On 02/23/2018 07:15 AM, Peter Maydell wrote:
>> +static const uint64_t expand_bit_data[5][2] = {
>> +    { 0x1111111111111111ull, 0x2222222222222222ull },
>> +    { 0x0303030303030303ull, 0x0c0c0c0c0c0c0c0cull },
>> +    { 0x000f000f000f000full, 0x00f000f000f000f0ull },
>> +    { 0x000000ff000000ffull, 0x0000ff000000ff00ull },
>> +    { 0x000000000000ffffull, 0x00000000ffff0000ull }
>> +};
>> +
>> +/* Expand units of 2**N bits to units of 2**(N+1) bits,
>> +   with the higher bits zero.  */
> 
> In bitops.h we call this operation "half shuffle" (where
> it is specifically working on units of 1 bit size), and
> the inverse "half unshuffle". Worth mentioning that (or
> using similar terminology) ?

I hadn't noticed this helper.  I'll at least mention.

FWIW, the half_un/shuffle operation is what you get with N=0, which corresponds
to a byte predicate interleave.  We need the intermediate steps for half,
single, and double predicate interleaves.

>> +static uint64_t expand_bits(uint64_t x, int n)
>> +{
>> +    int i, sh;
> 
> Worth asserting that n is within the range we expect it to be ?
> (what range is that? 0 to 4?)

N goes from 0-3; I goes from 0-4.  N will have been controlled by decode, so
I'm not sure it's worth an assert.  Even if I did add one, I wouldn't want it
here, at the center of a loop kernel.

>> +        d[0] = nn + (mm << (1 << esz));
> 
> Is this actually doing an addition, or is it just an odd
> way of writing a bitwise OR when neither of the two
> inputs have 1 in the same bit position?

It could be an OR.  Here I'm hoping that the compiler will use a shift-add
instruction.  Which it wouldn't necessarily be able to prove by itself if I did
write it with an OR.

>> +        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
> 
> This looks like it's using addition for logical OR again ?

Yes.  Although this time I admit it'll never produce an LEA.

>> +        /* For VL which is not a power of 2, the results from M do not
>> +           align nicely with the uint64_t for D.  Put the aligned results
>> +           from M into TMP_M and then copy it into place afterward.  */
> 
> How much risu testing did you do of funny vector lengths ?

As much as I can with the unlicensed Foundation Platform: all lengths from 1-4.

Which, unfortunately does leave a few multi-word predicate paths untested, but
many of the routines loop identically within this length and beyond.


>> +static const uint64_t even_bit_esz_masks[4] = {
>> +    0x5555555555555555ull,
>> +    0x3333333333333333ull,
>> +    0x0f0f0f0f0f0f0f0full,
>> +    0x00ff00ff00ff00ffull
>> +};
> 
> Comment describing the purpose of these numbers would be useful.

Ack.


r~
