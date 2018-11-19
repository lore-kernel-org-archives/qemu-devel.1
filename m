Received: from eggs.gnu.org ([2001:4830:134:3::10]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gOlpy-0005lt-NM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gOlpx-0003E5-L4
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:51:46 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1gOlpx-0003BC-Ah
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:51:45 -0500
Received: by mail-io1-xd41.google.com with SMTP id a3so15875528ioc.4
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 07:51:41 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
	<CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
	<20181119124423.qj3sjhhdyetrbju5@bivouac.eciton.net>
In-Reply-To: <20181119124423.qj3sjhhdyetrbju5@bivouac.eciton.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 19 Nov 2018 07:51:29 -0800
Message-ID: <CAKv+Gu_-U8BHthhen-GBkium9qJMdd-pe_PB9TPdUaP=koeajQ@mail.gmail.com>
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
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, 19 Nov 2018 at 04:44, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> On Fri, Nov 16, 2018 at 02:04:07PM -0800, Ard Biesheuvel wrote:
> > > > > What is this using the exynos4210 USB device for? That
> > > > > is definitely not correct for a generic board.
> > > > >
> > > > Checked the code:
> > > > #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> > > > #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> > > > #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> > > > #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> > > > #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> > > >
> > > > The first one seems only a parent type, not a general instance, cannot
> > > > be used directly.
> > > > The other four are specific instances using the first as parent type,
> > > > one of them can be chosen to use.
> > > > That is my understanding, any comments, or do we need to implement one
> > > > which seems generic?
> > >
> > > I think what we *really* want is sysbus-xhci-generic.
> > >
> > > That'll be a bit more work though as xhci core and xhci pci needs to be
> > > splitted, simliar to how it was done for ehci in commit
> > > 5010d4dc618b6b8e7c21129c487c06f6493f71fc (and related patches).
> > >
> > > Or just plug qemu-xhci into a pcie slot.  Not sure which would be closer
> > > to physical hardware.
> >
> > We don't need XHCI especially, EHCI is perfectly fine as well.
> >
> > This is mostly about ensuring that the emulated hardware spans the
> > space of what we encounter on real hardware, and non-PCIE SATA and USB
> > controllers is something we see often.
> >
> > So I could live with MMIO SATA and PCI USB as well, but I'd prefer it
> > if we could have both MMIO.
>
> I would actually strongly prefer non-MMIO.
>
> What "we see" is generally a result of embedded companies "value
> adding" in the usual way when moving from embedded to servers.
>
> I want the SBSA target to be an idealised machine, not an educational
> vehicle for showing how companies have got it wrong.
>
> Where in doubt, anything software discoverable should win over
> non-discoverable.
>

I don't think it makes sense at all to idealize the SBSA machine in
this way. For example, there are elaborate provisions in the IORT spec
how to describe an I/O topology involving named components (as opposed
to PCIe devices), and I have not seen an arm64 SoC yet that uses PCIe
internally for on-chip network controllers, nor do I expect to in the
near future. So having non-PCIe USB or SATA will permit us to exercise
code paths in the OS that we do rely on in production, and will for
the foreseeable future.
