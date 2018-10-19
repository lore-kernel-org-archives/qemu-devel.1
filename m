Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXOW-0003Gz-IN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXOV-0007tS-FL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:13:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDXOV-0007tE-1T
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:12:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id v2so26576069otk.1
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:12:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1dda484c-1fc8-f75e-3150-111b0c7d85f9@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-4-richard.henderson@linaro.org>
	<CAFEAcA81rDucGOEVYi1LCw=1eiHisuM8+yXGzaw2dMktdU99cw@mail.gmail.com>
	<1dda484c-1fc8-f75e-3150-111b0c7d85f9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:12:37 +0100
Message-ID: <CAFEAcA8f2SvmsABANVrWLZo8NzeAirMOqsm7AnyPCVVKL_z0Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 16:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/19/18 7:28 AM, Peter Maydell wrote:
>> On 19 October 2018 at 02:56, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Only the EL0 and EL1 TLBs are affected by the EL1 register,
>>> so flush only 2 of the 8 TLBs.
>>>
>>> In testing a boot of the Ubuntu installer to the first menu, this
>>> accounts for nearly all of the full tlb flushes: all but 11k of
>>> the 1.2M instances without the patch.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/arm/helper.c | 16 +++++++++-------
>>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index ed70ac645e..3ba8e66487 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -2706,14 +2706,16 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>>      tcr->raw_tcr = value;
>>>  }
>>>
>>> -static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>> -                            uint64_t value)
>>> +static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>> +                                uint64_t value)
>>>  {
>>>      /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>>>      if (cpreg_field_is_64bit(ri) &&
>>>          extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>>>          ARMCPU *cpu = arm_env_get_cpu(env);
>>> -        tlb_flush(CPU(cpu));
>>> +        tlb_flush_by_mmuidx(CPU(cpu),
>>> +                            ARMMMUIdxBit_S12NSE1 |
>>> +                            ARMMMUIdxBit_S12NSE0);
>>
>> This isn't taking account of the possibility of secure mode.
>> ARMMMUIdxBit_S1SE0 and ARMMMUIdxBit_S1SE1 might also be affected.
>
> Ah.  Is there an easy way to tell if secure mode is present/enabled?  It'd be
> nice to not flush tlbs that aren't in use...

If ARM_FEATURE_EL3 is set, we have an EL3. It is probably possible
to look at the current state of the CPU and determine whether we
need to flush the NS TLBs or the S TLBs, but I would need to
think about that. For AArch32 there are banked registers here, so
we could in theory distinguish writes to the S banked and NS banked
regs. For AArch64 there's only one EL1 register, so we'd
need to check the Arm ARM for how interleaved writes to the TTBR_EL1
and flipping between S and NS work (and when the guest is supposed
to do the TLB maintenance anyway).

A conservative check is probably:
  if arm_current_el() < 3
     // TTBR definitely can only be affecting the EL0/1
     // translation regime for the current security state
     if arm_is_secure_below_el3()
        if EL3 is AArch32
            flush S1SE0, S1E3
        else
            flush S1SE0, S1SE1
     else
        flush S12NSE1, S12NSE0
  else
     // err on the side of flushing more than maybe we need to
     flush S1SE0, S12NSE1, S12NSE0
     if EL3 is AArch32
          flush S1E3
     else
          flush S1SE1

(but you should check my logic ;-))

>> And for AArch32, this writefn is used for the secure-banked versions
>> of TTBR0/TTBR1, which means ARMMMUIdxBit_S1E3 may also need flushing.
>
> For aarch32, we don't have an asid, and so do not flush at all.

We do for AArch32 with TTBCR.EAE == 1 (ie LPAE, when you want to
use the 64-bit form of the register, accessed via MRRC/MCRR).
cpreg_field_is_64bit() is true for both "AArch64 sysreg" and
"AArch32 64-bit cp reg".

thanks
-- PMM
