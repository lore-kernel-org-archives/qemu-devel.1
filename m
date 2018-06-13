Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSuZg-0005zn-Ey
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSuZb-0005Lj-I4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:27:48 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSuZb-0005LU-Av
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:27:43 -0400
Received: by mail-pg0-x243.google.com with SMTP id c9-v6so428284pgf.5
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:27:43 -0700 (PDT)
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-16-richard.henderson@linaro.org>
	<CAFEAcA-weWiOLsrucjWMUjAh3tgS02RgBChpZOiOgd3HZK+imw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fef082f7-e297-61d8-8850-6d33e93b976f@linaro.org>
Date: Tue, 12 Jun 2018 15:27:37 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-weWiOLsrucjWMUjAh3tgS02RgBChpZOiOgd3HZK+imw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3b 15/18] target/arm: Implement SVE
 Integer Compare - Scalars Group
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

On 06/05/2018 08:02 AM, Peter Maydell wrote:
>> +    if (count & 63) {
>> +        d->p[i] = ~(-1ull << (count & 63)) & esz_mask;
> 
> Is this d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask; ?

Fixed.


>> +    tcg_gen_setcond_i64(cond, cmp, rn, rm);
>> +    tcg_gen_extrl_i64_i32(cpu_NF, cmp);
>> +    tcg_temp_free_i64(cmp);
>> +
>> +    /* VF = !NF & !CF.  */
>> +    tcg_gen_xori_i32(cpu_VF, cpu_NF, 1);
>> +    tcg_gen_andc_i32(cpu_VF, cpu_VF, cpu_CF);
>> +
>> +    /* Both NF and VF actually look at bit 31.  */
>> +    tcg_gen_neg_i32(cpu_NF, cpu_NF);
>> +    tcg_gen_neg_i32(cpu_VF, cpu_VF);
> 
> Microoptimization, but I think you can save an instruction here
> using
>        /* VF = !NF & !CF == !(NF || CF); we know NF and CF are
>         * both 0 or 1, so the result of the logical NOT has
>         * VF bit 31 set or clear as required.
>         */
>        tcg_gen_or_i32(cpu_VF, cpu_NF, cpu_CF);
>        tcg_gen_not_i32(cpu_VF, cpu_VF);

No, ~({0,1} | {0,1}) -> {-1,-2}.


>> +    /* For the helper, compress the different conditions into a computation
>> +     * of how many iterations for which the condition is true.
>> +     *
>> +     * This is slightly complicated by 0 <= UINT64_MAX, which is nominally
>> +     * 2**64 iterations, overflowing to 0.  Of course, predicate registers
>> +     * aren't that large, so any value >= predicate size is sufficient.
>> +     */
> 
> The comment says that 0 <= UINT64_MAX is a special case,
> but I don't understand how the code accounts for it ?
> 
>> +    tcg_gen_sub_i64(t0, op1, op0);
>> +
>> +    /* t0 = MIN(op1 - op0, vsz).  */
>> +    if (a->eq) {
>> +        /* Equality means one more iteration.  */
>> +        tcg_gen_movi_i64(t1, vsz - 1);
>> +        tcg_gen_movcond_i64(TCG_COND_LTU, t0, t0, t1, t0, t1);

By bounding the input, here, to the vector size.  This reduces the (2**64-1)+1
case, which we can't represent, to a vsz+1 case, which we can.  This produces
the same result for this instruction.

This does point out that I should be using the new tcg_gen_umin_i64 helper
instead of open-coding with movcond.


r~
