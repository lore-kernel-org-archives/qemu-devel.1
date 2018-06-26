Received: from eggs.gnu.org ([2001:4830:134:3::10]:50589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXu8Z-00036u-JJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXu8Y-0004sv-D0
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:00:27 -0400
Date: Tue, 26 Jun 2018 13:00:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180626200008.GA680@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
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

On Tue, Jun 26, 2018 at 07:10:45PM +0100, Peter Maydell wrote:
> On 26 June 2018 at 18:59, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Jun 26, 2018 at 06:17:44PM +0100, Peter Maydell wrote:
> >> Thanks for this patch. I was wondering whether it would be better
> >> just to remove the fprintf message instead. I'll either apply
> >> this or send a patch to do that before 3.0, anyway.
> >>
> >
> > If I recall correctly, I tried that, and it did not help.
> > The messages don't happen too often, and the message itself
> > does not cause a problem. Issue is that the interrupts happen
> > at the wrong time or not at all (after a while, ie after the
> > configured one-shot time expires), and the kernel really doesn't
> > like that.
> >
> > I think the underlying problem was that the periodic timer counts
> > the period down (based on the time set for the one-shot timer),
> > stops with the "Timer with delta zero, disabling" message once
> > the period reaches 0, and does not fire anymore afterwards.
> > As a result, the kernel fails to boot maybe 90% of the time.
> > I should probably have mentioned that in more detail in the
> > commit log.
> 
> Hmm, that's odd, because I don't really see what the difference
> between the two is. If you set the thing as a one-shot then we
> won't reenable the timer later either with this patch.
> 
> Can you provide an image/QEMU command line that repros this,
> and I'll see if I can find time to investigate it? (We have
> a softfreeze deadline next Tuesday, so I probably won't be
> able to get to it until after that, but since this is a bugfix
> it doesn't have to be done before freeze.)
> 

Here is a log, with debug messages added to ptimer code.

Without my patch:

ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1
[    0.497942] clocksource: Switched to clocksource mps2-clksrc^M
ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1

# up to here timer is in periodic mode and fires on a regular basis

# prepare to switch to one-shot mode
ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=0

# set timer for one-shot mode, start
ptimer_set_count(0x555556edac70, 92004
ptimer_reload(555556edac70): frac=0 period=40 delta=92004 limit=0 adjust=0

# one-shot mode fires
ptimer_tick(0x555556edac70): enabled=1 delta=92004 limit=0

# timer is in periodic mode, limit is 0 (from one-shot mode)
# reload propagates limit -> delta, making it 0
ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1

# and the timer is disabled as result.
0x555556edac70: Timer with delta zero, disabling

ptimer_set_count(0x555556edac70, 199340
ptimer_reload(555556edac70): frac=0 period=40 delta=199340 limit=0 adjust=0
[    0.514458] NET: Registered protocol family 2^M
ptimer_tick(0x555556edac70): enabled=1 delta=199340 limit=0
ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1
0x555556edac70: Timer with delta zero, disabling
ptimer_set_count(0x555556edac70, 240488
ptimer_reload(555556edac70): frac=0 period=40 delta=240488 limit=0 adjust=0
[    0.526096] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096
bytes)^M
[    0.526533] TCP established hash table entries: 1024 (order: 0, 4096 bytes)^M
[    0.526943] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)^M
ptimer_tick(0x555556edac70): enabled=1 delta=240488 limit=0
ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=-1
0x555556edac70: Timer with delta zero, disabling

And so on. The system may finish booting or lock up. Which one it is seems
to be random.

Same log with my patch applied:

ptimer_tick(0x555556edac70): enabled=1 delta=250000 limit=250000
ptimer_reload(555556edac70): frac=0 period=40 delta=250000 limit=250000 adjust=1

# switch to one-shot mode
ptimer_reload(555556edac70): frac=0 period=40 delta=0 limit=0 adjust=0

@ set counter, start
ptimer_set_count(0x555556edac70, 24
ptimer_reload(555556edac70): frac=0 period=40 delta=24 limit=0 adjust=0

# tick
ptimer_tick(0x555556edac70): enabled=2 delta=24 limit=0

# update counter, restart
ptimer_set_count(0x555556edac70, 209498
ptimer_reload(555556edac70): frac=0 period=40 delta=209498 limit=0 adjust=0
[    0.509883] NET: Registered protocol family 2^M

# tick
ptimer_tick(0x555556edac70): enabled=2 delta=209498 limit=0

# update counter, restart
ptimer_set_count(0x555556edac70, 217500
ptimer_reload(555556edac70): frac=0 period=40 delta=217500 limit=0 adjust=0

# tick
ptimer_tick(0x555556edac70): enabled=2 delta=217500 limit=0

# update counter, restart
ptimer_set_count(0x555556edac70, 236941
ptimer_reload(555556edac70): frac=0 period=40 delta=236941 limit=0 adjust=0
[    0.529228] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)^M
[    0.529661] TCP established hash table entries: 1024 (order: 0, 4096 bytes)^M
[    0.530059] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)^M
[    0.530535] TCP: Hash tables configured (established 1024 bind 1024)^M

# tick
ptimer_tick(0x555556edac70): enabled=2 delta=236941 limit=0

# update counter, restart
ptimer_set_count(0x555556edac70, 245934
ptimer_reload(555556edac70): frac=0 period=40 delta=245934 limit=0 adjust=0

and so on.

Hope this helps,

Guenter
