Received: from eggs.gnu.org ([209.51.188.92]:42102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grqiB-0002iW-5S
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grqiA-0005GU-8G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:55:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grqi9-0005ES-WA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:55:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so1294405wrt.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:55:53 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-39-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-39-cota@braap.org>
Date: Thu, 07 Feb 2019 20:55:50 +0000
Message-ID: <87h8dfmi7d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 38/73] arm: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
<snip>
>
> -    /* Hooks may change global state so BQL should be held, also the
> -     * BQL needs to be held for any modification of
> -     * cs->interrupt_request.
> -     */
> +    /* Hooks may change global state so BQL should be held */
>      g_assert(qemu_mutex_iothread_locked());
>
>      arm_call_pre_el_change_hook(cpu);

So I dug into this and currently the only user is pmu_pre_el_change
which updates a bunch of the performance counters. While profiling the
system running the other thing that showed up was:

  void HELPER(set_cp_reg)(CPUARMState *env, void *rip, uint32_t value)
  {
      const ARMCPRegInfo *ri =3D rip;

      if (ri->type & ARM_CP_IO) {
          qemu_mutex_lock_iothread();
          ri->writefn(env, ri, value);
          qemu_mutex_unlock_iothread();
      } else {
          ri->writefn(env, ri, value);
      }
  }

And friends. I'm wondering now if these are candidates for using CPU
locks. We mention it in out docs (which might be a little out of date now):

  MMIO access automatically serialises hardware emulation by way of the
  BQL. Currently ARM targets serialise all ARM_CP_IO register accesses
  and also defer the reset/startup of vCPUs to the vCPU context by way
  of async_run_on_cpu().

for registers that affect things like the GIC that can have cross-vCPU
effects I suspect the race free IRQ raising might be enough. Are we over
locking if only a vCPU can read/write it's own CP regs?

Peter any thoughts?

Anyway as far as this patch goes:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
