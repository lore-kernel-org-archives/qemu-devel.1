Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eH5HN-0000LY-0c
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eH5HJ-0006nO-So
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:55:45 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eH5HJ-0006mt-I3
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:55:41 -0500
Received: by mail-wr0-x232.google.com with SMTP id u40so10708349wrf.10
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 01:55:41 -0800 (PST)
References: <1511222455.862.5.camel@linuxfoundation.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1511222455.862.5.camel@linuxfoundation.org>
Date: Tue, 21 Nov 2017 09:55:38 +0000
Message-ID: <8760a4x8f9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-system-ppc hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, qemu-devel <qemu-devel@nongnu.org>


Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> Hi,
>
> I work on the Yocto Project and we use qemu to test boot our Linux
> images and run tests against them. We've been noticing some instability
> for ppc where the images sometimes hang, usually around udevd bring up
> time so just after booting into userspace.
>
> To cut a long story short, I've tracked down what I think is the
> problem. I believe the decrementer timer stops receiving interrupts so
> tasks in our images hang indefinitely as the timer stopped.
>
> It can be summed up with this line of debug:
>
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0004
>
> It should normally read:
>
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level1 =3D> pending 00000100req 00000=
002
>
> The question is whyCPU_INTERRUPT_EXITTB ends up being set when the
> lines above thislog message clearly setsCPU_INTERRUPT_HARD (via
> cpu_interrupt() ).
>
> I note in cpu.h:
>
> /* updates protected by BQL */
> uint32_t interrupt_request;
>
> (for struct CPUState)
>
> The ppc code does "cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB" in 5
> places, 3 in excp_helper.c and 2 in helper_regs.h. In all cases,
> g_assert(qemu_mutex_iothread_locked()); fails. If I do something like:
>
> if (!qemu_mutex_iothread_locked()) {
> qemu_mutex_lock_iothread();
> cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> qemu_mutex_unlock_iothread();
> } else {
> cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> }
>
> in these call sites then I can no longer lock qemu up with my test
> case.
>
> I suspect the _HARD setting gets overwritten which stops the
> decrementer interrupts being delivered.
>
> I don't know if taking this lock in these situations is going to be bad
> for performance and whether such a patch would be right/wrong.

It is certainly right to hold the BQL when messing with cpu_interrupt()
(and by extension cpu->interrupt_request). This is because although
nominally a per-vCPU variable there are cross-vCPU accesses and therefor
a chance of races like the one you have triggered.

> At this point I therefore wanted to seek advice on what the real issue
> is here and how to fix it!

Code should be using cpu_interrupt() to change things but we have plenty
of examples in the code of messing with cpu->interrupt_request directly
which is often why the assert() in cpu_interrupt() doesn't get a chance
to fire.

The two most prolific direct users seems to be i386 and ppc.

The i386 cases are all most likely OK as it tends to be in KVM emulation
code where by definition the BQL is already held by the time you get
there. For PPC it will depend on how you got there. The
multi-thread-tcg.txt document describes the approach:

  Emulated hardware state
  -----------------------

  Currently thanks to KVM work any access to IO memory is automatically
  protected by the global iothread mutex, also known as the BQL (Big
  Qemu Lock). Any IO region that doesn't use global mutex is expected to
  do its own locking.

  However IO memory isn't the only way emulated hardware state can be
  modified. Some architectures have model specific registers that
  trigger hardware emulation features. Generally any translation helper
  that needs to update more than a single vCPUs of state should take the
  BQL.

  As the BQL, or global iothread mutex is shared across the system we
  push the use of the lock as far down into the TCG code as possible to
  minimise contention.

  (Current solution)

  MMIO access automatically serialises hardware emulation by way of the
  BQL. Currently ARM targets serialise all ARM_CP_IO register accesses
  and also defer the reset/startup of vCPUs to the vCPU context by way
  of async_run_on_cpu().

  Updates to interrupt state are also protected by the BQL as they can
  often be cross vCPU.

So basically it comes down to the call-path into your final
cpu_interrupt() call which is why I guess your doing the:

  if (!qemu_mutex_iothread_locked()) {
     qemu_mutex_lock_iothread();
     cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
     qemu_mutex_unlock_iothread();
  }

dance. I suspect the helper functions are called both from device
emulation (where BQL is held) and from vCPU helpers (where it is
currently not).

So I suggest the fix is:

 1. Convert sites doing their own manipulation of
 cpu->interrupt_request() to call the helper instead
 2. If helper directly called from TCG code:
      - take BQL before calling cpu_interrupt(), release after
    Else if helper shared between MMIO/TCG paths
      - take BQL from TCG path, call helper, release after

It might be there is some sensible re-factoring that could be done to
make things clearer but I'll leave that to the PPC experts to weigh in
on.

Hope that helps!

--
Alex Benn=C3=A9e
