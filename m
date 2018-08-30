Received: from eggs.gnu.org ([2001:4830:134:3::10]:41364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvNQh-0002pF-PT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvNNf-0000pQ-In
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:53:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1fvNNf-0000ow-2r
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:53:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id w11-v6so8148047wrc.5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 06:53:02 -0700 (PDT)
Date: Thu, 30 Aug 2018 14:52:58 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20180830135258.olr7yt6univbjqx7@bivouac.eciton.net>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
	<20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
	<CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Aug 30, 2018 at 03:29:02PM +0200, Ard Biesheuvel wrote:
> On 30 August 2018 at 12:02, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > On Thu, Aug 30, 2018 at 09:39:33AM +0100, Peter Maydell wrote:
> >> On 30 August 2018 at 09:31, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> >> > On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
> >> >> @Ard, @Leif, is there any possibility to remove all the DT nodes?
> >> >> On real hardware, how does UEFI find the memory size and CPU number?
> >> >
> >> > Usually by asking some form of SCP/PMU.
> >> > So until we have rock-solid multi-cpu-instance (making terms up here,
> >> > there may be a proper name already?) support upstream, we need to take
> >> > shortcuts.
> >>
> >> I would expect that you'd want a "faked-on-the-QEMU end" SCP
> >> communications endpoint to start with anyway. We have one of
> >> those for vexpress, for instance.
> >
> > Ah, I wasn't aware we did!
> >
> > In that case - sure, that is probably the more sensible solution.
> > Does it emulate SCMI?
> 
> The purpose of the SBSA/SBBR qemu machine is prototyping the
> interactions between rich firmware and the OS for things like RAS,
> secure variable storage for UEFI or capsule update.

I think it would be useful to at some point have also an open-source
SCP implementation and tie it into this platform (if feasible). I do
not however think it is important, and certainly nothing we need to
worry about for now.

> How exactly the firmware figures out how many CPUs and how much memory
> we are running with is out of scope for this, and so I don't think
> there is a need to build something from scratch here: DT will do just
> fine, given that both EDK2 and ARM-TF have working DT code for these
> things.

Agreed.

> fw_cfg, on the other hand, is unsuitable for us. Generating ACPI
> tables in a different way from actual bare metal is not a good idea,
> given that things like RAS interact with ACPI as well, and fw_cfg is
> also exposed to the OS in the default mach-virt configuration. So we
> could tweak fw_cfg to be more suitable, but I think that does not
> improve the usefulness of our prototype at all.

Indeed.

> At some point, it would be nice if we could get UEFI to receive its
> platform description from ARM-TF in a generic manner, and it would be
> good for EDK2 and ARM-TF to align on this. So even if we decide that
> SCMI is more suitable way to convey this information from QEMU to the
> guest firmware, I would object to implementing the client side of that
> in UEFI, given that it should be ARM-TF that provides this
> information.

Yes, but the modeled SCP is relevant for the ARM-TF port for this
platform. A "faked-on-the-QEMU end" SCP that communicates via SCMI (or
if that's been superseded, I may have lost track) allows for sharing
generic arm-tf code for retrieving this information with most hardware
platforms.

And that _would_ be nicer than having the lowest layers of the EDK2
port looking more like hardware than mach-virt.

This is of course also something that could be addressed at a later
date - I'm not sure how generic arm-tf is in this regard today.

/
    Leif
