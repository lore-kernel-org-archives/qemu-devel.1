Received: from eggs.gnu.org ([2001:4830:134:3::10]:39311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4B4N-0005iT-96
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4B4K-0004tj-1w
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:01:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f4B4J-0004tT-R8
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:01:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id p53so30364470wrc.10
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 13:01:11 -0700 (PDT)
References: <CAFEAcA9PbAr+0U1dJ22fr3+B0-KO3Oy73-mk755rJQtmY_rSKA@mail.gmail.com>
	<cfb5230b-ec8e-ccb7-788d-0b389a93e128@redhat.com>
	<CAFEAcA-vUuGWqPfDEz9Qu+q3PGqctSw-YxRnH3jWJGH+QVLHsg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7f67671-c8e8-f05e-722b-7616a2ac11c0@redhat.com>
Date: Thu, 5 Apr 2018 22:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vUuGWqPfDEz9Qu+q3PGqctSw-YxRnH3jWJGH+QVLHsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] TCG icount interaction with timer deadlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Alex Bennée" <alex.bennee@linaro.org>, "Richard Henderson"
> <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
> Sent: Thursday, April 5, 2018 7:35:56 PM
> Subject: Re: TCG icount interaction with timer deadlines
> 
> On 5 April 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 05/04/2018 18:01, Peter Maydell wrote:
> >>  * however, if the guest reprograms the clock during the tcg_cpu_exec()
> >>    run, we don't do anything to cause us to stop earlier
> >
> > Anything that does this from the vCPU thread should be between
> > gen_icount_start and gen_icount_end.  (In fact, it's the entire reason
> > why cpu_io_recompile exists).
> 
> Yes, and this does cause us to do a cpu_io_recompile, which
> rebuilds the TB and does a longjmp. However:
>  (1) that only takes us out to cpu_exec(), which will then
>  just go ahead and execute the next TB, whereas the
>  recalculation of deadlines happens at the next level out
>  in tcg_cpu_exec()
>  (2) the io_recompile happens *before* the guest writes to
>  the timer register that reprograms the deadline, so even
>  if we recomputed deadlines after this longjmp they wouldn't
>  be correct

Right - that part would be handled here:

void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
{
    if (!use_icount || type != QEMU_CLOCK_VIRTUAL) {
        qemu_notify_event();
        return;
    }

    if (!qemu_in_vcpu_thread() && first_cpu) {
        /* qemu_cpu_kick is not enough to kick a halted CPU out of
         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
         * causes cpu_thread_is_idle to return false.  This way,
         * handle_icount_deadline can run.
         */
        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
    }
}

(called by timerlist_notify, called in turn by timerlist_rearm)
but that second "if" is too restrictive.  Maybe just removing
the first arm is enough.  All this was broken by MTTCG.

Paolo
