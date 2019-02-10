Received: from eggs.gnu.org ([209.51.188.92]:38786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsdnI-0006Q8-VQ
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsdnH-0004dN-0e
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:20:28 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsdnF-0004cH-Tg
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:20:26 -0500
Received: by mail-pf1-x442.google.com with SMTP id c123so3514255pfb.0
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 17:20:25 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
	<CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <252331dd-aea1-03ac-daa8-d37e2076a08c@linaro.org>
Date: Sat, 9 Feb 2019 17:20:20 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
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

On 2/5/19 11:27 AM, Peter Maydell wrote:
>> +#ifdef TARGET_AARCH64
>> +        uint64_t tfsr_el[4]; /* tfsrel0_el1 is index 0.  */
>> +        uint64_t gcr_el1;
>> +        uint64_t rgsr_el1;
>> +#endif
> 
> Are we going to add more fields inside this #ifdef or is it only
> saving 12 words?

Just the 12 words here.  We've got plenty of other ifdefs though...

>> +/* Set bits within PSTATE.  */
>> +static inline void set_pstate_bits(uint32_t bits)
>> +{
>> +    TCGv_i32 p = tcg_temp_new_i32();
>> +
>> +    tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
>> +    tcg_gen_ori_i32(p, p, bits);
>> +    tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
>> +    tcg_temp_free_i32(p);
> 
> Maybe assert() that all the bits in the input are in the
> set that we actually store in env->pstate, to catch attempts
> to set NZCV, nRW, etc this way ?

I suppose.  There's the clear_pstate_bits just below, which has a couple of users.

>> +      .type = ARM_CP_NO_RAW,
>> +      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
>> +    REGINFO_SENTINEL
> 
> Missing GMID_EL1 ?

Err..  that's not in 00eac5, at least.

>> +    case 0x1c: /* TCO */
>> +        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
>> +            goto do_unallocated;
>> +        }
>> +        if (crm & 1) {
>> +            set_pstate_bits(PSTATE_TCO);
>> +        } else {
>> +            clear_pstate_bits(PSTATE_TCO);
>> +        }
>> +        break;
> 
> Don't we need to break the TB here or something to pick up
> the new value of TCO when we generate code for a following
> load or store?

Yep.  It's included in the (quite complex) MTE_ACTIVE.


r~
