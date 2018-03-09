Received: from eggs.gnu.org ([2001:4830:134:3::10]:56670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1euNAs-0003GY-EP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1euNAo-0007dU-L6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:55:26 -0500
Received: from mail5.windriver.com ([192.103.53.11]:41978 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Bill.Paul@windriver.com>)
	id 1euNAo-0007bI-B4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:55:22 -0500
From: Bill Paul <wpaul@windriver.com>
Date: Fri, 9 Mar 2018 10:53:43 -0800
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9T=sydu47UGry2TVOa0gZF8SZLnaaQ5gqzTQmAgm2b1w@mail.gmail.com>
	<20180309182030.GA22836@roeck-us.net>
In-Reply-To: <20180309182030.GA22836@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <201803091053.43494.wpaul@windriver.com>
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>

Of all the gin joints in all the towns in all the world, Guenter Roeck had to 
walk into mine at 10:20 on Friday 09 March 2018 and say:

> On Fri, Mar 09, 2018 at 05:47:16PM +0000, Peter Maydell wrote:
> > On 8 March 2018 at 18:28, Bill Paul <wpaul@windriver.com> wrote:
> > > Anyway, this means that the only reason older Linux kernels worked in
> > > QEMU with the broken interrupt configuration is that they also
> > > registered a handler on vector 151 (119). Even though QEMU could not
> > > send events via GPIO6, it was mistakenly sending them via vector 151,
> > > so it looked like things worked. On real hardware, the older kernels
> > > would have gotten their interrupts via GPIO6 and also worked. The
> > > older kernels would _not_ work if you fix QEMU because now they would
> > > never get interrupts on either vector, unless you fudge things so that
> > > the ENET module triggers both vector 150 and the vector for GPIO6 in
> > > the GIC or patch them to back out the erratum 6678 workaround as later
> > > kernels do.
> > 
> > Thanks for that really useful writeup. So if I understand correctly
> > 
> > we have several choices here:
> >  (1) we could implement a model of the IOMUX block that is at least
> >  sufficient to support guests that configure it to route the ENET
> >  interrupt line to a GPIO pin. Then we could apply this patch that fixes
> >  the ENET line definitions. Old kernels would continue to work (for the
> >  same reason they worked on hardware), and new ones would work now too.
> >  This is in some ways the preferred option, but it's possibly a lot of
> >  code and we're nearly in freeze for 2.12.
> >  
> >  (2) we could leave everything as it is for 2.12. This would mean that
> >  at least we don't regress setups that used to work on older QEMU
> >  versions. Downside is that we wouldn't be able to run Linux v4.15+, or
> >  other guest OSes that don't have the bug that older Linux kernels do.
> >  (Presumably we'd only do this on the understanding that we were going
> >  to go down route (1) for 2.13.)
> >  
> >  (3) we could apply this patch for 2.12. Linux v4.15+ now works, as
> >  do other guest OSes that use the ENET interrupt. v4.1 and older Linux
> >  guests that used to boot in QEMU stop doing so, and 4.2-4.9 boot but
> >  lose the ethernet device support. Perhaps for 2.13 we might
> >  take route (1) to make those older guests start working again.
> > 
> > Do I have that right?
> 
> Pretty much.

There may be a 4th option.

Since older kernels work because they were looking at vector 151, you could 
patch the imx_fec.c module so that when it signals an event for vector 150, it 
also signals vector 151 too. This would keep newer versions of QEMU "bug-
compatible" with older versions while also fixing support for newer Linux 
kernels and other guests (e.g. VxWorks) that follow the hardware spec 
correctly.

I think this would require only a small modification to this function:

static void imx_eth_update(IMXFECState *s)
{
    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_TS_TIMER) {
        qemu_set_irq(s->irq[1], 1);
    } else {
        qemu_set_irq(s->irq[1], 0);
    }

    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_MAC) {
        qemu_set_irq(s->irq[0], 1);
    } else {
        qemu_set_irq(s->irq[0], 0);
    }
}

(For ENET_INT_MAC events, just signal both s->irq[0] and s->irq[1]).

This of course means signaling spurious events on vector 151, but you're doing 
that now anyway. :)

This is much less work than implementing an IOMUX module. Creating an IOMUX 
module for QEMU just for this one fixup would probably be the most elegant 
solution, but adding IOMUX support to QEMU also doesn't make much sense since 
QEMU has no actual pins.

-Bill

> > None of these options seems especially palatable to me, so we're
> > choosing the lesser evil, I think... (unless somebody wants to say
> > that option (1) would be 20 lines of code and here's the patch :-))
> > I guess in the absence of (1) that (3) is better than (2) ?
> 
> I would prefer (2). This is what I decided to use in my "local"
> version of qemu. Older versions of Linux can be fixed by applying one
> (4.2..4.9) or two (4.1 and older) upstream patches; anyone interested
> running those kernels in qemu with Ethernet working should apply those
> patches (or, alternatively, provide a patch adding IOMUX support to
> qemu).
> 
> Thanks,
> Guenter
-- 
=============================================================================
-Bill Paul            (510) 749-2329 | Senior Member of Technical Staff,
                 wpaul@windriver.com | Master of Unix-Fu - Wind River Systems
=============================================================================
   "I put a dollar in a change machine. Nothing changed." - George Carlin
=============================================================================
