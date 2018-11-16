Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gNmDw-0007s1-1v
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gNmDu-0006bv-TB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:04:23 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1gNmDu-0006Or-8e
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:04:22 -0500
Received: by mail-it1-x141.google.com with SMTP id v11so68972itj.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 14:04:20 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
In-Reply-To: <20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 16 Nov 2018 14:04:07 -0800
Message-ID: <CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, 16 Nov 2018 at 04:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > What is this using the exynos4210 USB device for? That
> > > is definitely not correct for a generic board.
> > >
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
> I think what we *really* want is sysbus-xhci-generic.
>
> That'll be a bit more work though as xhci core and xhci pci needs to be
> splitted, simliar to how it was done for ehci in commit
> 5010d4dc618b6b8e7c21129c487c06f6493f71fc (and related patches).
>
> Or just plug qemu-xhci into a pcie slot.  Not sure which would be closer
> to physical hardware.
>

We don't need XHCI especially, EHCI is perfectly fine as well.

This is mostly about ensuring that the emulated hardware spans the
space of what we encounter on real hardware, and non-PCIE SATA and USB
controllers is something we see often.

So I could live with MMIO SATA and PCI USB as well, but I'd prefer it
if we could have both MMIO.
