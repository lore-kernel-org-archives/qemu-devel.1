Received: from eggs.gnu.org ([209.51.188.92]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpB2p-00066n-8J
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpB2k-0003xa-80
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:02:11 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpB2j-0003wb-WD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:02:06 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so2484343oie.7
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 04:02:05 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8WF1nKfgQWZ11GgMzgLxOtGwoJS9zyeFQkm5ii5GLrpw@mail.gmail.com>
	<CAHmQWvCRfcP1z01OD4_EWVz6nYoYgvDiQKiQJ0puxGGreJchHA@mail.gmail.com>
In-Reply-To: <CAHmQWvCRfcP1z01OD4_EWVz6nYoYgvDiQKiQJ0puxGGreJchHA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 12:01:53 +0000
Message-ID: <CAFEAcA8uZyW8i-5Enb_0AC04UEUrtjZ0Lk5Tr8XjXPCgVgwTfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Wed, 30 Jan 2019 at 08:59, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 19:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 7 Dec 2018 at 09:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > > +    [VIRT_SECURE_MEM] =         { 0x20000000, 0x20000000 },
> > > +    [VIRT_CPUPERIPHS] =         { 0x40000000, 0x00080000 },
> > > +    /* GIC distributor and CPU interface expansion spaces reserved */
> > > +    [VIRT_GIC_DIST] =           { 0x40000000, 0x00010000 },
> > > +    [VIRT_GIC_CPU] =            { 0x40040000, 0x00010000 },
> >
> > If they're just reserved you don't really need to list them here,
> > as they're covered by the VIRT_CPUPERIPHS space anyway. (You
> > don't list the VIRT_GIC_HYP registers or VIRT_GIC_VCPU.)
> >
> We need more consideration here.

Yeah, this is a little more complex than I thought.

> Why CPUPERIPHS is used to cover DIST and CPU interface? is this from
> some old platform? I don't see the term in GICv3 memory map in the
> user manual, so do we still need it for this Arm64 GICv3?
> If we only list CPUPERIPHS but without DIST, I am afraid firmware or
> driver developer still looking for the term of DIST for base address.

OK, so what CPUPERIPHS does (in the virt board) is set the
CPU property which defines the reset value of the CBAR_EL1 register.
(The size specified isn't used.)

The set of memory mapped things in this area should (in theory)
be the same as what the hardware CPU puts there, because guest
code can reasonably look at CBAR and expect to find there the
devices that the real CPU puts there. Unfortunately on the virt
board we don't get this right (and in any case we support multiple
CPU types which don't necessarily have the same set of devices).
Things work in practice because Linux and OVMF both look at
the device tree rather than assuming they can find things
via CBAR_EL1. This is awkward to fix in the virt board without
breaking compatibility, but we can get it right for this new board.

> For GICv3, what we can have are DIST, CPU, REDIST, VCPU and HYP.
> CPU, VCPU and HYP are not simulated for GICv3 (curious it still works
> without CPU interface emulated), so we only have DIST and REDIST.
> Can we only list the DIST and REDIST without CPUPERIPHS?

QEMU's GICv3 implementation only supports the system register
interface, not the memory-mapped interface. This is why we don't
have a memory mapped thing to put into VIRT_GIC_HYP/VIRT_GIC_CPU/
VIRT_GIC_VCPU.

For the Cortex-A53/A57/A72, the only things in the CBAR area are
these memory mapped interfaces that we don't implement:
  CBAR+0x00000 : cpu interface
  CBAR+0x10000 : virt interface control
  CBAR+0x20000 : vcpu interface
  CBAR+0x2F000 : alias of vcpu interface
(other parts of the CBAR+0x00000 to CBAR+0x3ffff reserved)

So for the SBSA reference board, I think the right thing is to
leave a gap in the memory map of 0x40000 in size for CPUPERIPHS,
with a comment that this is reserved CPU peripheral space
because we don't implement the GICv3 memory-mapped CPU interface.
Put GIC_DIST somewhere else (it is a GICv3 device register
bank, not part of the CPU's peripherals), and don't define
GIC_CPU at all (since you don't use it).

thanks
-- PMM
