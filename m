Received: from eggs.gnu.org ([2001:4830:134:3::10]:59996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEhID-0006lw-2z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEhIA-00017Q-0Y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:50:13 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEhI9-00017E-Sz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:50:09 -0500
Received: by mail-io0-f193.google.com with SMTP id s82so15544064ioi.3
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 10:50:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAP5jUk10i4P0x99n6+yXvDfR=ExN0jxyvF2_Ur_82N1_JTWgxg@mail.gmail.com>
References: <CAP5jUk10i4P0x99n6+yXvDfR=ExN0jxyvF2_Ur_82N1_JTWgxg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 Dec 2016 18:49:08 +0000
Message-ID: <CAJSP0QWj_PB_=ChXOO=PGTdsSRXvRG4CmA1-yvkPrBVomS5Q0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Slow qemu guest performance after host is resumed
 from suspended state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ruslan Habalov <3v0n1d3@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>

On Sun, Dec 4, 2016 at 10:52 PM, Ruslan Habalov <3v0n1d3@gmail.com> wrote:
> Hi everyone,
>
> I'm having the following qemu issue since about February on Xubuntu.
>
> Steps to reproduce:
> 1) Boot host and boot qemu guest - everything works perfect
> 2) Shutdown qemu guest
> 3) Suspend host and resume host
> 4) Boot qemu guest again - the guest is now extremely slow
>
> Current system setup:
> host: kernel 4.8.0-27-generic (also reproducible with older kernel versions)
> qemu guest: Linux or Windows affected (tested both)
>
> I've tried to debug the issue on my own with the following results:
> ------------------------------------------------------------------------------------------------------------------------------
> https://www.evonide.com/images/qemu_problem.png
> - This shows "perf top $QEMU_PID" from guest boot to shutdown for three
> different scenarios:
>   Left: normal guest behavior after fresh boot of host system
>   Middle: very slow guest after host was suspended and resumed
>   Right: test run with disabled HPET (since I initially assumed some
> problems with HPET)
>
> https://www.evonide.com/images/qemu_hpet_investigation.png
> - Results of "perf record -g" and "perf report"
>   According to stefanha (qemu IRC) this doesn't seem to indicate any error
> sources.
>
> https://www.evonide.com/images/qemu_vm_exit_healthy_vs_unhealthy.png
> - Results of running: "perf record -a -e kvm:kvm_exit" and "perf
> report" from guest boot to shutdown
>   - Left: normal situation (after fresh host boot)
>   - Right: bad situation    (after suspend and resume on host and boot of
> qemu guest)
>   There were ~300 out of order events reported by perf for the "bad"
> scenario (vs. only 2 for the "good" scenario).
> ------------------------------------------------------------------------------------------------------------------------------
> I was also recommended to check the host timers (e.g. /proc/timer_list).
> However, this file has more than 800 lines and I am unsure what to look for.
>
> Please let me know if you need further information on this issue.

Unfortunately I don't see an obvious pattern in the kvm_exit reasons.
Maybe someone on kvm@vger.kernel.org can help, I have CCed the list.

One idea that might explain the read_hpet trace you collected is an
interrupt storm.  That means an interrupt is firing all the time
without doing useful work.  This could explain why the vcpu keeps
halting (leading to many ktime_get() calls on the host).

You can check the interrupt storm theory by collecting
/proc/interrupts on the host and inside the guest.  If you compare the
healthy system against the slowed system there might be an obvious
difference in the interrupt counters.  That would allow you to track
down which device keeps firing an interrupt.

Stefan
