Received: from eggs.gnu.org ([2001:4830:134:3::10]:33559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctA7a-000596-91
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctA7X-0001yK-47
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:42:30 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ctA7W-0001wc-QU
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:42:27 -0400
Received: by mail-wm0-x229.google.com with SMTP id o81so18051174wmb.1
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 02:42:26 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000601d2a852$ac5211d0$04f63570$@ru>
Date: Wed, 29 Mar 2017 10:42:23 +0100
Message-ID: <87vaqs4dxc.fsf@linaro.org>
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


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>> >> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>> >> >> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> >> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>> >> >
>> >> >> I ran the following test on both pre-mttcg-merge and my current HEAD
>> >> >> which includes Paolo's fix series:
>> >> >>
>> >> >>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>> >> >>     -append "console=ttyAMA0" -serial mon:stdio \
>> >> >>     -net none \
>> >> >>     -icount shift=7,rr=record,rrfile=replay.bin
>> >> >>
>> >> >> And then:
>> >> >>
>> >> >>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>> >> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>> >> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>> >> >>     -append "console=ttyAMA0" -serial mon:stdio \
>> >> >>     -net none \
>> >> >>     -icount shift=7,rr=replay,rrfile=replay.bin
>> >> >>
>> >> >> And they both ran the same. However I kept running into:
>> >> >>
>> >> >>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> >> >> qemu-system-arm: Missing character write event in the replay log
>> >> >>
>> >> >> This seems to be a pre-existing
>> >> >
>> >> > Does it mean that qemu-arm platform includes some serial devices that were
>> >> > not detected by the replay?
>> >>
>> >> It's the standard ARM platform serial port. When I read replay.txt is
>> >> said:
>> >>
>> >>  * Supports i386, x86_64, and ARM hardware platforms.
>> >>
>> >> Should we add some qualifications about which machine types are
>> >> supported? What is you ARM test case for record/replay?
>> >
>> > I tested on vexpress-a9 platform with Debian wheezy.
>>
>> Thanks for that. I now have a test case that I can reproduce failures on
>> without needing graphics.
>>
>> I've been investigating if there are any problems with the timer
>> processing now they have been moved into the TCG thread. The record
>> stage seems to work fine but I'm having difficulty figuring out why
>> playback freezes. It seems we get to a point where we are stuck waiting
>> for a suspiciously exact timer deadline:
>
> I've encountered the following behavior at replay stage:
> - replay takes some instructions to execute (qemu_icount += counter)
> - virtual timer is fired

This is the virtual timer based on icount not the virtual rt timer? So
under the new scheme of being processed in the vCPU loop we should only
fire this one once all execution is done (although you may exit the loop
early before icount is exhausted).

> - replay puts back unexecuted instructions (qemu_icount -= counter)
>
> But virtual timer cannot take in account non-executed instructions (counter) and
> therefore it reads only qemu_icount, which provides incorrect time.
>
>> But the timers are all enabled:
>>
>>   (gdb) qemu timers
>>   Processing Realtime timers
>>     clock QEMU_CLOCK_REALTIME is enabled:true, last:-9223372036854775808
>>   Processing Virtual timers
>>     clock QEMU_CLOCK_VIRTUAL is enabled:true, last:-9223372036854775808
>>       timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
>>       timer 503290000000/1000000 (cb:0x555555bd4d1d <ra_timer_handler>)
>>   Processing Host timers
>>     clock QEMU_CLOCK_HOST is enabled:true, last:1490191319270134000
>>   Processing Virtual RT timers
>>     clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, last:-9223372036854775808
>
> Timers are processed only at checkpoints recorded in the log.
> When replay is stuck, probably there is a pending checkpoint in the log
> and pending instructions in CPU (because iothread breaks its
> synchronization).

How does this work for instructions that sleep (like WFI)? The WFI will
cause us to exit the loop but I assume we need a "real" timer to trigger
a firing of whatever the WFI is waiting for as time according to icount
isn't advancing.

>
>> One area I wanted to look back at was comparing the record trace from
>> pre-mttcg-merge to now to see if any information was missing. However
>
> I usually use in_asm and exec logs and also add some logging at replay checkpoints.
>
>> the bin file has quite a lot of noise in it from changing fields so I
>> was wondering do you have any sort of dumper tool for comparing the
>> traces? If not is the format of the trace file specified anywhere?
>
> Usually you cannot compare two different record/replay logs, because there
> is no synchronization of the timers in different recording runs and
> therefore you'll get totally different logs.

I wasn't looking to have identical traces but I was interested in the
patterns in the logs and how they have changed. For example:

HEADER: version 0xe02005                                      | HEADER: version 0xe02006
1:EVENT_CP_INIT                                                 1:EVENT_CP_INIT
2:EVENT_CLOCK_HOST 0x14afc6687f1fc738                         | 2:EVENT_CLOCK_HOST 0x14b000644239c8d8
3:EVENT_CLOCK_HOST 0x14afc66c6ac91858                         | 3:EVENT_CLOCK_HOST 0x14b00064423a1310
4:EVENT_CP_RESET no additional data                             4:EVENT_CP_RESET no additional data
5:EVENT_CP_CLOCK_WARP_START no additional data                  5:EVENT_CP_CLOCK_WARP_START no additional data
6:EVENT_CP_CLOCK_VIRTUAL no additional data                   | 6:EVENT_CP_CLOCK_WARP_START no additional data
7:EVENT_CP_CLOCK_WARP_START no additional data                | 7:EVENT_CP_CLOCK_VIRTUAL no additional data
8:EVENT_CP_CLOCK_VIRTUAL no additional data                   | 8:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data
9:EVENT_CP_CLOCK_WARP_START no additional data                | 9:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data
10:EVENT_CP_CLOCK_VIRTUAL no additional data                  | 10:EVENT_INSTRUCTION 0x1000000
11:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data               11:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data
12:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data             | 12:EVENT_INSTRUCTION 0x1000000
13:EVENT_INSTRUCTION 0x1000000                                | 13:EVENT_CP_CLOCK_WARP_ACCOUNT no additional data

There is a difference to the pattern at the start as the initial
checkpoints are layed down. I guess this is due to the interaction of
the main thread with the vCPU as they bounce the BQL with each other.

I'm wondering why we don't just do all the warp timer management in the
vCPU thread as well?

--
Alex Bennée
