Received: from eggs.gnu.org ([2001:4830:134:3::10]:43489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDio-0000lR-L1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDin-0004EE-MW
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:49:10 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:42215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDin-0004D7-Eb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:49:09 -0500
Received: by mail-pl0-x234.google.com with SMTP id 31so4915494ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:49:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-22-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:48:47 +0000
Message-ID: <CAFEAcA_sKYmMijPzaYaBzuNkJ3po7oMoV+JYwJ9OE9xRsr_Gvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 21/67] target/arm: Implement
 SVE floating-point exponential accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  4 +++
>  target/arm/sve_helper.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 22 +++++++++++++
>  target/arm/sve.decode      |  7 ++++
>  4 files changed, 114 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 5280d375f9..e2925ff8ec 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -385,6 +385,10 @@ DEF_HELPER_FLAGS_4(sve_adr_p64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_adr_s32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_adr_u32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_3(sve_fexpa_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_fexpa_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_fexpa_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index a290a58c02..4d42653eef 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1101,3 +1101,84 @@ void HELPER(sve_adr_u32)(void *vd, void *vn, void *vm, uint32_t desc)
>          d[i] = n[i] + ((uint64_t)(uint32_t)m[i] << sh);
>      }
>  }
> +
> +void HELPER(sve_fexpa_h)(void *vd, void *vn, uint32_t desc)
> +{
> +    static const uint16_t coeff[] = {
> +        0x0000, 0x0016, 0x002d, 0x0045, 0x005d, 0x0075, 0x008e, 0x00a8,
> +        0x00c2, 0x00dc, 0x00f8, 0x0114, 0x0130, 0x014d, 0x016b, 0x0189,
> +        0x01a8, 0x01c8, 0x01e8, 0x0209, 0x022b, 0x024e, 0x0271, 0x0295,
> +        0x02ba, 0x02e0, 0x0306, 0x032e, 0x0356, 0x037f, 0x03a9, 0x03d4,
> +    };

Worth a comment that these data tables are from the specification
pseudocode, I think.

> +void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
> +{
> +    static const uint64_t coeff[] = {
> +        0x0000000000000, 0x02C9A3E778061, 0x059B0D3158574, 0x0874518759BC8,
> +        0x0B5586CF9890F, 0x0E3EC32D3D1A2, 0x11301D0125B51, 0x1429AAEA92DE0,
> +        0x172B83C7D517B, 0x1A35BEB6FCB75, 0x1D4873168B9AA, 0x2063B88628CD6,
> +        0x2387A6E756238, 0x26B4565E27CDD, 0x29E9DF51FDEE1, 0x2D285A6E4030B,
> +        0x306FE0A31B715, 0x33C08B26416FF, 0x371A7373AA9CB, 0x3A7DB34E59FF7,
> +        0x3DEA64C123422, 0x4160A21F72E2A, 0x44E086061892D, 0x486A2B5C13CD0,
> +        0x4BFDAD5362A27, 0x4F9B2769D2CA7, 0x5342B569D4F82, 0x56F4736B527DA,
> +        0x5AB07DD485429, 0x5E76F15AD2148, 0x6247EB03A5585, 0x6623882552225,
> +        0x6A09E667F3BCD, 0x6DFB23C651A2F, 0x71F75E8EC5F74, 0x75FEB564267C9,
> +        0x7A11473EB0187, 0x7E2F336CF4E62, 0x82589994CCE13, 0x868D99B4492ED,
> +        0x8ACE5422AA0DB, 0x8F1AE99157736, 0x93737B0CDC5E5, 0x97D829FDE4E50,
> +        0x9C49182A3F090, 0xA0C667B5DE565, 0xA5503B23E255D, 0xA9E6B5579FDBF,
> +        0xAE89F995AD3AD, 0xB33A2B84F15FB, 0xB7F76F2FB5E47, 0xBCC1E904BC1D2,
> +        0xC199BDD85529C, 0xC67F12E57D14B, 0xCB720DCEF9069, 0xD072D4A07897C,
> +        0xD5818DCFBA487, 0xDA9E603DB3285, 0xDFC97337B9B5F, 0xE502EE78B3FF6,
> +        0xEA4AFA2A490DA, 0xEFA1BEE615A27, 0xF50765B6E4540, 0xFA7C1819E90D8,

This confused me at first because it looks like these are 64-bit numbers
but they are only 52 bits. Maybe comment? (or add the leading '000'?)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
