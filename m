Received: from eggs.gnu.org ([2001:4830:134:3::10]:60268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXswR-0000wv-FE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXswQ-0004tc-4R
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:43:51 -0400
Date: Tue, 26 Jun 2018 11:43:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180626184341.GA5039@roeck-us.net>
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

I had added some debug messages into the timer code and noticed
the behavior. If I recall correctly, for periodic timers, the timer
period counts down in ptimer_reload(). At some point, it reaches
zero, and the timer stops working. The behavior is different
between one-shot and periodic timers; I think that count-down
does not happen with one-shot timers. This also has to do with the
timer limit which is 0 for one-shot timers but != 0 for periodic
timers and is used in various locations in hw/core/ptimer.c.

This was with Cortex-M3 where you said you won't accept my patches
to add initrd/dtb/bios support, so the qemu version would not be
an official one and has functionality not available in upstream qemu
(it has other changes but those are relevant for reproducing the
problem). My qemu clone is at git@github.com:groeck/qemu.git in branch
v2.12.0-local. It includes this patch. The test scripts are at
git@github.com:groeck/linux-build-test.git, in the rootfs/arm/
subdirectory.

I can try to reproduce it myself tonight and send you a log,
but no promises.

Guenter

> >> periodic timer if the reload register is written with a nonzero
> >> value before the timer expires (and that if that happens after
> >> the timer expired that we restart the timer). Thinking about
> >> this is also on my todo list.
> >>
> >
> > I thought that was handled in the Linux driver by disabling
> > the timer, updating the period, and then re-enabling it in
> > periodic mode, but I may have misinterpreted the code.
> 
> Yeah, it would depend what the guest does whether it's affected,
> but my reading of the data sheet is that messing with the reload
> register with the timer still active isn't prohibited.
> 
> thanks
> -- PMM
