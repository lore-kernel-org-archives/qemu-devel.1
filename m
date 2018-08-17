Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhNn-0008C3-RE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhE0-0000od-5N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:03:44 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhDz-0000oI-Md
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:03:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so14800170oiw.8
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:03:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-7-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:03:22 +0100
Message-ID: <CAFEAcA8D1ddN5ruYBr23o9YRQ=a0XSBp67OJ71ust664WKo9nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/20] target/arm: Fix arm_current_el for
 user-only
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
> Saves about 12k code size in qemu-aarch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2d6d7d03aa..aedaf2631e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1958,6 +1958,9 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
>   */
>  static inline int arm_current_el(CPUARMState *env)
>  {
> +#ifdef CONFIG_USER_ONLY
> +    return 0;
> +#else
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          return arm_v7m_is_handler_mode(env) ||
>              !(env->v7m.control[env->v7m.secure] & 1);
> @@ -1984,6 +1987,7 @@ static inline int arm_current_el(CPUARMState *env)
>
>          return 1;
>      }
> +#endif

Again, the #ifdeffery here should be unnecessary ? env->pstate,
env->uncached_cpsr, etc should be set so that we return the
right thing.

thanks
-- PMM
