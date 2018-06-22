Received: from eggs.gnu.org ([2001:4830:134:3::10]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOYi-0003WM-Sx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOYe-0006Nf-L4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:05:12 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWOYe-0006NK-EF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:05:08 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so8068479otj.0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:05:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-3-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 17:04:47 +0100
Message-ID: <CAFEAcA9Vr-iqQS2gyper7TwF+MOOGcFyB6vp-VN35=RUpJDQcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 02/35] target/arm: Implement SVE
 Contiguous Load, first-fault and no-fault
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
>  target/arm/helper-sve.h    |  40 ++++++++++
>  target/arm/sve_helper.c    | 156 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  69 ++++++++++++++++
>  target/arm/sve.decode      |   6 ++
>  4 files changed, 271 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index fcc9ba5f50..7338abbbcf 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -754,3 +754,43 @@ DEF_HELPER_FLAGS_4(sve_ld1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>
>  DEF_HELPER_FLAGS_4(sve_ld1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_ld1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldff1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 4e6ad282f9..6e1b539ce3 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2963,3 +2963,159 @@ DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
>  #undef DO_LD2
>  #undef DO_LD3
>  #undef DO_LD4
> +
> +/*
> + * Load contiguous data, first-fault and no-fault.
> + */
> +
> +#ifdef CONFIG_USER_ONLY
> +
> +/* Fault on byte I.  All bits in FFR from I are cleared.  The vector
> + * result from I is CONSTRAINED UNPREDICTABLE; we choose the MERGE
> + * option, which leaves subsequent data unchanged.
> + */
> +static void __attribute__((cold))

attribute cold was first introduced in GCC 4.3. As of
commit fa54abb8c29 I think we still support gcc 4.1,
so we need to hide this behind a QEMU_COLD or something I think, eg

#ifndef __has_attribute
#define __has_attribute(x) 0 /* compatibility with older gcc */
#endif

#if __has_attribute(cold) || QEMU_GNUC_PREREQ(4, 3)
#define QEMU_COLD __attribute__((cold))
#else
#define QEMU_COLD
#endif

(gcc added __has_attribute in gcc 5, which is nice.)

> +record_fault(CPUARMState *env, intptr_t i, intptr_t oprsz)
> +{
> +    uint64_t *ffr = env->vfp.pregs[FFR_PRED_NUM].p;
> +    if (i & 63) {
> +        ffr[i / 64] &= MAKE_64BIT_MASK(0, (i & 63) - 1);

Should this really have a - 1 here? (i & 63) will
be anything between 1 and 63, so I would have expected
the set of masks to be anything from "1 bit set" to
"63 bits set", not "0 bits set" to "62 bits set".

> +        i = ROUND_UP(i, 64);
> +    }
> +    for (; i < oprsz; i += 64) {
> +        ffr[i / 64] = 0;
> +    }
> +}
> +

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
