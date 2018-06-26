Received: from eggs.gnu.org ([2001:4830:134:3::10]:59156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXpw5-0004sf-CR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXpw4-0000ms-Gh
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:31:17 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXpw4-0000mX-B2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:31:16 -0400
Received: by mail-oi0-x231.google.com with SMTP id c6-v6so16414343oiy.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:31:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-34-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 16:30:55 +0100
Message-ID: <CAFEAcA_-39brD_S6SiDfaQRO16bE1pw79JDywnPfzybbPc_hCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 33/35] target/arm: Implement SVE dot
 product (indexed)
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        |  5 ++
>  target/arm/translate-sve.c | 18 +++++++
>  target/arm/vec_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 +++-
>  4 files changed, 126 insertions(+), 1 deletion(-)
>

> +void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
> +    intptr_t index = simd_data(desc);
> +    uint32_t *d = vd;
> +    int8_t *n = vn, *m = vm;
> +
> +    for (i = 0; i < opr_sz_4; i = j) {
> +        int8_t m0 = m[(i + index) * 4 + 0];
> +        int8_t m1 = m[(i + index) * 4 + 1];
> +        int8_t m2 = m[(i + index) * 4 + 2];
> +        int8_t m3 = m[(i + index) * 4 + 3];
> +
> +        j = i;
> +        do {
> +            d[j] += n[j * 4 + 0] * m0
> +                  + n[j * 4 + 1] * m1
> +                  + n[j * 4 + 2] * m2
> +                  + n[j * 4 + 3] * m3;
> +        } while (++j < MIN(i + 4, opr_sz_4));
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}

Maybe I'm just half asleep this afternoon, but this is pretty
confusing -- nested loops where the outer loop's increment
uses the inner loop's index, and the inner loop's conditions
depend on the outer loop index...

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 0b29da9f3a..f69ff285a1 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -722,7 +722,13 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
>  MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
>
>  # SVE integer dot product (unpredicated)
> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
> +DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx

Should this have been in the previous patch ?

> +
> +# SVE integer dot product (indexed)
> +DOT_zzx         01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
> +                sz=0 ra=%reg_movprfx
> +DOT_zzx         01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
> +                sz=1 ra=%reg_movprfx
>
>  # SVE floating-point complex add (predicated)
>  FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
> --
> 2.17.1

thanks
-- PMM
