Received: from eggs.gnu.org ([2001:4830:134:3::10]:60614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRxM-0000IG-2B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRxE-0003Gs-0D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:12:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCRxC-0003FX-NJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:12:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id s4-v6so11265758plp.0
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:12:16 -0700 (PDT)
References: <20181008212205.17752-1-richard.henderson@linaro.org>
	<20181008212205.17752-11-richard.henderson@linaro.org>
	<CAFEAcA-aSSg+EujPCcLg_Fb8Q2yY=Z43bKQz_jX8UCUabX2_hg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26d5b304-88cb-e51f-0578-0d234d39c0ad@linaro.org>
Date: Tue, 16 Oct 2018 09:12:11 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aSSg+EujPCcLg_Fb8Q2yY=Z43bKQz_jX8UCUabX2_hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 10/10] target/arm: Convert v8.2-fp16
 from feature bit to aa64pfr0 test
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

On 10/16/18 3:36 AM, Peter Maydell wrote:
> On 8 October 2018 at 22:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h           | 17 +++++++++++++++-
>>  target/arm/translate-a64.h |  1 +
>>  target/arm/translate.h     |  1 +
>>  linux-user/elfload.c       |  6 +-----
>>  target/arm/cpu64.c         |  9 ++-------
>>  target/arm/helper.c        |  2 +-
>>  target/arm/translate-a64.c | 40 +++++++++++++++++++-------------------
>>  target/arm/translate.c     |  6 +++---
>>  8 files changed, 45 insertions(+), 37 deletions(-)
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index ee2c04a627..38e9afef3b 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -266,6 +266,8 @@ static void aarch64_max_initfn(Object *obj)
>>
>>          t = cpu->id_aa64pfr0;
>>          t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
>> +        t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);
>> +        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
>>          cpu->id_aa64pfr0 = t;
>>
>>          /* Replicate the same data to the 32-bit id registers.  */
>> @@ -283,13 +285,6 @@ static void aarch64_max_initfn(Object *obj)
>>          cpu->id_isar6 = u;
>>
>>  #ifdef CONFIG_USER_ONLY
>> -        /* We don't set these in system emulation mode for the moment,
>> -         * since we don't correctly set the ID registers to advertise them,
>> -         * and in some cases they're only available in AArch64 and not AArch32,
>> -         * whereas the architecture requires them to be present in both if
>> -         * present in either.
>> -         */
>> -        set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
> 
> FP16 is the feature that this comment refers to about not having the
> AArch32 support present yet. So previously we only set that feature
> bit in the user-only mode. Doesn't that mean we need to only
> set the equivalent PFR0 bits in the ID register in user-only mode now?

If we do that, then we violate the SVE rule that FP16 must be present.  I think
it's more valuable to have SVE available in system mode than the more obscure
AArch64 <-> AArch32 feature correspondence.


r~
