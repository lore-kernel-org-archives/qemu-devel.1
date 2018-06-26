Received: from eggs.gnu.org ([2001:4830:134:3::10]:46727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXsFB-0004Yj-Ap
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXsFA-0002fv-HW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:59:09 -0400
Date: Tue, 26 Jun 2018 10:59:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180626175900.GA4307@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
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

On Tue, Jun 26, 2018 at 06:17:44PM +0100, Peter Maydell wrote:
> On 19 June 2018 at 03:08, Guenter Roeck <linux@roeck-us.net> wrote:
> > The CMSDK APB timer is currently always configured as periodic timer.
> > This results in the following messages when trying to boot Linux.
> >
> > Timer with delta zero, disabling
> >
> > If the timer limit set with the RELOAD command is 0, the timer
> > needs to be enabled as one-shot timer.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/timer/cmsdk-apb-timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
> > index 9878746..79c1b49 100644
> > --- a/hw/timer/cmsdk-apb-timer.c
> > +++ b/hw/timer/cmsdk-apb-timer.c
> > @@ -119,7 +119,7 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
> >          }
> >          s->ctrl = value & 0xf;
> >          if (s->ctrl & R_CTRL_EN_MASK) {
> > -            ptimer_run(s->timer, 0);
> > +            ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
> >          } else {
> >              ptimer_stop(s->timer);
> >          }
> > --
> > 2.7.4
> 
> Thanks for this patch. I was wondering whether it would be better
> just to remove the fprintf message instead. I'll either apply
> this or send a patch to do that before 3.0, anyway.
> 

If I recall correctly, I tried that, and it did not help.
The messages don't happen too often, and the message itself
does not cause a problem. Issue is that the interrupts happen
at the wrong time or not at all (after a while, ie after the
configured one-shot time expires), and the kernel really doesn't
like that.

I think the underlying problem was that the periodic timer counts
the period down (based on the time set for the one-shot timer),
stops with the "Timer with delta zero, disabling" message once
the period reaches 0, and does not fire anymore afterwards.
As a result, the kernel fails to boot maybe 90% of the time.
I should probably have mentioned that in more detail in the
commit log.

> I think we also want to make sure we convert back to a
> periodic timer if the reload register is written with a nonzero
> value before the timer expires (and that if that happens after
> the timer expired that we restart the timer). Thinking about
> this is also on my todo list.
> 

I thought that was handled in the Linux driver by disabling
the timer, updating the period, and then re-enabling it in
periodic mode, but I may have misinterpreted the code.

Guenter
