Received: from eggs.gnu.org ([2001:4830:134:3::10]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPmkg-0007dt-TX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPmka-0000D3-Nu
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:30:14 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPmka-0000Cr-IY
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:30:08 -0400
Received: by mail-ot0-x242.google.com with SMTP id l12-v6so36977665oth.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 03:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1487722868-9111-8-git-send-email-yongbok.kim@imgtec.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<1487722868-9111-8-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 11:29:47 +0100
Message-ID: <CAFEAcA8NehifKn7wsmLgUqiYNHwczzrXGnUcTvx-AbLM=_LeMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> Add support for emulating the Xilinx AXI Root Port Bridge for PCI
> Express as described by Xilinx' PG055 document. This is a PCIe
> controller that can be used with certain series of Xilinx FPGAs, and is
> used on the MIPS Boston board which will make use of this code.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> [yongbok.kim@imgtec.com:
>   removed returning on !level,
>   updated IRQ connection with GPIO logic,
>   moved xilinx_pcie_init() to boston.c
>   replaced stw_le_p() with pci_set_word()
>   and other cosmetic changes]
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> ---

> +static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    XilinxPCIEHost *s = XILINX_PCIE_HOST(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +
> +    snprintf(s->name, sizeof(s->name), "pcie%u", s->bus_nr);
> +
> +    /* PCI configuration space */
> +    pcie_host_mmcfg_init(pex, s->cfg_size);
> +
> +    /* MMIO region */
> +    memory_region_init(&s->mmio, OBJECT(s), "mmio", UINT64_MAX);
> +    memory_region_set_enabled(&s->mmio, false);
> +
> +    /* dummy I/O region */
> +    memory_region_init_ram(&s->io, OBJECT(s), "io", 16, NULL);
> +    memory_region_set_enabled(&s->io, false);

Hi; I was looking at the code for this PCI controller as
part of identifying RAM memory regions that don't migrate
their contents, and this looks kind of odd. Can you explain
why this is using a RAM region for the PCI bus's IO memory
space? None of our other PCI controller models do this, so
I suspect this is a bug. (The effect would be that PCI IO
accesses to addresses which don't have a PCI BAR mapped there
will behave as reads-as-written, which seems pretty unlikely
to be what the hardware does.)

What is the intended semantics for PCI IO accesses with this
controller? (It seems to only be used with the MIPS boston
board model.)

thanks
-- PMM
