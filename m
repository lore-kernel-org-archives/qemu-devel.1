Received: from eggs.gnu.org ([2001:4830:134:3::10]:47207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cTMaJ-0003Ju-SS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cTMaF-0008Fx-0p
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:45:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44272)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cTMaE-0008Fp-Op
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:45:26 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
	<001201d26cc6$f023ad00$d06b0700$@ru>
	<CAFEAcA-AMJ33g9hO2k9oGJfDr-Fatk7TY+Sbs_wRC-OfCjWhmQ@mail.gmail.com>
	<001301d26cce$21ad3d30$6507b790$@ru>
	<f2f54dce-0e3f-2718-4b35-1321f5c2ae11@redhat.com>
In-Reply-To: <f2f54dce-0e3f-2718-4b35-1321f5c2ae11@redhat.com>
Date: Tue, 17 Jan 2017 08:45:26 +0300
Message-ID: <000c01d27084$e749e7a0$b5ddb6e0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Alex Bligh' <alex@alex.org.uk>, 'Max Filippov' <jcmvbkbc@gmail.com>, 'qemu-devel' <qemu-devel@nongnu.org>, 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>, 'Richard Henderson' <rth@twiddle.net>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> On 12/01/2017 13:19, Pavel Dovgalyuk wrote:
> >> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >> On 12 January 2017 at 11:28, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >>>> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> >>>> Ok, looks like what happens in my case is that instruction that
> >>>> sets CCOMPARE and thus changes remaining icount does not
> >>>> cause exit from the cpu_exec. So merely ending TB on
> >>>> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
> >>>> throw an exception of some kind? Or does the timer code need
> >>>> to take care of that?
> >>>
> >>> Yes, it seems that you should end the block with an exception,
> >>> to allow icount loop recalculate the timeouts.
> >>
> >> Really? The ARM translate.c doesn't generate an exception.
> >> It just does
> >>  gen_io_end();
> >>  gen_lookup_tb();
> >>
> >> (so we force a lookup of the next TB, but don't throw an
> >> exception of any kind).
> >
> > Maybe I missing something. As far as I understand, changing the virtual timer
> > notifies the iothread and os_host_main_loop_wait kicks the CPU thread.
> >
> > But within that period of time before changing the timer and kicking the thread
> > CPU may proceed some instructions and the timer will be expired if it was set
> > to one of the soonest instructions.
> 
> My understanding (which may be wrong!) was that after gen_io_end you
> would exit with TB_EXIT_ICOUNT_EXPIRED and cpu->icount_decr.u16.high =
> -1, but indeed I don't see anything that calls cpu_interrupt in that
> path.
> 
> Maybe something like this:
> 
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 050de59..c20d193 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -73,6 +73,9 @@ static inline void gen_io_end(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(0);
>      tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    /* Make the next TB exit immediately with TB_EXIT_ICOUNT_EXPIRED.  */
> +    tcg_gen_st16_i32(-1, cpu_env,
> +                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.high));
>      tcg_temp_free_i32(tmp);
>  }

I guess it will help, but this seems too general.
There are some IO cases that do not need breaking the execution.
E.g., rdtsc in x86 does not change any timers, but is translated as IO operation.
However, I think it doesn't called too often, therefore it will not affect on performance too much.

Pavel Dovgalyuk
