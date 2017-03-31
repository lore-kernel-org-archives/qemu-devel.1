Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctwNy-0004cl-D7
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctwNu-0002vO-9f
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:14:38 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:36736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ctwNt-0002sj-UZ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:14:34 -0400
Received: by mail-lf0-x233.google.com with SMTP id x137so43805097lff.3
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 06:14:33 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
	<001b01d2a94a$fe5c46a0$fb14d3e0$@ru> <87o9wj3phd.fsf@linaro.org>
	<000901d2a9ff$89fcdad0$9df69070$@ru> <87fuht4rpy.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87fuht4rpy.fsf@linaro.org>
Date: Fri, 31 Mar 2017 14:14:30 +0100
Message-ID: <87efxd4mh5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com


Alex Bennée <alex.bennee@linaro.org> writes:

> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>
>>> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
>>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
>>> request@listserver.greensocs.com]
>>> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>> >> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
>>> >> request@listserver.greensocs.com]
>>> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>> <snip>
>>> >> >> > I tested on vexpress-a9 platform with Debian wheezy.
>>> >> >>
>>> >> >> Thanks for that. I now have a test case that I can reproduce failures on
>>> >> >> without needing graphics.
>>> >> >>
>>> >> >> I've been investigating if there are any problems with the timer
>>> >> >> processing now they have been moved into the TCG thread. The record
>>> >> >> stage seems to work fine but I'm having difficulty figuring out why
>>> >> >> playback freezes. It seems we get to a point where we are stuck waiting
>>> >> >> for a suspiciously exact timer deadline:
>>> >> >
>>> >> > I've encountered the following behavior at replay stage:
>>> >> > - replay takes some instructions to execute (qemu_icount += counter)
>>> >> > - virtual timer is fired
>>> >>
>>> >> This is the virtual timer based on icount not the virtual rt timer? So
>>> >
>>> > Regular virtual timer. It's value is based on icount.
>>> > virtual_rt is used for internal icount purposes.
>>>
>>> And this is where the clock warps come in? The bias brings the
>>> virtual_rt time forward because execution is waiting for some external
>>> event to fire (e.g. a timer IRQ)?
>>
>> I guess so. But bias is not updated when the vCPU works.
>> vCPU thread updates only qemu_icount which is used for virtual clock calculation.
>>
>>> >> under the new scheme of being processed in the vCPU loop we should only
>>> >> fire this one once all execution is done (although you may exit the loop
>>> >> early before icount is exhausted).
>>> >
>>> > We should stop the vCPU before processing virtual timers because:
>>> > - virtual clock depends on instruction counter
>>> > - virtual timers may change virtual hardware state
>>>
>>> If we do the processing in the top of main vCPU loop this should be
>>> equivalent. The instruction counter cannot run because we haven't
>>> entered tcg_exec_cpu. We also process virtual timers in this thread
>>> outside the loop so nothing else can be poking the hardware state.
>>
>> This is how qemu worked in older version - it switched between
>> processing tasks (vCPU and timers) in one thread.
>
> The only real difference is the sequencing in the old case was protected
> by the BQL - now its my program order.
>
>> But how we'll join this behavior with the current design and MTTCG?
>
> Ignore MTTCG for now. We don't even try and run multiple-threads when
> icount is enabled. However the change in the BQL locking is what has
> triggered the failures.
>
> Anyway I think I'm getting closer to narrowing it down. On record I see
> replay_current_step jump backwards with this:
>
> /* A common event print, called when reading or saving an event */
> static void print_event(uint8_t event)
> {
>     static int event_count;
>     static uint64_t last_step;
>     uint64_t this_step = replay_get_current_step();
>
>     fprintf(stderr, "replay: event %d is %d @ step=%#" PRIx64 "\n",
>             event_count, event, this_step);
>
>     if (this_step < last_step) {
>         fprintf(stderr,"%s: !!! step %d went backwards %#"PRIx64"=>%#"PRIx64"!!!\n",
>                 __func__, event_count, last_step, this_step);
>         abort();
>     }
>     last_step = this_step;
>     event_count++;
> }
>
> void replay_put_event(uint8_t event)
> {
>     assert(event < EVENT_COUNT);
>     replay_put_byte(event);
>     print_event(event);
> }
>
> The jump back is fairly consistent in my case (event 66 in the vexpress
> run) but I'm fairly sure that is the bug. I can't see any reason for the
> step count to go backwards - indeed that breaks the premise of .
>
> Unfortunately when I start putting break and watchpoints in to see how
> this jump back occurs the problem goes away until I disable them. So
> this very much looks like a race condition corrupting the icount data.

So this is a symptom of cpu_get_icount_raw(void) only accounting for in
progress instructions when in the vCPU context and the fact
timers_state.qemu_icount is "in credit" while the vCPU is running.

--
Alex Bennée
