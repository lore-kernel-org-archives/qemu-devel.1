Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1esKkc-0007LT-OT
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 22:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1esKkb-0000G9-LW
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 22:55:54 -0500
Date: Sun, 4 Mar 2018 05:55:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180304055334-mutt-send-email-mst@kernel.org>
References: <20180213170712.18239-1-andrew.smirnov@gmail.com>
	<20180213170712.18239-2-andrew.smirnov@gmail.com>
	<20180213200450-mutt-send-email-mst@kernel.org>
	<CAHQ1cqEpeq+M6bVTBLd6dvN7=h-s_bPTXRx_GaoMFhhpq2gTpA@mail.gmail.com>
	<20180214000837-mutt-send-email-mst@kernel.org>
	<CAHQ1cqEDDz5ni-+MfQp7dE0x_b51=JwgU-fwS4Y+AkyDyLpxRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqEDDz5ni-+MfQp7dE0x_b51=JwgU-fwS4Y+AkyDyLpxRQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/3] pci: Add support for Designware IP
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Feb 13, 2018 at 02:47:24PM -0800, Andrey Smirnov wrote:
> On Tue, Feb 13, 2018 at 2:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Feb 13, 2018 at 12:24:40PM -0800, Andrey Smirnov wrote:
> >> On Tue, Feb 13, 2018 at 10:13 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Tue, Feb 13, 2018 at 09:07:10AM -0800, Andrey Smirnov wrote:
> >> >> +static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
> >> >> +{
> >> >> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> >> >> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >> >> +
> >> >> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >> >> +
> >> >> +    k->vendor_id = PCI_VENDOR_ID_SYNOPSYS;
> >> >> +    k->device_id = 0xABCD;
> >> >> +    k->revision = 0;
> >> >> +    k->class_id = PCI_CLASS_BRIDGE_PCI;
> >> >> +    k->is_express = true;
> >> >> +    k->is_bridge = true;
> >> >> +    k->exit = pci_bridge_exitfn;
> >> >> +    k->realize = designware_pcie_root_realize;
> >> >> +    k->config_read = designware_pcie_root_config_read;
> >> >> +    k->config_write = designware_pcie_root_config_write;
> >> >> +
> >> >> +    dc->reset = pci_bridge_reset;
> >> >> +    /*
> >> >> +     * PCI-facing part of the host bridge, not usable without the
> >> >> +     * host-facing part, which can't be device_add'ed, yet.
> >> >> +     */
> >> >> +    dc->user_creatable = false;
> >> >> +    dc->vmsd = &vmstate_designware_pcie_root;
> >> >> +}
> >> >> +
> >> >> +static uint64_t designware_pcie_host_mmio_read(void *opaque, hwaddr addr,
> >> >> +                                               unsigned int size)
> >> >> +{
> >> >> +    PCIHostState *pci = PCI_HOST_BRIDGE(opaque);
> >> >> +    PCIDevice *device = pci_find_device(pci->bus, 0, 0);
> >> >> +
> >> >> +    return pci_host_config_read_common(device,
> >> >> +                                       addr,
> >> >> +                                       pci_config_size(device),
> >> >> +                                       size);
> >> >> +}
> >> >> +
> >> >> +static void designware_pcie_host_mmio_write(void *opaque, hwaddr addr,
> >> >> +                                            uint64_t val, unsigned int size)
> >> >> +{
> >> >> +    PCIHostState *pci = PCI_HOST_BRIDGE(opaque);
> >> >> +    PCIDevice *device = pci_find_device(pci->bus, 0, 0);
> >> >> +
> >> >> +    return pci_host_config_write_common(device,
> >> >> +                                        addr,
> >> >> +                                        pci_config_size(device),
> >> >> +                                        val, size);
> >> >> +}
> >> >> +
> >> >> +static const MemoryRegionOps designware_pci_mmio_ops = {
> >> >> +    .read       = designware_pcie_host_mmio_read,
> >> >> +    .write      = designware_pcie_host_mmio_write,
> >> >> +    .endianness = DEVICE_NATIVE_ENDIAN,
> >> >> +    .impl = {
> >> >> +        /*
> >> >> +         * Our device would not work correctly if the guest was doing
> >> >> +         * unaligned access. This might not be a limitation on the real
> >> >> +         * device but in practice there is no reason for a guest to access
> >> >> +         * this device unaligned.
> >> >> +         */
> >> >> +        .min_access_size = 4,
> >> >> +        .max_access_size = 4,
> >> >> +        .unaligned = false,
> >> >> +    },
> >> >> +};
> >> >
> >> > Could you pls add some comments explaining why is DEVICE_NATIVE_ENDIAN
> >> > appropriate here?  Most of these cases are plain "we never bothered
> >> > about cross-endian setups". Some are "there's a mix of different
> >> > endian-ness values, need to handle in a special way".
> >> >
> >> > I suspect you really need DEVICE_LITTLE_ENDIAN.
> >> >
> >>
> >> That MemoryRegion corresponds to a register file permanently mapped
> >> into CPU's address space, so my assumption is that SoC designers will
> >> wire it according to CPUs endianness be it big or little. I am not
> >> aware of any big-endian CPU based SoC on the market using Designware's
> >> IP block, so I don't think there are any precedent confirming or
> >> denying correctness of my assumption. IMHO, this is also the reason
> >> why all of Linux driver code for that IP assumes little endianness.
> >
> > IMHO if Linux driver code does cpu_to_le then it seems best to be
> > consistent with that.
> >
> 
> Well, all of the DW code does so implicitly by using readl()/writel()
> helpers which will perform cpu_to_le/le_to_cpu under the hood. But is
> seems to me that it could be either because the access does have to be
> LE always or simply because readl()/writel() are goto memory helpers
> on ARM/LE-platforms.

PCI things generally tend to be LE since that's how standard
PCI registers are defined, and being consistent avoids confusion.

> FWIW: Somewhat similar precedent of MIPS/Boston machine can serve as
> counter-example to my assumption, since Xilinx PCIE IP there seem to
> be wired to be LE despite being attached to BE CPU.
> 
> Thanks,
> Andrey Smirnov

OK so the above seems to imply it really should be LE, right?

-- 
MST
