Received: from eggs.gnu.org ([209.51.188.92]:41652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmpu-0007a5-OT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmps-0005db-8L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:47:38 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grmpq-0005Zu-AU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:47:34 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so857423otk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-7-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 16:47:20 +0000
Message-ID: <CAFEAcA9Kcd6a1Af4ChbOH55XRVWfpeCAexJwxH5AwP8Kn_U0+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/17] target/arm: Implement the IRG
 instruction
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
>  target/arm/helper-a64.h    |  1 +
>  target/arm/mte_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |  7 +++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index fa4c371a47..7a6051fdab 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -104,3 +104,4 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>
>  DEF_HELPER_FLAGS_2(mte_check, TCG_CALL_NO_WG, i64, env, i64)
> +DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index 6f4bc0aa04..1878393fc4 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -36,6 +36,48 @@ static int allocation_tag_from_addr(uint64_t ptr)
>      return (extract64(ptr, 56, 4) + extract64(ptr, 55, 1)) & 15;
>  }
>
> +/* Like ChooseNonExcludedTag, except that GCR_EL1 is already in.  */

I don't understand this comment -- neither the pseudocode
function nor this code refer to GCR_EL1.

> +static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
> +{
> +    if (exclude != 0xffff) {
> +        int i;
> +        for (i = 0; i < offset; ++i) {
> +            do {
> +                tag = (tag + 1) & 15;
> +            } while (exclude & (1 << tag));
> +        }
> +    }
> +    return tag;

This doesn't seem to do the same thing as ChooseNonExcludedTag()
for the offset==0 case, or for the exclude == 0xffff case.

> +}
> +
> +static int choose_random_nonexcluded_tag(CPUARMState *env, uint16_t exclude)
> +{
> +    /* Ignore GCR_EL1.RRND.  Always produce deterministic results.  */

This comment is trying to say that our IMPDEF choice for GCR_EL1.RRND==1
is "behave the same as if RRND==0", right? I think that would be
clearer as a comment at the callsite, because if you're following
along with the pseudocode you expect the IRG code to do an
"if RRND == 1 then { choose_random_nonexcluded_tag(); } else { ... }".

thanks
-- PMM
