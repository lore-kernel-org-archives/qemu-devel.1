Received: from eggs.gnu.org ([209.51.188.92]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnTp-0005Ba-S7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnTp-0005yU-19
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:53 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grnTo-0005x8-Qo
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so1049710otm.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-8-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:28:38 +0000
Message-ID: <CAFEAcA9T2C0-KAhU5c=+r0g5Ti_ZtL_TJE0rqWS8qkqDO5MELg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/17] target/arm: Implement ADDG,
 SUBG instructions
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

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    |  2 ++
>  target/arm/internals.h     |  3 ++
>  target/arm/mte_helper.c    | 34 ++++++++++++++++++
>  target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++------------
>  4 files changed, 87 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index 7a6051fdab..47577207b2 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -105,3 +105,5 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>
>  DEF_HELPER_FLAGS_2(mte_check, TCG_CALL_NO_WG, i64, env, i64)
>  DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
> +DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 2922324f63..a5a249b001 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1002,4 +1002,7 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
>      return sctlr != 0;
>  }
>
> +/* We associate one allocation tag per 16 bytes, the minimum.  */
> +#define LOG2_TAG_GRANULE 4
> +
>  #endif
> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index 1878393fc4..e2b1a5dd40 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -163,3 +163,37 @@ uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
>      }
>      return address_with_allocation_tag(rn, rtag);
>  }
> +
> +uint64_t HELPER(addg)(CPUARMState *env, uint64_t ptr,
> +                      uint32_t offset, uint32_t tag_offset)
> +{
> +    int el = arm_current_el(env);
> +    uint64_t sctlr = arm_sctlr(env, el);
> +    int rtag = 0;
> +
> +    if (allocation_tag_access_enabled(env, el, sctlr)) {
> +        int start_tag = allocation_tag_from_addr(ptr);
> +        uint16_t exclude = env->cp15.gcr_el1;

I'm not entirely convinced about this extraction of the 'exclude'
field from GCR_EL1 by silently assigning it to a uint16_t;
it's a bit non-obvious.

> +        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
> +    }
> +
> +    offset <<= LOG2_TAG_GRANULE;
> +    return address_with_allocation_tag(ptr + offset, rtag);
> +}
> +
> +uint64_t HELPER(subg)(CPUARMState *env, uint64_t ptr,
> +                      uint32_t offset, uint32_t tag_offset)
> +{
> +    int el = arm_current_el(env);
> +    uint64_t sctlr = arm_sctlr(env, el);
> +    int rtag = 0;
> +
> +    if (allocation_tag_access_enabled(env, el, sctlr)) {
> +        int start_tag = allocation_tag_from_addr(ptr);
> +        uint16_t exclude = env->cp15.gcr_el1;
> +        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
> +    }
> +
> +    offset <<= LOG2_TAG_GRANULE;
> +    return address_with_allocation_tag(ptr - offset, rtag);
> +}

You could have done the shift of the offset at translate time,
but I guess it doesn't make any difference given everything else
we're doing.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
