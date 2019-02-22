Received: from eggs.gnu.org ([209.51.188.92]:36993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIr0-0004Rm-79
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIqy-00005q-Qh
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:59:33 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxIqy-0008KF-Cy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:59:32 -0500
Received: by mail-pf1-x443.google.com with SMTP id j5so1700908pfa.2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:59:17 -0800 (PST)
References: <20190222170936.13268-1-peter.maydell@linaro.org>
	<20190222170936.13268-3-peter.maydell@linaro.org>
	<CAFEAcA-YCosZjWEiLC6cc8Z7rfOUQMLYZJX48MKOYuZNQQVR_A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de513053-6406-4389-5ad8-da113e02ca48@linaro.org>
Date: Fri, 22 Feb 2019 13:59:13 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YCosZjWEiLC6cc8Z7rfOUQMLYZJX48MKOYuZNQQVR_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Gate "miscellaneous FP"
 insns by ID register field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 2/22/19 9:36 AM, Peter Maydell wrote:
> On Fri, 22 Feb 2019 at 17:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> There is a set of VFP instructions which we implement in
>> disas_vfp_v8_insn() and gate on the ARM_FEATURE_V8 bit.
>> These were all first introduced in v8 for A-profile, but in
>> M-profile they appeared in v7M. Gate them on the MVFR2
>> FPMisc field instead, and rename the function appropriately.
> 
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index b7702fb49f7..af8f9e669b8 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -3357,7 +3357,7 @@ static const uint8_t fp_decode_rm[] = {
>>      FPROUNDING_NEGINF,
>>  };
>>
>> -static int disas_vfp_v8_insn(DisasContext *s, uint32_t insn)
>> +static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
>>  {
>>      uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);
>>
> 
> Oops, I forgot to commit this part of the change:
> 
> @@ -3361,10 +3361,6 @@ static int disas_vfp_misc_insn(DisasContext *s,
> uint32_t insn)
>  {
>      uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);
> 
> -    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
> -        return 1;
> -    }
> -
>      if (dp) {
>          VFP_DREG_D(rd, insn);
>          VFP_DREG_N(rn, insn);

With the addition,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
