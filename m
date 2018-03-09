Received: from eggs.gnu.org ([2001:4830:134:3::10]:60713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1euRzZ-0007HA-Fp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 19:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1euRzV-0003Sv-FR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 19:04:05 -0500
Received: from mail1.windriver.com ([147.11.146.13]:49340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Bill.Paul@windriver.com>)
	id 1euRzV-0003H4-13
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 19:04:01 -0500
From: Bill Paul <wpaul@windriver.com>
Date: Fri, 9 Mar 2018 15:03:15 -0800
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<201803091053.43494.wpaul@windriver.com>
	<20180309213832.GA8594@roeck-us.net>
In-Reply-To: <20180309213832.GA8594@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <201803091503.16120.wpaul@windriver.com>
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
walk into mine at 13:38 on Friday 09 March 2018 and say:

[...]
> > > > Do I have that right?
> > > 
> > > Pretty much.
> > 
> > There may be a 4th option.
> > 
> > Since older kernels work because they were looking at vector 151, you
> > could patch the imx_fec.c module so that when it signals an event for
> > vector 150, it also signals vector 151 too. This would keep newer
> > versions of QEMU "bug- compatible" with older versions while also fixing
> > support for newer Linux kernels and other guests (e.g. VxWorks) that
> > follow the hardware spec correctly.
> > 
> > I think this would require only a small modification to this function:
> > 
> > static void imx_eth_update(IMXFECState *s)
> > {
> > 
> >     if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_TS_TIMER) {
> >     
> >         qemu_set_irq(s->irq[1], 1);
> >     
> >     } else {
> >     
> >         qemu_set_irq(s->irq[1], 0);
> >     
> >     }
> >     
> >     if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_MAC) {
> >     
> >         qemu_set_irq(s->irq[0], 1);
> >     
> >     } else {
> >     
> >         qemu_set_irq(s->irq[0], 0);
> >     
> >     }
> > 
> > }
> > 
> > (For ENET_INT_MAC events, just signal both s->irq[0] and s->irq[1]).
> 
> Now this is an excellent idea.
> 
> > This of course means signaling spurious events on vector 151, but you're
> > doing that now anyway. :)
> 
> Actually, it doesn't. It looks like the first interrupt is handled,
> resetting the interrupt status, and the second interrupt is never even
> executed. I tested this with all kernel releases back to v3.16.

I just did a quick test with your patch and I can confirm that VxWorks 7 also 
works correctly.

-Bill

> I'll send out patch v2 with this change and let Peter decide which version
> to apply.
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
