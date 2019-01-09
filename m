Received: from eggs.gnu.org ([209.51.188.92]:45468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1ghGky-0001hG-Vy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1ghGkx-0000vO-II
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:04 -0500
MIME-Version: 1.0
References: <20190103094211.28473-1-geert+renesas@glider.be>
	<acd10959-a781-d3bf-dc67-bda878740ec9@redhat.com>
	<CAFEAcA9jk1ocW8h33-f9mRM52mT96o+bviaRe6MRErkyxBtqYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9jk1ocW8h33-f9mRM52mT96o+bviaRe6MRErkyxBtqYQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Jan 2019 17:30:15 +0100
Message-ID: <CAMuHMdX6gwnw7RYQNik4QQmfWoTmemMgrUaPuW9Rgd56pW+4jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH QEMU v5] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Auger Eric <eric.auger@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Peter,

Thanks for your comments!

On Wed, Jan 9, 2019 at 5:03 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Wed, 9 Jan 2019 at 15:55, Auger Eric <eric.auger@redhat.com> wrote:
> > On 1/3/19 10:42 AM, Geert Uytterhoeven wrote:
> > > Add a fallback for instantiating generic devices without a type-specific
> > > or compatible-specific instantiation method.  This will be used when no
> > > other match is found.
> > >
> > > Generic device instantiation avoids having to write device-specific
> > > instantiation methods for each and every "simple" device using only a
> > > set of generic properties.  Devices that need more specialized handling
> > > can still provide their own instantiation methods.
>
> > > +    /* Ignoring the following may or may not work, hence the warning */
> > > +    { "gpio-ranges",     PROP_WARN },   /* no support for pinctrl yet */
> > > +    { "dmas",            PROP_WARN },   /* no support for external DMACs yet */
> > I would be tempted to simply reject things that may not work.
>
> More generally, this whole feature seems to be "allow things that
> might not work", isn't it? Otherwise we could just have explicit

I can remove the two PROP_WARN properties above from the list, if you prefer.
Exporting rcar-sata still works fine after that.

> whitelists for the devices we want to allow passthrough of and
> that we've tested to work.

In the end, this will become a loooooong list (SoC x devices)...

> I have to say I'm not really very enthusiastic about
> enhancing this to allow random device passthrough,
> because it encourages further use of this. If people
> want hardware that can be passed through they should
> put it behind a bus that can be probed and can go
> behind an IOMMU, ie pci or some equivalent. That
> is a supportable hardware mechanism. All this
> machinery feels very heath-robinson...

As no-iommu suppport is not upstream (in Qemu; it is upstream in Linux,
perhaps it should be removed?), all devices using DMA require being
behind an IOMMU.

Reality is that on embedded, on-SoC devices are usually not on a PCI bus.
But IOMMUs are present, and virtualization is wanted.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
