Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fa1g9-0000OU-J2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fa1g8-000109-7U
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:27:53 -0400
Date: Mon, 2 Jul 2018 09:27:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180702162733.GB32333@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 02, 2018 at 04:05:54PM +0100, Peter Maydell wrote:
> On 26 June 2018 at 21:00, Guenter Roeck <linux@roeck-us.net> wrote:
> > Here is a log, with debug messages added to ptimer code.
> 
> Thanks for the logging. (I am currently also messing about
> with buildroot to try to reproduce -- I have a kernel that
> boots, but since it has no initial filesystem it hits the
> "stop because I can't find init" before anything interesting
> happens.)
> 
> > Without my patch:
> >
> > ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
> > ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
> > ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
> > ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
> > [    0.497942] clocksource: Switched to clocksource mps2-clksrc^M
> > ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
> > ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
> >
> > # up to here timer is in periodic mode and fires on a regular basis
> >
> > # prepare to switch to one-shot mode
> > ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=0
> >
> > # set timer for one-shot mode, start
> > ptimer_set_count(0x555556edac70, 92004
> > ptimer_reload(555556edac70): frac=0 period=40 delta=92004 limit=0 adjust=0
> >
> > # one-shot mode fires
> > ptimer_tick(0x555556edac70): enabled=1 delta=92004 limit=0
> >
> > # timer is in periodic mode, limit is 0 (from one-shot mode)
> > # reload propagates limit -> delta, making it 0
> > ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1
> >
> > # and the timer is disabled as result.
> > 0x555556edac70: Timer with delta zero, disabling
> >
> > ptimer_set_count(0x555556edac70, 199340
> > ptimer_reload(555556edac70): frac=0 period=40 delta=199340 limit=0 adjust=0
> > [    0.514458] NET: Registered protocol family 2^M
> > ptimer_tick(0x555556edac70): enabled=1 delta=199340 limit=0
> > ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1
> > 0x555556edac70: Timer with delta zero, disabling
> > ptimer_set_count(0x555556edac70, 240488
> > ptimer_reload(555556edac70): frac=0 period=40 delta=240488 limit=0 adjust=0
> > [    0.526096] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096
> > bytes)^M
> > [    0.526533] TCP established hash table entries: 1024 (order: 0, 4096 bytes)^M
> > [    0.526943] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)^M
> > ptimer_tick(0x555556edac70): enabled=1 delta=240488 limit=0
> > ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1
> > 0x555556edac70: Timer with delta zero, disabling
> 
> OK, but I can't see anything actually going wrong here. Once
> the guest sets the RELOAD register to 0, it gets one-shot timers, and
> needs to write to VALUE each time to restart the timer. We seem to get
> calls to set_count which set different counts, and a a tick for each
> set_count, so that looks like it's working to me. (But see below...)
> 

Sometimes the timer doesn't fire or is not reloaded when expected, causing
the system to stall. It also seemed to me that the timer fires at the wrong
time, ie at the period instead of the selected one-time value, but I may
misinterpret the log.

> > And so on. The system may finish booting or lock up. Which one it is seems
> > to be random.
> >
> > Same log with my patch applied:
> >
> > ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
> > ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
> >
> > # switch to one-shot mode
> > ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=0
> >
> > @ set counter, start
> > ptimer_set_count(0x555556edac70, 24
> > ptimer_reload(555556edac70): frac=0 period=40 delta=24 limit=0 adjust=0
> >
> > # tick
> > ptimer_tick(0x555556edac70): enabled=2 delta=24 limit=0
> >
> > # update counter, restart
> > ptimer_set_count(0x555556edac70, 209498
> > ptimer_reload(555556edac70): frac=0 period=40 delta=209498 limit=0 adjust=0
> > [    0.509883] NET: Registered protocol family 2^M
> >
> > # tick
> > ptimer_tick(0x555556edac70): enabled=2 delta=209498 limit=0
> >
> > # update counter, restart
> > ptimer_set_count(0x555556edac70, 217500
> > ptimer_reload(555556edac70): frac=0 period=40 delta=217500 limit=0 adjust=0
> >
> > # tick
> > ptimer_tick(0x555556edac70): enabled=2 delta=217500 limit=0
> 
> This doesn't seem to be behaving any differently (apart from
> having silenced the fprintf about the zero delta).
> 
> My reading of the code in ptimer_tick() is that the behaviour
> for "this was setup as a one-shot" is in effect the same as
> for "this was setup as periodic but the reload value is 0"
> is the same: it sets enabled to 0 and delta to 0.
> 

To me the second log looks more predictive than the first, but that
may just be me.

Again, in my observation the boot sometimes stalls without my
patch. Maybe there is a better fix, but the code as-is doesn't
work for me. All I can say is that the current code does not set
one-shot mode when it should, and that seems wrong.

You could of course take out the zero delta warning. Personally
I would caution against that - whenever I have seen that warning,
it suggested that something is wrong with the emulation, and it
helped me track down the problem. Your call, of course. Also,
I don't think taking out the warning would fix my stall problem.

Thanks,
Guenter

> One thing I do notice reading the code is that we don't
> actually do anything to re-enable the timer on a write to
> the VALUE register. We call ptimer_set_count(), but that will
> not reenable the timer if it was disabled -- the cmsdk timer
> code needs to call ptimer_run() if necessary, I think. But
> that bug should manifest whether we're setting the timer up
> as a one-shot or as a periodic with a 0 limit, because
> ptimer_tick() will disable the timer when it fires whichever
> way we do that.
> 
> thanks
> -- PMM
