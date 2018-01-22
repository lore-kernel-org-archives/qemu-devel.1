Received: from eggs.gnu.org ([2001:4830:134:3::10]:34369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfH2-00018B-1K
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfH1-0004wJ-8q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:48:44 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:45263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfH1-0004w1-46
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:48:43 -0500
Received: by mail-it0-x244.google.com with SMTP id x42so10585030ita.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:48:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA997FE0OJmf2YXd7FXurDTZeEwb38ND85agXebP72uRag@mail.gmail.com>
References: <20180119141707.11733-1-ard.biesheuvel@linaro.org>
	<20180119141707.11733-3-ard.biesheuvel@linaro.org>
	<CAFEAcA997FE0OJmf2YXd7FXurDTZeEwb38ND85agXebP72uRag@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 16:48:41 +0000
Message-ID: <CAKv+Gu9d18Aupj6Q_UpVxk0aSt9BbwGGgztO-=_b2LVOwqTAEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/arm: implement SHA-3
 instructions
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

On 22 January 2018 at 16:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 14:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> This implements emulation of the new SHA-3 instructions that have
>> been added as an optional extensions to the ARMv8 Crypto Extensions
>> in ARM v8.2.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  target/arm/cpu.h           |   1 +
>>  target/arm/crypto_helper.c |  69 +++++++++++++
>>  target/arm/helper.h        |   5 +
>>  target/arm/translate-a64.c | 108 +++++++++++++++++++-
>>  4 files changed, 179 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 295529366c0a..8e355398e3e0 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1341,6 +1341,7 @@ enum arm_features {
>>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
>>      ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
>> +    ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
>>  };
>>
>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>>  /* initialize TCG globals.  */
>>  void a64_translate_init(void)
>> @@ -11125,6 +11127,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
>>      int rn = extract32(insn, 5, 5);
>>      int rd = extract32(insn, 0, 5);
>>      TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno;
>> +    int feature;
>>      CryptoThreeOpEnvFn *genfn;
>>
>>      if (o != 0) {
>> @@ -11134,20 +11137,24 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
>>
>>      switch (opcode) {
>>      case 0: /* SHA512H */
>> +        feature = ARM_FEATURE_V8_SHA512;
>>          genfn = gen_helper_crypto_sha512h;
>>          break;
>>      case 1: /* SHA512H2 */
>> +        feature = ARM_FEATURE_V8_SHA512;
>>          genfn = gen_helper_crypto_sha512h2;
>>          break;
>>      case 2: /* SHA512SU1 */
>> +        feature = ARM_FEATURE_V8_SHA512;
>>          genfn = gen_helper_crypto_sha512su1;
>>          break;
>
> I think these lines should have been in patch 1, right?
>
>> -    default:
>> -        unallocated_encoding(s);
>> -        return;
>> +    case 3: /* RAX1 */
>> +        feature = ARM_FEATURE_V8_SHA3;
>> +        genfn = gen_helper_crypto_rax1;
>> +        break;
>>      }
>>
>> -    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA512)) {
>> +    if (!arm_dc_feature(s, feature)) {

only if I include this line as well

>>          unallocated_encoding(s);
>>          return;
>
> thanks
> -- PMM
