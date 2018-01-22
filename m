Received: from eggs.gnu.org ([2001:4830:134:3::10]:36456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfOG-0005mQ-Mu
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfOF-0001qL-Le
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:12 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfOF-0001q2-H0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:11 -0500
Received: by mail-io0-x242.google.com with SMTP id c17so10128717iod.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:56:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu87P07jeBezDdxAqoGZCtY-t0y0d4i5UvJ1-BK24UWuJA@mail.gmail.com>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-4-ard.biesheuvel@linaro.org>
	<CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
	<CAKv+Gu87P07jeBezDdxAqoGZCtY-t0y0d4i5UvJ1-BK24UWuJA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 16:56:10 +0000
Message-ID: <CAKv+Gu9qX+pAThzXFC_iUBi_zztyqUoVL8=55MYShw5QK=cnCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] target/arm: implement SM3
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 22 January 2018 at 16:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 January 2018 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 19 January 2018 at 18:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> This implements emulation of the new SM3 instructions that have
>>> been added as an optional extension to the ARMv8 Crypto Extensions
>>> in ARM v8.2.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>>
>>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>>> index 787b94047286..1e3ff9a6152f 100644
>>> --- a/target/arm/translate-a64.c
>>> +++ b/target/arm/translate-a64.c
>>> @@ -11148,28 +11148,39 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
>>>      CryptoThreeOpFn *genfn;
>>>      int feature;
>>>
>>> -    if (o != 0) {
>>> -        unallocated_encoding(s);
>>> -        return;
>>> -    }
>>
>> If you wrote this code in the first patch in the
>>      if (o == 0) {
>>          stuff;
>>      } else {
>>          unallocated_encoding(s);
>>          return;
>>      }
>>
>> form, it would make this patch easier to read as it wouldn't
>> need to change the lines for the SHA512 cases.
>>
>
> ok
>
>>> -
>>> -    switch (opcode) {
>>> -    case 0: /* SHA512H */
>>> -        feature = ARM_FEATURE_V8_SHA512;
>>> -        genfn = gen_helper_crypto_sha512h;
>>> -        break;
>>> -    case 1: /* SHA512H2 */
>>> -        feature = ARM_FEATURE_V8_SHA512;
>>> -        genfn = gen_helper_crypto_sha512h2;
>>> -        break;
>>> -    case 2: /* SHA512SU1 */
>>> -        feature = ARM_FEATURE_V8_SHA512;
>>> -        genfn = gen_helper_crypto_sha512su1;
>>> -        break;
>>> -    case 3: /* RAX1 */
>>> -        feature = ARM_FEATURE_V8_SHA3;
>>> -        genfn = NULL;
>>> -        break;
>>> +    if (o == 0) {
>>> +        switch (opcode) {
>>> +        case 0: /* SHA512H */
>>> +            feature = ARM_FEATURE_V8_SHA512;
>>> +            genfn = gen_helper_crypto_sha512h;
>>> +            break;
>>> +        case 1: /* SHA512H2 */
>>> +            feature = ARM_FEATURE_V8_SHA512;
>>> +            genfn = gen_helper_crypto_sha512h2;
>>> +            break;
>>> +        case 2: /* SHA512SU1 */
>>> +            feature = ARM_FEATURE_V8_SHA512;
>>> +            genfn = gen_helper_crypto_sha512su1;
>>> +            break;
>>> +        case 3: /* RAX1 */
>>> +            feature = ARM_FEATURE_V8_SHA3;
>>> +            genfn = NULL;
>>> +            break;
>>> +        }
>>> +    } else {
>>> +        switch (opcode) {
>>> +        case 0: /* SM3PARTW1 */
>>> +            feature = ARM_FEATURE_V8_SM3;
>>> +            genfn = gen_helper_crypto_sm3partw1;
>>> +            break;
>>> +        case 1: /* SM3PARTW2 */
>>> +            feature = ARM_FEATURE_V8_SM3;
>>> +            genfn = gen_helper_crypto_sm3partw2;
>>> +            break;
>>> +        default:
>>> +            unallocated_encoding(s);
>>> +            return;
>>> +        }
>>
>> This seems to be missing support for SM4EKEY (which is O==1
>> opcode == 0b10 and also part of the v8.2 SM feature) ?
>>
>
> It is part of the v8.2 SM extension, which consists of SM3 secure hash
> and SM4 encryption, which are two different things (and AA64ISAR0 has
> separate feature bits for each). The ARM ARM does stipulate that both
> should be set if either one is set, but still provides two separate
> bits, and so one can be enabled without the other.
>

Same for ELF_HWCAPs btw
