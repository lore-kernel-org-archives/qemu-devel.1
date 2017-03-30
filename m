Received: from eggs.gnu.org ([2001:4830:134:3::10]:34627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctYVJ-0001TB-1Q
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctYVF-0003W0-Oa
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:44:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56906)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ctYVF-0003V6-BR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:44:33 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
In-Reply-To: <87vaqs4dxc.fsf@linaro.org>
Date: Thu, 30 Mar 2017 14:44:30 +0300
Message-ID: <001b01d2a94a$fe5c46a0$fb14d3e0$@ru>
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
> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
> request@listserver.greensocs.com]
> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >>
> >> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> >> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> >> >
> >> >> >> I ran the following test on both pre-mttcg-merge and my =
current HEAD
> >> >> >> which includes Paolo's fix series:
> >> >> >>
> >> >> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >> >> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >> >> >>     -net none \
> >> >> >>     -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
> >> >> >>
> >> >> >> And then:
> >> >> >>
> >> >> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >> >> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >> >> >>     -net none \
> >> >> >>     -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin
> >> >> >>
> >> >> >> And they both ran the same. However I kept running into:
> >> >> >>
> >> >> >>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel =
transport module.
> >> >> >> qemu-system-arm: Missing character write event in the replay =
log
> >> >> >>
> >> >> >> This seems to be a pre-existing
> >> >> >
> >> >> > Does it mean that qemu-arm platform includes some serial =
devices that were
> >> >> > not detected by the replay?
> >> >>
> >> >> It's the standard ARM platform serial port. When I read =
replay.txt is
> >> >> said:
> >> >>
> >> >>  * Supports i386, x86_64, and ARM hardware platforms.
> >> >>
> >> >> Should we add some qualifications about which machine types are
> >> >> supported? What is you ARM test case for record/replay?
> >> >
> >> > I tested on vexpress-a9 platform with Debian wheezy.
> >>
> >> Thanks for that. I now have a test case that I can reproduce =
failures on
> >> without needing graphics.
> >>
> >> I've been investigating if there are any problems with the timer
> >> processing now they have been moved into the TCG thread. The record
> >> stage seems to work fine but I'm having difficulty figuring out why
> >> playback freezes. It seems we get to a point where we are stuck =
waiting
> >> for a suspiciously exact timer deadline:
> >
> > I've encountered the following behavior at replay stage:
> > - replay takes some instructions to execute (qemu_icount +=3D =
counter)
> > - virtual timer is fired
>=20
> This is the virtual timer based on icount not the virtual rt timer? So

Regular virtual timer. It's value is based on icount.
virtual_rt is used for internal icount purposes.

> under the new scheme of being processed in the vCPU loop we should =
only
> fire this one once all execution is done (although you may exit the =
loop
> early before icount is exhausted).

We should stop the vCPU before processing virtual timers because:
- virtual clock depends on instruction counter
- virtual timers may change virtual hardware state

> > - replay puts back unexecuted instructions (qemu_icount -=3D =
counter)
> >
> > But virtual timer cannot take in account non-executed instructions =
(counter) and
> > therefore it reads only qemu_icount, which provides incorrect time.
> >
> >> But the timers are all enabled:
> >>
> >>   (gdb) qemu timers
> >>   Processing Realtime timers
> >>     clock QEMU_CLOCK_REALTIME is enabled:true, =
last:-9223372036854775808
> >>   Processing Virtual timers
> >>     clock QEMU_CLOCK_VIRTUAL is enabled:true, =
last:-9223372036854775808
> >>       timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
> >>       timer 503290000000/1000000 (cb:0x555555bd4d1d =
<ra_timer_handler>)
> >>   Processing Host timers
> >>     clock QEMU_CLOCK_HOST is enabled:true, last:1490191319270134000
> >>   Processing Virtual RT timers
> >>     clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, =
last:-9223372036854775808
> >
> > Timers are processed only at checkpoints recorded in the log.
> > When replay is stuck, probably there is a pending checkpoint in the =
log
> > and pending instructions in CPU (because iothread breaks its
> > synchronization).
>=20
> How does this work for instructions that sleep (like WFI)? The WFI =
will
> cause us to exit the loop but I assume we need a "real" timer to =
trigger
> a firing of whatever the WFI is waiting for as time according to =
icount
> isn't advancing.

This is virtual_rt for. It advances even when vCPU is stopped.

