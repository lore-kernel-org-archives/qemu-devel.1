Received: from eggs.gnu.org ([2001:4830:134:3::10]:43870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDg8-0002ZB-9I
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDg7-0004Wj-Jd
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:22:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDg7-0004WH-BI
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:21:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id l6-v6so41618448wrt.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:21:59 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-30-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50ad13eb-5983-c21a-3db6-f85434519cca@linaro.org>
Date: Sun, 21 Oct 2018 14:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-30-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 29/56] arm: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> +++ b/target/arm/helper.c
> @@ -1295,12 +1295,14 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      CPUState *cs = ENV_GET_CPU(env);
>      uint64_t ret = 0;
>  
> -    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +    cpu_mutex_lock(cs);
> +    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
>          ret |= CPSR_I;
>      }
> -    if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
> +    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_FIQ) {
>          ret |= CPSR_F;
>      }
> +    cpu_mutex_unlock(cs);
>      /* External aborts are not possible in QEMU so A bit is always clear */
>      return ret;
>  }

I think simply reading cpu_interrupt_request once into a local variable is
better, and no need for extra locking then.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
