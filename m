Received: from eggs.gnu.org ([2001:4830:134:3::10]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowb7-0007Mz-OP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowb3-0001ZQ-Ol
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:32:05 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eowb3-0001Yu-Ja
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:32:01 -0500
Received: by mail-pg0-x243.google.com with SMTP id f6so2385052pgs.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:32:01 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-6-richard.henderson@linaro.org>
	<CAFEAcA9dA5rgqRGJV8rPrDGdzX5ZCKOpTMwDRMp_yu-sycyV+g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad61bcfb-152e-b383-5121-b42880f6426b@linaro.org>
Date: Thu, 22 Feb 2018 11:31:57 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dA5rgqRGJV8rPrDGdzX5ZCKOpTMwDRMp_yu-sycyV+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/67] target/arm: Implement SVE load
 vector/predicate
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

On 02/22/2018 10:20 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-sve.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/sve.decode      |  22 +++++++-
>>  2 files changed, 153 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
>> index 50cf2a1fdd..c0cccfda6f 100644
>> --- a/target/arm/translate-sve.c
>> +++ b/target/arm/translate-sve.c
>> @@ -46,6 +46,19 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
>>   * Implement all of the translator functions referenced by the decoder.
>>   */
>>
>> +/* Return the offset info CPUARMState of the predicate vector register Pn.
>> + * Note for this purpose, FFR is P16.  */
> 
> Missing newline before */.
> 
>> +/*
>> + *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
>> + */
>> +
>> +/* Subroutine loading a vector register at VOFS of LEN bytes.
>> + * The load should begin at the address Rn + IMM.
>> + */
>> +
>> +#if UINTPTR_MAX == UINT32_MAX
>> +# define ptr i32
>> +#else
>> +# define ptr i64
>> +#endif
> 
> I think that rather than doing this we should improve the
> provision that tcg/tcg-op.h has for *_ptr() wrappers, so
> from the target's point of view it has a proper tcg_const_local_ptr()
> and tcg_gen_brcondi_ptr(), same as for _i32, _i64 and _tl.
> 
>> +
>> +static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
>> +                   int rn, int imm)
>> +{
>> +    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
>> +    uint32_t len_remain = len % 8;
>> +    uint32_t nparts = len / 8 + ctpop8(len_remain);
>> +    int midx = get_mem_index(s);
>> +    TCGv_i64 addr, t0, t1;
>> +
>> +    addr = tcg_temp_new_i64();
>> +    t0 = tcg_temp_new_i64();
>> +
>> +    /* Note that unpredicated load/store of vector/predicate registers
>> +     * are defined as a stream of bytes, which equates to little-endian
>> +     * operations on larger quantities.  There is no nice way to force
>> +     * a little-endian load for aarch64_be-linux-user out of line.
>> +     *
>> +     * Attempt to keep code expansion to a minimum by limiting the
>> +     * amount of unrolling done.
>> +     */
>> +    if (nparts <= 4) {
>> +        int i;
>> +
>> +        for (i = 0; i < len_align; i += 8) {
>> +            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
>> +            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
>> +            tcg_gen_st_i64(t0, cpu_env, vofs + i);
>> +        }
>> +    } else {
>> +        TCGLabel *loop = gen_new_label();
>> +        TCGv_ptr i = TCGV_NAT_TO_PTR(glue(tcg_const_local_, ptr)(0));
>> +        TCGv_ptr dest;
>> +
>> +        gen_set_label(loop);
>> +
>> +        /* Minimize the number of local temps that must be re-read from
>> +         * the stack each iteration.  Instead, re-compute values other
>> +         * than the loop counter.
>> +         */
>> +        dest = tcg_temp_new_ptr();
>> +        tcg_gen_addi_ptr(dest, i, imm);
>> +#if UINTPTR_MAX == UINT32_MAX
>> +        tcg_gen_extu_i32_i64(addr, TCGV_PTR_TO_NAT(dest));
>> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
>> +#else
>> +        tcg_gen_add_i64(addr, TCGV_PTR_TO_NAT(dest), cpu_reg_sp(s, rn));
>> +#endif
> 
> Can we avoid the ifdef by creating a tcg_gen_ext_ptr_i64() (similar
> to but opposite in effect to the existing tcg_gen_ext_i32_ptr()) ?

Ok, I will improve tcg.h as necessary for better support of TCGv_ptr.

>> -@rd_rn_rm_e0   ........ ... rm:5  ... ...  rn:5 rd:5           &rrr_esz esz=0
>> +@rd_rn_rm_e0   ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
> 
> This change looks like it should be squashed into a previous patch?

Ho hum, I thought I got all of these.  I'll take another look through.


r~