> >> One area I wanted to look back at was comparing the record trace =
from
> >> pre-mttcg-merge to now to see if any information was missing. =
However
> >
> > I usually use in_asm and exec logs and also add some logging at =
replay checkpoints.
> >
> >> the bin file has quite a lot of noise in it from changing fields so =
I
> >> was wondering do you have any sort of dumper tool for comparing the
> >> traces? If not is the format of the trace file specified anywhere?
> >
> > Usually you cannot compare two different record/replay logs, because =
there
> > is no synchronization of the timers in different recording runs and
> > therefore you'll get totally different logs.
>=20
> I wasn't looking to have identical traces but I was interested in the
> patterns in the logs and how they have changed. For example:
>=20
> HEADER: version 0xe02005                                      | =
HEADER: version 0xe02006
> 1:EVENT_CP_INIT                                                 =
1:EVENT_CP_INIT
> 2:EVENT_CLOCK_HOST 0x14afc6687f1fc738                         | =
2:EVENT_CLOCK_HOST
> 0x14b000644239c8d8
> 3:EVENT_CLOCK_HOST 0x14afc66c6ac91858                         | =
3:EVENT_CLOCK_HOST
> 0x14b00064423a1310
> 4:EVENT_CP_RESET no additional data                             =
4:EVENT_CP_RESET no additional
> data
> 5:EVENT_CP_CLOCK_WARP_START no additional data                  =
5:EVENT_CP_CLOCK_WARP_START no
> additional data
> 6:EVENT_CP_CLOCK_VIRTUAL no additional data                   | =
6:EVENT_CP_CLOCK_WARP_START no
> additional data
> 7:EVENT_CP_CLOCK_WARP_START no additional data                | =
7:EVENT_CP_CLOCK_VIRTUAL no
> additional data
> 8:EVENT_CP_CLOCK_VIRTUAL no additional data                   | =
8:EVENT_CP_CLOCK_WARP_ACCOUNT
> no additional data
> 9:EVENT_CP_CLOCK_WARP_START no additional data                | =
9:EVENT_CP_CLOCK_WARP_ACCOUNT
> no additional data
> 10:EVENT_CP_CLOCK_VIRTUAL no additional data                  | =
10:EVENT_INSTRUCTION 0x1000000
> 11:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data               =
11:EVENT_CP_CLOCK_WARP_ACCOUNT
> no additional data
> 12:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data             | =
12:EVENT_INSTRUCTION 0x1000000
> 13:EVENT_INSTRUCTION 0x1000000                                | =
13:EVENT_CP_CLOCK_WARP_ACCOUNT
> no additional data
>=20
> There is a difference to the pattern at the start as the initial
> checkpoints are layed down. I guess this is due to the interaction of
> the main thread with the vCPU as they bounce the BQL with each other.

Yes, this may be caused by changed interaction between the threads.

> I'm wondering why we don't just do all the warp timer management in =
the
> vCPU thread as well?

Because vCPU may sleep and we'll have to setup some timer (virtual_rt as =
now) anyway.



By the way, I made small description of the replay log format
to be later included into docs/replay.txt:

Record/replay log consits of the header and the sequence of execution
events. The header includes 4-byte replay version id and 8-byte reserved
field. Version is updated every time replay log format changes to =
prevent
using replay log created by another build of qemu.

The sequence of the events describes virtual machine state changes.
It includes all non-deterministic inputs of VM, synchronization marks =
and
instruction counts used to correctly inject inputs at replay.

Synchronization marks (checkpoints) are used for synchronizing qemu =
threads
that perform operations with virtual hardware. These operations may =
change
system's state (e.g., change some register or generate interrupt) and
therefore should execute synchronously with CPU thread.

Every event in the log includes 1-byte event id and optional arguments.
When argument is an array, it is stored as 4-byte array length
and corresponding number of bytes with data.
Here is the list of events that are written into the log:

 - EVENT_INSTRUCTION. Instructions executed since last event.
   Argument: 4-byte number of executed instructions.
 - EVENT_INTERRUPT. Used to synchronize interrupt processing.
 - EVENT_EXCEPTION. Used to synchronize exception handling.
 - EVENT_ASYNC. This is a group of events. They are always processed
   together with checkpoints. When such an event is generated, it is
   stored in the queue and processed only when checkpoint occurs.
   Every such event is followed by 1-byte checkpoint id and 1-byte
   async event id from the following list:
     - REPLAY_ASYNC_EVENT_BH. Bottom-half callback. This event =
synchronizes
       callbacks that affect virtual machine state, but normally called
       asyncronously.
       Argument: 8-byte operation id.
     - REPLAY_ASYNC_EVENT_INPUT. Input device event. Contains
       parameters of keyboard and mouse input operations
       (key press/release, mouse pointer movement).
       Arguments: 9-16 bytes depending of input event.
     - REPLAY_ASYNC_EVENT_INPUT_SYNC. Internal input synchronization =
event.
     - REPLAY_ASYNC_EVENT_CHAR_READ. Character (e.g., serial port) =
device input
       initiated by the sender.
       Arguments: 1-byte character device id.
                  Array with bytes were read.
     - REPLAY_ASYNC_EVENT_BLOCK. Block device operation. Used to =
synchronize
       operations with disk and flash drives with CPU.
       Argument: 8-byte operation id.
     - REPLAY_ASYNC_EVENT_NET. Incoming network packet.
       Arguments: 1-byte network adapter id.
                  4-byte packet flags.
                  Array with packet bytes.
 - EVENT_SHUTDOWN. Occurs when user sends shutdown event to qemu,
   e.g., by closing the window.
 - EVENT_CHAR_WRITE. Used to synchronize character output operations.
   Arguments: 4-byte output function return value.
              4-byte offset in the output array.
 - EVENT_CHAR_READ_ALL. Used to synchronize character input operations,
   initiated by qemu.
   Argument: Array with bytes that were read.
 - EVENT_CHAR_READ_ALL_ERROR. Unsuccessful character input operation,
   initiated by qemu.
   Argument: 4-byte error code.
 - EVENT_CLOCK + clock_id. Group of events for host clock read =
operations.
   Argument: 8-byte clock value.
 - EVENT_CHECKPOINT + checkpoint_id. Checkpoint for synchronization of
   CPU, internal threads, and asynchronous input events. May be followed
   by one or more EVENT_ASYNC events.
 - EVENT_END. Last event in the log.


Pavel Dovgalyuk
