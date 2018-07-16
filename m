Received: from eggs.gnu.org ([2001:4830:134:3::10]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff69O-0000l2-PA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff69N-0002r9-Eb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:15:02 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Jul 2018 09:14:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180716161452.GA22620@roeck-us.net>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_k7Pq8MCJ+hEMO-9q=A=GkmjMgE-S1o4oU9MG-KLdPOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_k7Pq8MCJ+hEMO-9q=A=GkmjMgE-S1o4oU9MG-KLdPOw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] hw: arm: Add basic support for cprman
 (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>

On Mon, Jul 16, 2018 at 03:33:15PM +0100, Peter Maydell wrote:
> On 15 July 2018 at 23:06, Guenter Roeck <linux@roeck-us.net> wrote:
> > Add basic support for BCM283x CPRMAN. Provide support for reading and
> > writing CPRMAN registers and initialize registers with sensible default
> > values. During runtime retain any written values.
> >
> > Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
> > and raspi3 systems.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > I don't seriously expect this patch to get accepted, but I thought
> > it might be valuable enough for others to use it when playing with
> > raspi2 and raspi3 emulations.
> 
> Looking around I guess that a stub version of this device is
> worth having. It's not like we'd be wiring up the clock control
> information to anything anyway, given that QEMU doesn't much
> care about clocks...
> 
> > +#define CM_GNRICCTL        (0x000 / 4)
> > +#define CM_VECCTL        (0x0f8 / 4)
> > +#define CM_DFTCTL        (0x168 / 4)
> > +#define CM_EMMCCTL        (0x1c0 / 4)
> > +#define A2W_PLLA_CTRL        (0x1100 / 4)
> > +#define A2W_PLLB_CTRL        (0x11e0 / 4)
> 
> The information at https://elinux.org/BCM2835_registers#CM
> and https://elinux.org/BCM2835_registers#A2W
> suggests that the A2W is a separate thing from the CPRMAN...
>

Both are used together to define individual clocks in the Linux clock
driver (each clock has a CM register and a matching A2W register), so
they must be associated to each other. It might or might not make sense
to treat them as separate devices in qemu. Hard to say without datasheet.

> > +static void bcm2835_cprman_reset(DeviceState *dev)
> > +{
> > +    BCM2835CprmanState *s = BCM2835_CPRMAN(dev);
> > +    int i;
> > +
> > +    /*
> > +     * Available information suggests that CPRMAN registers have default
> > +     * values which are not overwritten by ROMMON (u-boot). The hardware
> > +     * default values are unknown at this time.
> > +     * The default values selected here are necessary and sufficient
> > +     * to boot Linux directly (on raspi2 and raspi3). The selected
> > +     * values enable all clocks and set clock rates to match their
> > +     * parent rates.
> > +     */
> > +    for (i = CM_GNRICCTL; i <= CM_VECCTL; i += 2) {
> > +        s->regs[i] = 0x11;
> > +        s->regs[i + 1] = 0x1000;
> > +    }
> > +    for (i = CM_DFTCTL; i <= CM_EMMCCTL; i += 2) {
> > +        s->regs[i] = 0x11;
> > +        s->regs[i + 1] = 0x1000;
> > +    }
> 
> If you believe the register lists from the links above this
> loop will set CM_PLLB, which is an exception from the
> pairs of CM_FOOCTL/CM_FOODIV) registers in this range.
> There are also a few CTL/DIV register pairs in the gap
> between CM_VECCTL and CM_EMMCCTL.
> 
Good point. I'll fix that up.

Overall it would be great to get a register dump from someone
with real hardware. I don't really like my guesswork too much.

Thanks,
Guenter
