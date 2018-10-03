Received: from eggs.gnu.org ([2001:4830:134:3::10]:46185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7d31-0004Il-TQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7d2v-0005Uz-6t
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:02:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7d2u-0005Ul-U9
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:02:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so4911279wmc.0
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:02:16 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b536462-0b6e-cb70-166c-a1108b15f73a@redhat.com>
Date: Wed, 3 Oct 2018 11:02:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm: Add v8M stack limit
 checks on NS function calls
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
> Check the v8M stack limits when pushing the frame for a
> non-secure function call via BLXNS.
> 
> In order to be able to generate the exception we need to
> promote raise_exception() from being local to op_helper.c
> so we can call it from helper.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/internals.h | 9 +++++++++
>  target/arm/helper.c    | 4 ++++
>  target/arm/op_helper.c | 4 ++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 966a8131623..aa124a06a9d 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -94,6 +94,15 @@ FIELD(V7M_EXCRET, RES1, 7, 25) /* including the must-be-1 prefix */
>  #define M_FAKE_FSR_NSC_EXEC 0xf /* NS executing in S&NSC memory */
>  #define M_FAKE_FSR_SFAULT 0xe /* SecureFault INVTRAN, INVEP or AUVIOL */
>  
> +/**
> + * raise_exception: Raise the specified exception.
> + * Raise a guest exception with the specified value, syndrome register
> + * and target exception level. This should be called from helper functions,
> + * and never returns because we will longjump back up to the CPU main loop.
> + */
> +void QEMU_NORETURN raise_exception(CPUARMState *env, uint32_t excp,
> +                                   uint32_t syndrome, uint32_t target_el);
> +
>  /*
>   * For AArch64, map a given EL to an index in the banked_spsr array.
>   * Note that this mapping and the AArch32 mapping defined in bank_number()
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a10dff01a90..074f7616272 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6710,6 +6710,10 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
>                        "BLXNS with misaligned SP is UNPREDICTABLE\n");
>      }
>  
> +    if (sp < v7m_sp_limit(env)) {
> +        raise_exception(env, EXCP_STKOF, 0, 1);
> +    }
> +
>      saved_psr = env->v7m.exception;
>      if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK) {
>          saved_psr |= XPSR_SFPA;
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 38f885b290f..de0d3984ea4 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -28,8 +28,8 @@
>  #define SIGNBIT (uint32_t)0x80000000
>  #define SIGNBIT64 ((uint64_t)1 << 63)
>  
> -static void raise_exception(CPUARMState *env, uint32_t excp,
> -                            uint32_t syndrome, uint32_t target_el)
> +void raise_exception(CPUARMState *env, uint32_t excp,
> +                     uint32_t syndrome, uint32_t target_el)
>  {
>      CPUState *cs = CPU(arm_env_get_cpu(env));
>  
> 
