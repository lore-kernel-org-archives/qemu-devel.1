Received: from eggs.gnu.org ([2001:4830:134:3::10]:40041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f96qJ-0007fm-IZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f96qI-0007uH-Pq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:31:07 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f96qI-0007u1-Ke
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:31:06 -0400
Received: by mail-ot0-x243.google.com with SMTP id w4-v6so5261491ote.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 03:31:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417222635.17007-1-richard.henderson@linaro.org>
References: <20180417222635.17007-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 11:30:45 +0100
Message-ID: <CAFEAcA-od4ewuZ40tRFnMj6UKxn-9=u5GyNFUVAng3X2eJ3yPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13] tcg: Improve TCGv_ptr support
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

2018-04-17 23:26 GMT+01:00 Richard Henderson <richard.henderson@linaro.org>:
> Drop TCGV_PTR_TO_NAT and TCGV_NAT_TO_PTR internal macros.
>
> Add tcg_temp_local_new_ptr, tcg_gen_brcondi_ptr, tcg_gen_ext_i32_ptr,
> tcg_gen_trunc_i64_ptr, tcg_gen_extu_ptr_i64, tcg_gen_trunc_ptr_i32.
>
> Use inlines instead of macros where possible.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
>
> These additions will be used by target/arm/translate-sve.c.

> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index c532889b1f..cdc397308b 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c

> @@ -251,13 +245,7 @@
>  #define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i32
>  #define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i32
>  #define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i32
> -#if UINTPTR_MAX == UINT32_MAX
> -# define tcg_gen_trunc_reg_ptr(p, r) \
> -    tcg_gen_mov_i32(TCGV_PTR_TO_NAT(p), r)
> -#else
> -# define tcg_gen_trunc_reg_ptr(p, r) \
> -    tcg_gen_extu_i32_i64(TCGV_PTR_TO_NAT(p), r)
> -#endif
> +#define tcg_gen_trunc_reg_ptr   tcg_gen_ext_i32_ptr

For the 64-bit host case, this used to be an unsigned
32->64 extension, but now it is a sign extension.

Otherwise the patch looks good, though reading it it felt like
it was really three patches rolled into one (roughly
correpsonding to the three paragraphs in the commit message)...

thanks
-- PMM
