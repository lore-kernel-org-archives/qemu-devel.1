Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaEG-0007ea-8Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaEF-0003WW-CA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:43:00 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:41103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIaEF-0003W1-4r
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:42:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id g21-v6so189742wrb.8
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:42:58 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-28-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-28-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 14:42:56 +0100
Message-ID: <87bmdhf31b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/28] fpu/softfloat: Clean up
 parts_default_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reduce the number of ifdefs.  Correct the result for OpenRISC
> and TriCore (although TriCore fixed in target-specific code).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat-specialize.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index 9d562ed504..ec4fb6ba8b 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -129,22 +129,29 @@ static FloatParts parts_default_nan(float_status *s=
tatus)
>      uint64_t frac;
>
>  #if defined(TARGET_SPARC) || defined(TARGET_M68K)
> +    /* !snan_bit_is_one, set all bits */
>      frac =3D (1ULL << DECOMPOSED_BINARY_POINT) - 1;
> -#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA=
) || \
> -      defined(TARGET_S390X) || defined(TARGET_RISCV)
> +#elif defined(TARGET_I386) || defined(TARGET_X86_64) \
> +    || defined(TARGET_MICROBLAZE)
> +    /* !snan_bit_is_one, set sign and msb */
>      frac =3D 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> +    sign =3D 1;
>  #elif defined(TARGET_HPPA)
> +    /* snan_bit_is_one, set msb-1.  */
>      frac =3D 1ULL << (DECOMPOSED_BINARY_POINT - 2);
>  #else
> +    /* This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
> +     * S390, SH4, TriCore, and Xtensa.  I cannot find documentation
> +     * for Unicore32; the choice from the original commit is unchanged.
> +     * Our other supported targets, CRIS, LM32, Moxie, Nios2, and Tile,
> +     * do not have floating-point.
> +     */
>      if (snan_bit_is_one(status)) {
> +        /* set all bits other than msb */
>          frac =3D (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
>      } else {
> -#if defined(TARGET_MIPS)
> +        /* set msb */
>          frac =3D 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> -#else
> -        frac =3D 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> -        sign =3D 1;
> -#endif
>      }
>  #endif


--
Alex Benn=C3=A9e
