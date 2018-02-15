Received: from eggs.gnu.org ([2001:4830:134:3::10]:40581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJT9-0001Xs-H6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJT8-0004T4-H2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:20:59 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emJT8-0004SZ-CD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:20:58 -0500
Received: by mail-ot0-x243.google.com with SMTP id q12so23333333otg.10
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:20:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211205848.4568-7-richard.henderson@linaro.org>
References: <20180211205848.4568-1-richard.henderson@linaro.org>
	<20180211205848.4568-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:20:37 +0000
Message-ID: <CAFEAcA_1wbQukD_rQzxMWMox7wtOopUd5sVPiyxsH0th_anA_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] linux-user: Support SVE in aarch64
 signal frames
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

On 11 February 2018 at 20:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/signal.c | 348 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 283 insertions(+), 65 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 9a380b9e31..af953175db 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1443,35 +1443,61 @@ struct target_fpsimd_context {
>      uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
>  };
>
> -/*
> - * Auxiliary context saved in the sigcontext.__reserved array. Not exported to
> - * user space as it will change with the addition of new context. User space
> - * should check the magic/size information.
> - */
> -struct target_aux_context {
> -    struct target_fpsimd_context fpsimd;
> -    /* additional context to be added before "end" */
> -    struct target_aarch64_ctx end;
> +#define TARGET_EXTRA_MAGIC  0x45585401
> +
> +struct target_extra_context {
> +    struct target_aarch64_ctx head;
> +    uint64_t datap; /* 16-byte aligned pointer to extra space cast to __u64 */
> +    uint32_t size; /* size in bytes of the extra space */
> +    uint32_t reserved[3];
> +};
> +
> +#define TARGET_SVE_MAGIC    0x53564501
> +
> +struct target_sve_context {
> +    struct target_aarch64_ctx head;
> +    uint16_t vl;
> +    uint16_t reserved[3];
>  };

I found this patch too hard to review. It looks like you've combined
a refactoring of how we handle the AArch64 "bunch of extra auxiliary
context records" sigframe information with the addition of the SVE
context record. Could you split that into separate patches, please?
A description of why the current code isn't sufficient would also
be helpful.

thanks
-- PMM
