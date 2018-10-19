Received: from eggs.gnu.org ([2001:4830:134:3::10]:41814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWbK-0004jX-VF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWbF-0007hR-6j
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:22:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDWbD-0007f3-Pu
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:22:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id 1-v6so16002829plv.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:22:03 -0700 (PDT)
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-4-richard.henderson@linaro.org>
	<CAFEAcA81rDucGOEVYi1LCw=1eiHisuM8+yXGzaw2dMktdU99cw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dda484c-1fc8-f75e-3150-111b0c7d85f9@linaro.org>
Date: Fri, 19 Oct 2018 08:21:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81rDucGOEVYi1LCw=1eiHisuM8+yXGzaw2dMktdU99cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: Flush only the TLBs
 affected by TTBR*_EL1
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

On 10/19/18 7:28 AM, Peter Maydell wrote:
> On 19 October 2018 at 02:56, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Only the EL0 and EL1 TLBs are affected by the EL1 register,
>> so flush only 2 of the 8 TLBs.
>>
>> In testing a boot of the Ubuntu installer to the first menu, this
>> accounts for nearly all of the full tlb flushes: all but 11k of
>> the 1.2M instances without the patch.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index ed70ac645e..3ba8e66487 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2706,14 +2706,16 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>      tcr->raw_tcr = value;
>>  }
>>
>> -static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> -                            uint64_t value)
>> +static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> +                                uint64_t value)
>>  {
>>      /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>>      if (cpreg_field_is_64bit(ri) &&
>>          extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>>          ARMCPU *cpu = arm_env_get_cpu(env);
>> -        tlb_flush(CPU(cpu));
>> +        tlb_flush_by_mmuidx(CPU(cpu),
>> +                            ARMMMUIdxBit_S12NSE1 |
>> +                            ARMMMUIdxBit_S12NSE0);
> 
> This isn't taking account of the possibility of secure mode.
> ARMMMUIdxBit_S1SE0 and ARMMMUIdxBit_S1SE1 might also be affected.

Ah.  Is there an easy way to tell if secure mode is present/enabled?  It'd be
nice to not flush tlbs that aren't in use...

> And for AArch32, this writefn is used for the secure-banked versions
> of TTBR0/TTBR1, which means ARMMMUIdxBit_S1E3 may also need flushing.

For aarch32, we don't have an asid, and so do not flush at all.


r~
