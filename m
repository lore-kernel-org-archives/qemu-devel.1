Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhNl-0008Bg-Nr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhEY-00011s-92
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:04:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhEY-00011m-4E
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:04:18 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so14838108ois.1
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:04:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-8-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:03:52 +0100
Message-ID: <CAFEAcA8Pb+HNsndA=8KU0+bq5jirK_0JipLR7gdspb1LstthTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/20] target/arm: Fix is_a64 for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Saves about 8k code size in qemu-aarch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index aedaf2631e..ed51a2f5aa 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -918,7 +918,15 @@ void aarch64_sync_64_to_32(CPUARMState *env);
>
>  static inline bool is_a64(CPUARMState *env)
>  {
> +#ifdef CONFIG_USER_ONLY
> +# ifdef TARGET_AARCH64
> +    return true;
> +# else
> +    return false;
> +# endif
> +#else
>      return env->aarch64;
> +#endif
>  }

And again. I don't want to pepper the code with ifdefs if
we can do the right thing without them.

thanks
-- PMM
