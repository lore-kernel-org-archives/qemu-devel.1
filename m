Received: from eggs.gnu.org ([2001:4830:134:3::10]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW4Rq-0008W6-Iw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW4Rn-0000Xa-IX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:59:58 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW4Rn-0000XM-CP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:59:55 -0500
Received: by mail-wm0-x22f.google.com with SMTP id c206so219652635wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:59:55 -0800 (PST)
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-7-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484937883-1068-7-git-send-email-peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:59:52 +0000
Message-ID: <87pojc9ywn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/6] armv7m: Clear FAULTMASK on
 return from non-NMI exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> FAULTMASK must be cleared on return from all
> exceptions other than NMI.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc383d1..cfbc622 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5969,8 +5969,13 @@ static void do_v7m_exception_exit(CPUARMState *env)
>      uint32_t xpsr;
>
>      type = env->regs[15];
> -    if (env->v7m.exception != 0)
> +    if (env->v7m.exception != ARMV7M_EXCP_NMI) {
> +        /* Auto-clear FAULTMASK on return from other than NMI */
> +        env->daif &= ~PSTATE_F;
> +    }
> +    if (env->v7m.exception != 0) {
>          armv7m_nvic_complete_irq(env->nvic, env->v7m.exception);
> +    }
>
>      /* Switch to the target stack.  */
>      switch_v7m_sp(env, (type & 4) != 0);

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
