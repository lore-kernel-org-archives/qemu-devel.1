Received: from eggs.gnu.org ([2001:4830:134:3::10]:41066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cl99k-0007EW-BV
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cl99f-0001qL-Md
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:03:36 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47848)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cl99f-0001qE-G0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:03:31 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
In-Reply-To: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
Date: Tue, 7 Mar 2017 10:03:30 +0300
Message-ID: <000601d29710$edf987b0$c9ec9710$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: "'Nutaro, James J.'" <nutarojj@ornl.gov>, mttcg@listserver.greensocs.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

I also encountered icount problems with new MTTCG patches.

Record/replay now cannot work, because iothread requests timers
without kicking the CPU. And cpu thread updates icount (that
are used for the clock).

Therefore invocation of iothread uses incorrect clock and
all virtual timers behave incorrectly.

Record/replay is also broken because current icount is requested
from iothread where current_cpu (and icount progress stored in icount_extra)
is unavailable.

Pavel Dovgalyuk

> -----Original Message-----
> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
> On Behalf Of Nutaro, James J.
> Sent: Friday, March 03, 2017 10:39 PM
> To: 'mttcg@listserver.greensocs.com'
> Cc: 'qemu-devel@nongnu.org'
> Subject: RE: -rtc clock=vm with -icount 1,sleep=off introduces unexpected delays in device
> interactions
> 
> My original problem seems to stem from something that changed in the way that device emulation
> and instruction execution interact (I'm guessing). To reproduce the issue, I started a linux
> image with
> 
> qemu-system-i386 -rtc clock=vm -monitor none -icount 1,sleep=off jack.img
> 
> After booting, I run
> 
> ping localhost
> 
> The first round trip time reports look reasonable, being in the millisecond to sub-millisecond
> range. These occur while the emulator is running slower than real time.
> 
> After a bit, the emulator speeds up (skipping over idle periods during I/O?) and the round
> trip times jump to hundreds of milliseconds, which I had not expected.
> 
> If you want to try this experiment yourself, you can get the disk image that I used from here:
> 
> http://www.ornl.gov/~1qn/qemu-images/jack.img
> 
> 
> Jim
