Received: from eggs.gnu.org ([2001:4830:134:3::10]:39464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPv3-0005bl-8t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPv0-0008AR-1Y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:49 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnPuz-00089S-QC
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:45 -0400
Received: by mail-wr0-x22c.google.com with SMTP id g10so103509034wrg.2
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:21:45 -0700 (PDT)
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
	<000601d29710$edf987b0$c9ec9710$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000601d29710$edf987b0$c9ec9710$@ru>
Date: Mon, 13 Mar 2017 13:21:59 +0000
Message-ID: <874lyxqpl4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: "'Nutaro, James J.'" <nutarojj@ornl.gov>, mttcg@listserver.greensocs.com, pbonzini@redhat.com, qemu-devel@nongnu.org


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> I also encountered icount problems with new MTTCG patches.
>
> Record/replay now cannot work, because iothread requests timers
> without kicking the CPU. And cpu thread updates icount (that
> are used for the clock).

The interaction of kicking the vCPU while grabbing the BQL was a
side-effect. This is now done explicitly for single-threaded emulation
by (6546706d28):

  tcg: add kick timer for single-threaded vCPU emulation

> Therefore invocation of iothread uses incorrect clock and
> all virtual timers behave incorrectly.
>
> Record/replay is also broken because current icount is requested
> from iothread where current_cpu (and icount progress stored in icount_extra)
> is unavailable.

I'm working through Paolo's series now but I don't see it as
insurmountable. The aim of keeping current_cpu set only during the
cpu-exec loop was intentional because the system as a whole can't make
assumptions about it always being valid.

>
> Pavel Dovgalyuk
>
>> -----Original Message-----
>> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
>> On Behalf Of Nutaro, James J.
>> Sent: Friday, March 03, 2017 10:39 PM
>> To: 'mttcg@listserver.greensocs.com'
>> Cc: 'qemu-devel@nongnu.org'
>> Subject: RE: -rtc clock=vm with -icount 1,sleep=off introduces unexpected delays in device
>> interactions
>>
>> My original problem seems to stem from something that changed in the way that device emulation
>> and instruction execution interact (I'm guessing). To reproduce the issue, I started a linux
>> image with
>>
>> qemu-system-i386 -rtc clock=vm -monitor none -icount 1,sleep=off jack.img
>>
>> After booting, I run
>>
>> ping localhost
>>
>> The first round trip time reports look reasonable, being in the millisecond to sub-millisecond
>> range. These occur while the emulator is running slower than real time.
>>
>> After a bit, the emulator speeds up (skipping over idle periods during I/O?) and the round
>> trip times jump to hundreds of milliseconds, which I had not expected.
>>
>> If you want to try this experiment yourself, you can get the disk image that I used from here:
>>
>> http://www.ornl.gov/~1qn/qemu-images/jack.img
>>
>>
>> Jim


--
Alex Bennée
