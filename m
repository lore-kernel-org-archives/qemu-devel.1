Received: from eggs.gnu.org ([2001:4830:134:3::10]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDsJ-0003KC-SU
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDsF-0001fF-WE
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:34:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDsD-0001ah-8v
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:34:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id f8-v6so2527459wro.9
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:34:28 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-47-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8af6bae7-ac35-f419-0a83-8a54cfb5eb0d@linaro.org>
Date: Sun, 21 Oct 2018 14:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-47-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 46/56] accel/tcg: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> @@ -540,16 +540,16 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>       */
>      atomic_mb_set(&cpu->icount_decr.u16.high, 0);
>  
> -    if (unlikely(atomic_read(&cpu->interrupt_request))) {
> +    if (unlikely(cpu_interrupt_request(cpu))) {
>          int interrupt_request;
>          qemu_mutex_lock_iothread();
> -        interrupt_request = cpu->interrupt_request;
> +        interrupt_request = cpu_interrupt_request(cpu);
>          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
>              /* Mask out external interrupts for this step. */
>              interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
>          }
>          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>              cpu->exception_index = EXCP_DEBUG;
>              qemu_mutex_unlock_iothread();
>              return true;

Multiple calls.


r~
