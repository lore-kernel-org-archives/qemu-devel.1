Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ct6l8-0002vH-Ew
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ct6l4-0002GH-Eo
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:07:06 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59760)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ct6l4-0002FN-1U
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:07:02 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
In-Reply-To: <87inn1xunu.fsf@linaro.org>
Date: Wed, 29 Mar 2017 09:06:56 +0300
Message-ID: <000601d2a852$ac5211d0$04f63570$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

> From: mttcg-request@listserver.greensocs.com =
[mailto:mttcg-request@listserver.greensocs.com]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>=20
> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> >
> >> >> I ran the following test on both pre-mttcg-merge and my current =
HEAD
> >> >> which includes Paolo's fix series:
> >> >>
> >> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >> >>     -net none \
> >> >>     -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
> >> >>
> >> >> And then:
> >> >>
> >> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >> >>     -net none \
> >> >>     -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin
> >> >>
> >> >> And they both ran the same. However I kept running into:
> >> >>
> >> >>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel =
transport module.
> >> >> qemu-system-arm: Missing character write event in the replay log
> >> >>
> >> >> This seems to be a pre-existing
> >> >
> >> > Does it mean that qemu-arm platform includes some serial devices =
that were
> >> > not detected by the replay?
> >>
> >> It's the standard ARM platform serial port. When I read replay.txt =
is
> >> said:
> >>
> >>  * Supports i386, x86_64, and ARM hardware platforms.
> >>
> >> Should we add some qualifications about which machine types are
> >> supported? What is you ARM test case for record/replay?
> >
> > I tested on vexpress-a9 platform with Debian wheezy.
>=20
> Thanks for that. I now have a test case that I can reproduce failures =
on
> without needing graphics.
>=20
> I've been investigating if there are any problems with the timer
> processing now they have been moved into the TCG thread. The record
> stage seems to work fine but I'm having difficulty figuring out why
> playback freezes. It seems we get to a point where we are stuck =
waiting
> for a suspiciously exact timer deadline:

I've encountered the following behavior at replay stage:
- replay takes some instructions to execute (qemu_icount +=3D counter)
- virtual timer is fired
- replay puts back unexecuted instructions (qemu_icount -=3D counter)

But virtual timer cannot take in account non-executed instructions =
(counter) and
therefore it reads only qemu_icount, which provides incorrect time.

> But the timers are all enabled:
>=20
>   (gdb) qemu timers
>   Processing Realtime timers
>     clock QEMU_CLOCK_REALTIME is enabled:true, =
last:-9223372036854775808
>   Processing Virtual timers
>     clock QEMU_CLOCK_VIRTUAL is enabled:true, =
last:-9223372036854775808
>       timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
>       timer 503290000000/1000000 (cb:0x555555bd4d1d =
<ra_timer_handler>)
>   Processing Host timers
>     clock QEMU_CLOCK_HOST is enabled:true, last:1490191319270134000
>   Processing Virtual RT timers
>     clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, =
last:-9223372036854775808

Timers are processed only at checkpoints recorded in the log.
When replay is stuck, probably there is a pending checkpoint in the log
and pending instructions in CPU (because iothread breaks its =
synchronization).

> One area I wanted to look back at was comparing the record trace from
> pre-mttcg-merge to now to see if any information was missing. However

I usually use in_asm and exec logs and also add some logging at replay =
checkpoints.

> the bin file has quite a lot of noise in it from changing fields so I
> was wondering do you have any sort of dumper tool for comparing the
> traces? If not is the format of the trace file specified anywhere?

Usually you cannot compare two different record/replay logs, because =
there
is no synchronization of the timers in different recording runs and
therefore you'll get totally different logs.

Pavel Dovgalyuk
