Received: from eggs.gnu.org ([2001:4830:134:3::10]:35901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctsfy-0001Jd-PD
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 05:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctsfv-0003Pm-Hq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 05:16:58 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctsfv-0003PB-3j
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 05:16:55 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
	<001b01d2a94a$fe5c46a0$fb14d3e0$@ru> <87o9wj3phd.fsf@linaro.org>
In-Reply-To: <87o9wj3phd.fsf@linaro.org>
Date: Fri, 31 Mar 2017 12:16:53 +0300
Message-ID: <000901d2a9ff$89fcdad0$9df69070$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
> request@listserver.greensocs.com]
> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
> >> request@listserver.greensocs.com]
> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> <snip>
> >> >> > I tested on vexpress-a9 platform with Debian wheezy.
> >> >>
> >> >> Thanks for that. I now have a test case that I can reproduce failures on
> >> >> without needing graphics.
> >> >>
> >> >> I've been investigating if there are any problems with the timer
> >> >> processing now they have been moved into the TCG thread. The record
> >> >> stage seems to work fine but I'm having difficulty figuring out why
> >> >> playback freezes. It seems we get to a point where we are stuck waiting
> >> >> for a suspiciously exact timer deadline:
> >> >
> >> > I've encountered the following behavior at replay stage:
> >> > - replay takes some instructions to execute (qemu_icount += counter)
> >> > - virtual timer is fired
> >>
> >> This is the virtual timer based on icount not the virtual rt timer? So
> >
> > Regular virtual timer. It's value is based on icount.
> > virtual_rt is used for internal icount purposes.
> 
> And this is where the clock warps come in? The bias brings the
> virtual_rt time forward because execution is waiting for some external
> event to fire (e.g. a timer IRQ)?

I guess so. But bias is not updated when the vCPU works.
vCPU thread updates only qemu_icount which is used for virtual clock calculation.

> >> under the new scheme of being processed in the vCPU loop we should only
> >> fire this one once all execution is done (although you may exit the loop
> >> early before icount is exhausted).
> >
> > We should stop the vCPU before processing virtual timers because:
> > - virtual clock depends on instruction counter
> > - virtual timers may change virtual hardware state
> 
> If we do the processing in the top of main vCPU loop this should be
> equivalent. The instruction counter cannot run because we haven't
> entered tcg_exec_cpu. We also process virtual timers in this thread
> outside the loop so nothing else can be poking the hardware state.

This is how qemu worked in older version - it switched between
processing tasks (vCPU and timers) in one thread.
But how we'll join this behavior with the current design and MTTCG?

> 
> >> > - replay puts back unexecuted instructions (qemu_icount -= counter)
> >> >
> >> > But virtual timer cannot take in account non-executed instructions (counter) and
> >> > therefore it reads only qemu_icount, which provides incorrect time.
> >> >
> >> >> But the timers are all enabled:
> >> >>
> >> >>   (gdb) qemu timers
> >> >>   Processing Realtime timers
> >> >>     clock QEMU_CLOCK_REALTIME is enabled:true, last:-9223372036854775808
> >> >>   Processing Virtual timers
> >> >>     clock QEMU_CLOCK_VIRTUAL is enabled:true, last:-9223372036854775808
> >> >>       timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
> >> >>       timer 503290000000/1000000 (cb:0x555555bd4d1d <ra_timer_handler>)
> >> >>   Processing Host timers
> >> >>     clock QEMU_CLOCK_HOST is enabled:true, last:1490191319270134000
> >> >>   Processing Virtual RT timers
> >> >>     clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, last:-9223372036854775808
> >> >
> >> > Timers are processed only at checkpoints recorded in the log.
> >> > When replay is stuck, probably there is a pending checkpoint in the log
> >> > and pending instructions in CPU (because iothread breaks its
> >> > synchronization).
> >>
> >> How does this work for instructions that sleep (like WFI)? The WFI will
> >> cause us to exit the loop but I assume we need a "real" timer to trigger
> >> a firing of whatever the WFI is waiting for as time according to icount
> >> isn't advancing.
> >
> > This is virtual_rt for. It advances even when vCPU is stopped.
> 
> So I'm not seeing this happen:
> 
>   process_icount_data: icount not increased 117302332749=>117302332749 RT:-1
> 
> I wonder if the advance of virtual_rt has been deadlocked? The -1
> suggests its not even setup.

qemu_start_warp_timer says that it is setup only when there are active virtual timers.


> > By the way, I made small description of the replay log format
> > to be later included into docs/replay.txt:
> >
> Thanks. That's really useful.
> 
> Do you think it would be worth including the dumper script I wrote in
> ./scripts/? I mainly wrote it to aid my understanding of the code flow
> but it might be useful in future investigations?

Usually I get human-readable logs in record and replay modes to find
divergence between them, but I think your script might be useful in some cases.

Pavel Dovgalyuk
