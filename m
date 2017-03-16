Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coV6p-0003of-R7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coV6l-0003Uc-PG
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:06:27 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coV6l-0003UO-IZ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:06:23 -0400
Received: by mail-wr0-x236.google.com with SMTP id g10so31544151wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:06:23 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000001d29e30$138e5700$3aab0500$@ru>
Date: Thu, 16 Mar 2017 13:06:40 +0000
Message-ID: <871stxpdzz.fsf@linaro.org>
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
>> >> >> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-
>> >> request@listserver.greensocs.com]
>> >> >>
>> >> >> The next thing on my list it to look at the icount problems and review
>> >> >> Paolo's fixes for it. However those fixes should go in a separate
>> >> >> series and I assume via Paolo's tree.
>> >> >
>> >> > Do you mean those problems that completely broke icount?
>> >>
>> >> Completely broke is a bit strong. Certainly I tested icount on my
>> >> patches but I missed the pathological failure mode that led to the
>> >> interaction between the BQL lock breaking patch and running a real
>> >> guest. It didn't break icount so much as slow down guests so much they
>> >> never got round to finishing their IRQ handling.
>> >
>> > That might look as slowing down in regular icount mode.
>> > But it becomes non-deterministic in record/replay mode.
>> > Therefore none of the recorded scenarios may be replayed.
>> >
>> > I tried the simplest command lines:
>> >
>> > qemu-system-i386.exe -icount shift=7,rr=record,rrfile=replay.bin -net
>> > none
>>
>> Running this against 2421f381dc (pre-merge of MTTCG) from the source
>> tree generates no output. My command is on Linux:
>>
>>   /x86_64-softmmu/qemu-system-x86_64 -icount shift=7,rr=record,rrfile=replay.bin -net none
>>
>> Do I need to specify the BIOS manually?
>
> No, this command line works well for me. BIOS executes and shows some messages.
> Do you have any graphical output for QEMU?

Ahh I was running remotely. OK I can now get output on the graphics
display and the described hang. I'll have a look at it.

>
>> > qemu-system-i386.exe -icount shift=7,rr=replay,rrfile=replay.bin -net none
>> >
>> > First one was used to record execution until BIOS will print its startup info.
>> > The second one is for replay, but it can replay about 200000 instructions
>> > until the problems with icount manifest itself - the execution does
>> > not proceed.
>>
>> What error message does it give? How do you know how many instructions
>> have been executed?
>
> It hangs after executing about 200000 instructions.
> I checked -d exec logs.
>
>> I ran the following test on both pre-mttcg-merge and my current HEAD
>> which includes Paolo's fix series:
>>
>>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>>     -append "console=ttyAMA0" -serial mon:stdio \
>>     -net none \
>>     -icount shift=7,rr=record,rrfile=replay.bin
>>
>> And then:
>>
>>  ./arm-softmmu/qemu-system-arm -machine type=virt \
>>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
>>     -kernel ../images/aarch32-current-linux-initrd-guest.img
>>     -append "console=ttyAMA0" -serial mon:stdio \
>>     -net none \
>>     -icount shift=7,rr=replay,rrfile=replay.bin
>>
>> And they both ran the same. However I kept running into:
>>
>>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> qemu-system-arm: Missing character write event in the replay log
>>
>> This seems to be a pre-existing
>
> Does it mean that qemu-arm platform includes some serial devices that were
> not detected by the replay?

It's the standard ARM platform serial port. When I read replay.txt is
said:

 * Supports i386, x86_64, and ARM hardware platforms.

Should we add some qualifications about which machine types are
supported? What is you ARM test case for record/replay?

--
Alex Bennée
