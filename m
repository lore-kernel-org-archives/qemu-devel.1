Received: from eggs.gnu.org ([2001:4830:134:3::10]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0BJg-0003n2-G5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0BJf-0004lw-LG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:16 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0BJf-0004kp-Dt
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:15 -0400
Received: by mail-wm0-x235.google.com with SMTP id t69so3787887wmt.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:56:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cd16f792-28a0-95b8-6a68-73f1427e6d38@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
	<cd16f792-28a0-95b8-6a68-73f1427e6d38@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 19:55:53 +0100
Message-ID: <CAFEAcA8y8f27o=c_Cpox8KZWGZshER5PrztorPZUf+RFnAHrAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Implement SG instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2017 at 19:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/22/2017 11:00 AM, Peter Maydell wrote:
>> Implement the SG instruction, which we emulate 'by hand' in the
>> exception handling code path.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 124 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index b1ecb66..8df819d 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -41,6 +41,10 @@ typedef struct V8M_SAttributes {
>>      bool irvalid;
>>  } V8M_SAttributes;
>>
>> +static void v8m_security_lookup(CPUARMState *env, uint32_t address,
>> +                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
>> +                                V8M_SAttributes *sattrs);
>> +
>>  /* Definitions for the PMCCNTR and PMCR registers */
>>  #define PMCRD   0x8
>>  #define PMCRC   0x4
>> @@ -6724,6 +6728,123 @@ static void arm_log_exception(int idx)
>>      }
>>  }
>>
>> +static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, uint16_t *insn)
>> +{
>
> This function doesn't take an address ...
>
>> +    if (get_phys_addr(env, env->regs[15], MMU_INST_FETCH, mmu_idx,
>> +                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi)) {
>
> ... reading it directly from r15 ...
>
>> +    if (insn != 0xe97f) {
>> +        /* Not an SG instruction first half (we choose the IMPDEF
>> +         * early-SG-check option).
>> +         */
>> +        goto gen_invep;
>> +    }
>> +
>> +    if (!v7m_read_half_insn(cpu, mmu_idx, &insn)) {
>> +        return false;
>> +    }
>> +
>> +    if (insn != 0xe97f) {
>> +        /* Not an SG instruction second half */
>> +        goto gen_invep;
>> +    }
>
> ... but somehow expects to get two different values read from the same address?
>
> Certainly you'd get the wrong exception frame if you incremented r15 in between.

Oops. I missed this in my testing because it happens that the
two halves of an SG instruction are the same value :-)

thanks
-- PMM
