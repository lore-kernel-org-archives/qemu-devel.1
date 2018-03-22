Received: from eggs.gnu.org ([2001:4830:134:3::10]:59998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxui-0008Nh-8F
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxuh-0003D7-9u
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:57:44 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyxuh-0003Ct-4e
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:57:43 -0400
Received: by mail-oi0-x243.google.com with SMTP id q71-v6so6937876oic.6
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 03:57:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <899fd41e-46cf-44e8-2df5-24d9e705e264@amsat.org>
References: <20180320134114.30418-1-peter.maydell@linaro.org>
	<20180320134114.30418-3-peter.maydell@linaro.org>
	<899fd41e-46cf-44e8-2df5-24d9e705e264@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 10:57:21 +0000
Message-ID: <CAFEAcA82jYWDPUK7d6o_gfgvUPb1O+3PbNxCnHAVbSAAKokBGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 2/4] target/arm: Factor
 out code to calculate FSR for debug exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 March 2018 at 22:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Peter,
>
> This patch might be split in 2.

For a +27-10 patch, it doesn't really seem necessary.

> On 03/20/2018 02:41 PM, Peter Maydell wrote:
>> When a debug exception is taken to AArch32, it appears as a Prefetch
>> Abort, and the Instruction Fault Status Register (IFSR) must be set.
>> The IFSR has two possible formats, depending on whether LPAE is in
>
> ^ intro
>
>> use. Factor out the code in arm_debug_excp_handler() which picks
>> an FSR value into its own utility function, update it to use
>> arm_fi_to_lfsc() and arm_fi_to_sfsc() rather than hard-coded constants,
>
> ^ part 1 (refactor):
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> and use the correct condition to select long or short format.
>
> ^ part 2 (fix) looks correct:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>
>> In particular this fixes a bug where we could select the short
>> format because we're at EL0 and the EL1 translation regime is
>> not using LPAE, but then route the debug exception to EL2 because
>> of MDCR_EL2.TDE and hand EL2 the wrong format FSR.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/internals.h | 25 +++++++++++++++++++++++++
>>  target/arm/op_helper.c | 12 ++----------
>>  2 files changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 47cc224a46..8ce944b7a0 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -763,4 +763,29 @@ static inline bool regime_is_secure(CPUARMState *en=
v, ARMMMUIdx mmu_idx)
>>      }
>>  }
>>
>> +/* Return the FSR value for a debug exception (watchpoint, hardware
>> + * breakpoint or BKPT insn) targeting the specified exception level.
>> + */
>> +static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
>> +{
>> +    ARMMMUFaultInfo fi =3D { .type =3D ARMFault_Debug };
>> +    int target_el =3D arm_debug_target_el(env);
>> +    bool using_lpae =3D false;
>> +
>> +    if (target_el =3D=3D 2 || arm_el_is_aa64(env, target_el)) {
>> +        using_lpae =3D true;
>> +    } else {
>> +        if (arm_feature(env, ARM_FEATURE_LPAE) &&
>> +            (env->cp15.tcr_el[target_el].raw_tcr & TTBCR_EAE)) {
>> +            using_lpae =3D true;
>> +        }
>> +    }
>
> This looks pretty similar to regime_using_lpae_format() but for
> ARMFault_Debug.

Yeah, it's basically similar logic.

I'm a bit confused overall -- are you giving a reviewed-by for
this patch, or do you want changes?

thanks
-- PMM
