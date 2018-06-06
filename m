Received: from eggs.gnu.org ([2001:4830:134:3::10]:55659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1fQeyA-0008UL-FH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1fQey7-0001SF-Cf
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:46 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:34240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Burton@mips.com>)
	id 1fQey7-0001Pc-2f
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:43 -0400
Date: Wed, 6 Jun 2018 13:23:20 -0700
From: Paul Burton <paul.burton@mips.com>
Message-ID: <20180606202320.4lopjnm4be3d5gix@pburton-laptop>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<1487722868-9111-8-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA8NehifKn7wsmLgUqiYNHwczzrXGnUcTvx-AbLM=_LeMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8NehifKn7wsmLgUqiYNHwczzrXGnUcTvx-AbLM=_LeMQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 7/8] hw: xilinx-pcie: Add support for
 Xilinx AXI PCIe Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yongbok Kim <yongbok.kim@mips.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

Hi Peter,

On Mon, Jun 04, 2018 at 11:29:47AM +0100, Peter Maydell wrote:
> On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> > From: Paul Burton <paul.burton@imgtec.com>
> >
> > Add support for emulating the Xilinx AXI Root Port Bridge for PCI
> > Express as described by Xilinx' PG055 document. This is a PCIe
> > controller that can be used with certain series of Xilinx FPGAs, and is
> > used on the MIPS Boston board which will make use of this code.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > [yongbok.kim@imgtec.com:
> >   removed returning on !level,
> >   updated IRQ connection with GPIO logic,
> >   moved xilinx_pcie_init() to boston.c
> >   replaced stw_le_p() with pci_set_word()
> >   and other cosmetic changes]
> > Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> > ---
> 
> > +static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> > +    XilinxPCIEHost *s = XILINX_PCIE_HOST(dev);
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> > +
> > +    snprintf(s->name, sizeof(s->name), "pcie%u", s->bus_nr);
> > +
> > +    /* PCI configuration space */
> > +    pcie_host_mmcfg_init(pex, s->cfg_size);
> > +
> > +    /* MMIO region */
> > +    memory_region_init(&s->mmio, OBJECT(s), "mmio", UINT64_MAX);
> > +    memory_region_set_enabled(&s->mmio, false);
> > +
> > +    /* dummy I/O region */
> > +    memory_region_init_ram(&s->io, OBJECT(s), "io", 16, NULL);
> > +    memory_region_set_enabled(&s->io, false);
> 
> Hi; I was looking at the code for this PCI controller as
> part of identifying RAM memory regions that don't migrate
> their contents, and this looks kind of odd. Can you explain
> why this is using a RAM region for the PCI bus's IO memory
> space? None of our other PCI controller models do this, so
> I suspect this is a bug. (The effect would be that PCI IO
> accesses to addresses which don't have a PCI BAR mapped there
> will behave as reads-as-written, which seems pretty unlikely
> to be what the hardware does.)
> 
> What is the intended semantics for PCI IO accesses with this
> controller? (It seems to only be used with the MIPS boston
> board model.)
> 
> thanks
> -- PMM

The controller here simply doesn't support I/O accesses, and the dummy
region is there to prevent the rest of QEMU's PCI code & device
emulation from needing to care about that fact. The region is never
mapped into the system memory and so software running on the emulated
system has no way to access it.

Thanks,
    Paul
