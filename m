Received: from eggs.gnu.org ([2001:4830:134:3::10]:59169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqh5B-0002GK-JD
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqh56-0008Dm-Un
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:17:49 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cqh56-0008Di-LJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:17:44 -0400
Received: by mail-wr0-x230.google.com with SMTP id g10so130496591wrg.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 07:17:44 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <002501d29e64$27b383c0$771a8b40$@ru>
Date: Wed, 22 Mar 2017 14:17:41 +0000
Message-ID: <87inn1xunu.fsf@linaro.org>
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

>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>> >> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>> >
>> >> I ran the following test on both pre-mttcg-merge and my current HEAD
>> >> which includes Paolo's fix series:
>> >>
>> >>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>> >>     -append "console=ttyAMA0" -serial mon:stdio \
>> >>     -net none \
>> >>     -icount shift=7,rr=record,rrfile=replay.bin
>> >>
>> >> And then:
>> >>
>> >>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>> >>     -append "console=ttyAMA0" -serial mon:stdio \
>> >>     -net none \
>> >>     -icount shift=7,rr=replay,rrfile=replay.bin
>> >>
>> >> And they both ran the same. However I kept running into:
>> >>
>> >>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> >> qemu-system-arm: Missing character write event in the replay log
>> >>
>> >> This seems to be a pre-existing
>> >
>> > Does it mean that qemu-arm platform includes some serial devices that were
>> > not detected by the replay?
>>
>> It's the standard ARM platform serial port. When I read replay.txt is
>> said:
>>
>>  * Supports i386, x86_64, and ARM hardware platforms.
>>
>> Should we add some qualifications about which machine types are
>> supported? What is you ARM test case for record/replay?
>
> I tested on vexpress-a9 platform with Debian wheezy.

Thanks for that. I now have a test case that I can reproduce failures on
without needing graphics.

I've been investigating if there are any problems with the timer
processing now they have been moved into the TCG thread. The record
stage seems to work fine but I'm having difficulty figuring out why
playback freezes. It seems we get to a point where we are stuck waiting
for a suspiciously exact timer deadline:

  replay_account_executed_instructions: instructions_count reached zero
  handle_icount_deadline: deadline=471077745280
  replay_account_executed_instructions: instructions_count reached zero
  handle_icount_deadline: deadline=10000000
  [Switching to Thread 0x7fff7a7be700 (LWP 733)]

  Thread 3 "qemu-system-arm" hit Breakpoint 1, handle_icount_deadline () at /home/alex/lsrc/qemu/qemu.git/cpus.c:1184
  1184                    fprintf(stderr,"%s: no change to deadline=%ld for %ld\n",
  (gdb) c
  Continuing.
  handle_icount_deadline: no change to deadline=10000000 for 11

  Thread 3 "qemu-system-arm" hit Breakpoint 1, handle_icount_deadline () at /home/alex/lsrc/qemu/qemu.git/cpus.c:1184
  1184                    fprintf(stderr,"%s: no change to deadline=%ld for %ld\n",
  (gdb) c 10
  Will ignore next 9 crossings of breakpoint 1.  Continuing.
  handle_icount_deadline: no change to deadline=10000000 for 12
  handle_icount_deadline: no change to deadline=10000000 for 13
  handle_icount_deadline: no change to deadline=10000000 for 14
  handle_icount_deadline: no change to deadline=10000000 for 15
  handle_icount_deadline: no change to deadline=10000000 for 16
  handle_icount_deadline: no change to deadline=10000000 for 17
  handle_icount_deadline: no change to deadline=10000000 for 18
  handle_icount_deadline: no change to deadline=10000000 for 19
  handle_icount_deadline: no change to deadline=10000000 for 20
  handle_icount_deadline: no change to deadline=10000000 for 21

  (gdb) p replay_state
  $1 = {cached_clock = {1490191319270134000, 0}, current_step = 267869922, instructions_count = 0, data_kind = 12, has_unread_data = 1, file_offset = 0, block_request_id = 0}

But the timers are all enabled:

  (gdb) qemu timers
  Processing Realtime timers
    clock QEMU_CLOCK_REALTIME is enabled:true, last:-9223372036854775808
  Processing Virtual timers
    clock QEMU_CLOCK_VIRTUAL is enabled:true, last:-9223372036854775808
      timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
      timer 503290000000/1000000 (cb:0x555555bd4d1d <ra_timer_handler>)
  Processing Host timers
    clock QEMU_CLOCK_HOST is enabled:true, last:1490191319270134000
  Processing Virtual RT timers
    clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, last:-9223372036854775808

One area I wanted to look back at was comparing the record trace from
pre-mttcg-merge to now to see if any information was missing. However
the bin file has quite a lot of noise in it from changing fields so I
was wondering do you have any sort of dumper tool for comparing the
traces? If not is the format of the trace file specified anywhere?

I found:
  #define REPLAY_VERSION              0xe02005

but couldn't find any more than that. Is the format basically just
described by the calls to replay_put_byte?

--
Alex Bennée
