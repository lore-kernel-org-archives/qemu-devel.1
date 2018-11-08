Received: from eggs.gnu.org ([2001:4830:134:3::10]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKo3t-00079y-Vm
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKo3o-00069c-Rs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKo3m-0005QV-7F
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id t15-v6so1983073wmt.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:25:27 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e33f03d9-1223-3396-ad79-2a7ae264c13a@linaro.org>
Date: Thu, 8 Nov 2018 18:25:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] arm: fix
 aa64_generate_debug_exceptions to work with EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/8/18 5:33 PM, Alex Bennée wrote:
> The test was incomplete and incorrectly caused debug exceptions to be
> generated when returning to EL2 after a failed attempt to single-step
> an EL1 instruction. Fix this while cleaning up the function a little.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1efff21a18..a6d8eb14f6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2764,23 +2764,33 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
>      return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
>  }
>  
> +/* See AArch64.GenerateDebugExceptionsFrom() in ARM ARM pseudocode */
>  static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
>  {
> +    int cur_el = arm_current_el(env);
> +    int debug_el;
> +
>      if (arm_is_secure(env)) {
>          /* MDCR_EL3.SDD disables debug events from Secure state */
>          if (extract32(env->cp15.mdcr_el3, 16, 1) != 0
> -            || arm_current_el(env) == 3) {
> +            || cur_el == 3) {

Hmm.  Perhaps better as

    if (cur_el == 3) {
        return false;
    }
    /* MDCR_EL3.SDD disables... */
    if (arm_is_secure_below_el3(env)
        && extract32(env->cp15.mdcr_el3, 16, 1)) {
        return false;
    }

and of course more symbols would be nice, but it's not wrong as-is.


r~
