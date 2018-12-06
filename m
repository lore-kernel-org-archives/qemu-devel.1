Received: from eggs.gnu.org ([2001:4830:134:3::10]:57652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gUpp8-0005RL-Et
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gUpp7-0002VW-0J
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:19:58 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gUpp6-0002SK-L2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:19:56 -0500
Received: by mail-lf1-x141.google.com with SMTP id b20so16889204lfa.12
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 01:19:56 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<CAFEAcA_a-YMNaGtPPn+8DBFmx4xGYCkuybMck_Wquw6zmLTbCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_a-YMNaGtPPn+8DBFmx4xGYCkuybMck_Wquw6zmLTbCQ@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 6 Dec 2018 17:19:42 +0800
Message-ID: <CAHmQWvAy0kdhXd=atnzB6_ASoRmrxv3wB8AaJPf1eFpf8ex+Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] hw/arm: Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Fri, 16 Nov 2018 at 19:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 16 November 2018 at 10:46, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > On Fri, 16 Nov 2018 at 00:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> If after you've done that this patch is still more than
> >> about 500 lines long, I would recommend that you split it
> >> up into coherent pieces, to make it easier to review.
>
> > I think however I re-work this file, it is still more than 500 lines.
> > If split it, then how? one for most basic skeleton, including memory
> > map, class and instance init etc, and another adding peripheral
> > devices, like pcie etc?
>
> Yes, that's a reasonable split.
>
> >> This is still generating a lot of device tree nodes.
> >> I thought we had agreed that we were going to just have
> >> a minimal device tree that says "here is the RAM" and nothing
> >> else ?
> >>
> > If I remember correct, it was not only the RAM, but also the CPUs
> > because it depends on the command parameters dynamically, and also the
> > GIC as well since it depends on the CPU number.
> > And should NUMA info if used, be added to DT?
> > And by the way, I didn't find the RAM size info in the DT.
>
> You should include the absolute minimum you need that you
> cannot either say "we know what this value is because we
> know the board" or probe for anyway. I think that is basically
> ram inf and number of CPUs. (Ram size and numa configuration
> is added to the dtb by the hw/arm/boot.c code, which sets up
> the "/memory" nodes.)
>
> You shouldn't need to put the GIC info into the DT, because
> you can just hard code into UEFI where it is in memory.
>
> >> > +static void create_ehci(const VirtMachineState *vms, qemu_irq *pic)
> >> > +{
> >> > +    hwaddr base = vms->memmap[VIRT_EHCI].base;
> >> > +    int irq = vms->irqmap[VIRT_EHCI];
> >> > +    USBBus *usb_bus;
> >> > +
> >> > +    sysbus_create_simple("exynos4210-ehci-usb", base, pic[irq]);
> >>
> >> What is this using the exynos4210 USB device for? That
> >> is definitely not correct for a generic board.
> >>
> > Checked the code:
> > #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> > #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> > #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> > #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> > #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> >
> > The first one seems only a parent type, not a general instance, cannot
> > be used directly.
> > The other four are specific instances using the first as parent type,
> > one of them can be chosen to use.
> > That is my understanding, any comments, or do we need to implement one
> > which seems generic?
>
> You need to work out what you want and implement that;
> I don't really know enough about USB to advise.
> You probably also need to consider how you want
> the USB companion chip stuff to work -- I know that
> we've had a bug report that the Exynos4210 USB setup
> is not getting that right, so it may be a poor example
> to copy from.
>
> >> > +
> >> > +    usb_bus = usb_bus_find(-1);
> >> > +    usb_create_simple(usb_bus, "usb-kbd");
> >> > +    usb_create_simple(usb_bus, "usb-mouse");
> >>
> >> Don't create USB devices by default -- let the user do it on
> >> the command line.
> >>
> > Some users hope that, I can remove it if not reasonable.
>
> Almost no other board models do it (only a few PPC ones
> and an sh4 board). Generally for QEMU the approach we take
> is that we don't provide defaults, we expect the user
> (or the 'management layer' software like libvirt) to
> specify what they want. This allows users to specify that
> they *don't* want a usb keyboard, for instance.
>
One thing I forgot to mention that we have VGA on this machine, so it
is convenient/better that we have mouse/keyboard.
(Anyway my next iteration won't have them due to the xhci needs to be
rebuild separately later)

> >> > +    /* If we have an EL3 boot ROM then the assumption is that it will
> >> > +     * implement PSCI itself, so disable QEMU's internal implementation
> >> > +     * so it doesn't get in the way. Instead of starting secondary
> >> > +     * CPUs in PSCI powerdown state we will start them all running and
> >> > +     * let the boot ROM sort them out.
> >> > +     * The usual case is that we do use QEMU's PSCI implementation;
> >> > +     * if the guest has EL2 then we will use SMC as the conduit,
> >> > +     * and otherwise we will use HVC (for backwards compatibility and
> >> > +     * because if we're using KVM then we must use HVC).
> >> > +     */
> >> > +    if (vms->secure && firmware_loaded) {
> >> > +        vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
> >> > +    } else if (vms->virt) {
> >> > +        vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
> >> > +    } else {
> >> > +        vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
> >> > +    }
> >>
> >> Do you actually intend this to work in all these cases? I
> >> thought the intention was "always start the boot rom in EL3"
> >> for this board, like the real hardware would. In that case, most
> >> of these if clauses are dead code.
> >>
> > Well, I myself prefer "always enable EL3" too.
> > But during this work, I found that if EL2/EL3 enabled, QEMU runs much
> > slower than without EL2/3, so I guess if there would be some user of
> > this platform, for the reason of speed they choose to disable EL2/3,
> > should we give them such a chance?
> > If get confirmation that we always enable EL2/3, that is fine for me,
> > this will make codes cleaner.
> >
> > (By the way, I wonder why QEMU becomes much slower with EL2/3 enabled,
> > because when OS is running, most of the time, we don't call into
> > EL2/3, does this mean there is a big space for us to optimize it?)
>
> I think users who don't care about the EL2/EL3 parts of the software
> stack should just use the "virt" machine instead -- that is the
> board we have for "run as fast as possible and just boot a kernel".
>
> It would be interesting at some point to find out why EL2 and EL3
> are causing slowdowns, yes.
>
> thanks
> -- PMM
