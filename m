Received: from eggs.gnu.org ([2001:4830:134:3::10]:50802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUuDZ-00007D-6Y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUuB0-0004IS-I1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:58:55 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUuB0-0004Hj-0Y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:58:50 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 81so479619otj.2
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:58:49 -0800 (PST)
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-9-richard.henderson@linaro.org>
	<CAFEAcA__1C-GkRk65E+JL9Ovte7GhZhGKmP3Zcv_w=wZSqV7=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <915ab710-26df-43af-495f-7c59b0b885e9@linaro.org>
Date: Thu, 6 Dec 2018 07:58:44 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__1C-GkRk65E+JL9Ovte7GhZhGKmP3Zcv_w=wZSqV7=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/10] target/arm: Implement the
 ARMv8.1-LOR extension
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

On 12/6/18 7:49 AM, Peter Maydell wrote:
>> +static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR1, LO) != 0;
> 
> You're testing the wrong ID register here...

Oops, I thought I fixed that...

>> +static CPAccessResult access_lor_other(CPUARMState *env,
>> +                                       const ARMCPRegInfo *ri, bool isread)
>> +{
>> +    int el = arm_current_el(env);
>> +
>> +    if (arm_is_secure_below_el3(env)) {
>> +        /* Access denied in secure mode.  */
>> +        return CP_ACCESS_TRAP;
>> +    }
>> +    if (el < 2 && arm_el_is_aa64(env, 2)) {
> 
> You don't need to explicitly check if EL2 is AArch64 --
> these registers are AArch64 only so if we accessed them
> from a lower EL then that EL is AArch64 and so all the
> ELs above it must be too.

Ok.

> 
>> +        uint64_t hcr = arm_hcr_el2_eff(env);
>> +        if (hcr & HCR_E2H) {
>> +            hcr &= HCR_TLOR;
>> +        } else {
>> +            hcr &= HCR_TGE | HCR_TLOR;
> 
> This doesn't make sense to me: I think TGE can't be 1 here.
> We know (.access flag) that we're not in EL0. We know from
> the el < 2 that we're in EL1, and we've already ruled out
> Secure EL1. So this is NS EL1. If E2H == 0 then TGE can't
> be set, because E2H,TGE={0,1} means the CPU can never be
> in NS EL1.

Ok.  Perhaps I was too blindly following the access cases listed in the ARM and
not applying any extra thought.

> (these remarks apply also to the access_lorid function)

I think I will split out a shared subroutine for these.

>> +    case 0x8: /* STLLR */
>> +        if (!dc_isar_feature(aa64_lor, s)) {
>> +            break;
>> +        }
>> +        /* StoreLORelease is the same as Store-Release for QEMU.  */
>> +        /* fallthru */
> 
> We are as usual a bit inconsistent, but we seem to use the
> spelling "fall through" for this linter-hint more often than
> any of the other variations.

I was going to say something about old habits, but I do note that I've somehow
migrated from the witheringly old FALLTHRU.  So perhaps I can learn eventually...


r~
