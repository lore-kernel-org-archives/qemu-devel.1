Received: from eggs.gnu.org ([2001:4830:134:3::10]:60525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edf8p-0005JO-46
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edf8o-0007f3-6P
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:40:15 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:42405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edf8n-0007el-Iy
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:40:13 -0500
Received: by mail-ot0-x22e.google.com with SMTP id s3so7992058otc.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:40:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119182248.10821-4-ard.biesheuvel@linaro.org>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-4-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 16:39:52 +0000
Message-ID: <CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 19 January 2018 at 18:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This implements emulation of the new SM3 instructions that have
> been added as an optional extension to the ARMv8 Crypto Extensions
> in ARM v8.2.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 787b94047286..1e3ff9a6152f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11148,28 +11148,39 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
>      CryptoThreeOpFn *genfn;
>      int feature;
>
> -    if (o != 0) {
> -        unallocated_encoding(s);
> -        return;
> -    }

If you wrote this code in the first patch in the
     if (o == 0) {
         stuff;
     } else {
         unallocated_encoding(s);
         return;
     }

form, it would make this patch easier to read as it wouldn't
need to change the lines for the SHA512 cases.

> -
> -    switch (opcode) {
> -    case 0: /* SHA512H */
> -        feature = ARM_FEATURE_V8_SHA512;
> -        genfn = gen_helper_crypto_sha512h;
> -        break;
> -    case 1: /* SHA512H2 */
> -        feature = ARM_FEATURE_V8_SHA512;
> -        genfn = gen_helper_crypto_sha512h2;
> -        break;
> -    case 2: /* SHA512SU1 */
> -        feature = ARM_FEATURE_V8_SHA512;
> -        genfn = gen_helper_crypto_sha512su1;
> -        break;
> -    case 3: /* RAX1 */
> -        feature = ARM_FEATURE_V8_SHA3;
> -        genfn = NULL;
> -        break;
> +    if (o == 0) {
> +        switch (opcode) {
> +        case 0: /* SHA512H */
> +            feature = ARM_FEATURE_V8_SHA512;
> +            genfn = gen_helper_crypto_sha512h;
> +            break;
> +        case 1: /* SHA512H2 */
> +            feature = ARM_FEATURE_V8_SHA512;
> +            genfn = gen_helper_crypto_sha512h2;
> +            break;
> +        case 2: /* SHA512SU1 */
> +            feature = ARM_FEATURE_V8_SHA512;
> +            genfn = gen_helper_crypto_sha512su1;
> +            break;
> +        case 3: /* RAX1 */
> +            feature = ARM_FEATURE_V8_SHA3;
> +            genfn = NULL;
> +            break;
> +        }
> +    } else {
> +        switch (opcode) {
> +        case 0: /* SM3PARTW1 */
> +            feature = ARM_FEATURE_V8_SM3;
> +            genfn = gen_helper_crypto_sm3partw1;
> +            break;
> +        case 1: /* SM3PARTW2 */
> +            feature = ARM_FEATURE_V8_SM3;
> +            genfn = gen_helper_crypto_sm3partw2;
> +            break;
> +        default:
> +            unallocated_encoding(s);
> +            return;
> +        }

This seems to be missing support for SM4EKEY (which is O==1
opcode == 0b10 and also part of the v8.2 SM feature) ?


>      }
>
>      if (!arm_dc_feature(s, feature)) {
> @@ -11273,10 +11284,22 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
>      int ra = extract32(insn, 10, 5);
>      int rn = extract32(insn, 5, 5);
>      int rd = extract32(insn, 0, 5);
> -    TCGv_i64 tcg_op1, tcg_op2, tcg_op3, tcg_res[2];
> -    int pass;
> +    int feature;
>
> -    if (op0 > 1 || !arm_dc_feature(s, ARM_FEATURE_V8_SHA3)) {
> +    switch (op0) {
> +    case 0: /* EOR3 */
> +    case 1: /* BCAX */
> +        feature = ARM_FEATURE_V8_SHA3;
> +        break;
> +    case 2: /* SM3SS1 */
> +        feature = ARM_FEATURE_V8_SM3;
> +        break;
> +    default:
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    if (!arm_dc_feature(s, feature)) {
>          unallocated_encoding(s);
>          return;
>      }
> @@ -11285,34 +11308,54 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
>          return;
>      }
>
> -    tcg_op1 = tcg_temp_new_i64();
> -    tcg_op2 = tcg_temp_new_i64();
> -    tcg_op3 = tcg_temp_new_i64();
> -    tcg_res[0] = tcg_temp_new_i64();
> -    tcg_res[1] = tcg_temp_new_i64();
> +    if (op0 == 2) {
> +        TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_ra_ptr, tcg_rm_ptr;
>
> -    for (pass = 0; pass < 2; pass++) {
> -        read_vec_element(s, tcg_op1, rn, pass, MO_64);
> -        read_vec_element(s, tcg_op2, rm, pass, MO_64);
> -        read_vec_element(s, tcg_op3, ra, pass, MO_64);
> +        tcg_rd_ptr = vec_full_reg_ptr(s, rd);
> +        tcg_rn_ptr = vec_full_reg_ptr(s, rn);
> +        tcg_ra_ptr = vec_full_reg_ptr(s, ra);
> +        tcg_rm_ptr = vec_full_reg_ptr(s, rm);

Similarly this part of this patch is a pain to read, and you
could avoid that by making the patch that introduces the function
structure things so this patch doesn't need do then reformat them.


thanks
-- PMM
