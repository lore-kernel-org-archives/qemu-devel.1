Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4KA-0002uE-2a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4K8-0006Av-LE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:52:02 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4K8-0006AC-CB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:52:00 -0500
Received: by mail-ua0-x229.google.com with SMTP id 96so138254918uaq.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:52:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpdka0hg.fsf@linaro.org>
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-2-git-send-email-peter.maydell@linaro.org>
	<87wpdka0hg.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:51:39 +0000
Message-ID: <CAFEAcA82d2QcMgEk1VKMrQS6S0dzOY-D4PX=RzYf-E72viX72w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/6] armv7m: MRS/MSR: handle
 unprivileged access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 24 January 2017 at 16:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> From: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> The MRS and MSR instruction handling has a number of flaws:
>>  * unprivileged accesses should only be able to read
>>    CONTROL and the xPSR subfields, and only write APSR
>>    (others RAZ/WI)
>>  * privileged access should not be able to write xPSR
>>    subfields other than APSR
>>  * accesses to unimplemented registers should log as
>>    guest errors, not abort QEMU
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> [PMM: rewrote commit message]
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 79 +++++++++++++++++++++++++---------------------=
-------
>>  1 file changed, 37 insertions(+), 42 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 7111c8c..ad23de3 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -8243,23 +8243,32 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUStat=
e *cs, vaddr addr,
>>
>>  uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>>  {
>> -    ARMCPU *cpu =3D arm_env_get_cpu(env);
>> +    uint32_t mask;
>> +    unsigned el =3D arm_current_el(env);
>> +
>> +    /* First handle registers which unprivileged can read */
>> +
>> +    switch (reg) {
>> +    case 0 ... 7: /* xPSR sub-fields */
>
> This reads a little confusingly compared to the pseudo-code in the ARM
> ARM. Would it be clearer if we just went:
>
>   switch(extract32(reg, 3, 5)) {
>     case 0: /* xPSR */
>     ...
>     case 1: /* SP */
>     ...
>     case 2: /* Priority Mask or CONTROL.. */
>     ...
>   }
>
> ?

I think a simple switch on the register number is rather
less confusing than the pseudocode's nested switches on
the two halves of the register number -- this is a case where
we don't have to follow the pseudocode if it phrases something
weirdly.

>> +        mask =3D 0;
>> +        if ((reg & 1) && el) {
>> +            mask |=3D 0x000001ff; /* IPSR (unpriv. reads as zero) */
>
> As B5.2.2 doesn't imply any particular access limit perhaps the comment
> should read /* ISPR (reads as zero when not in exception) */

B5.2.2 Notes says "If unprivileged code attempts to read [...] the IPSR,
the read returns zero". In the pseudocode this is handled by an
architectural guarantee that you can't get here in unprivileged
mode with an IPSR value that isn't zero; however given the current
state of the QEMU code I'm not really prepared to make that assertion,
so it seems better to just report 0 here.

>> +        }
>> +        if (!(reg & 4)) {
>> +            mask |=3D 0xf8000000; /* APSR */
>> +        }
>> +        /* EPSR reads as zero */
>> +        return xpsr_read(env) & mask;
>> +        break;
>> +    case 20: /* CONTROL */
>> +        return env->v7m.control;
>
> I'm fairly sure this was meant to be 0x20 and either way the result is
> gated by current privilege.

No, it's decimal 20, binary 0b10100. CONTROL is the case
of 00010 in the outer switch and 100 in the inner, and
it isn't privilege-checked. (See how confusing the
pseudocode phrasing is ? :-))

>> +    }
>> +
>> +    if (el =3D=3D 0) {
>> +        return 0; /* unprivileged reads others as zero */
>> +    }
>>
>>      switch (reg) {
>> -    case 0: /* APSR */
>> -        return xpsr_read(env) & 0xf8000000;
>> -    case 1: /* IAPSR */
>> -        return xpsr_read(env) & 0xf80001ff;
>> -    case 2: /* EAPSR */
>> -        return xpsr_read(env) & 0xff00fc00;
>> -    case 3: /* xPSR */
>> -        return xpsr_read(env) & 0xff00fdff;
>> -    case 5: /* IPSR */
>> -        return xpsr_read(env) & 0x000001ff;
>> -    case 6: /* EPSR */
>> -        return xpsr_read(env) & 0x0700fc00;
>> -    case 7: /* IEPSR */
>> -        return xpsr_read(env) & 0x0700edff;
>>      case 8: /* MSP */
>>          return env->v7m.current_sp ? env->v7m.other_sp : env->regs[13];
>>      case 9: /* PSP */
>> @@ -8271,40 +8280,26 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint3=
2_t reg)
>>          return env->v7m.basepri;
>>      case 19: /* FAULTMASK */
>>          return (env->daif & PSTATE_F) !=3D 0;
>> -    case 20: /* CONTROL */
>> -        return env->v7m.control;
>>      default:
>> -        /* ??? For debugging only.  */
>> -        cpu_abort(CPU(cpu), "Unimplemented system register read (%d)\n"=
, reg);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special=
"
>> +                                       " register %d\n", reg);
>>          return 0;
>>      }
>>  }
>>
>>  void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
>>  {
>> -    ARMCPU *cpu =3D arm_env_get_cpu(env);
>> +    if (arm_current_el(env) =3D=3D 0 && reg > 7) {
>> +        /* only xPSR sub-fields may be written by unprivileged */
>> +        return;
>> +    }
>>
>>      switch (reg) {
>> -    case 0: /* APSR */
>> -        xpsr_write(env, val, 0xf8000000);
>> -        break;
>> -    case 1: /* IAPSR */
>> -        xpsr_write(env, val, 0xf8000000);
>> -        break;
>> -    case 2: /* EAPSR */
>> -        xpsr_write(env, val, 0xfe00fc00);
>> -        break;
>> -    case 3: /* xPSR */
>> -        xpsr_write(env, val, 0xfe00fc00);
>> -        break;
>> -    case 5: /* IPSR */
>> -        /* IPSR bits are readonly.  */
>> -        break;
>> -    case 6: /* EPSR */
>> -        xpsr_write(env, val, 0x0600fc00);
>> -        break;
>> -    case 7: /* IEPSR */
>> -        xpsr_write(env, val, 0x0600fc00);
>> +    case 0 ... 7: /* xPSR sub-fields */
>> +        /* only APSR is actually writable */
>> +        if (reg & 4) {
>> +            xpsr_write(env, val, 0xf8000000); /* APSR */
>> +        }
>
> I assuming insn<10> selects a different helper....

insn<10> is mask<0> -- the behaviour is UNPREDICTABLE unless
the DSP extension is implemented. This code all predates the
attempt to support that in our cortex-m4 model (and indeed
predates the existence of M profile DSP extns), so it doesn't
care about the mask bits. I think the translate.c code is
probably just going to get that decode wrong at the moment.
We should tighten it up but it will likely be a different
helper and definitely a separate patch.

>>          break;
>>      case 8: /* MSP */
>>          if (env->v7m.current_sp)
>> @@ -8345,8 +8340,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t re=
g, uint32_t val)
>>          switch_v7m_sp(env, (val & 2) !=3D 0);
>>          break;
>>      default:
>> -        /* ??? For debugging only.  */
>> -        cpu_abort(CPU(cpu), "Unimplemented system register write (%d)\n=
", reg);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown specia=
l"
>> +                                       " register %d\n", reg);
>>          return;
>>      }
>>  }

thanks
-- PMM
