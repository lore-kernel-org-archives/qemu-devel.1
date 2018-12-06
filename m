Received: from eggs.gnu.org ([2001:4830:134:3::10]:43378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUtlz-0000Nr-K8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUtlv-0005J0-Ao
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:32:59 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUtlv-0005IT-35
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:32:55 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so419029otl.0
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:32:54 -0800 (PST)
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-7-richard.henderson@linaro.org>
	<CAFEAcA9-jB-RhEPb4CnnrCZ9y+SWu_1Ec6GYw7dyQyrVi3fd7w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5e828de-24d5-73a2-27e3-dac101926faa@linaro.org>
Date: Thu, 6 Dec 2018 07:32:49 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-jB-RhEPb4CnnrCZ9y+SWu_1Ec6GYw7dyQyrVi3fd7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/10] target/arm: Use arm_hcr_el2_eff
 more places
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

On 12/6/18 7:06 AM, Peter Maydell wrote:
> On Mon, 3 Dec 2018 at 20:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Since arm_hcr_el2_eff includes a check against
>> arm_is_secure_below_el3, we can often remove a
>> nearby check against secure state.
>>
>> In some cases, sort the call to arm_hcr_el2_eff
>> to the end of a short-circuit logical sequence.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> 
>> @@ -8797,6 +8795,8 @@ static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
>>  static inline bool regime_translation_disabled(CPUARMState *env,
>>                                                 ARMMMUIdx mmu_idx)
>>  {
>> +    uint64_t hcr_el2;
>> +
>>      if (arm_feature(env, ARM_FEATURE_M)) {
>>          switch (env->v7m.mpu_ctrl[regime_is_secure(env, mmu_idx)] &
>>                  (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
>> @@ -8815,19 +8815,21 @@ static inline bool regime_translation_disabled(CPUARMState *env,
>>          }
>>      }
>>
>> +    hcr_el2 = arm_hcr_el2_eff(env);
> 
> Changing this in this function makes me nervous, because
> arm_hcr_el2_eff() looks at the current CPU state via
> arm_is_secure_below_el3() rather than at the security state
> of the translation regime we're asking about. I think
> it probably doesn't change behaviour, but I'm finding
> it hard to reason about...

Oops, I missed that we weren't talking about "current" here.

I can either just revert this function for now, or introduce a new
arm_hcr_el2_eff_ns that does not take secure into effect, but does adjust all
of the other flags within HCR relative to its own contents.

>> -    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
>> +    if (!secure && cur_el == 1 && (arm_hcr_el2_eff(env) & HCR_TSC)) {
> 
> Why can't we drop the !secure check here?

Either I missed it, or it was premature optimization of the form "well, it's
already computed into a local variable..."


r~
