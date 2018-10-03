Received: from eggs.gnu.org ([2001:4830:134:3::10]:44130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7ctD-0007dX-A5
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7ct8-0001kw-MN
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:52:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7ct8-0001kQ-DT
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:52:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so5168270wrw.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 01:52:10 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5cd37a9e-ee75-6a98-4b9c-b659208c1118@redhat.com>
Date: Wed, 3 Oct 2018 10:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/13] target/arm: Define new EXCP type for
 v8M stack overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/10/2018 18:35, Peter Maydell wrote:
> Define EXCP_STKOF, and arrange for it to cause us to take
> a UsageFault with CFSR.STKOF set.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/cpu.h    | 2 ++
>  target/arm/helper.c | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d2c1d005ed7..318792823b9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -56,6 +56,7 @@
>  #define EXCP_SEMIHOST       16   /* semihosting call */
>  #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
>  #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
> +#define EXCP_STKOF          19   /* v8M STKOF UsageFault */
>  /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
>  
>  #define ARMV7M_EXCP_RESET   1
> @@ -1380,6 +1381,7 @@ FIELD(V7M_CFSR, UNDEFINSTR, 16 + 0, 1)
>  FIELD(V7M_CFSR, INVSTATE, 16 + 1, 1)
>  FIELD(V7M_CFSR, INVPC, 16 + 2, 1)
>  FIELD(V7M_CFSR, NOCP, 16 + 3, 1)
> +FIELD(V7M_CFSR, STKOF, 16 + 4, 1)
>  FIELD(V7M_CFSR, UNALIGNED, 16 + 8, 1)
>  FIELD(V7M_CFSR, DIVBYZERO, 16 + 9, 1)
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6ed8631dbee..c303dc453f1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7511,6 +7511,7 @@ static void arm_log_exception(int idx)
>              [EXCP_SEMIHOST] = "Semihosting call",
>              [EXCP_NOCP] = "v7M NOCP UsageFault",
>              [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
> +            [EXCP_STKOF] = "v8M STKOF UsageFault",
>          };
>  
>          if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
> @@ -7666,6 +7667,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVSTATE_MASK;
>          break;
> +    case EXCP_STKOF:
> +        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
> +        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
> +        break;
>      case EXCP_SWI:
>          /* The PC already points to the next instruction.  */
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC, env->v7m.secure);
> 
