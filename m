Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gOmmZ-0001hH-L5
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gOmf1-0006j7-QB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:44:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1gOmey-0006eh-CF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:44:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id b13so32778561wrx.6
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 08:44:25 -0800 (PST)
Date: Mon, 19 Nov 2018 16:44:21 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20181119164421.me2j4fwzo43aghaa@bivouac.eciton.net>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
	<CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
	<20181119124423.qj3sjhhdyetrbju5@bivouac.eciton.net>
	<CAKv+Gu_-U8BHthhen-GBkium9qJMdd-pe_PB9TPdUaP=koeajQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_-U8BHthhen-GBkium9qJMdd-pe_PB9TPdUaP=koeajQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] hw/arm: Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, Nov 19, 2018 at 07:51:29AM -0800, Ard Biesheuvel wrote:
> > > > I think what we *really* want is sysbus-xhci-generic.
> > > >
> > > > That'll be a bit more work though as xhci core and xhci pci needs to be
> > > > splitted, simliar to how it was done for ehci in commit
> > > > 5010d4dc618b6b8e7c21129c487c06f6493f71fc (and related patches).
> > > >
> > > > Or just plug qemu-xhci into a pcie slot.  Not sure which would be closer
> > > > to physical hardware.
> > >
> > > We don't need XHCI especially, EHCI is perfectly fine as well.
> > >
> > > This is mostly about ensuring that the emulated hardware spans the
> > > space of what we encounter on real hardware, and non-PCIE SATA and USB
> > > controllers is something we see often.
> > >
> > > So I could live with MMIO SATA and PCI USB as well, but I'd prefer it
> > > if we could have both MMIO.
> >
> > I would actually strongly prefer non-MMIO.
> >
> > What "we see" is generally a result of embedded companies "value
> > adding" in the usual way when moving from embedded to servers.
> >
> > I want the SBSA target to be an idealised machine, not an educational
> > vehicle for showing how companies have got it wrong.
> >
> > Where in doubt, anything software discoverable should win over
> > non-discoverable.
> 
> I don't think it makes sense at all to idealize the SBSA machine in
> this way. For example, there are elaborate provisions in the IORT spec
> how to describe an I/O topology involving named components (as opposed
> to PCIe devices), and I have not seen an arm64 SoC yet that uses PCIe
> internally for on-chip network controllers, nor do I expect to in the
> near future. So having non-PCIe USB or SATA will permit us to exercise
> code paths in the OS that we do rely on in production, and will for
> the foreseeable future.

Fair point.

I have no objections at all to adding _some_ MMIO components for the
purpose of being able to validate this. But I am reluctant to mandate
discrepancies in bits that 99% of users would expect to work
identically as it has done on x86.

If USB isn't auto-instantiated in qemu-system-x86_64, then indeed we
don't need to do it here either.

But I assume you specifically want things that do a lot of DMA, so I
couldn't get away with asking for keeping it to the SBSA UART(s)? :)

/
    Leif
