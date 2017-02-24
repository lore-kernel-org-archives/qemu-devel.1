Received: from eggs.gnu.org ([2001:4830:134:3::10]:58931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJU9-0000mT-Lh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJU6-0000j6-8R
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:16:49 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chJU6-0000iw-2j
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:16:46 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so19485772wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:16:46 -0800 (PST)
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<1487262963-11519-13-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1487262963-11519-13-git-send-email-peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:16:42 +0000
Message-ID: <87mvdbldad.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/13] armv7m: Raise correct kind of
 UsageFault for attempts to execute ARM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> M profile doesn't implement ARM, and the architecturally required
> behaviour for attempts to execute with the Thumb bit clear is to
> generate a UsageFault with the CFSR INVSTATE bit set.  We were
> incorrectly implementing this as generating an UNDEFINSTR UsageFault;
> fix this.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h       | 1 +
>  linux-user/main.c      | 1 +
>  target/arm/helper.c    | 4 ++++
>  target/arm/translate.c | 8 ++++++--
>  4 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 017e301..228747f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -54,6 +54,7 @@
>  #define EXCP_VFIQ           15
>  #define EXCP_SEMIHOST       16   /* semihosting call */
>  #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
> +#define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
>
>  #define ARMV7M_EXCP_RESET   1
>  #define ARMV7M_EXCP_NMI     2
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 4fd49ce..b6043d8 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -574,6 +574,7 @@ void cpu_loop(CPUARMState *env)
>          switch(trapnr) {
>          case EXCP_UDEF:
>          case EXCP_NOCP:
> +        case EXCP_INVSTATE:
>              {
>                  TaskState *ts = cs->opaque;
>                  uint32_t opcode;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6a476b4..948aba2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6244,6 +6244,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>          env->v7m.cfsr |= R_V7M_CFSR_NOCP_MASK;
>          break;
> +    case EXCP_INVSTATE:
> +        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
> +        env->v7m.cfsr |= R_V7M_CFSR_INVSTATE_MASK;
> +        break;
>      case EXCP_SWI:
>          /* The PC already points to the next instruction.  */
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4436d8f..9fded03 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7978,9 +7978,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>      TCGv_i32 addr;
>      TCGv_i64 tmp64;
>
> -    /* M variants do not implement ARM mode.  */
> +    /* M variants do not implement ARM mode; this must raise the INVSTATE
> +     * UsageFault exception.
> +     */
>      if (arm_dc_feature(s, ARM_FEATURE_M)) {
> -        goto illegal_op;
> +        gen_exception_insn(s, 4, EXCP_INVSTATE, syn_uncategorized(),
> +                           default_exception_el(s));
> +        return;
>      }
>      cond = insn >> 28;
>      if (cond == 0xf){


--
Alex Bennée
