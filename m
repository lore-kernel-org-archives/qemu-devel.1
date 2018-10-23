Received: from eggs.gnu.org ([2001:4830:134:3::10]:50489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gEmG0-0003rp-S0
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 22:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gEmFx-0002Kh-Gr
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 22:17:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gEmFw-0002JU-Pu
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 22:17:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id 193-v6so70710wme.3
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 19:17:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-47-cota@braap.org>
	<8af6bae7-ac35-f419-0a83-8a54cfb5eb0d@linaro.org>
	<20181022235040.GB31407@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <33d570f5-5837-09ff-a599-c50c9f3ea331@twiddle.net>
Date: Tue, 23 Oct 2018 03:17:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181022235040.GB31407@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 10/23/18 12:50 AM, Emilio G. Cota wrote:
> On Sun, Oct 21, 2018 at 14:34:25 +0100, Richard Henderson wrote:
>> On 10/19/18 2:06 AM, Emilio G. Cota wrote:
>>> @@ -540,16 +540,16 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>>>       */
>>>      atomic_mb_set(&cpu->icount_decr.u16.high, 0);
>>>  
>>> -    if (unlikely(atomic_read(&cpu->interrupt_request))) {
>>> +    if (unlikely(cpu_interrupt_request(cpu))) {
>>>          int interrupt_request;
>>>          qemu_mutex_lock_iothread();
>>> -        interrupt_request = cpu->interrupt_request;
>>> +        interrupt_request = cpu_interrupt_request(cpu);
>>>          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
>>>              /* Mask out external interrupts for this step. */
>>>              interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
>>>          }
>>>          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
>>> -            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
>>> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>>>              cpu->exception_index = EXCP_DEBUG;
>>>              qemu_mutex_unlock_iothread();
>>>              return true;
>>
>> Multiple calls.
> 
> I'd rather keep it as is.
> 
> The first read takes the lock, and that has to stay unless
> we want to use atomic_set on interrupt_request everywhere.

Why not?  That's even cheaper.

> Given that the CPU lock is uncontended (so it's cheap to
> acquire) ...

It still requires at minimum a "lock xchg" (or equivalent on non-x86), which
isn't free -- think 50-ish cycles minimum just for that one insn, plus call
overhead.


r~
