Received: from eggs.gnu.org ([209.51.188.92]:56195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcjf-00077C-Hy
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcdM-0000aa-J2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:41:54 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqcdK-0000WF-Rb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:41:52 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so12385109otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20190128223118.5255-1-richard.henderson@linaro.org>
	<20190128223118.5255-6-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 11:41:29 +0000
Message-ID: <CAFEAcA_DHJf6-ewYoNEWyF2VDF+n6W_DtMgqTNA==rEpDE0AMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/12] target/arm: Cache the GP bit for
 a page in MemTxAttrs
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

On Mon, 28 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Caching the bit means that we will not have to re-walk the
> page tables to look up the bit during translation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6efe88a157..70277222da 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10457,6 +10457,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>      bool ttbr1_valid;
>      uint64_t descaddrmask;
>      bool aarch64 = arm_el_is_aa64(env, el);
> +    bool guarded = false;
>
>      /* TODO:
>       * This code does not handle the different format TCR for VTCR_EL2.
> @@ -10629,6 +10630,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>          }
>          /* Merge in attributes from table descriptors */
>          attrs |= nstable << 3; /* NS */
> +        guarded |= extract64(descriptor, 50, 1);  /* GP */

Should just be "guarded =", as per previous discussion.
Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
